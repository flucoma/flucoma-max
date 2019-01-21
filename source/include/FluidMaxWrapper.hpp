#pragma once

#include <ext.h>
#include <ext_obex.h>
#include <ext_obex_util.h>
#include <commonsyms.h>
#include <z_dsp.h>

#include <clients/common/OfflineClient.hpp>
#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/ParameterTypes.hpp>

#include <MaxBufferAdaptor.hpp> 

#include <tuple>
#include <utility>

namespace fluid {
namespace client {

// Forward declaration
    
template <typename Client>
class FluidMaxWrapper;
    
namespace impl {
  
template <typename Client, typename T, size_t N> struct Setter;
template <typename Client, typename T, size_t N> struct Getter;

/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// We need set + get specialisations for each allowed type (Float,Long, Buffer, Enum, FloatArry, LongArray, BufferArray)
/// Note that set in the fluid base client *returns a function

// Setters

template<typename Client, size_t N, typename T, T Method(const t_atom *av)>
struct SetValue
{
  
  static Result* result()
  {
    static Result res;
    return &res;
  }
  
  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    result()->reset();
    x->mClient.template setter<N>(x->mVerbose?result():nullptr)(Method(av));
    if(x->mVerbose && !result()->ok())
    {
      switch(result()->status())
      {
        case Result::Status::kWarning:
          object_warn((t_object*)&x,result()->message().c_str());
          break;
        case Result::Status::kError:
          object_error((t_object*)&x,result()->message().c_str());
          break;
        default: {}
      }
    }
    return MAX_ERR_NONE;
  }
};

template <typename Client, size_t N>
struct Setter<Client, FloatT, N> : public SetValue<Client, N, t_atom_float, &atom_getfloat> {};

template <typename Client, size_t N>
struct Setter<Client, LongT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong> {};

template <typename Client, size_t N>
struct Setter<Client, EnumT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong> {};

//MaxBufferAdaptor* getBuffer(t_atom* av)
//{
//  return new MaxBufferAdaptor(atom_getsymbol(av));
//}

template<typename Client, size_t N>
struct Setter<Client, BufferT, N >
{
  
  static Result* result()
  {
    static Result res;
    return &res;
  }

  static t_max_err set(FluidMaxWrapper<Client>* x, t_object *attr, long ac, t_atom *av)
  {
    x->mClient.template setter<N>(x->mVerbose ? result() : nullptr) (typename BufferT::type(new MaxBufferAdaptor((t_object*)x, atom_getsym(av))));
    if(x->mVerbose && !result()->ok())
    {
      switch(result()->status())
      {
        case Result::Status::kWarning:
          object_warn((t_object*)&x,result()->message().c_str());
          break;
        case Result::Status::kError:
          object_error((t_object*)&x,result()->message().c_str());
          break;
        default: {}
      }
    }
    return MAX_ERR_NONE;
  }
};


// Getters

template<typename Client, size_t N, typename T, t_max_err Method(t_atom *av, T)>
struct GetValue
{
  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc(ac, av, &alloc);
    (Method)(*av, x->mClient.template get<N>());
    return MAX_ERR_NONE;
  }
};

template <typename Client, size_t N>
struct Getter<Client, FloatT, N> : public GetValue<Client, N, double, &atom_setfloat> {};

template <typename Client, size_t N>
struct Getter<Client, LongT, N> : public GetValue<Client, N, t_atom_long, &atom_setlong> {};

template <typename Client, size_t N>
struct Getter<Client, EnumT, N> : public GetValue<Client, N, t_atom_long, &atom_setlong> {};


template <typename Client, size_t N>
struct Getter<Client, BufferT, N>
{
  static t_max_err get(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc(ac, av, &alloc);
    atom_setsym(*av, static_cast<MaxBufferAdaptor*>(x->mClient.template get<N>().get())->name()); 
//    (Method)(*av, x->mClient.template get<N>());
    return MAX_ERR_NONE;
  }
};

template<typename Client, size_t, typename> struct Notify
{
  static void notify(Client& c, t_symbol *s, t_symbol *msg, void *sender, void *data) {}
};

template<typename Client, size_t N>
struct Notify<Client,N,BufferT>
{
  static void notify(Client& c, t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    if(auto p = static_cast<MaxBufferAdaptor*>(c.template get<N>().get()))
      p->notify(s,msg,sender,data);
  }
};

template<typename Client>
t_max_err getLatency(FluidMaxWrapper<Client>* x, t_object *attr, long *ac, t_atom **av)
{
  char alloc;
  atom_alloc(ac, av, &alloc);
  atom_setlong(*av,x->mClient.latency());
}

// Broken things
/*
 template <typename Client, size_t N>
 struct SetterDispatchImpl<Client, BufferT, N> {
 static void f(Client *x, t_object *attr, long ac, t_atom *av) {
 x->template setter<N>()(atom_getlong(av));
 }
 };
 
 template <typename Client, size_t N>
 struct SetterDispatchImpl<Client, FloatArrayT, N> {
 static void f(Client *x, t_object *attr, long ac, t_atom *av) {
 x->template setter<N>()(atom_getlong(av));
 }
 };
 
 template <typename Client, size_t N>
 struct SetterDispatchImpl<Client, LongArrayT, N> {
 static void f(Client *x, t_object *attr, long ac, t_atom *av) {
 x->template setter<N>()(atom_getlong(av));
 }
 };
 
 template <typename Client, size_t N>
 struct SetterDispatchImpl<Client, BufferArrayT, N> {
 static void f(Client *x, t_object *attr, long ac, t_atom *av) {
 x->template setter<N>()(atom_getlong(av));
 }
 };
 */
  
 
  
template<class Wrapper>
class RealTime
{
  using ViewType = FluidTensorView<double,1>;
  
public:

