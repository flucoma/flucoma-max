/*
Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
Copyright 2017-2019 University of Huddersfield.
Licensed under the BSD-3 License.
See license.md file in the project root for full license information.
This project has received funding from the European Research Council (ERC)
under the European Union’s Horizon 2020 research and innovation programme
(grant agreement No 725899).
*/

#pragma once

#include <ext.h>
#include <ext_atomic.h>
#include <ext_dictobj.h>
#include <ext_obex.h>
#include <ext_obex_util.h>
#include <z_dsp.h>

#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/FluidNRTClientWrapper.hpp>
#include <clients/common/OfflineClient.hpp>
#include <clients/common/ParameterSet.hpp>
#include <clients/common/ParameterTypes.hpp>
#include <clients/nrt/FluidSharedInstanceAdaptor.hpp>

#include <data/FluidMemory.hpp>

#include "MaxBufferAdaptor.hpp"

#include <FluidVersion.hpp>
#include <atomic>
#include <cctype> //std::tolower
#include <deque>
#include <map>
#include <tuple>
#include <utility>

namespace fluid {
namespace client {

namespace dataset {
  class DataSetClient;
}

namespace labelset {
  class LabelSetClient;
}

template<typename T>
const char* SharedClientName="Unrecognised object";

template<>
const char* SharedClientName<dataset::DataSetClient> ="fluid.dataset~";

template<>
const char* SharedClientName<labelset::LabelSetClient> ="fluid.labelset~";


////////////////////////////////////////////////////////////////////////////////

namespace impl {

template <typename Wrapper>
t_max_err getLatency(Wrapper* x, t_object* /*attr*/, long* ac, t_atom** av)
{
  char alloc;
  atom_alloc(ac, av, &alloc);
  atom_setlong(*av, static_cast<t_atom_long>(x->client().latency()));
  return MAX_ERR_NONE;
}

////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
class RealTime
{
  using ViewType = FluidTensorView<double, 1>;

public:
  static void setup(t_class* c)
  {

    constexpr bool isModel =
        Wrapper::template IsModel_t<typename Wrapper::ClientType>::value;

    if (isModel)
    {
      class_addmethod(c, (method) Wrapper::assistDataObject, "assist", A_CANT,
                      0);
    }
    else
      class_addmethod(c, (method) assist, "assist", A_CANT, 0);

    /// FIXME: Better test needed
    using ClientClass = typename Wrapper::ClientType::Client;
    constexpr bool addDSP = !(isModel && isControl<ClientClass>);

    if (addDSP)
    {
      class_dspinit(c);
      class_addmethod(c, (method) callDSP, "dsp64", A_CANT, 0);
      class_addattr(c, attribute_new("latency", USESYM(long), 0,
                                     (method) getLatency<Wrapper>, nullptr));
      CLASS_ATTR_LABEL(c, "latency", 0, "Latency");
    }
  }

  static void callDSP(Wrapper* x, t_object* dsp64, short* count,
                      double samplerate, long maxvectorsize, long flags)
  {
    x->dsp(dsp64, count, samplerate, maxvectorsize, flags);
  }

  static void callPerform(Wrapper* x, t_object* dsp64, double** ins,
                          long numins, double** outs, long numouts,
                          long vec_size, long flags, void* userparam)
  {
    x->perform(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam);
  }

  void dsp(t_object* dsp64, short* count, double samplerate, long maxvectorsize,
           long /*flags*/)
  {
    Wrapper* wrapper = static_cast<Wrapper*>(this);
    if (!Wrapper::template IsModel_t<typename Wrapper::ClientType>::value)
      wrapper->mClient = typename Wrapper::ClientType{
          wrapper->mParams,
          FluidContext(maxvectorsize, FluidDefaultAllocator())};

    auto& client = wrapper->client();

    client.sampleRate(samplerate);

    audioInputConnections.resize(asUnsigned(client.audioChannelsIn()));
    std::copy(count, count + client.audioChannelsIn(),
              audioInputConnections.begin());

    assert((client.audioChannelsOut() > 0) !=
               (client.controlChannelsOut().count > 0) &&
           "Client must *either* be audio out or control out, sorry");

    audioOutputConnections.resize(asUnsigned(client.audioChannelsOut()));
    std::copy(count + client.audioChannelsIn(),
              count + client.audioChannelsIn() + client.audioChannelsOut(),
              audioOutputConnections.begin());

    mInputs = std::vector<ViewType>(asUnsigned(client.audioChannelsIn()),
                                    ViewType(nullptr, 0, 0));

    if (client.audioChannelsOut() > 0)
      mOutputs = std::vector<ViewType>(asUnsigned(client.audioChannelsOut()),
                                       ViewType(nullptr, 0, 0));
    if (client.controlChannelsOut().count > 0 && client.audioChannelsIn() > 0)
    {
      mControlClock =
          mControlClock ? mControlClock
                        : clock_new((t_object*) wrapper, (method) doControlOut);
      mTick.clear();

      mControlOutputs.resize(asUnsigned(client.maxControlChannelsOut()));
      
      mOutputs.clear(); 
      mOutputs.emplace_back(mControlOutputs.data(),0,mControlOutputs.size());
      mControlAtoms.resize(asUnsigned(client.maxControlChannelsOut()));
      
    }

    if(!(client.controlChannelsIn() > 0))
      object_method(dsp64, gensym("dsp_add64"), wrapper, ((method) callPerform),
                  0, nullptr);
  }

  void perform(t_object* /*dsp64*/, double** ins, long numins, double** outs,
               long /*numouts*/, long sampleframes, long /*flags*/,
               void* /*userparam*/)
  {

    auto  wrapper = static_cast<Wrapper*>(this);
    auto& client = wrapper->mClient;
    ATOMIC_INCREMENT(&wrapper->mInPerform);

    for (index i = 0; i < numins; ++i)
      if (audioInputConnections[asUnsigned(i)])
        mInputs[asUnsigned(i)].reset(ins[i], 0, sampleframes);

    for (index i = 0; i < client.audioChannelsOut(); ++i)
    {
      set_zero64(outs[i], sampleframes);
      mOutputs[asUnsigned(i)].reset(outs[asUnsigned(i)], 0, sampleframes);
    }

    client.process(mInputs, mOutputs, mContext);

    if (mControlClock && !mTick.test_and_set()) clock_delay(mControlClock, 0);

    ATOMIC_DECREMENT(&wrapper->mInPerform);
  }

  void controlData()
  {
    Wrapper* w = static_cast<Wrapper*>(this);
    auto&    client = w->client();
    atom_setdouble_array(
        static_cast<long>(client.controlChannelsOut().size), mControlAtoms.data(),
        static_cast<long>(client.controlChannelsOut().size), mControlOutputs.data());
    w->controlOut(static_cast<long>(client.controlChannelsOut().size),
                  mControlAtoms.data());
    mTick.clear();
  }

  static void assist(Wrapper* x, void* /*b*/, long io, long index, char* s)
  {
    auto& client = x->client();
    switch (io)
    {
    case 1:
    {
      if(!client.controlChannelsIn())
        snprintf_zero(s, 512, "(signal) %s", client.getInputLabel(index));
      else
        snprintf_zero(s, 512, "(list) %s", client.getInputLabel(index));
      break;
    }
    case 2:
      if (index < client.audioChannelsOut())
      {
        snprintf_zero(s, 512, "(signal) %s", client.getOutputLabel(index));
        break;
      }
      else if (index <
               client.audioChannelsOut() + client.controlChannelsOut().count)
      {
        snprintf_zero(s, 512, "(list) %s", client.getOutputLabel(index));
        break;
      }
      else
      {
        strncpy_zero(s, "(list) dumpout", 512);
        break;
      }
    }
  }

  ~RealTime()
  {
    if (mControlClock) freeobject((t_object*) mControlClock);
  }

private:
  static void           doControlOut(Wrapper* x) { x->controlData(); }
  std::vector<ViewType> mInputs;
  std::vector<ViewType> mOutputs;
  std::vector<short>    audioInputConnections;
  std::vector<short>    audioOutputConnections;
  std::vector<double>   mControlOutputs;
  std::vector<t_atom>   mControlAtoms;
  void*                 mControlClock;
  std::atomic_flag      mTick;
  FluidContext          mContext;
};

////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
struct NonRealTime
{
  
//  std::array<t_buffer_ref*,Wrapper::ParamDescType::NumOf<BufferT>> outputBufferThings;
    
  NonRealTime()
  {
    mQelem = qelem_new(static_cast<Wrapper*>(this), (method) checkProcess);
    mClock = clock_new(static_cast<Wrapper*>(this), (method) clockTick);
  }

  ~NonRealTime()
  {
    qelem_free(mQelem);
    object_free(mClock);
  }

  static void setup(t_class* c)
  {

    using Client = typename Wrapper::ClientType;
    constexpr bool isDataObject =
        Wrapper::template IsThreadedShared<Client>::value ||
        Wrapper::template IsModel_t<Client>::value;

    if (isDataObject)
    {
      class_addmethod(c, (method) Wrapper::assistDataObject, "assist", A_CANT,
                      0);
    }
    else
    {
      class_addmethod(c, (method) deferProcess, "bang", 0);
      if(Wrapper::NumInputBuffers) class_addmethod(Wrapper::getClass(), (method) doBuffer, "buffer", A_GIMME, 0);
      class_addmethod(c, (method) callCancel, "cancel", 0);
      class_addmethod(c, (method) assist, "assist", A_CANT, 0);
      
      CLASS_ATTR_LONG(c, "blocking", 0, Wrapper, mSynchronous);
      CLASS_ATTR_FILTER_CLIP(c, "blocking", 0, 2);
      CLASS_ATTR_ENUMINDEX(
          c, "blocking", 0,
          "Non-Blocking \"Blocking (Low Priority)\" \"Blocking "
          "(High Priority)\"");
      CLASS_ATTR_LABEL(c, "blocking", 0, "Blocking");

      CLASS_ATTR_LONG(c, "queue", 0, Wrapper, mQueueEnabled);
      CLASS_ATTR_FILTER_CLIP(c, "queue", 0, 1);
      CLASS_ATTR_STYLE_LABEL(c, "queue", 0, "onoff", "Non-Blocking Queue Flag");
    }
  }

