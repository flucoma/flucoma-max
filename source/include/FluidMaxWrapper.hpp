#pragma once

#include <ext.h>
#include <ext_obex.h>
#include <ext_obex_util.h>
#include <z_dsp.h>

#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/OfflineClient.hpp>
#include <clients/common/ParameterSet.hpp>
#include <clients/common/ParameterTypes.hpp>

#include <clients/nrt/FluidSharedInstanceAdaptor.hpp>

#include "MaxBufferAdaptor.hpp"

#include <cctype>  //std::tolower
#include <tuple>
#include <utility>

namespace fluid {
namespace client {

//////////////////////////////////////////////////////////////////////////////////////////////////

namespace impl {

template <typename Wrapper>
t_max_err getLatency(Wrapper *x, t_object * /*attr*/, long *ac, t_atom **av)
{
  char alloc;
  atom_alloc(ac, av, &alloc);
  atom_setlong(*av, static_cast<t_atom_long>(x->client().latency()));
  return MAX_ERR_NONE;
}

//////////////////////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
class RealTime
{
  using ViewType = FluidTensorView<double, 1>;

public:
  static void setup(t_class *c)
  {
    class_dspinit(c);
    class_addmethod(c, (method) callDSP, "dsp64", A_CANT, 0);
    class_addattr(c, attribute_new("latency", USESYM(long), 0, (method) getLatency<Wrapper>, nullptr));
    CLASS_ATTR_LABEL(c, "latency", 0, "Latency");
  }

  static void callDSP(Wrapper *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    x->dsp(dsp64, count, samplerate, maxvectorsize, flags);
  }

  static void callPerform(Wrapper *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size, long flags, void *userparam)
  {
    x->perform(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam);
  }

  void dsp(t_object *dsp64, short *count, double samplerate, long /*maxvectorsize*/, long /*flags*/)
  {
    Wrapper *wrapper = static_cast<Wrapper *>(this);

    wrapper->mClient = typename Wrapper::ClientType{wrapper->mParams};
    auto &   client  = wrapper->client();
    client.sampleRate(samplerate);

    audioInputConnections.resize(client.audioChannelsIn());
    std::copy(count, count + client.audioChannelsIn(), audioInputConnections.begin());

    assert((client.audioChannelsOut() > 0) != (client.controlChannelsOut() > 0) &&
           "Client must *either* be audio out or control out, sorry");

    audioOutputConnections.resize(client.audioChannelsOut());
    std::copy(count + client.audioChannelsIn(), count + client.audioChannelsIn() + client.audioChannelsOut(),
              audioOutputConnections.begin());

    mInputs = std::vector<ViewType>(client.audioChannelsIn(), ViewType(nullptr, 0, 0));

    if (client.audioChannelsOut() > 0) mOutputs = std::vector<ViewType>(client.audioChannelsOut(), ViewType(nullptr, 0, 0));
    if (client.controlChannelsOut() > 0)
    {
      mControlClock = mControlClock ? mControlClock : clock_new((t_object *) wrapper, (method) doControlOut);

      mOutputs = std::vector<ViewType>(client.controlChannelsOut(), ViewType(nullptr, 0, 0));
      mControlOutputs.resize(client.controlChannelsOut());
      mControlAtoms.resize(client.controlChannelsOut());
    }

    object_method(dsp64, gensym("dsp_add64"), wrapper, ((method) callPerform), 0, nullptr);
  }

  void perform(t_object * /*dsp64*/, double **ins, long numins, double **outs, long /*numouts*/, long sampleframes, long /*flags*/, void* /*userparam*/)
  {
    auto &client = static_cast<Wrapper *>(this)->mClient;
    for (auto i = 0u; i < static_cast<size_t>(numins); ++i)
      if (audioInputConnections[i]) mInputs[i].reset(ins[i], 0, sampleframes);

    for (auto i = 0u; i < client.audioChannelsOut(); ++i)
      // if(audioOutputConnections[i])
      mOutputs[i].reset(outs[i], 0, sampleframes);

    for (auto i = 0u; i < client.controlChannelsOut(); ++i) mOutputs[i].reset(&mControlOutputs[i], 0, 1);

    client.process(mInputs, mOutputs, mContext);

    if (mControlClock) clock_delay(mControlClock, 0);
  }

