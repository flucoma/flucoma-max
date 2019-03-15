#pragma once

#include <ext.h>
#include <ext_obex.h>
#include <ext_obex_util.h>
#include <z_dsp.h>

#include <commonsyms.h>

#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/OfflineClient.hpp>
#include <clients/common/ParameterSet.hpp>
#include <clients/common/ParameterTypes.hpp>

#include <MaxBufferAdaptor.hpp>

#include <tuple>
#include <utility>

namespace fluid {
namespace client {

//////////////////////////////////////////////////////////////////////////////////////////////////
// Forward declaration

template <typename Client>
class FluidMaxWrapper;
    
//////////////////////////////////////////////////////////////////////////////////////////////////
namespace impl {

template <typename Client>
void printResult(FluidMaxWrapper<Client>* x)
{
  if (!x) return;

  if (x->verbose() && !x->messages().ok())
  {
    switch (x->messages().status())
    {
    case Result::Status::kWarning: object_warn((t_object *) x, x->messages().message().c_str()); break;
    case Result::Status::kError: object_error((t_object *) x, x->messages().message().c_str()); break;
    default: {
    }
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
template <size_t ParamIdx, typename T, T Method(const t_atom *av)>
struct FetchValue
{
  template <typename Params>
  T operator()(const long ac, t_atom *av, Params &params, long &currentCount)
  {
    return currentCount < ac ? Method(av + currentCount++) : params.template defaultAt<ParamIdx>();
  }
};

template <size_t ParamIdx, typename T>
struct Fetcher;

template <size_t ParamIdx>
struct Fetcher<ParamIdx, FloatT> : public FetchValue<ParamIdx, t_atom_float, atom_getfloat>
{};

template <size_t ParamIdx>
struct Fetcher<ParamIdx, LongT> : public FetchValue<ParamIdx, t_atom_long, atom_getlong>
{};
//////////////////////////////////////////////////////////////////////////////////////////////////

template <typename Client, typename T, size_t N>
struct Setter;
template <typename Client, typename T, size_t N>
struct Getter;

/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// We need set + get specialisations for each allowed type (Float,Long, Buffer, Enum, FloatArry, LongArray, BufferArray)

// Setters


template<typename Client, size_t N, typename T, T Method(const t_atom *av)>
struct SetValue
{
  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    x->messages().reset();
    x->params().template set<N>(Method(av), x->verbose() ? &x->messages() : nullptr);
    printResult(x);
    object_attr_touch((t_object *) x, gensym("latency"));
    return MAX_ERR_NONE;
  }
};
    
template <typename Client, size_t N>
struct Setter<Client, FloatT, N> : public SetValue<Client, N, t_atom_float, &atom_getfloat>
{};

template <typename Client, size_t N>
struct Setter<Client, LongT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong>
{};

template <typename Client, size_t N>
struct Setter<Client, EnumT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong>
{};

//////////////////////////////////////////////////////////////////////////////////////////////////
    
template <typename Client, size_t N>
struct Setter<Client, FloatPairsArrayT, N>
{
  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    using type  = typename FloatPairsArrayT::type;
    type &param = x->params().template get<N>();
    assert(ac = param.size() * 2 && "Array parameter is wrong length");
    for (auto &&a : param)
    {
      a.first  = atom_getfloat(av++);
      a.second = atom_getfloat(av++);
    }
    x->messages().reset();
    x->params().template set<N>(param, x->verbose() ? &x->messages() : nullptr);
    printResult(x);
    return MAX_ERR_NONE;
  }
};
    
//////////////////////////////////////////////////////////////////////////////////////////////////

template <typename Client, size_t N>
struct Setter<Client, FFTParamsT, N>
{
  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    using type  = typename FFTParamsT::type;
    type &param = x->params().template get<N>();
    param.setWin(atom_getlong(av++));
    param.setHop(atom_getlong(av++));
    param.setFFT(atom_getlong(av++));
    x->messages().reset();
    x->params().template set<N>(param, x->verbose() ? &x->messages() : nullptr);
    printResult(x);
    object_attr_touch((t_object *) x, gensym("latency"));
    return MAX_ERR_NONE;
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template<typename Client, size_t N>
struct Setter<Client, BufferT, N >
{
  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    using type = typename BufferT::type;
    auto b     = static_cast<MaxBufferAdaptor *>(x->params().template get<N>().get());
    x->messages().reset();
    if (b)
      b->set(atom_getsym(av));
    else
      x->params().template set<N>(type(new MaxBufferAdaptor((t_object *) x, atom_getsym(av))),
                                  x->verbose() ? &x->messages() : nullptr);
    printResult(x);
    return MAX_ERR_NONE;
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////
// Getters

template<typename Client, size_t N, typename T, t_max_err Method(t_atom *av, T)>
struct GetValue
{
  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc(ac, av, &alloc);
    (Method)(*av, x->params().template get<N>());
    return MAX_ERR_NONE;
  }
};

template <typename Client, size_t N>
struct Getter<Client, FloatT, N> : public GetValue<Client,N, double, &atom_setfloat>
{};

template <typename Client, size_t N>
struct Getter<Client, LongT, N> : public GetValue<Client, N, t_atom_long, &atom_setlong>
{};

template <typename Client, size_t N>
struct Getter<Client, EnumT, N> : public GetValue<Client, N, t_atom_long, &atom_setlong>
{};
    
//////////////////////////////////////////////////////////////////////////////////////////////////

template <typename Client, size_t N>
struct Getter<Client, BufferT, N>
{
  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc(ac, av, &alloc);
    auto b = static_cast<MaxBufferAdaptor *>(x->params().template get<N>().get());
    atom_setsym(*av, b ? b->name() : nullptr);
    //    (Method)(*av, x->mClient.template get<N>());
    return MAX_ERR_NONE;
  }
};

    //////////////////////////////////////////////////////////////////////////////////////////////////

template <typename Client, size_t N>
struct Getter<Client, FloatPairsArrayT, N>
{
  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc_array(4, ac, av, &alloc);
    auto &param = x->params().template get<N>();
    //    assert(*ac == param.size() * 2 && "Array parameter is unexpected length");
    t_atom *arr = *av;
    for (auto &&a : param)
    {
      atom_setfloat(arr++, a.first);
      atom_setfloat(arr++, a.second);
    }
    return MAX_ERR_NONE;
  }
};
    
//////////////////////////////////////////////////////////////////////////////////////////////////

template <typename Client, size_t N>
struct Getter<Client, FFTParamsT, N>
{
  using type = typename FFTParamsT::type;

  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc_array(3, ac, av, &alloc);
    type &  param = x->params().template get<N>();
    t_atom *arr   = *av;
    atom_setlong(arr++, param.winSize());
    atom_setlong(arr++, param.hopRaw());
    atom_setlong(arr++, param.fftRaw());