  void cancel()
  {
    auto& wrapper = static_cast<Wrapper&>(*this);
    auto& client = wrapper.mClient;
    client.cancel();
  }

  template <size_t N, typename T>
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
    auto& wrapper = static_cast<Wrapper&>(*this);
    auto& client = wrapper.mClient;
    long  syncMode = mSynchronous;
    bool  synchronous = syncMode > 0;

    wrapper.mParams.template forEachParamType<BufferT, BufferImmediate>(
        syncMode == 2);

    client.setSynchronous(synchronous);
    client.setQueueEnabled(mQueueEnabled);

    Result res = client.process();
    if (wrapper.checkResult(res))
    {
      if (synchronous)
        wrapper.doneBang();
      else
        clockWait();
    }
  }

  static void callCancel(Wrapper* x) {
    x->cancel();
    t_box *b;
    t_max_err err = object_obex_lookup(x, gensym("#B"), (t_object **)&b);
    if(!err)
      object_method(b, gensym("stopprogress"));
  }

  static void dobang(Wrapper *x) {
    index in = proxy_getinlet(x);
    
    if(in == 0) deferProcess(x);
  }

  static void deferProcess(Wrapper* x)
  {
    x->mClient.enqueue(x->mParams);

    if (x->mSynchronous != 2)
    {
      if(x->mSynchronous == 0)
      {
        t_box *b;
        t_max_err err = object_obex_lookup((t_object*)x, gensym("#B"), (t_object **)&b);
        if(!err)
          object_method(b, gensym("startprogress"),&x->mProgress);
      }
    
      defer(x, (method) &callProcess, nullptr, 0, nullptr);
    }
    else
    {
      callProcess(x, nullptr, 0, nullptr);
    }
  }

  static void callProcess(Wrapper* x, t_symbol*, short, t_atom*)
  {
    x->process();
  }

  static void checkProcess(Wrapper* x)
  {
    Result res;
    auto&  client = x->mClient;

    ProcessState state = client.checkProgress(res);

    if (state == ProcessState::kDone ||
        state == ProcessState::kDoneStillProcessing)
    {
      if (x->checkResult(res)) x->doneBang();
    }

    if (state != ProcessState::kDone)
    {
      x->progress(client.progress());
      x->clockWait();
    }
  }

  static void doBuffer(Wrapper* x, t_symbol*, long ac, t_atom* av)
  {
      index inlet =proxy_getinlet((t_object *)x);
      
      x->mBufferDispatch[inlet](x,ac,av);
      
      if(inlet == 0)
      {
       
       static std::array<t_symbol*, 4> rangeAttributes{
          gensym("startframe"),gensym("numframes"),gensym("startchan"),gensym("numchans")
       };
       //extra args in left inlet are interpreted as setting input buffer range:
       for(index i = 1; i < ac && i < 5; ++i)
          object_attr_setlong(x, rangeAttributes[i - 1], atom_getlong(av + i));
       
       deferProcess(x);
      }
  }
  
  static void clockTick(Wrapper* x) { qelem_set(x->mQelem); }

  static void assist(Wrapper* x, void* /*b*/, long io, long index, char* s)
  {

    using Client = typename Wrapper::ClientType;

    constexpr bool isDataObject =
        Wrapper::template IsThreadedShared<Client>::value ||
        Wrapper::template IsModel_t<Client>::value;

    if (isDataObject)
    {
      switch (io)
      {
      case 1: strncpy_zero(s, "(anything) messages in", 512); break;
      case 2:
        if (index < 1)
        {
          strncpy_zero(s, "(anything) message results", 512);
          break;
        }
        else
        {
          strncpy_zero(s, "(anything) dumpout", 512);
          break;
        }
      }
    }
    else
    {
      switch (io)
      {
      case 1:
        {
          if(index == 0) strncpy_zero(s, "(bang) start processing; (buffer <symbol>) set source and start processing", 512);
          else x->mInputBufferAssist[index](x,s);
          break;
        }
      case 2:
          if(index < Wrapper::NumOutputBuffers)
          {
             x->mOutputBufferAssist[index](x,s);
          }
          else strncpy_zero(s, "(anything) dumpout", 512);
      }
    }
  }