  static void setup(t_class *c)
  {
    class_dspinit(c);
    class_addmethod(c, (method)callDSP, "dsp64", A_CANT, 0);
    auto latencyAttr = attribute_new("latency",  USESYM(long) , 0, (method)getLatency<typename Wrapper::ClientType>, nullptr);
  }
  
  static void callDSP(Wrapper *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    x->dsp(dsp64, count, samplerate, maxvectorsize, flags);
  }
  
  static void callPerform(Wrapper *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size, long flags, void *userparam)
  {
    x->perform(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam);
  }

  void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    auto& client = static_cast<Wrapper*>(this)->mClient;
    Wrapper* wrapper = static_cast<Wrapper*>(this);

    audioInputConnections.resize(client.audioChannelsIn());
    std::copy(count, count + client.audioChannelsIn(), audioInputConnections.begin());
    
    audioOutputConnections.resize(client.audioChannelsOut());
    std::copy(count + client.audioChannelsIn(),count + client.audioChannelsIn() + client.audioChannelsOut(),audioOutputConnections.begin());
    
    mInputs = std::vector<ViewType>(client.audioChannelsIn(), ViewType(nullptr,0,0));
    mOutputs = std::vector<ViewType>(client.audioChannelsIn(), ViewType(nullptr,0,0));
    
    object_method(dsp64, gensym("dsp_add64"), wrapper, ((method) callPerform), 0, nullptr);
  }
  
  void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
  {
      auto& client = static_cast<Wrapper*>(this)->mClient;
      for(int i = 0; i < numins; ++i)
        if(audioInputConnections[i])
          mInputs[i].reset(ins[i], 0, sampleframes);
  
      for(int i = 0; i < numouts; ++i)
        //if(audioOutputConnections[i])
          mOutputs[i].reset(outs[i], 0, sampleframes);

     client.process(mInputs,mOutputs);
  }

private:
  std::vector<ViewType> mInputs;
  std::vector<ViewType> mOutputs;
  std::vector<short> audioInputConnections;
  std::vector<short> audioOutputConnections;
};
  
template <class Wrapper>
struct NonRealTime
{
  static void setup(t_class *c)
  {
    class_addmethod(c, (method)deferProcess, "process", A_GIMME, 0);
  }
  