  void controlData()
  {
    Wrapper *w      = static_cast<Wrapper *>(this);
    auto &   client = w->client();
    atom_setdouble_array(static_cast<long>(client.controlChannelsOut()), mControlAtoms.data(), static_cast<long>(client.controlChannelsOut()),
                         mControlOutputs.data());
    w->controlOut(static_cast<long>(client.controlChannelsOut()), mControlAtoms.data());
  }

private:
  static void           doControlOut(Wrapper *x) { x->controlData(); }
  std::vector<ViewType> mInputs;
  std::vector<ViewType> mOutputs;
  std::vector<short>    audioInputConnections;
  std::vector<short>    audioOutputConnections;
  std::vector<double>   mControlOutputs;
  std::vector<t_atom>   mControlAtoms;
  void *                mControlClock;
  FluidContext          mContext;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
struct NonRealTime
{
  NonRealTime()
  {
    mQelem = qelem_new(static_cast<Wrapper *>(this), (method) checkProcess);
    mClock = clock_new(static_cast<Wrapper *>(this), (method) clockTick);
  }
    
  ~NonRealTime()
  {
    qelem_free(mQelem);
    object_free(mClock);
  }
    
  static void setup(t_class *c)
  {
    class_addmethod(c, (method) deferProcess, "bang", 0);
    class_addmethod(c, (method) callCancel, "cancel", 0);
    
    CLASS_ATTR_LONG(c, "blocking", 0, Wrapper, mSynchronous);
    CLASS_ATTR_FILTER_CLIP(c, "blocking", 0, 2);
    CLASS_ATTR_ENUMINDEX(c, "blocking", 0, "Non-Blocking \"Blocking (low priority)\" \"Blocking (high priority)\"");
    
    CLASS_ATTR_LONG(c, "queue", 0, Wrapper, mQueueEnabled);
    CLASS_ATTR_FILTER_CLIP(c, "queue", 0, 1);
    CLASS_ATTR_STYLE_LABEL(c, "queue", 0, "onoff", "Enable Queue for Async Processing");
  }

  bool checkResult(Result& res)
  {
    auto &wrapper = static_cast<Wrapper &>(*this);
      
    if (!res.ok())
    {
      switch (res.status())
      {
        case Result::Status::kWarning: object_warn((t_object *) &wrapper, res.message().c_str()); break;
        case Result::Status::kError: object_error((t_object *) &wrapper, res.message().c_str()); break;
        case Result::Status::kCancelled: object_post((t_object *) &wrapper, "Job cancelled"); break;
        default: {
        }
      }
      return false;
    }
      
    return true;
  }
  
  void cancel()
  {
    auto &wrapper = static_cast<Wrapper &>(*this);
    auto &client  = wrapper.mClient;
    client.cancel();
  }
    
  template<size_t N, typename T>
  struct BufferImmediate
  {
    void operator()(typename T::type& param, bool immediate)
    {
      if (param)
      {
        auto b = static_cast<MaxBufferAdaptor*>(param.get());
        b->immediate(immediate);
      }
    }
  };
    
  void process()
  {
    auto &wrapper = static_cast<Wrapper &>(*this);
    auto &client  = wrapper.mClient;
    long syncMode = mSynchronous;
    bool synchronous = syncMode != 1;
      
    wrapper.mParams.template forEachParamType<BufferT, BufferImmediate>(syncMode == 2);
      
    client.setSynchronous(synchronous);
    client.setQueueEnabled(mQueueEnabled);
    
    Result res = client.process();
    if (checkResult(res))
    {
      if (synchronous) 
        wrapper.doneBang();
      else
        clockWait();
    }
  }

  static void callCancel(Wrapper *x) { x->cancel(); }
    
  static void deferProcess(Wrapper *x)
  {
    x->mClient.enqueue(x->mParams);
    
    if (x->mSynchronous != 2)
    {
      defer(x, (method) &callProcess, nullptr, 0, nullptr);
    }
    else
    {
      callProcess(x, nullptr, 0, nullptr);
    }
  }
    
  static void callProcess(Wrapper *x, t_symbol*, short, t_atom*) { x->process(); }


  static void checkProcess(Wrapper *x)
  {
    Result res;
    auto &client  = x->mClient;
      
    ProcessState state = client.checkProgress(res);
      
    if (state == ProcessState::kDone || state == ProcessState::kDoneStillProcessing)
    {
      if (x->checkResult(res))
        x->doneBang();
    }
      
    if (state != ProcessState::kDone)
    {
      x->progress(client.progress()); 
      x->clockWait();
    }
  }
    