  void clockWait()
  {
    clock_set(mClock, 20); // FIX - set at 20ms for now...
  }


protected:
  long  mSynchronous = 1;
  long  mQueueEnabled = 0;
  void* mQelem;
  void* mClock;
};

////////////////////////////////////////////////////////////////////////////////

template <class Wrapper>
struct NonRealTimeAndRealTime : public RealTime<Wrapper>,
                                public NonRealTime<Wrapper>
{
  static void setup(t_class* c)
  {
    RealTime<Wrapper>::setup(c);
    NonRealTime<Wrapper>::setup(c);
  }
};

////////////////////////////////////////////////////////////////////////////////

// Max base type

struct MaxBase
{
  t_object*   getMaxObject() { return (t_object*) &mObject; }
  t_pxobject* getMSPObject() { return &mObject; }
  t_pxobject  mObject;
};

////////////////////////////////////////////////////////////////////////////////

// Templates and specialisations for all possible base options

template <class Wrapper, typename NRT, typename RT>
struct FluidMaxBase : public MaxBase
{
  static_assert(isRealTime<FluidMaxBase>::value ||
                    isNonRealTime<FluidMaxBase>::value,
                "This object seems to be neither real-time nor non-real-time! "
                "Check that your Client inherits from "
                "Audio[In/Out], Control[In/Out] or Offline[In/Out]");
};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::true_type, std::false_type>
    : public MaxBase, public NonRealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::false_type, std::true_type>
    : public MaxBase, public RealTime<Wrapper>
{};

template <class Wrapper>
struct FluidMaxBase<Wrapper, std::true_type, std::true_type>
    : public MaxBase, public NonRealTimeAndRealTime<Wrapper>
{};

////////////////////////////////////////////////////////////////////////////////

} // namespace impl

template <typename Client>
class FluidMaxWrapper
    : public impl::FluidMaxBase<FluidMaxWrapper<Client>,
                                typename Client::isNonRealTime,
                                typename Client::isRealTime>
{

  struct StreamingListInput
  {

    void processInput(FluidMaxWrapper*, long, t_atom*)
    {
    
    }

    void operator()(FluidMaxWrapper* x, long ac, t_atom* av)
    {
      FluidContext c;
            
      atom_getdouble_array(std::min<index>(x->mListSize, ac), av,
                           std::min<index>(x->mListSize, ac),
                           x->mInputListData[0].data());
      x->mClient.process(x->mInputListViews, x->mOutputListViews, c);
      
      for (index i = 0; i <  asSigned(x->mDataOutlets.size()); ++i)
      {
        atom_setdouble_array(
            std::min<index>(x->mListSize, ac), x->mOutputListAtoms.data(),
            std::min<index>(x->mListSize, ac), x->mOutputListData[i].data());
        outlet_list(x->mDataOutlets[i], nullptr, x->mListSize,
                    x->mOutputListAtoms.data());
      }
    }
  };

  struct NoStreamingListInput
  {
    void operator()(FluidMaxWrapper*, long, t_atom*) {}
  };

  using ListInputHandler =
      std::conditional_t<isControlIn<typename Client::Client>,
                         StreamingListInput, NoStreamingListInput>;

  ListInputHandler mListHandler;

  using WrapperBase = impl::FluidMaxBase<FluidMaxWrapper<Client>,
                                         typename Client::isNonRealTime,
                                         typename Client::isRealTime>;

  friend impl::RealTime<FluidMaxWrapper<Client>>;
  friend impl::NonRealTime<FluidMaxWrapper<Client>>;

  template <typename T>
  struct IsModel
  {
    using type = std::false_type;
  };

  template <typename T>
  struct IsModel<NRTThreadingAdaptor<ClientWrapper<T>>>
  {
    using type = typename ClientWrapper<T>::isModelObject;
  };

  template <typename T>
  struct IsModel<ClientWrapper<T>>
  {
    using type = typename ClientWrapper<T>::isModelObject;
  };

  template <typename T>
  using IsModel_t = typename IsModel<T>::type;

  template <size_t N>
  static constexpr auto paramDescriptor()
  {
    return Client::getParameterDescriptors().template get<N>();
  }

  template <size_t N>
  static constexpr auto makeValue()
  {
    return Client::getParameterDescriptors().template makeValue<N>(FluidDefaultAllocator());
  }

  bool checkResult(Result& res)
  {

    if (!res.ok())
    {
      switch (res.status())
      {
      case Result::Status::kWarning:
        object_warn((t_object*) this, res.message().c_str());
        return true; //
      case Result::Status::kError:
        object_error((t_object*) this, res.message().c_str());
        break;
      case Result::Status::kCancelled:
        object_post((t_object*) this, "Job cancelled");
        break;
      default: {
      }
      }
      return false;
    }

    return true;
  }

  static void printResult(FluidMaxWrapper<Client>* x, Result& r,
                          bool alwaysWarn = false)
  {
    if (!x) return;

    if (!r.ok())
    {
      switch (r.status())
      {
      case Result::Status::kWarning:
        if (alwaysWarn || x->verbose())
          object_warn((t_object*) x, r.message().c_str());
        break;
      case Result::Status::kError:
        object_error((t_object*) x, r.message().c_str());
        break;
      default: {
      }
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  template <size_t N, typename T, T Method(const t_atom* av)>
  struct FetchValue
  {
    T operator()(const long ac, t_atom* av, long& currentCount)
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
    rt::string operator()(const long ac, t_atom* av, long& currentCount)
    {
      auto defaultValue = paramDescriptor<N>().defaultValue;
      return {currentCount < ac ? atom_getsym(av + currentCount++)->s_name
                                : defaultValue};
    }
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////

  // ParamsToAtoms
  struct ParamAtomConverter
  {

    static rt::string getString(t_atom* a)
    {
      switch (atom_gettype(a))
      {
      case A_LONG: return rt::string{std::to_string(atom_getlong(a))};
      case A_FLOAT: return rt::string{std::to_string(atom_getfloat(a))};
      default: return {atom_getsym(a)->s_name};
      }
    }

    template <typename T>
    static Optional<T> fromAtom(t_object* x, t_atom* a, Optional<T>)
    {
      return {fromAtom(x,a,T{})}; 
    }
  
    template <typename T>
    static std::enable_if_t<std::is_integral<T>::value, T>
    fromAtom(t_object* /*x*/, t_atom* a, T)
    {
      return atom_getlong(a);
    }

    template <typename T>
    static std::enable_if_t<std::is_floating_point<T>::value, T>
    fromAtom(t_object* /*x*/, t_atom* a, T)
    {
      return atom_getfloat(a);
    }

    static auto fromAtom(t_object* x, t_atom* a, BufferT::type)
    {
      return BufferT::type(new MaxBufferAdaptor(x, atom_getsym(a)));
    }

    static auto fromAtom(t_object* x, t_atom* a, InputBufferT::type)
    {
      return InputBufferT::type(new MaxBufferAdaptor(x, atom_getsym(a)));
    }

    template <typename Allocator>
    static auto fromAtom(t_object*, t_atom* a, std::basic_string<char,std::char_traits<char>, Allocator>)
    {
      return std::basic_string<char,std::char_traits<char>, Allocator>{getString(a)};
    }

    template <typename T>
    static std::enable_if_t<IsSharedClient<T>::value, T> fromAtom(t_object*,
                                                                  t_atom* a, T)
    {
      return {atom_getsym(a)->s_name};
    }

    template <typename T>
    static std::enable_if_t<std::is_integral<T>::value> toAtom(t_atom* a, T v)
    {
      atom_setlong(a, v);
    }

    template <typename T>
    static std::enable_if_t<std::is_floating_point<T>::value> toAtom(t_atom* a,
                                                                     T       v)
    {
      atom_setfloat(a, v);
    }

    static auto toAtom(t_atom* a, BufferT::type v)
    {
      auto b = static_cast<MaxBufferAdaptor*>(v.get());
      atom_setsym(a, b ? b->name() : nullptr);
    }

    static auto toAtom(t_atom* a, InputBufferT::type v)
    {
      auto b = static_cast<const MaxBufferAdaptor*>(v.get());
      atom_setsym(a, b ? b->name() : nullptr);
    }

    template<typename Allocator>
    static auto toAtom(t_atom* a, std::basic_string<char,std::char_traits<char>,Allocator> v)
    {
      atom_setsym(a, gensym(v.c_str()));
    }

    template<typename Allocator>
    static auto toAtom(t_atom* a, FluidTensor<std::basic_string<char,std::char_traits<char>,Allocator>, 1> v)
    {
      for (auto& s : v) atom_setsym(a++, gensym(s.c_str()));
    }

    template <typename T>
    static std::enable_if_t<std::is_floating_point<T>::value>
    toAtom(t_atom* a, FluidTensor<T, 1> v)
    {
      for (auto& x : v) atom_setfloat(a++, x);
    }

    template <typename T>
    static std::enable_if_t<std::is_integral<T>::value>
    toAtom(t_atom* a, FluidTensor<T, 1> v)
    {
      for (auto& x : v) atom_setlong(a++, x);
    }

    template <typename T>
    static std::enable_if_t<IsSharedClient<T>::value> toAtom(t_atom* a, T v)
    {
      atom_setsym(a, gensym(v.name()));
      //  else
      //    atom_setsym(a, gensym("<undefined object>"));
    }

    template <typename... Ts, size_t... Is>
    static void toAtom(t_atom* a, std::tuple<Ts...> const& x,
                       std::index_sequence<Is...>,
                       std::array<size_t, sizeof...(Ts)> offsets)
    {
      (void) std::initializer_list<int>{
          (toAtom(a + offsets[Is], std::get<Is>(x)), 0)...};
    }
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Setter

  template <typename T, size_t N>
  struct Setter
  {
    static constexpr index argSize = paramDescriptor<N>().fixedSize;

    static t_max_err set(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long ac, t_atom* av)
    {
      while (x->mInPerform) {} // spin-wait
      
      ParamLiteralConvertor<T, argSize> a;
      a.set(makeValue<N>());

      x->messages().reset();

      for (index i = 0; i < argSize && i < static_cast<index>(ac); i++)
        a[i] = ParamAtomConverter::fromAtom((t_object*) x, av + i, a[0]);

      x->params().template set<N>(a.value(),
                                  x->verbose() ? &x->messages() : nullptr);
      printResult(x, x->messages());
      
      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };
  
  template <size_t N>
  struct Setter<BufferT, N>
  {
    static t_max_err set(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long ac, t_atom* av)
    {
      while (x->mInPerform) {} // spin-wait
      
      ParamLiteralConvertor<BufferT, 1> a;
      a.set(makeValue<N>());

      if(!ac || atom_getsym(av) == gensym(""))
      {
          a[0] = BufferT::type(new MaxBufferAdaptor((t_object*)x, x->mHostedOutputBufferNames[N]));
      }
      else a[0] = ParamAtomConverter::fromAtom((t_object*) x, av, a[0]);
      
      x->params().template set<N>(a.value(),
                                  x->verbose() ? &x->messages() : nullptr);
      printResult(x, x->messages());
      
      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
      
    }
  
 };

  template <size_t N>
  struct Setter<LongArrayT, N>
  {

    static t_max_err set(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long ac, t_atom* av)
    {
      while (x->mInPerform) {} // spin-wait

      x->messages().reset();
      typename LongArrayT::type& a = x->params().template get<N>();

      a.resize(ac);

      using T = typename LongArrayT::type::type;

      for (index i = 0; i < static_cast<index>(ac); i++)
        a[i] = ParamAtomConverter::fromAtom((t_object*) x, av + i, T{});
        
      x->params().template set<N>(std::move(a),x->verbose() ? &x->messages() : nullptr);
        
      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };
  
  template <size_t N>
  struct Setter<LongRuntimeMaxT,N>
  {
    static t_max_err set(FluidMaxWrapper<Client>* x, t_object*, long ac, t_atom* av)
    {
      if (!ac) return MAX_ERR_NONE;
      while (x->mInPerform) {}
      x->messages().reset();
      auto& a = x->params().template get<N>();
      
      if(!x->mInitialized)
         x->params().template set<N>(LongRuntimeMaxParam(atom_getlong(av), a.maxRaw()),
                                  x->verbose() ? &x->messages() : nullptr);
      else
         x->params().template set<N>(LongRuntimeMaxParam(atom_getlong(av), a.max()),
                                  x->verbose() ? &x->messages() : nullptr);
                                  
//      x->params().template constrain<N>()
                                  
      printResult(x, x->messages());

      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };
  
  template <size_t N>
  struct Setter<FFTParamsT,N>
  {
    static t_max_err set(FluidMaxWrapper<Client>* x, t_object*, long ac, t_atom* av)
    {
      if (!ac) return MAX_ERR_NONE;
      while (x->mInPerform) {}
      x->messages().reset();
      auto& a = x->params().template get<N>();
     
      std::array<index,3> defaults{1024,-1,-1};
      for (index i = 0; i < 3 && i < static_cast<index>(ac); i++)
            defaults[i] = ParamAtomConverter::fromAtom((t_object*) x, av + i, defaults[0]);
     
      if(!x->mInitialized)
        a = FFTParams(defaults[0], defaults[1], defaults[2], a.maxRaw());
      else
        x->params().template set<N>(FFTParams(defaults[0], defaults[1], defaults[2], a.max()),
                                  x->verbose() ? &x->messages() : nullptr);
                                  
//      x->params().template constrain<N>()
                                  
      printResult(x, x->messages());

      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };
  
  

  template <size_t N>
  struct Setter<ChoicesT, N>
  {

    static t_max_err set(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long ac, t_atom* av)
    {
      while (x->mInPerform) {} // spin-wait

      x->messages().reset();
      auto desc = x->params().template descriptorAt<N>();
            
      typename ChoicesT::type a{ac ? 0u : desc.defaultValue};
      

      for (index i = 0; i < static_cast<index>(ac); i++)
      {
          t_symbol* s = atom_getsym(av + i);
          index pos = desc.lookup(s->s_name);
          if(pos == -1)
          {
            object_error((t_object*)x,"%s: unrecognised choice",s->s_name);
            continue;
          }
          a.set(pos,1);
      }
      
      x->params().template set<N>(std::move(a), x->verbose() ? &x->messages() : nullptr);
      
      object_attr_touch((t_object*) x, gensym("latency"));
      return MAX_ERR_NONE;
    }
  };


  //////////////////////////////////////////////////////////////////////////////

  // Getter

  template <typename T, size_t N>
  struct Getter
  {
    static constexpr index argSize = paramDescriptor<N>().fixedSize;

    static t_max_err get(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long* ac, t_atom** av)
    {
      ParamLiteralConvertor<T, argSize> a;

      char alloc;
      atom_alloc_array(argSize, ac, av, &alloc);

      a.set(x->params().template get<N>());

      for (index i = 0; i < argSize; i++)
        ParamAtomConverter::toAtom(*av + i, a[i]);

      return MAX_ERR_NONE;
    }
  };

  template <size_t N>
  struct Getter<LongArrayT, N>
  {

    static t_max_err get(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long* ac, t_atom** av)
    {

      typename LongArrayT::type& a = x->params().template get<N>();
      index                      argSize = a.size();

      char alloc;
      atom_alloc_array(argSize, ac, av, &alloc);

      using T = typename LongArrayT::type::type;

      for (index i = 0; i < argSize; i++)
        ParamAtomConverter::toAtom(*av + i, static_cast<T>(a[i]));

      return MAX_ERR_NONE;
    }
  };
  
  template <size_t N>
  struct Getter<LongRuntimeMaxT, N>
  {
     static t_max_err get(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long* ac, t_atom** av)
    {
        char alloc;
        atom_alloc_array(1, ac, av, &alloc);
        
        atom_setlong(av[0], x->mParams.template get<N>()());
        
        return MAX_ERR_NONE;
    }
  };

  template <size_t N>
  struct Getter<FFTParamsT, N>
  {
     static t_max_err get(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long* ac, t_atom** av)
    {
        char alloc;
        atom_alloc_array(3, ac, av, &alloc);
        
        auto a = x->mParams.template get<N>();
        
        atom_setlong(*av, a.winSize());
        atom_setlong(*av + 1, a.hopRaw());
        atom_setlong(*av + 2, a.fftRaw());
        
        return MAX_ERR_NONE;
    }
  };

  template <size_t N>
  struct Getter<ChoicesT,N>
  {
    static constexpr index argSize = paramDescriptor<N>().fixedSize;

    static t_max_err get(FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                         long* ac, t_atom** av)
    {
      
      typename ChoicesT::type& a = x->params().template get<N>();
      auto desc = x->params().template descriptorAt<N>();
      
      index argSize = a.count();
      
      char alloc;
      atom_alloc_array(argSize, ac, av, &alloc);

      for (index i = 0, arg = 0; i < desc.numOptions; i++)
      {
        if (a[i])
          ParamAtomConverter::toAtom(*av + arg++, std::string{desc.strings[i]});
      }

      return MAX_ERR_NONE;
    }
  };

  //////////////////////////////////////////////////////////////////////////////

  template <size_t, typename>
  struct Notify
  {
    static void notify(FluidMaxWrapper<Client>*, t_symbol*, t_symbol*, void*,
                       void*)
    {}
  };

  template <size_t N>
  struct Notify<N, BufferT>
  {
    static void notify(FluidMaxWrapper<Client>* x, t_symbol* s, t_symbol* msg,
                       void* sender, void* data)
    {
      if (auto p = static_cast<MaxBufferAdaptor*>(
              x->params().template get<N>().get()))
        p->notify(s, msg, sender, data);
    }
  };

  template <size_t N>
  struct Notify<N, InputBufferT>
  {
    static void notify(FluidMaxWrapper<Client>* x, t_symbol* s, t_symbol* msg,
                       void* sender, void* data)
    {
      if (auto p = static_cast<const MaxBufferAdaptor*>(
              x->params().template get<N>().get()))
        p->notify(s, msg, sender, data);
    }
  };

  template <typename T>
  struct IsThreadedShared : std::false_type
  {};

  template <typename T>
  struct IsThreadedShared<NRTThreadingAdaptor<NRTSharedInstanceAdaptor<T>>>
      : std::true_type
  {};

public:
  using ClientType = Client;
  using ParamDescType = typename Client::ParamDescType;
  using ParamSetType = typename Client::ParamSetType;
  using ParamValues = typename ParamSetType::ValueTuple;
  
  static constexpr index NumInputBuffers = ParamDescType::template NumOfType<InputBufferT>;
  static constexpr index NumOutputBuffers = ParamDescType::template NumOfType<BufferT>;

  FluidMaxWrapper(t_symbol*, long ac, t_atom* av)
      : mListSize{32}, mMessages{}, mParams(Client::getParameterDescriptors(), FluidDefaultAllocator()),
        mParamSnapshot{mParams.toTuple()},
        mClient{initParamsFromArgs(ac, av), FluidContext()}, mDumpDictionary{nullptr}
  {
    if (mClient.audioChannelsIn())
    {
      assert((mClient.audioChannelsIn() <= std::numeric_limits<long>::max()));
      dsp_setup(impl::MaxBase::getMSPObject(),
                static_cast<long>(mClient.audioChannelsIn()));
      impl::MaxBase::getMSPObject()->z_misc |= Z_NO_INPLACE;
    }
    
    //TODO: this implicitly assumes no audio in?
    if (index controlInputs = mClient.controlChannelsIn())
    {
      mAutosize = true;      
      if(mListSize)
      {
        mInputListData.resize(controlInputs, mListSize);
        for (index i = 1; i <= controlInputs; ++i)
          mInputListViews.emplace_back(mInputListData.row(i - 1));
      }
      
      //we already have a left inlet, but do we need more?
      index newInlets = controlInputs - 1;
      mProxies.reserve(newInlets);
      for (index i = 1; i <= newInlets; ++i)
        mProxies.push_back(proxy_new(this, i + 1, &this->mProxyNumber));
    }
    
    
    //new proxy inlets for any additional input buffers beyond the first
    if(asSigned(mProxies.size()) < NumInputBuffers - 1)
    {
      for(index i = mProxies.size(); i < NumInputBuffers - 1; i++)
      {
        mProxies.push_back(proxy_new(this,i + 1, &this->mProxyNumber));
      }
    }
    
    //handle runtime dispatch of `buffer` message through a lookup table of functions that will set the attr
    mParams.template forEachParamType<InputBufferT>([this](auto&, auto idx){
      static constexpr index N = decltype(idx)::value;
      mBufferDispatch.push_back([](FluidMaxWrapper* x, long, t_atom* av)
      {
        static const std::string param_name = lowerCase(x->params().template descriptorAt<N>().name);
        t_symbol* attrval =  atom_getsym(av);
        t_symbol* attrname = gensym(param_name.c_str());
        object_attr_setsym(x, attrname, attrval);
      });
    });
    
    
    //functions for buffer inlet assistance
    mParams.template forEachParamType<InputBufferT>([this](auto&, auto idx){
       static constexpr index N = decltype(idx)::value;
       mInputBufferAssist.push_back([](FluidMaxWrapper *x, char* s)
       {
          static const std::string param_name = lowerCase(x->params().template descriptorAt<N>().name);
          sprintf(s,"(buffer <symbol>): set %s buffer", param_name.c_str());
       });
    });

    
    //functions for buffer outlet assistance
    mParams.template forEachParamType<BufferT>([this](auto&, auto idx){
       static constexpr index N = decltype(idx)::value; 
       mOutputBufferAssist.push_back([](FluidMaxWrapper *x, char* s)
       {
          static const std::string param_name = lowerCase(x->params().template descriptorAt<N>().name);
          sprintf(s,"buffer: %s", param_name.c_str());
       });
    });
    
    //setup an array of buffer~ object that we'll use if the respective params are unset when process is called
    mParams.template forEachParamType<BufferT>([this](auto&, auto idx){
        constexpr index N = idx();
        t_symbol* uniqueName = symbol_unique();
        t_atom bufferArgs;
        atom_setsym(&bufferArgs,uniqueName);
        mHostedOutputBufferNames[N] = uniqueName;
        
        mHostedOutputBufferObjects.push_back((t_object*) object_new_typed(CLASS_BOX, gensym("buffer~"), 1,
                                               &bufferArgs));
        
        auto currentValue =
        static_cast<MaxBufferAdaptor*>(mParams.template get<N>().get());
        
        if(!currentValue || currentValue->name() == gensym(""))
          mParams.template set<N>(BufferT::type(new MaxBufferAdaptor((t_object*)this, uniqueName)),nullptr);
                
        
    });
    

    while (mMessages.size() > 0)
    {
      printResult(this, mMessages.front(), true);
      mMessages.pop_front();
    }

    auto results = mParams.keepConstrained(true);
    mParamSnapshot = mParams.toTuple();

    for (auto& r : results) printResult(this, r);

    object_obex_store(this, gensym("dumpout"),
                      (t_object*) outlet_new(this, nullptr));
    
    
    //how many non-signal outlets do we need?
    index numDataOutlets = std::max<index>({NumOutputBuffers,mClient.controlChannelsOut().count,
      Client::getMessageDescriptors().size() > 0
    });
    
    mDataOutlets.reserve(numDataOutlets);
    
    for (index i = 0; i < numDataOutlets; ++i)
        mDataOutlets.insert(mDataOutlets.begin(),outlet_new((t_object*)this,nullptr));
  
    if (mClient.controlChannelsOut().count)
    {
      if(mListSize)
      {
        mOutputListData.resize(mClient.controlChannelsOut().count, mListSize);
        mOutputListAtoms.reserve(mListSize);
        for (index i = 0; i < mClient.controlChannelsOut().count; ++i)
          mOutputListViews.emplace_back(mOutputListData.row(i));
      }
      mControlOutlet = mDataOutlets[0];
    }

    for (index i = 0; i < mClient.audioChannelsOut(); ++i)
      outlet_new(this, "signal");

    Client::getParameterDescriptors().template iterate<AddListener>(this,
                                                                    mParams);
    mInitialized = true;
  }

  ~FluidMaxWrapper()
  {
    Client::getParameterDescriptors().template iterate<RemoveListener>(this,
                                                                       mParams);
    if (mDumpDictionary) object_free(mDumpDictionary);
    for (auto p : mProxies) object_free(p);
    for (auto b : mHostedOutputBufferObjects) object_free(b);
    
    t_symbol* ns = gensym("_FLUCOMA") ;
    
    for (auto&& s: mArgObjects){
      t_symbol* name = s.second;
      if(name)
      {
        t_object* o = (t_object*) object_findregistered(ns,name);
        if(o)
        {
          object_unregister(o);
          object_free(o);
        }
      }
    }
  }

  template <size_t N, typename T>
  struct AddListener
  {
    void operator()(const T& param, FluidMaxWrapper* x, ParamSetType& paramSet)
    {
      auto listenerFunc = [x, name=gensym(lowerCase(param.name).c_str())]() {
        object_attr_touch((t_object*) (x), name);
      };
      paramSet.template addListener<N>(std::move(listenerFunc), x);
    }
  };

  template <size_t N, typename T>
  struct RemoveListener
  {
    void operator()(const T&, FluidMaxWrapper* x, ParamSetType& paramSet)
    {
      paramSet.template removeListener<N>(x);
    }
  };

  void progress(double progress)
  {
    mProgress = progress;
    t_atom a;
    atom_setfloat(&a,progress);
    object_obex_dumpout(this,gensym("progress"),1,&a);
  }

  void doneBang()
  {
    t_box *b;
    t_max_err err = object_obex_lookup((t_object*)this, gensym("#B"), (t_object **)&b);
    if(!err)
      object_method(b, gensym("stopprogress"));

    t_atom a;
    atom_setfloat(&a,1);
    object_obex_dumpout(this,gensym("progress"),1,&a);

    params().template forEachParamType<BufferT>([this,i=0](auto&, auto idx)mutable{
    
      constexpr index N = idx();
      
      auto b = static_cast<MaxBufferAdaptor*>(params().template get<N>().get());
      
      atom a;
      atom_setsym(&a,b->name());

      outlet_anything(mDataOutlets[i++],gensym("buffer"), 1, &a);
    });
  }

  void controlOut(long ac, t_atom* av)
  {
    outlet_list(mControlOutlet, nullptr, static_cast<short>(ac), av);
  }

  static void* create(t_symbol* sym, long ac, t_atom* av)
  {
    void* x = object_alloc(getClass());
    new (x) FluidMaxWrapper(sym, ac, av);
    if (static_cast<index>(attr_args_offset(static_cast<short>(ac), av)) - isControlIn<typename Client::Client> >
        ParamDescType::NumFixedParams + ParamDescType::NumPrimaryParams)
    {
      object_warn((t_object*) x,
                  "Too many arguments. Got %d, expect at most %d", ac,
                  ParamDescType::NumFixedParams + isControlIn<typename Client::Client>);
    }

    return x;
  }

  static void destroy(FluidMaxWrapper* x) { x->~FluidMaxWrapper(); }

  static void makeClass(const char* className)
  {
    
    static constexpr bool AudioInput = isAudioIn<typename Client::Client>;
    const ParamDescType& p = Client::getParameterDescriptors();
    const auto&          m = Client::getMessageDescriptors();
    getClass(class_new(className, (method) create, (method) destroy,
                       sizeof(FluidMaxWrapper), 0, A_GIMME, 0));
    WrapperBase::setup(getClass());
    
    (void)FFTSetup();
    
    if (isControlIn<typename Client::Client>)
    {
      class_addmethod(getClass(), (method) handleList, "list", A_GIMME, 0);
      t_object* a = attr_offset_new("autosize", USESYM(atom_long), 0, nullptr, nullptr,
                                  calcoffset(FluidMaxWrapper, mAutosize));
      class_addattr(getClass(), a);
      CLASS_ATTR_FILTER_CLIP(getClass(), "autosize", 0, 1);
      CLASS_ATTR_STYLE_LABEL(getClass(), "autosize", 0, "onoff",
                           "Report Warnings");
                                  
    }
    
    class_addmethod(getClass(), (method) doNotify, "notify", A_CANT, 0);
    class_addmethod(getClass(), (method) object_obex_dumpout, "dumpout", A_CANT,
                    0);
    class_addmethod(getClass(), (method) doReset, "reset", 0);

    makeReferable();

    m.template iterate<SetupMessage>();

    class_addmethod(getClass(), (method) doVersion, "version", 0);
    // Change for MSVC, which didn't like the macro version
    t_object* a = attr_offset_new("warnings", USESYM(atom_long), 0, nullptr, nullptr,
                                  calcoffset(FluidMaxWrapper, mVerbose));
    class_addattr(getClass(), a);

    // CLASS_ATTR_LONG(getClass(), "warnings", 0, FluidMaxWrapper, mVerbose);
    CLASS_ATTR_FILTER_CLIP(getClass(), "warnings", 0, 1);
    CLASS_ATTR_STYLE_LABEL(getClass(), "warnings", 0, "onoff",
                           "Report Warnings");

    p.template iterateMutable<SetupAttribute>();
    p.template iterateFixed<SetupReadOnlyAttribute>();
    
    
    //for non-audio classes, give us cold inlets for non-left
    if(!AudioInput)
      class_addmethod(getClass(), (method)stdinletinfo, "inletinfo", A_CANT, 0);
    
    class_dumpout_wrap(getClass());
    class_register(CLASS_BOX, getClass());
  }

  static void doReset(FluidMaxWrapper* x)
  {
    x->mParams.fromTuple(x->mParamSnapshot);
    x->params().template forEachParam<touchAttribute>(x);
    object_attr_touch((t_object*) x, gensym("latency"));
  }

  static void doVersion(FluidMaxWrapper* x)
  {
    object_post((t_object*) x, "Fluid Corpus Manipulation Toolkit, version %s",
                fluidVersion());
  }

  template <typename CType = Client>
  static std::enable_if_t<!IsThreadedShared<CType>::value> makeReferable()
  {}

  template <typename CType = Client>
  static std::enable_if_t<IsThreadedShared<CType>::value> makeReferable()
  {
    class_addmethod(getClass(), (method) doSharedClientRefer, "refer", A_SYM,
                    0);
  }

  void resizeListHandlers(index newSize)
  {
      index numIns = mClient.controlChannelsIn();
      mListSize = newSize; 
      if(mListSize)
      {
        mInputListData.resize(numIns,mListSize);
        mInputListViews.clear();
        for (index i = 0; i < numIns; ++i)
        {
          mInputListViews.emplace_back(mInputListData.row(i));
        }
        mOutputListData.resize(mClient.controlChannelsOut().count,mListSize);
        mOutputListAtoms.reserve(mListSize);
        mOutputListViews.clear();
        for (index i = 0; i < mClient.controlChannelsOut().count; ++i)
        {
          mOutputListViews.emplace_back(mOutputListData.row(i));
        }
        
      }
  }

  static void doList(FluidMaxWrapper* x, t_symbol*, long ac, t_atom* av)
  {

//    if(!isr() && x->mAutosize && (ac != x->mListSize)) x->resizeListHandlers(ac);
    x->mListHandler(x, ac, av);
  }
  
  static void doListResize(FluidMaxWrapper* x, t_symbol*, long ac, t_atom*)
  {
    x->resizeListHandlers(ac);
  }
  
  
  static void handleList(FluidMaxWrapper* x, t_symbol* s, long ac, t_atom* av)
  {
      if(!x->mListSize && !x->mAutosize)
      {
        object_error((t_object*)x, "No list size argument nor autosize enabled: can't do anything");
        return;
      }
      
      if(isr())
      {
        if(x->mAutosize && ac != x->mListSize)
        {
          object_warn((t_object*)x, "input list size (%d) != object argument (%d) and autosize is enabled: this operation will be deferred",ac,x->mListSize);
          defer(x,method(doListResize),s,ac,av);
          defer(x,(method)doList,s, ac, av);
          return;
        }

        if(!x->mAutosize && ac != x->mListSize)
        {
          object_warn((t_object*)x, "bad input list size (%d), expect %d",ac,x->mListSize);
          return;
        }
      }
      else if(ac != x->mListSize) doListResize(x,s,ac,av);
      
      doList(x,s,ac,av);
      
  }
  
  static void doSharedClientRefer(FluidMaxWrapper* x, t_symbol* newName)
  {
    rt::string name(newName->s_name);
    if (name != x->mParams.template get<0>())
    {
      //      auto newParams = ParamSetType(Client::getParameterDescriptors());
      Result r = x->mParams.lookup(name);
      if (r.ok())
      {
        Client::getParameterDescriptors().template iterate<RemoveListener>(
            x, x->mParams);
        x->mParams.refer(name);
        x->mClient = Client(x->mParams, FluidContext());
        Client::getParameterDescriptors().template iterate<AddListener>(
            x, x->mParams);
      }
      else
        printResult(x, r);
    }
  }

  Result&       messages() { return mResult; }
  long          verbose() { return mVerbose; }
  Client&       client() { return mClient; }
  ParamSetType& params() { return mParams; }

  static void assistDataObject(FluidMaxWrapper* /*x*/, void* /*b*/, long io,
                               long index, char* s)
  {
    switch (io)
    {
    case 1: strncpy_zero(s, "(anything) messages in", 512); break;
    case 2:
      if (index < 2)
      {

        constexpr bool isModel = IsModel_t<ClientType>::value;
        using ClientClass = typename ClientType::Client;
        if (index == 0 && isModel && isAudioOut<ClientClass>)
        {
          strncpy_zero(s, "(signal) audio out", 512);
          break;
        }

        strncpy_zero(s, "(unused)", 512);
        break;
      }
      else
      {
        strncpy_zero(s, "(list) message results / dumpout", 512);
        break;
      }
    }
  }

private:
  static t_class* getClass(t_class* setClass = nullptr)
  {
    static t_class* c = nullptr;
    return (c = setClass ? setClass : c);
  }

  static std::string lowerCase(const char* str)
  {
    std::string result(str);
    std::transform(result.begin(), result.end(), result.begin(),
                   [](unsigned char c) {
                     return static_cast<unsigned char>(std::tolower(c));
                   });
    return result;
  }

  static t_max_err doNotify(FluidMaxWrapper* x, t_symbol* s, t_symbol* msg,
                            void* sender, void* data)
  {
    x->notify(s, msg, sender, data);
    return MAX_ERR_NONE;
  }

  void notify(t_symbol* s, t_symbol* msg, void* sender, void* data)
  {
    mParams.template forEachParam<notifyAttribute>(this, s, msg, sender, data);
  }

  template <size_t N, typename T>
  struct notifyAttribute
  {
    void operator()(const typename T::type& /*attr*/, FluidMaxWrapper* x,
                    t_symbol* s, t_symbol* msg, void* sender, void* data)
    {
      Notify<N, T>::notify(x, s, msg, sender, data);
    }
  };

  template <size_t N, typename T>
  struct touchAttribute
  {
    void operator()(const typename T::type& /*attr*/, FluidMaxWrapper* x)
    {
      const char* name = paramDescriptor<N>().name;
      object_attr_touch((t_object*) x,
                        gensym(FluidMaxWrapper::lowerCase(name).c_str()));
    }
  };

  ParamSetType& initParamsFromArgs(long argc, t_atom* argv)
  {
    long ac = argc;
    
    std::vector<t_atom> av_vec = [&](){
      bool needsNameAtom = IsThreadedShared<Client>::value &&
                            !attr_args_offset(static_cast<short>(argc), argv);
      ac = argc + needsNameAtom;
      std::vector<t_atom> result(ac);
      std::copy_n(argv, argc, result.data() + needsNameAtom);
      if(needsNameAtom)
      {
          t_symbol* autoName = symbol_unique();
          atom_setsym(result.data(), autoName);
      }
      return result;
    }();
    
    t_atom* av = av_vec.data();
  
    // Process arguments for instantiation parameters
    if (long numArgs = attr_args_offset(static_cast<short>(ac), av))
    {
      long argCount{0};
      
      if(isControlIn<typename Client::Client>)
      {
        mListSize = atom_getlong(av);
        numArgs -= 1;
        av += 1;
        ac--;
      }
      
      auto r1 = mParams.setPrimaryParameterValues(true,
        [](auto idx, long ac, t_atom* av, long& currentCount)
        {
            auto defaultValue = paramDescriptor<idx()>().defaultValue;
            
            if constexpr (std::is_same<std::decay_t<decltype(defaultValue)>,LongRuntimeMaxParam>())
            {
              index val = currentCount < ac ? atom_getlong(av + currentCount++) : defaultValue();
              return LongRuntimeMaxParam{val,-1};
            }
            else
            {
              return currentCount < ac ? atom_getlong(av + currentCount++) : defaultValue;
            }
        },
      numArgs,av,argCount);
      for (auto& r : r1) mMessages.push_back(r);
      auto results = mParams.template setFixedParameterValues<Fetcher>(
          true, numArgs, av, argCount);
      for (auto& r : results) mMessages.push_back(r);
    }
    // process in-box attributes for mutable params
    attr_args_process((t_object*) this, static_cast<short>(ac), av);
    // return params so this can be called in client initaliser
    return mParams;
  }

  template <size_t N>
  static void invokeMessage(FluidMaxWrapper* x, t_symbol* s, long ac,
                            t_atom* av)
  {
    using IndexList =
        typename Client::MessageSetType::template MessageDescriptorAt<
            N>::IndexList;
    x->client().setParams(x->params());
    invokeMessageImpl<N>(x, s, ac, av, IndexList());
  }

  template <size_t N, size_t... Is>
  static void invokeMessageImpl(FluidMaxWrapper* x, t_symbol* s, long ac,
                                t_atom* av, std::index_sequence<Is...>)
  {
    using ArgTuple =
        typename Client::MessageSetType::template MessageDescriptorAt<
            N>::ArgumentTypes;

    // Read in arguments
    ArgTuple args{setArg<ArgTuple, N, Is>(x, ac, av)...};
    std::vector<t_atom> outputTokens;
    
    ForEach(args,[&outputTokens](auto& a){
        outputToken(outputTokens,a);
    });
    
    auto result =
        x->mClient.template invoke<N>(x->mClient, std::get<Is>(args)...);

    if (x->checkResult(result)) messageOutput(x, s, outputTokens, result);
  }

  template <typename Tuple, size_t N, size_t I>
  static auto setArg(FluidMaxWrapper* x, long ac, t_atom* av)
  {
    if (I < asUnsigned(ac))
      return ParamAtomConverter::fromAtom(
          (t_object*) x, av + I, typename std::tuple_element<I, Tuple>::type{});
    else
        return x->argDefault<N, I>(typename std::tuple_element<I, Tuple>::type{});
  }
  
  template<size_t N, size_t I, typename T>
  auto argDefault(T obj){
     return obj;
  }  
  
  template<size_t N, size_t I>
  std::shared_ptr<BufferAdaptor> argDefault(std::shared_ptr<BufferAdaptor>&&){
    
    static t_symbol* namespace_binding = gensym("_FLUCOMA");

    t_symbol*& argName = mArgObjects[{N,I}];
    
    if(!argName)
    {
      argName = symbol_unique();
      t_atom oNameAtom;
      atom_setsym(&oNameAtom, argName);
      t_object* obj = (t_object*) object_new_typed(CLASS_BOX, gensym("buffer~"),
                                                   1, &oNameAtom);
      object_register(namespace_binding, argName, obj);
    }
      
    return std::make_shared<MaxBufferAdaptor>((t_object*)this, argName);
  }
  
  template<size_t N, size_t I, typename T>
  SharedClientRef<T> argDefault(SharedClientRef<T>)
  {

    static t_symbol* namespace_binding = gensym("_FLUCOMA");
    
    t_symbol*& argName = mArgObjects[{N,I}];

    if(!argName)
    {
      argName = symbol_unique();
      t_atom oNameAtom;
      atom_setsym(&oNameAtom, argName);
      t_symbol* maxclass = gensym(SharedClientName<T>);
      t_object* obj =
          (t_object*) object_new_typed(CLASS_BOX, maxclass, 1, &oNameAtom);
      object_register(namespace_binding, argName, obj);
    }

    return {argName->s_name};
  }
  
  template<size_t N,typename T>
  SharedClientRef<const T> argDefault(SharedClientRef<const T> object)
  {
     return object;
  }

  template<typename T>
  static void outputToken(std::vector<t_atom>&,T) {}
  
  static void outputToken(std::vector<t_atom>& v,std::shared_ptr<BufferAdaptor> const& b) {
    t_symbol* name = static_cast<MaxBufferAdaptor*>(b.get())->name();
    t_atom res;
    atom_setsym(&res, name);
    v.push_back(res);
  }

  template <typename T>
  static void outputToken(std::vector<t_atom>& v, SharedClientRef<T> const& ds)
  {
    t_symbol* name = gensym(ds.name());
    t_atom res;
    atom_setsym(&res, name);
    v.push_back(res);
  }

  template <typename T>
  static void outputToken(std::vector<t_atom>&, SharedClientRef<const T>)
  {}

  template <typename T>
  static size_t ResultSize(T)
  {
    return 1;
  }

  template <template <typename, size_t> class Tensor, typename T>
  static size_t ResultSize(Tensor<T, 1> const& x)
  {
    return static_cast<FluidTensor<T, 1>>(x).size();
  }

  template <typename... Ts, size_t... Is>
  static std::tuple<std::array<size_t, sizeof...(Ts)>, size_t>
  ResultSize(std::tuple<Ts...> const& x, std::index_sequence<Is...>)
  {
    size_t                            size = 0;
    std::array<size_t, sizeof...(Ts)> offsets;
    (void) std::initializer_list<int>{
        (offsets[Is] = size, size += ResultSize(std::get<Is>(x)), 0)...};
    return std::make_tuple(offsets, size);
  }

  template <typename T>
  static std::enable_if_t<!isSpecialization<T, std::tuple>::value>
  messageOutput(FluidMaxWrapper* x, t_symbol* s, std::vector<t_atom>& outputTokens, MessageResult<T> r)
  {
    size_t              resultSize = ResultSize(static_cast<T>(r)) + outputTokens.size();
    std::vector<t_atom> out(resultSize);
    std::copy_n(outputTokens.begin(), outputTokens.size(),out.begin());
    ParamAtomConverter::toAtom(out.data() + outputTokens.size(), static_cast<T>(r));
    outlet_anything(x->mDataOutlets[0],s,static_cast<long>(resultSize), out.data());
  }

  template <typename Tuple>
  static std::enable_if_t<isSpecialization<Tuple, std::tuple>::value>
  messageOutput(FluidMaxWrapper* x, t_symbol* s,
                std::vector<t_atom>& outputTokens, MessageResult<Tuple> r)
  {
    constexpr auto N = std::tuple_size_v<Tuple>;
    auto           indices = std::make_index_sequence<N>();

    size_t                resultSize;
    std::array<size_t, N> offsets;
    std::tie(offsets, resultSize) = ResultSize(r.value(), indices);
    resultSize += outputTokens.size();
    std::vector<t_atom> out(resultSize);
    std::copy_n(outputTokens.begin(), outputTokens.size(), out.begin());
    ParamAtomConverter::toAtom(out.data() + outputTokens.size(), r.value(),
                               indices, offsets);
    outlet_anything(x->mDataOutlets[0], s, static_cast<long>(resultSize),
                    out.data());
  }

  static void messageOutput(FluidMaxWrapper* x, t_symbol* s, std::vector<t_atom>& outputTokens,
                            MessageResult<void>)
  {
    outlet_anything(x->mDataOutlets[0],s,outputTokens.size(), outputTokens.data());
  }

  // Sets up a single message
  template <size_t N, typename T>
  struct SetupMessage
  {
    void operator()(const T& message)
    {
      if (message.name == "load")
      {
        using ReturnType = typename T::ReturnType;
        using ArgumentTypes = typename T::ArgumentTypes;
        constexpr bool isVoid = std::is_same<ReturnType, MessageResult<void>>::value;
        
        using IfVoid = SpecialCase<MessageResult<void>,std::string>;
        using IfParams = SpecialCase<MessageResult<ParamValues>,std::string>;
        using Handler = std::conditional_t<isVoid, IfVoid, IfParams>;

        Handler{}.template handle<N>(
                ReturnType{}, ArgumentTypes{}, [&message](auto M) {
                  class_addmethod(getClass(),
                                  (method) deferLoad<decltype(M)::value>,
                                  lowerCase(message.name).c_str(), A_GIMME, 0);
                });

        return;
      }
      if (message.name == "dump")
      {
        SpecialCase<MessageResult<std::string>>{}.template handle<N>(
            typename T::ReturnType{}, typename T::ArgumentTypes{},
            [&message](auto M) {
              class_addmethod(getClass(),
                              (method) deferDump<decltype(M)::value>,
                              lowerCase(message.name).c_str(), A_GIMME, 0);
            });
        return;
      }
      if (message.name == "print")
      {
        SpecialCase<MessageResult<std::string>>{}.template handle<N>(
            typename T::ReturnType{}, typename T::ArgumentTypes{},
            [&message](auto M) {
              class_addmethod(getClass(),
                              (method) deferPrint<decltype(M)::value>,
                              lowerCase(message.name).c_str(), A_GIMME, 0);
            });
        return;
      }
      if (message.name == "read")
      {
        using ReturnType = typename T::ReturnType;
        using ArgumentTypes = typename T::ArgumentTypes;
        constexpr bool isVoid = std::is_same<ReturnType, MessageResult<void>>::value;
        
        using IfVoid = SpecialCase<MessageResult<void>,std::string>;
        using IfParams = SpecialCase<MessageResult<ParamValues>,std::string>;
        using Handler = std::conditional_t<isVoid, IfVoid, IfParams>;
      
        Handler{}.template handle<N>(
            typename T::ReturnType{}, ArgumentTypes{},
            [&message](auto M) {
              class_addmethod(getClass(),
                              (method) deferRead<decltype(M)::value>,
                              lowerCase(message.name).c_str(), A_DEFSYM, 0);
            });
        return;
      }
      if (message.name == "write")
      {
        SpecialCase<MessageResult<void>, std::string>{}.template handle<N>(
            typename T::ReturnType{}, typename T::ArgumentTypes{},
            [&message](auto M) {
              class_addmethod(getClass(),
                              (method) deferWrite<decltype(M)::value>,
                              lowerCase(message.name).c_str(), A_DEFSYM, 0);
            });
        return;
      }
      class_addmethod(getClass(), (method) invokeMessage<N>,
                      lowerCase(message.name).c_str(), A_GIMME, 0);
    }

    // This amounts to me really, really promising the compiler that it's all ok
    //(life isn't as simple as being able to runtime dispatch on message names,
    // I neeed to make sure messages whose sigs don't match the special case
    // don't get even the possibility of being run)
    template <typename Return, typename... Args>
    struct SpecialCase
    {
      template <size_t M, typename F>
      void handle(Return, std::tuple<Args...>, F&& f)
      {
        f(std::integral_constant<size_t, M>());
      }

      template <size_t M, typename U, typename ArgTuple, typename F>
      void handle(U, ArgTuple, F&&)
      {}
    };
  };

  template <size_t N>
  static void deferLoad(FluidMaxWrapper* x, t_symbol*, long ac, t_atom* av)
  {
    defer(x, (method) doLoad<N>, nullptr, ac, av);
  }

  template <size_t N>
  static void doLoad(FluidMaxWrapper* x, t_symbol*, long ac, t_atom* av)
  {
    static t_symbol* dictionarySymbol = gensym("dictionary");

    if (ac < 2 || atom_getsym(av) != dictionarySymbol)
    {
      object_error((t_object*) x, "Expected a dictionary");
      return; 
    }

    t_symbol*     dictName = atom_getsym(av + 1);
    t_dictionary* d = dictobj_findregistered_retain(dictName);

    if (!d)
    {
      object_error((t_object*) x, "Could not get a dictionary %s", dictName);
      return;
    }

    t_object* jsonwriter = (t_object*) object_new(_sym_nobox, _sym_jsonwriter);
    t_handle  json;
    const char* str;
    object_method(jsonwriter, _sym_writedictionary, d);
    object_method(jsonwriter, _sym_getoutput, &json);
    str = *json;

    auto messageResult = x->mClient.template invoke<N>(x->mClient, str);
    updateParams(x, messageResult);
    x->params().template forEachParam<touchAttribute>(x);

    object_free(jsonwriter);
    if (x->checkResult(messageResult))
      object_obex_dumpout(x, gensym("load"), 0, nullptr);
  }

  static void
  updateParams(FluidMaxWrapper*                                        x,
               MessageResult<typename ParamSetType::ValueTuple> const& v)
  {
    x->mParams.fromTuple(typename ParamSetType::ValueTuple(v.value()));
  }

  static void updateParams(FluidMaxWrapper*, MessageResult<void>) {}

  template <size_t N>
  static void deferDump(FluidMaxWrapper* x, t_symbol*, long ac, t_atom* av)
  {
    defer(x, (method) doDump<N>, nullptr, ac, av);
  }

  template <size_t N>
  static void doDump(FluidMaxWrapper* x, t_symbol*, short ac, t_atom* av)
  {
    t_dictionary* d = nullptr;
    t_atom        result;
    std::memset(&result,0,sizeof(t_atom));
    
    t_object* jsonreader = (t_object*) object_new(_sym_nobox, _sym_jsonreader);
    
    auto messageresult = x->mClient.template invoke<N>(x->mClient);

    if (!x->checkResult(messageresult)) return;

    std::string jsontext = static_cast<std::string>(messageresult);

    t_max_err err = (t_max_err) object_method(jsonreader, _sym_parse,
                                              jsontext.c_str(), &result);
    if (!err)
    {
      t_object* ro = (t_object*) atom_getobj(&result);
      if (ro)
      {
        if (object_classname_compare(ro, _sym_dictionary))
          d = (t_dictionary*) ro;
        else
        {
          object_error((t_object*) x,
                       "Failed to make a dictionary from object");
          object_free(ro);
          return;
        }
      }
    }
    else
    {
      object_error((t_object*) x, "Could not parse object into Dictionary");
      return;
    }
    object_free(jsonreader);

    t_dictionary* dest = nullptr;
    t_symbol*     dictName = nullptr;

    if (ac)
    {
      dictName = atom_getsym(av);
      dest = dictobj_findregistered_retain(dictName);
      if (!dest)
      {
        object_error((t_object*) x, "unable to reference dictionary named %s",
                     dictName);
        if (d) object_free(d);
        return;
      }
    }
    else
    {
      if (!x->mDumpDictionary)
      {
        x->mDumpDictionary = dictionary_new();

        dictName = symbol_unique();
        x->mDumpDictionary = dictobj_register(x->mDumpDictionary, &dictName);
      }
      dest = x->mDumpDictionary;
      dictName = dictobj_namefromptr(dest);
    }

    dictionary_clear(dest);
    dictionary_clone_to_existing(d, dest);
    static t_symbol* modified = gensym("modified");
    static t_symbol* dictionarySymbol = gensym("dictionary");
    t_atom           a[2];
    atom_setsym(a, dictionarySymbol);
    atom_setsym(a + 1, dictName);
    if (ac) dictobj_release(dest);
    if (d) object_free(d);
    object_notify(dest, modified, nullptr);
    object_obex_dumpout(x, gensym("dump"), 2, a);
  }

  template <size_t N>
  static void deferPrint(FluidMaxWrapper* x, t_symbol*, long, t_atom*)
  {
    defer(x, (method) doPrint<N>, nullptr, 0, nullptr);
  }

  template <size_t N>
  static void doPrint(FluidMaxWrapper* x, t_symbol*, long, t_atom*)
  {
    auto result = x->mClient.template invoke<N>(x->mClient);
    if (x->checkResult(result))
    {
      object_post((t_object*) x, "%s",
                  static_cast<std::string>(result).c_str());
      object_obex_dumpout(x, gensym("print"), 0, nullptr);
    }
  }

  template <size_t N>
  static void deferRead(FluidMaxWrapper* x, t_symbol* s)
  {
    defer(x, (method) &doRead<N>, s, 0, nullptr);
  }

  template <size_t N>
  static void doRead(FluidMaxWrapper* x, t_symbol* s)
  {
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wfour-char-constants"
#endif
    t_fourcc filetype = FOUR_CHAR_CODE('JSON');
#ifdef __clang__
#pragma clang diagnostic pop
#endif
    t_fourcc outtype;
    char     filename[MAX_PATH_CHARS];
    short    path;
    char     fullpath[MAX_PATH_CHARS];

    if (s == gensym(""))
    {
      if (open_dialog(filename, &path, &outtype, &filetype, 1))
        return; // non-zero -> cancel
    }
    else
    {
      strcpy(filename, s->s_name);
      if (locatefile_extended(filename, &path, &outtype, &filetype,
                              1)) // non-zero -> not found
      {
        object_error((t_object*) x, "%s not found", s->s_name);
        return;
      }
    }

    path_toabsolutesystempath(path, filename, fullpath);

    auto messageResult = x->mClient.template invoke<N>(x->mClient, fullpath);
    updateParams(x, messageResult);
    x->params().template forEachParam<touchAttribute>(x);
    if (x->checkResult(messageResult))
      object_obex_dumpout(x, gensym("read"), 0, nullptr);
  }

  template <size_t N>
  static void deferWrite(FluidMaxWrapper* x, t_symbol* s)
  {
    defer(x, (method) &doWrite<N>, s, 0, nullptr);
  }

  template <size_t N>
  static void doWrite(FluidMaxWrapper* x, t_symbol* s)
  {
    //    t_fourcc filetype = FOUR_CHAR_CODE('JSON');
    //
    //    t_fourcc outtype;
    char  filename[MAX_PATH_CHARS];
    short path;
    char  fullpath[MAX_PATH_CHARS];
    strcpy(filename, "fluidobject.json");

    if (s == gensym(""))
    {
      if (saveas_dialog(filename, &path, nullptr)) return;
      path_toabsolutesystempath(path, filename, fullpath);
    }
    else
    {
      char  thispath[MAX_PATH_CHARS];
      char  infolder[MAX_PATH_CHARS];
      path_splitnames(s->s_name, infolder, thispath);
      if(strlen(thispath) == 0) //for relative paths, everything goes in infolder?
      {
        t_object* patcher;
        object_obex_lookup(x, gensym("#P"), &patcher);
        t_symbol *patcherpath = object_attr_getsym(patcher, gensym("filepath"));
        
        if(patcherpath && patcherpath != gensym(""))
        {
          path_splitnames(patcherpath->s_name, infolder,thispath);
          strncat_zero(infolder, "/", MAX_PATH_CHARS);
          strncpy_zero(thispath,infolder,MAX_PATH_CHARS);
        }
        else
        {
          path_topotentialname(path_getdefault(), "",thispath, 0);
          strncat_zero(thispath, "/", MAX_PATH_CHARS);
        }
        
        strncat_zero(thispath, s->s_name,MAX_PATH_CHARS);
        path_nameconform(thispath, fullpath, PATH_STYLE_SLASH, PATH_TYPE_BOOT);
      }
      else
      {
        strncpy_zero(fullpath,s->s_name,MAX_PATH_CHARS);
      }
    }
    auto messageResult = x->mClient.template invoke<N>(x->mClient, fullpath);
    if (x->checkResult(messageResult))
      object_obex_dumpout(x, gensym("write"), 0, nullptr);
  }

  // Sets up a single attribute
  // TODO: static assert on T?
  template <size_t N, typename T>
  struct SetupAttribute
  {
    void operator()(const T& attr)
    {
      std::string name = lowerCase(attr.name);
      method      setterMethod = (method) &Setter<T, N>::set;
      method      getterMethod = (method) &Getter<T, N>::get;
      t_object*   a = attribute_new(name.c_str(), maxAttrType(attr), 0,
                                  getterMethod, setterMethod);

      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), name.c_str(), 0, attr.displayName);
      decorateAttr(attr, name);
    }

    template <typename U>
    void decorateAttr(const U& /*attr*/, std::string /*name*/)
    {}

    void decorateAttr(const EnumT& attr, std::string name)
    {
      std::stringstream enumstrings;
      for (index i = 0; i < attr.numOptions; ++i)
        enumstrings << '"' << attr.strings[i] << "\" ";
      CLASS_ATTR_STYLE(getClass(), name.c_str(), 0, "enum");
      CLASS_ATTR_ENUMINDEX(getClass(), name.c_str(), 0,
                           enumstrings.str().c_str());
    }
    
    void decorateAttr(const LongRuntimeMaxT& attr, std::string name)
    {
      std::string maxName = "max" + name;
      std::string maxLabel = std::string("Maximum ") + attr.displayName;
            
      using stype = t_max_err(*)(FluidMaxWrapper* x, t_object*, long ac, t_atom* av);
      using gtype = t_max_err(*)(FluidMaxWrapper* x, t_object*, long* ac, t_atom** av);
      
      stype setter = [](FluidMaxWrapper* x, t_object*, long ac, t_atom* av) -> t_max_err
      {
        static constexpr index Idx = N;
        if(ac && !x->mInitialized)
        {
          auto current = x->mParams.template get<Idx>();
          index newMax = atom_getlong(av);
          if(newMax > 0)
          {
            x->mParams.template set<Idx>(LongRuntimeMaxParam(current(),newMax),nullptr);
          }
        }
        return MAX_ERR_NONE;
      };
      
            
      gtype getter = [](FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                                      long* ac, t_atom** av) -> t_max_err
      {
        char alloc;
        atom_alloc_array(1, ac, av, &alloc);
        static constexpr index Idx = N;
        if(alloc)
        {
          auto current = x->mParams.template get<Idx>();
          atom_setlong(av[0],current.max());
        }
        return MAX_ERR_NONE;
      };
            
      t_object*   a = attribute_new(maxName.c_str(), gensym("atom"), 0,
                                    (method)getter, (method)setter);
      
      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), maxName.c_str(), 0, maxLabel.c_str());
    }
    
    void decorateAttr(const FFTParamsT&, std::string)
    {
      std::string maxName = "maxfftsize";
      std::string maxLabel = "Maximum FFT Size";
            
      using stype = t_max_err(*)(FluidMaxWrapper* x, t_object*, long ac, t_atom* av);
      using gtype = t_max_err(*)(FluidMaxWrapper* x, t_object*, long* ac, t_atom** av);
      
      stype setter = [](FluidMaxWrapper* x, t_object*, long ac, t_atom* av) -> t_max_err
      {
        static constexpr index Idx = N;
        if(ac && !x->mInitialized)
        {
          auto current = x->mParams.template get<Idx>();
          index newMax = atom_getlong(av);
          if(newMax > 0)
          {
            x->mParams.template set<Idx>(FFTParams(current.winSize(), current.hopRaw(), current.fftRaw(), newMax),nullptr);
          }
        }
        return MAX_ERR_NONE;
      };
      
      gtype getter = [](FluidMaxWrapper<Client>* x, t_object* /*attr*/,
                                      long* ac, t_atom** av) -> t_max_err
      {
        char alloc;
        atom_alloc_array(1, ac, av, &alloc);
        static constexpr index Idx = N;
        if(alloc)
        {
          auto current = x->mParams.template get<Idx>();
          atom_setlong(av[0],current.maxRaw());
        }
        return MAX_ERR_NONE;
      };
            
      t_object*   a = attribute_new(maxName.c_str(), gensym("atom"), 0,
                                    (method)getter, (method)setter);
      
      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), maxName.c_str(), 0, maxLabel.c_str());
      
    }
    
  };

  template <size_t N, typename T>
  struct SetupReadOnlyAttribute
  {
    void operator()(const T& attr)
    {
      std::string name = lowerCase(attr.name);
      method      getterMethod = (method) &Getter<T, N>::get;
      t_object*   a = attribute_new(name.c_str(), maxAttrType(attr), 0,
                                  getterMethod, nullptr);
      class_addattr(getClass(), a);
      CLASS_ATTR_LABEL(getClass(), name.c_str(), 0, attr.displayName);
    }
  };
  // Get Symbols for attribute types

  static t_symbol* maxAttrType(FloatT) { return USESYM(float64); }
  static t_symbol* maxAttrType(LongT) { return USESYM(atom_long); }
  static t_symbol* maxAttrType(BufferT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(InputBufferT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(EnumT) { return USESYM(atom_long); }
  static t_symbol* maxAttrType(FloatPairsArrayT) { return gensym("atom"); }
  static t_symbol* maxAttrType(FFTParamsT) { return gensym("atom"); }
  static t_symbol* maxAttrType(StringT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(LongArrayT) { return gensym("atom"); }
  static t_symbol* maxAttrType(LongRuntimeMaxT) { return USESYM(atom_long); }
  static t_symbol* maxAttrType(ChoicesT) { return gensym("atom"); }
  
  template <typename T>
  static std::enable_if_t<IsSharedClient<typename T::type>::value, t_symbol*>
      maxAttrType(T)
  {
    return USESYM(symbol);
  }

  index mListSize;
  std::deque<Result> mMessages;
  Result             mResult;
  void*              mNRTDoneOutlet;
  void*              mControlOutlet;
  void*              mDumpOutlet;
  double             mProgress;
  bool               mVerbose;
  bool               mAutosize;
  ParamSetType       mParams;
  ParamValues        mParamSnapshot;

  Client             mClient;
  t_int32_atomic     mInPerform{0};
  t_dictionary*      mDumpDictionary;
  std::vector<void*> mProxies;
  
  std::map<index,t_symbol*> mHostedOutputBufferNames;
  std::vector<t_object*>    mHostedOutputBufferObjects;
  std::vector<void(*)(FluidMaxWrapper*,long,t_atom*)> mBufferDispatch;
  
  std::vector<void(*)(FluidMaxWrapper*,char* s)> mInputBufferAssist;
  std::vector<void(*)(FluidMaxWrapper*,char* s)> mOutputBufferAssist;
    
  long mProxyNumber;
  std::vector<void*> mDataOutlets;

  FluidTensor<double, 2>                  mInputListData;
  std::vector<FluidTensorView<double, 1>> mInputListViews;
  FluidTensor<double, 2>                  mOutputListData;
  std::vector<FluidTensorView<double, 1>> mOutputListViews;
  std::vector<t_atom>                     mOutputListAtoms;
  
  bool mInitialized{false};
  
  using ArgKey = std::pair<size_t, size_t>;
  //if we wanted unordered_map here we'd need to rustle up a hash function for ArgKey
  std::map<ArgKey,t_symbol*> mArgObjects;  
};

////////////////////////////////////////////////////////////////////////////////

template <typename RT = std::true_type>
struct InputTypeWrapper
{
  using type = double;
};

template <>
struct InputTypeWrapper<std::false_type>
{
  using type = float;
};

template <class Client>
void makeMaxWrapper(const char* classname)
{
  //  using InputType = typename
  //  InputTypeWrapper<isRealTime<Client<double>>>::type;
  common_symbols_init();
  FluidMaxWrapper<Client>::makeClass(classname);
}

} // namespace client
} // namespace fluid