  void process(t_symbol* s, long ac, t_atom* av)
  {
    std::vector<MaxBufferAdaptor> buffersIn;
    std::vector<MaxBufferAdaptor> buffersOut;
    
    std::vector<BufferProcessSpec> inputs;
    std::vector<BufferProcessSpec> outputs;
    
    auto& wrapper = static_cast<Wrapper&>(*this);
    auto& client = wrapper.mClient;

    if(ac != client.audioBuffersIn() + client.audioBuffersOut())
      object_error((t_object *)&wrapper, "Wrong number of buffers");
    
    buffersIn.reserve(client.audioBuffersIn());
    buffersOut.reserve(client.audioBuffersOut());
    
    for (int i = 0; i < client.audioBuffersIn(); ++i)
    {
      buffersIn.emplace_back(wrapper.getMaxObject(), atom_getsym(av + i));
      inputs.emplace_back();
      inputs[i].buffer = &buffersIn[i];
    }
    
    for (int i = client.audioBuffersIn(), j=0; i < client.audioBuffersIn() + client.audioBuffersOut(); ++i,++j)
    {
      buffersOut.emplace_back(wrapper.getMaxObject(), atom_getsym(av + i));
      outputs.emplace_back();
      outputs[j].buffer= &buffersOut[j];
    }
    
    Result res = client.process(inputs, outputs);
    if(!res.ok())
    {
      switch(res.status())
      {
        case Result::Status::kWarning:
          object_warn((t_object*)&wrapper,res.message().c_str());
          break;
        case Result::Status::kError:
          object_error((t_object*)&wrapper,res.message().c_str());
          break;
        default: {}
      }
      return;
    }
    wrapper.bang();
  }
  
  
  static void deferProcess(Wrapper *x, t_symbol* s, long ac, t_atom* av)
  {
    defer_low(x, (method)&callProcess, s, ac, av);
  }
  
  static void callProcess(Wrapper *x, t_symbol* s, short ac, t_atom* av)
  {
    x->process(s,ac,av);
  }
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
  
// Max base type
  
struct MaxBase
{
  t_object* getMaxObject() { return (t_object*) &mObject; }
  t_pxobject* getMSPObject() { return &mObject; }
  t_pxobject mObject;
};
  
// Templates and specilisations for all possible base options
    
template <class Wrapper, typename NRT, typename RT>
struct FluidMaxBaseImpl : public MaxBase { /* This shouldn't happen, but not sure how to throw an error if it does */ };

template<class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::true_type, std::false_type> : public MaxBase, public NonRealTime<Wrapper> {};
  
template<class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::false_type, std::true_type> : public MaxBase, public RealTime<Wrapper> {};
  
template<class Wrapper>
struct FluidMaxBaseImpl<Wrapper, std::true_type, std::true_type> : public MaxBase, public NonRealTimeAndRealTime<Wrapper> {};
  
// Base class selection
///Move to client layer, so all hosts can use this
//template<typename T> using isRealTime = typename std::is_base_of<Audio,T>::type;
//template<typename T> using isNonRealTime = typename std::is_base_of<Offline, T>::type;
  
template <typename Client>
using FluidMaxBase = FluidMaxBaseImpl<FluidMaxWrapper<Client>, isNonRealTime<Client>, isRealTime<Client>>;

} // namespace impl
  
template <typename Client>
class FluidMaxWrapper : public impl::FluidMaxBase<Client>
{
  friend impl::RealTime<FluidMaxWrapper<Client>>;
  friend impl::NonRealTime<FluidMaxWrapper<Client>>;
    
public:
  
  using ClientType = Client;
  
  FluidMaxWrapper(t_symbol*, long ac, t_atom *av)
  {
    if (mClient.audioChannelsIn())
      dsp_setup(impl::MaxBase::getMSPObject(), mClient.audioChannelsIn());

    object_obex_store(this, _sym_dumpout, (t_object*)outlet_new(this, nullptr));
    
    attr_args_process((t_object*)this, ac, av);
  
    if(isNonRealTime<Client>::value) mNRTDoneOutlet = bangout(this); 
    
    for(int i = 0; i < mClient.controlChannelsOut(); ++i)
      listout(this);
    
    for (int i = 0; i < mClient.audioChannelsOut(); ++i)
      outlet_new(this, "signal");
  }
    