  static void clockTick(Wrapper *x)
  {
    qelem_set(x->mQelem);
  }
    
  void clockWait()
  {
    clock_set(mClock, 20);  // FIX - set at 20ms for now...
  }
    
protected:
  long mSynchronous = 1;
  long mQueueEnabled = 0;
  void *mQelem;
  void* mClock;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
struct NonRealTimeAndRealTime : public RealTime<Wrapper>, public NonRealTime<Wrapper>
{
  static void setup(t_class *c)
  {
    RealTime<Wrapper>::setup(c);
    NonRealTime<Wrapper>::setup(c);
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////

// Max base type

struct MaxBase
{
  t_object*     getMaxObject() { return (t_object *) &mObject; }
  t_pxobject*   getMSPObject() { return &mObject; }
  t_pxobject    mObject;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

// Templates and specialisations for all possible base options

template <class Wrapper, typename NRT, typename RT>
struct FluidMaxBase : public MaxBase
{
  static_assert(isRealTime<FluidMaxBase>::value || isNonRealTime<FluidMaxBase>::value,
                "This object seems to be neither real-time nor non-real-time! Check that your Client inherits from "
                "Audio[In/Out], Control[In/Out] or Offline[In/Out]");
};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::true_type, std::false_type> : public MaxBase, public NonRealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::false_type, std::true_type> : public MaxBase, public RealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::true_type, std::true_type> : public MaxBase, public NonRealTimeAndRealTime<Wrapper>
{};

//////////////////////////////////////////////////////////////////////////////////////////////////

} // namespace impl

template <typename Client>
class FluidMaxWrapper : public impl::FluidMaxBase<FluidMaxWrapper<Client>, typename Client::isNonRealTime, typename Client::isRealTime>
{
  using WrapperBase = impl::FluidMaxBase<FluidMaxWrapper<Client>, typename Client::isNonRealTime, typename Client::isRealTime>;

  friend impl::RealTime<FluidMaxWrapper<Client>>;
  friend impl::NonRealTime<FluidMaxWrapper<Client>>;

  template <size_t N>
  static constexpr auto paramDescriptor() { return Client::getParameterDescriptors().template get<N>(); }

  template <size_t N>
  static constexpr auto makeValue() { return Client::getParameterDescriptors().template makeValue<N>(); }

  static void printResult(FluidMaxWrapper<Client>* x, Result& r)
  {
    if (!x) return;

    if (x->verbose() && !x->messages().ok())
    {
      switch (x->messages().status())
      {
        case Result::Status::kWarning: object_warn((t_object *) x, r.message().c_str()); break;
        case Result::Status::kError: object_error((t_object *) x, r.message().c_str()); break;
        default: {
        }
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////

  template <size_t N, typename T, T Method(const t_atom *av)>
  struct FetchValue
  {
    T operator()(const long ac, t_atom *av, long &currentCount)
    {
      auto defaultValue = paramDescriptor<N>().defaultValue;
      return currentCount < ac ? Method(av + currentCount++) : defaultValue;
    }
  };

  template <size_t N, typename T>
  struct Fetcher;

  template <size_t N>
  struct Fetcher<N, FloatT> : public FetchValue<N, t_atom_float, atom_getfloat>
  {};

  template <size_t N>
  struct Fetcher<N, LongT> : public FetchValue<N, t_atom_long, atom_getlong>
  {};

  template <size_t N>
  struct Fetcher<N, StringT>
  {
    std::string operator()(const long ac, t_atom *av, long &currentCount)
    {
      auto defaultValue = paramDescriptor<N>().defaultValue;
      return {currentCount < ac ? atom_getsym(av + currentCount++)->s_name : defaultValue};
    }
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////

  // ParamsToAtoms
  struct ParamAtomConverter
  {
    static std::string getString(t_atom* a)
    {
      switch(atom_gettype(a))
      {
        case A_LONG:  return std::to_string(atom_getlong(a));
        case A_FLOAT: return std::to_string(atom_getfloat(a));
        default: return {atom_getsym(a)->s_name};
      }
    }
    
    template<typename T>
    static std::enable_if_t<std::is_integral<T>::value, T>
    fromAtom(t_object* /*x*/, t_atom *a, T)  { return atom_getlong(a); }

    template<typename T>
    static std::enable_if_t<std::is_floating_point<T>::value, T>
    fromAtom(t_object* /*x*/, t_atom *a, T) { return atom_getfloat(a); }

    static auto fromAtom(t_object * x, t_atom *a, BufferT::type)
    {
      return BufferT::type(new MaxBufferAdaptor(x, atom_getsym(a)));
    }
    
    static auto fromAtom(t_object *x , t_atom *a, InputBufferT::type)
    {
      return InputBufferT::type(new MaxBufferAdaptor(x, atom_getsym(a)));
    }
    
    static auto fromAtom(t_object*, t_atom* a, StringT::type)
    {
      return getString(a);
    }
    
    template<typename T>
    static std::enable_if_t<IsSharedClient<T>::value,T>
    fromAtom(t_object*,t_atom* a, T)
    {
        return {atom_getsym(a)->s_name};
    }
    
    
    template<typename T>
    static std::enable_if_t<std::is_integral<T>::value>
    toAtom(t_atom *a, T v) { atom_setlong(a, v); }
    
    template<typename T>
    static std::enable_if_t<std::is_floating_point<T>::value>
    toAtom(t_atom *a, T v) { atom_setfloat(a, v); }

    static auto toAtom(t_atom *a, BufferT::type v)
    {
      auto b = static_cast<MaxBufferAdaptor *>(v.get());
      atom_setsym(a, b ? b->name() : nullptr);
    }
    
    static auto toAtom(t_atom *a, InputBufferT::type v)
    {
      auto b = static_cast<const MaxBufferAdaptor *>(v.get());
      atom_setsym(a, b ? b->name() : nullptr);
    }
    
    static auto toAtom(t_atom *a, StringT::type v)
    {
      atom_setsym(a,gensym(v.c_str()));
    }
    
    static auto toAtom(t_atom *a, FluidTensor<std::string,1> v)
    {
      for(auto& s:v)
        atom_setsym(a++,gensym(s.c_str()));
    }
    
    static auto toAtom(t_atom *a, FluidTensor<double,1> v)
    {
      for(auto& x:v) atom_setfloat(a++,x);
    }
    
    static auto toAtom(t_atom *a, FluidTensor<intptr_t,1> v)
    {
      for(auto& x:v) atom_setlong(a++,x);
    }
    
    template<typename T>
    static std::enable_if_t<IsSharedClient<T>::value>
    toAtom(t_atom* a, T v)
    {
          atom_setsym(a, gensym(v.name()));
      //  else
      //    atom_setsym(a, gensym("<undefined object>"));
    }
    
    template<typename...Ts,size_t...Is>
    static void toAtom(t_atom* a, std::tuple<Ts...>&& x, std::index_sequence<Is...>, std::array<size_t,sizeof...(Ts)> offsets)
    {
       (void)std::initializer_list<int>{(toAtom(a + offsets[Is],std::get<Is>(x)),0)...};
    }
  };
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Setter

  template<typename T, size_t N>
  struct Setter
  {
    static constexpr size_t argSize = paramDescriptor<N>().fixedSize;

    static t_max_err set(FluidMaxWrapper<Client>* x, t_object */*attr*/, long ac, t_atom *av)
    {
      ParamLiteralConvertor<T, argSize> a;
      a.set(makeValue<N>());

      x->messages().reset();

      for (auto i = 0u; i < argSize && i < static_cast<size_t>(ac); i++)
        a[i] = ParamAtomConverter::fromAtom((t_object *) x, av + i, a[0]);

      x->params().template set<N>(a.value(), x->verbose() ? &x->messages() : nullptr);
      printResult(x, x->messages());
      object_attr_touch((t_object *) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Getter

  template<typename T, size_t N>
  struct Getter
  {
    static constexpr size_t argSize = paramDescriptor<N>().fixedSize;

    static t_max_err get(FluidMaxWrapper<Client>* x, t_object */*attr*/, long *ac, t_atom **av)
    {
      ParamLiteralConvertor<T, argSize> a;

      char alloc;
      atom_alloc_array(argSize, ac, av, &alloc);

      a.set(x->params().template get<N>());

      for (auto i = 0u; i < argSize; i++)
        ParamAtomConverter::toAtom(*av + i, a[i]);

      return MAX_ERR_NONE;
    }
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////

  template<size_t, typename>
  struct Notify
  {
    static void notify(FluidMaxWrapper<Client>*, t_symbol*, t_symbol*, void*, void*) {}
  };

  template<size_t N>
  struct Notify<N, BufferT>
  {
    static void notify(FluidMaxWrapper<Client>* x, t_symbol *s, t_symbol *msg, void *sender, void *data)
    {
      if (auto p = static_cast<MaxBufferAdaptor *>(x->params().template get<N>().get())) p->notify(s, msg, sender, data);
    }
  };
  
  template<size_t N>
  struct Notify<N, InputBufferT>
  {
    static void notify(FluidMaxWrapper<Client>* x, t_symbol *s, t_symbol *msg, void *sender, void *data)
    {
      if (auto p = static_cast<const MaxBufferAdaptor *>(x->params().template get<N>().get())) p->notify(s, msg, sender, data);
    }
  };

public:

  using ClientType    = Client;
  using ParamDescType = typename Client::ParamDescType;
  using ParamSetType = typename Client::ParamSetType;

  FluidMaxWrapper(t_symbol*, long ac, t_atom *av)
    : mParams(Client::getParameterDescriptors()),
      mParamSnapshot(Client::getParameterDescriptors()),
      mClient{initParamsFromArgs(ac,av)}
  {
    if (mClient.audioChannelsIn())
    {
      dsp_setup(impl::MaxBase::getMSPObject(), mClient.audioChannelsIn());
      impl::MaxBase::getMSPObject()->z_misc |= Z_NO_INPLACE;
    }

    auto results = mParams.keepConstrained(true);
    mParamSnapshot = mParams;

    for (auto &r : results)
      printResult(this, r);
    
    object_obex_store(this, gensym("dumpout"), (t_object *) outlet_new(this, nullptr));

    if (isNonRealTime<Client>::value)
    {
      mProgressOutlet = floatout(this);
      mNRTDoneOutlet = bangout(this);
    }

    if (mClient.controlChannelsOut()) mControlOutlet = listout(this);

    for (auto i = 0u; i < mClient.audioChannelsOut(); ++i) outlet_new(this, "signal");
     
    Client::getParameterDescriptors().template iterate<AddListener>(this,mParams);
    
  }
  
  template<size_t N,typename T>
  struct AddListener
  {
    void operator()(const T& param, FluidMaxWrapper *x, ParamSetType& paramSet)
    {
      paramSet.template addListener<N>([x, &param]()
      {
        object_attr_touch((t_object*)(x), gensym(param.name));
      });
    }
  };


  void progress(double progress) { outlet_float(mProgressOutlet, progress); }

  void doneBang() { outlet_bang(mNRTDoneOutlet); }

  void controlOut(long ac, t_atom *av) { outlet_list(mControlOutlet, nullptr, static_cast<short>(ac), av); }

  static void *create(t_symbol *sym, long ac, t_atom *av)
  {
    void *x = object_alloc(getClass());
    new (x) FluidMaxWrapper(sym, ac, av);

    if (static_cast<size_t>(attr_args_offset(static_cast<short>(ac), av)) > ParamDescType::NumFixedParams)
    { object_warn((t_object *) x, "Too many arguments. Got %d, expect at most %d", ac, ParamDescType::NumFixedParams); }

    return x;
  }

  static void destroy(FluidMaxWrapper * x)
  {
    x->~FluidMaxWrapper();
  }

  static void makeClass(const char *className)
  {
    const ParamDescType& p = Client::getParameterDescriptors();
    const auto& m = Client::getMessageDescriptors();
    getClass(class_new(className, (method)create, (method)destroy, sizeof(FluidMaxWrapper), 0, A_GIMME, 0));
    WrapperBase::setup(getClass());

    class_addmethod(getClass(), (method)doNotify, "notify",A_CANT, 0);
    class_addmethod(getClass(), (method)object_obex_dumpout,"dumpout",A_CANT, 0);
    class_addmethod(getClass(), (method)doReset, "reset",0);

    m.template iterate<SetupMessage>();

	//Change for MSVC, which didn't like the macro version
	  t_object* a = attr_offset_new("warnings", USESYM(long), 0, nullptr, nullptr, calcoffset(FluidMaxWrapper,mVerbose));
	  class_addattr(getClass(), a);

    //CLASS_ATTR_LONG(getClass(), "warnings", 0, FluidMaxWrapper, mVerbose);
    CLASS_ATTR_FILTER_CLIP(getClass(), "warnings", 0, 1);
    CLASS_ATTR_STYLE_LABEL(getClass(), "warnings", 0, "onoff", "Report Warnings");

    p.template iterateMutable<SetupAttribute>();
    class_dumpout_wrap(getClass());
    class_register(CLASS_BOX, getClass());
  }

  static void doReset(FluidMaxWrapper *x)
  {
    x->mParams = x->mParamSnapshot;
    x->params().template forEachParam<touchAttribute>(x);
  }

  Result &messages() { return mResult; }
  long    verbose() { return mVerbose; }
  Client &client() { return mClient; }
  ParamSetType &params() { return mParams; }

private:

  static t_class *getClass(t_class *setClass = nullptr)
  {
    static t_class *c = nullptr;
    return (c = setClass ? setClass : c);
  }

  static std::string lowerCase(const char *str)
  {
    std::string result(str);
    std::transform(result.begin(), result.end(), result.begin(), [](unsigned char c) { return std::tolower(c); });
    return result;
  }

  static t_max_err doNotify(FluidMaxWrapper *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    x->notify(s, msg, sender, data);
    return MAX_ERR_NONE;
  }

  void notify(t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    mParams.template forEachParam<notifyAttribute>(this, s, msg, sender, data);
  }

  template <size_t N, typename T>
  struct notifyAttribute
  {
    void operator()(const typename T::type &/*attr*/, FluidMaxWrapper *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
    {
      Notify<N,T>::notify(x, s, msg, sender, data);
    }
  };

  template <size_t N, typename T>
  struct touchAttribute
  {
    void operator()(const typename T::type &/*attr*/, FluidMaxWrapper *x)
    {
      const char* name = paramDescriptor<N>().name;
      object_attr_touch((t_object *) x, gensym(FluidMaxWrapper::lowerCase(name).c_str()));
    }
  };

  ParamSetType &initParamsFromArgs(long ac, t_atom *av)
  {
    // Process arguments for instantiation parameters
    if (long numArgs = attr_args_offset(static_cast<short>(ac), av))
    {
      long argCount{0};
      mParams.template setFixedParameterValues<Fetcher>(true, numArgs, av, argCount);
    }
    // process in-box attributes for mutable params
    attr_args_process((t_object *) this, static_cast<short>(ac), av);
    // return params so this can be called in client initaliser
    return mParams;
  }

  template<size_t N>
  static void invokeMessage(FluidMaxWrapper *x, t_symbol* s, long ac, t_atom* av)
  {
    using IndexList = typename Client::MessageSetType::template MessageDescriptorAt<N>::IndexList;
    invokeMessageImpl<N>(x,s,ac,av,IndexList());
  }
  
  template<size_t N, size_t...Is>
  static void invokeMessageImpl(FluidMaxWrapper *x, t_symbol* s, long ac, t_atom* av,std::index_sequence<Is...>)
  {
    using ArgTuple = typename Client::MessageSetType::template MessageDescriptorAt<N>::ArgumentTypes;
    
    //Read in arguments
    ArgTuple args{setArg<ArgTuple, Is>(x,ac,av)...};

    auto result = x->mClient.template invoke<N>(x->mClient, std::get<Is>(args)...);
    
    if(x->checkResult(result))
      messageOutput(x, s, result);
  }

  
  template<typename Tuple, size_t N>
  static auto setArg(FluidMaxWrapper *x, long ac, t_atom* av)
  {
    if(N < ac)
      return  ParamAtomConverter::fromAtom((t_object*)x, av + N,typename std::tuple_element<N, Tuple>::type{});
    else
      return typename std::tuple_element<N, Tuple>::type{};
  }



  template <typename T>
  static size_t ResultSize(T) { return 1; }

  template <template <typename,size_t> class Tensor, typename T>
  static size_t ResultSize(Tensor<T,1>&& x) { return static_cast<FluidTensor<T,1>>(x).size(); }


  template <typename...Ts, size_t...Is>
  static std::tuple<std::array<size_t, sizeof...(Ts)>,size_t> ResultSize(std::tuple<Ts...>&& x,std::index_sequence<Is...>)
  {
    size_t size = 0;
    std::array<size_t, sizeof...(Ts)> offsets;
    (void) std::initializer_list<int>{(offsets[Is] = size, size += ResultSize(std::get<Is>(x)), 0)...};
    return std::make_tuple(offsets,size);
  }


  template<typename T>
  static std::enable_if_t<!isSpecialization<T,std::tuple>::value>
  messageOutput(FluidMaxWrapper *x, t_symbol* s, MessageResult<T> r)
  {
    size_t resultSize = ResultSize(static_cast<T>(r));
    std::vector<t_atom> out(resultSize);
    ParamAtomConverter::toAtom(out.data(),static_cast<T>(r));
    object_obex_dumpout(x, s, static_cast<long>(resultSize), out.data());
  }

  template<typename...Ts>
  static void messageOutput(FluidMaxWrapper *x, t_symbol* s, MessageResult<std::tuple<Ts...>> r)
  {
    auto indices = std::index_sequence_for<Ts...>();
    size_t resultSize;
    std::array<size_t, sizeof...(Ts)> offsets;
    std::tie(offsets,resultSize) = ResultSize(static_cast<std::tuple<Ts...>>(r), indices);
    std::vector<t_atom> out(resultSize);
    ParamAtomConverter::toAtom(out.data(),static_cast<std::tuple<Ts...>>(r),indices,offsets);
    object_obex_dumpout(x, s, static_cast<long>(resultSize), out.data());
  }

  static void messageOutput(FluidMaxWrapper *x, t_symbol* s,MessageResult<void>)
  {
    object_obex_dumpout(x, s, 0,nullptr);
  }


  //Sets up a single message
  template <size_t N, typename T>
  struct SetupMessage
  {
    void operator()(const T& message)
    {
      class_addmethod(getClass(), (method)invokeMessage<N>, message.name,A_GIMME, 0);
    }
  };


  // Sets up a single attribute
  // TODO: static assert on T?
  template <size_t N, typename T>
  struct SetupAttribute
  {
    void operator()(const T &attr)
    {
      std::string       name            = lowerCase(attr.name);
      method            setterMethod    = (method) &Setter<T, N>::set;
      method            getterMethod    = (method) &Getter<T, N>::get;
      t_object*         a               = attribute_new(name.c_str(), maxAttrType(attr), 0, getterMethod, setterMethod);
      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), name.c_str(), 0, attr.displayName);
      decorateAttr(attr,name);
    }

    template<typename U>
    void decorateAttr(const U &/*attr*/, std::string /*name*/)
    {}

    void decorateAttr(const EnumT& attr, std::string name)
    {
      std::stringstream enumstrings;
      for(auto i = 0u; i < attr.numOptions;++i) enumstrings << '"' << attr.strings[i] << "\" ";
      CLASS_ATTR_STYLE(getClass(), name.c_str(),0,"enum");
      CLASS_ATTR_ENUMINDEX(getClass(), name.c_str(), 0, enumstrings.str().c_str());
    }

  };

  // Get Symbols for attribute types

  static t_symbol* maxAttrType(FloatT) { return USESYM(float64); }
  static t_symbol* maxAttrType(LongT) { return USESYM(long); }
  static t_symbol* maxAttrType(BufferT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(InputBufferT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(EnumT) { return USESYM(long); }
  static t_symbol* maxAttrType(FloatPairsArrayT) { return gensym("atom"); }
  static t_symbol* maxAttrType(FFTParamsT) { return gensym("atom"); }

  template<typename T>
  static std::enable_if_t<IsSharedClient<typename T::type>::value, t_symbol*>
  maxAttrType(T) { return USESYM(symbol); }


  Result        mResult;
  void *        mNRTDoneOutlet;
  void *        mControlOutlet;
  void *        mDumpOutlet;
  void *        mProgressOutlet;
  bool          mVerbose;
  ParamSetType  mParams;
  ParamSetType  mParamSnapshot;
  Client        mClient;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template<typename RT = std::true_type>
struct InputTypeWrapper
{
  using type = double;
};

template<>
struct InputTypeWrapper<std::false_type>
{
  using type = float;
};

template <class Client>
void makeMaxWrapper(const char *classname)
{
//  using InputType = typename InputTypeWrapper<isRealTime<Client<double>>>::type;

  FluidMaxWrapper<Client>::makeClass(classname);
}

} // namespace client
} // namespace fluid