    return MAX_ERR_NONE;
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template<typename Client, size_t, typename>
struct Notify
{
  static void notify(FluidMaxWrapper<Client>*, t_symbol*, t_symbol*, void*, void*) {}
};

template<typename Client, size_t N>
struct Notify<Client, N, BufferT>
{
  static void notify(FluidMaxWrapper<Client>* x, t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    if (auto p = static_cast<MaxBufferAdaptor *>(x->params().template get<N>().get())) p->notify(s, msg, sender, data);
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////
template <typename Wrapper>
t_max_err getLatency(Wrapper *x, t_object *attr, long *ac, t_atom **av)
{
  char alloc;
  atom_alloc(ac, av, &alloc);
  atom_setlong(*av, x->client().latency());
  return MAX_ERR_NONE;
}
//////////////////////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
class RealTime
{
  using ViewType = FluidTensorView<double, 1>;

  //  using Client = typename Wrapper::Client;
  //  using Params = typename Wrapper::Params;

public:
  static void setup(t_class *c)
  {
    class_dspinit(c);
    class_addmethod(c, (method) callDSP, "dsp64", A_CANT, 0);
    class_addattr(c, attribute_new("latency", USESYM(long), 0, (method) getLatency<Wrapper>, nullptr));
  }

  static void callDSP(Wrapper *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    x->dsp(dsp64, count, samplerate, maxvectorsize, flags);
  }

  static void callPerform(Wrapper *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size,
                          long flags, void *userparam)
  {
    x->perform(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam);
  }

  void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {

    Wrapper *wrapper = static_cast<Wrapper *>(this);
    auto &   client  = wrapper->client();

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

  void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags,
               void *userparam)
  {
    auto &client = static_cast<Wrapper *>(this)->mClient;
    for (int i = 0; i < numins; ++i)
      if (audioInputConnections[i]) mInputs[i].reset(ins[i], 0, sampleframes);

    for (int i = 0; i < client.audioChannelsOut(); ++i)
      // if(audioOutputConnections[i])
      mOutputs[i].reset(outs[i], 0, sampleframes);

    for (int i = 0; i < client.controlChannelsOut(); ++i) mOutputs[i].reset(&mControlOutputs[i], 0, 1);

    client.process(mInputs, mOutputs);

    if (mControlClock) clock_delay(mControlClock, 0);
  }

  void controlData()
  {
    Wrapper *w      = static_cast<Wrapper *>(this);
    auto &   client = w->client();
    atom_setdouble_array(client.controlChannelsOut(), mControlAtoms.data(), client.controlChannelsOut(),
                         mControlOutputs.data());
    w->controlOut(client.controlChannelsOut(), mControlAtoms.data());
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
};
//////////////////////////////////////////////////////////////////////////////////////////////////
template <class Wrapper>
struct NonRealTime
{
  static void setup(t_class *c) { class_addmethod(c, (method) deferProcess, "bang", A_GIMME, 0); }

  void process(t_symbol *s, long ac, t_atom *av)
  {
    auto &wrapper = static_cast<Wrapper &>(*this);
    auto &client  = wrapper.mClient;

    Result res = client.process();
    if (!res.ok())
    {
      switch (res.status())
      {
      case Result::Status::kWarning: object_warn((t_object *) &wrapper, res.message().c_str()); break;
      case Result::Status::kError: object_error((t_object *) &wrapper, res.message().c_str()); break;
      default: {
      }
      }
      return;
    }
    wrapper.bang();
  }

  static void deferProcess(Wrapper *x, t_symbol *s, long ac, t_atom *av) { defer(x, (method) &callProcess, s, ac, av); }

  static void callProcess(Wrapper *x, t_symbol *s, short ac, t_atom *av) { x->process(s, ac, av); }
};

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
  t_object *  getMaxObject() { return (t_object *) &mObject; }
  t_pxobject *getMSPObject() { return &mObject; }
  t_pxobject  mObject;
};
//////////////////////////////////////////////////////////////////////////////////////////////////
// Templates and specilisations for all possible base options

template <class Wrapper, typename NRT, typename RT>
struct FluidMaxBaseImpl : public MaxBase
{
  static_assert(isRealTime<FluidMaxBaseImpl>::value || isNonRealTime<FluidMaxBaseImpl>::value,
                "This object seems to be neither real-time nor non-real-time! Check that your Client inherits from "
                "Audio[In/Out], Control[In/Out] or Offline[In/Out]");
};

template <class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::true_type, std::false_type> : public MaxBase, public NonRealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::false_type, std::true_type> : public MaxBase, public RealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::true_type, std::true_type> : public MaxBase, public NonRealTimeAndRealTime<Wrapper>
{};

// Base class selection
///Move to client layer, so all hosts can use this
//template<typename T> using isRealTime = typename std::is_base_of<Audio,T>::type;
//template<typename T> using isNonRealTime = typename std::is_base_of<Offline, T>::type;
 //////////////////////////////////////////////////////////////////////////////////////////////////
template <typename Client>
using FluidMaxBase = FluidMaxBaseImpl<FluidMaxWrapper<Client>, isNonRealTime<Client>, isRealTime<Client>>;

} // namespace impl
  
template <typename C>
class FluidMaxWrapper : public impl::FluidMaxBase<C>
{
  friend impl::RealTime<FluidMaxWrapper<C>>;
  friend impl::NonRealTime<FluidMaxWrapper<C>>;
    
public:
  