  FluidMaxWrapper(const FluidMaxWrapper&) = delete;
  FluidMaxWrapper& operator=(const FluidMaxWrapper&) = delete;

  void bang(){ outlet_bang(mNRTDoneOutlet); }
  
  static void *create(t_symbol *sym, long ac, t_atom *av)
  {
    void *x = object_alloc(getClass());
    new(x) FluidMaxWrapper(sym, ac, av);
    return x;
  }
  
  static void destroy(FluidMaxWrapper * x)
  {
    x->~FluidMaxWrapper();
  }
  
  static void makeClass(const char *className, typename Client::ParamType& params)
  {
    getClass(class_new(className, (method)create, (method)destroy, sizeof(FluidMaxWrapper), 0, A_GIMME, 0));
    impl::FluidMaxBase<Client>::setup(getClass());
    
    class_addmethod(getClass(), (method)doNotify, "notify",A_CANT, 0);
    
    CLASS_ATTR_LONG(getClass(), "warnings", 0, FluidMaxWrapper, mVerbose);
    CLASS_ATTR_FILTER_CLIP(getClass(), "warnings", 0, 1);
    CLASS_ATTR_STYLE_LABEL(getClass(),"warnings",0,"onoff","Report Warnings");
    
    Client::template iterateParameterDescriptors<SetupAttribute>(params);
    class_dumpout_wrap(getClass());
    class_register(CLASS_BOX, getClass());
  }
  
private:
    
  static t_class *getClass(t_class *setClass = nullptr)
  {
    static t_class *C = nullptr;
    return (C = setClass ? setClass : C);
  }
  
  static std::string lowerCase(const char *str)
  {
    std::string result(str);
    std::transform(result.begin(),result.end(),result.begin(),[](unsigned char c){return std::tolower(c);});
    return result;
  }
  
  static t_max_err doNotify(FluidMaxWrapper *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    x->notify(s, msg, sender, data);
    return MAX_ERR_NONE;
  }
  
  void notify(t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    mClient.template forEachParam<notifyAttribute>(client(),s,msg,sender,data);
  }
  
  template<size_t N, typename T>
  struct notifyAttribute
  {
    void operator()(Client& c, t_symbol *s, t_symbol *msg, void *sender, void *data)
    {
       impl::Notify<Client,N,T>::notify(c, s, msg, sender, data);
    }
  };
  
  
  
  // Sets up a single attribute
  // TODO: static assert on T?

  template <size_t N, typename T>
  struct SetupAttribute
  {
    void operator()(const T &attr)
    {
      std::string name = lowerCase(attr.name);
      method setterMethod = (method) &impl::Setter<Client, T, N>::set;
      method getterMethod = (method) &impl::Getter<Client, T, N>::get;
      
      t_object *maxAttr = attribute_new(name.c_str(), maxAttrType(attr), 0, getterMethod, setterMethod);
      class_addattr(getClass(), maxAttr);
    }
  };
  
  // Get Symbols for attribute types
  
  static t_symbol* maxAttrType(FloatT)  { return USESYM(float64); }
  static t_symbol* maxAttrType(LongT)   { return USESYM(long); }
  static t_symbol* maxAttrType(BufferT) { return USESYM(symbol); }
  static t_symbol* maxAttrType(EnumT)   { return USESYM(long); }
  
  Client& client() { return mClient; }
  
public:
  void* mNRTDoneOutlet;
  bool mVerbose;
  Client mClient;
};

template <typename Client>
void makeMaxWrapper(const char *classname, typename Client::ParamType &params)
{
  FluidMaxWrapper<Client>::makeClass(classname, params);
}

} // namespace client
} // namespace fluid