  using Client = C;
  using ParamDescriptors = typename C::Params;
  using Params = ParameterSet<ParamDescriptors>;
  
  FluidMaxWrapper(t_symbol*, long ac, t_atom *av)
    : mParams(*getParamDescriptors())
    , mClient{initParamsFromAttributeArgs(ac,av)}
  {
    if (mClient.audioChannelsIn())
    {
      dsp_setup(impl::MaxBase::getMSPObject(), mClient.audioChannelsIn());
      impl::MaxBase::getMSPObject()->z_misc |= Z_NO_INPLACE;
    }

    object_obex_store(this, _sym_dumpout, (t_object *) outlet_new(this, nullptr));

    attr_args_process((t_object *) this, ac, av);

    if (isNonRealTime<Client>::value) mNRTDoneOutlet = bangout(this);

    if (mClient.controlChannelsOut()) mControlOutlet = listout(this);

    for (int i = 0; i < mClient.audioChannelsOut(); ++i) outlet_new(this, "signal");
  }

  void bang() { outlet_bang(mNRTDoneOutlet); }

  void controlOut(long ac, t_atom *av) { outlet_list(mControlOutlet, nullptr, ac, av); }

  static void *create(t_symbol *sym, long ac, t_atom *av)
  {
    void *x = object_alloc(getClass());
    new (x) FluidMaxWrapper(sym, ac, av);

    if (attr_args_offset(ac, av) > Params::NumFixedParams)
    { object_warn((t_object *) x, "Too many arguments. Got %d, expect at most %d", ac, Params::NumFixedParams); }

    return x;
  }
  
  static void destroy(FluidMaxWrapper * x)
  {
    x->~FluidMaxWrapper();
  }
  
  static void makeClass(const char *className)
  {
    const ParamDescriptors& p = Client::getParameterDescriptor();
    getClass(class_new(className, (method)create, (method)destroy, sizeof(FluidMaxWrapper), 0, A_GIMME, 0));
    getParamDescriptors(&p);
    impl::FluidMaxBase<C>::setup(getClass());
    
    class_addmethod(getClass(), (method)doNotify, "notify",A_CANT, 0);
    class_addmethod(getClass(), (method)object_obex_dumpout,"dumpout",A_CANT, 0);
    class_addmethod(getClass(), (method)doReset, "reset",0);
    
    CLASS_ATTR_LONG(getClass(), "warnings", 0, FluidMaxWrapper, mVerbose);
    CLASS_ATTR_FILTER_CLIP(getClass(), "warnings", 0, 1);
    CLASS_ATTR_STYLE_LABEL(getClass(), "warnings", 0, "onoff", "Report Warnings");

    Params::template iterateMutableParameterDescriptors<SetupAttribute>(p.descriptors());
    class_dumpout_wrap(getClass());
    class_register(CLASS_BOX, getClass());
  }

  static void doReset(FluidMaxWrapper *x)
  {
    x->params().reset();
    x->params().template forEachParam<touchAttribute>(x);
  }

  Result &messages() { return mResult; }
  bool    verbose() { return mVerbose; }
  Client &client() { return mClient; }
  Params &params() { return mParams; }

private:
  static ParamDescriptors *getParamDescriptors(const ParamDescriptors *setParam = nullptr)
  {
    static const ParamDescriptors *p = nullptr;
    return (p = setParam ? setParam : p);
  }

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
    void operator()(typename T::type &attr, FluidMaxWrapper *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
    {
      impl::Notify<Client,N,T>::notify(x, s, msg, sender, data);
    }
  };

  template <size_t N, typename T>
  struct touchAttribute
  {
    void operator()(typename T::type &attr, FluidMaxWrapper *x)
    {
      object_attr_touch((t_object *) x, gensym(FluidMaxWrapper::lowerCase(x->params().template name<N>()).c_str()));
    }
  };

  Params &initParamsFromAttributeArgs(long ac, t_atom *av)
  {
    // Process arguments for instantiation parameters
    if (long numArgs = attr_args_offset(ac, av))
    {
      long argCount{0};
      mParams.template setFixedParameterValues<impl::Fetcher>(true, numArgs, av, mParams, argCount);
    }
    // process in-box attributes for mutable params
    attr_args_process((t_object *) this, ac, av);
    // return params so this can be called in client initaliser
    return mParams;
  }

  // Sets up a single attribute
  // TODO: static assert on T?

  template <size_t N, typename T>
  struct SetupAttribute
  {
    void operator()(const T &attr)
    {
      std::string   name            = lowerCase(attr.name);
      method        setterMethod    = (method) &impl::Setter<Client, T, N>::set;
      method        getterMethod    = (method) &impl::Getter<Client, T, N>::get;
      t_object*     a               = attribute_new(name.c_str(), maxAttrType(attr), 0, getterMethod, setterMethod);

      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), name.c_str(), 0, attr.displayName);
    }
  };

  // Get Symbols for attribute types

  static t_symbol *maxAttrType(FloatT) { return USESYM(float64); }
  static t_symbol *maxAttrType(LongT) { return USESYM(long); }
  static t_symbol *maxAttrType(BufferT) { return USESYM(symbol); }
  static t_symbol *maxAttrType(EnumT) { return USESYM(long); }
  static t_symbol *maxAttrType(FloatPairsArrayT) { return _sym_atom; }
  static t_symbol *maxAttrType(FFTParamsT) { return _sym_atom; }

  Result mResult;
  void * mNRTDoneOutlet;
  void * mControlOutlet;
  bool   mVerbose;
  Params mParams;
  Client mClient;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

template <class Client>
void makeMaxWrapper(const char *classname)
{
  FluidMaxWrapper<Client>::makeClass(classname);
}

} // namespace client
} // namespace fluid

