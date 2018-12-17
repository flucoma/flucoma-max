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

namespace impl {
  
template <typename Client, typename T, size_t N> struct Setter;
template <typename Client, typename T, size_t N> struct Getter;

  // Dummy Class
  
template <class Wrapper, typename T>
struct RealTime { static void callDSP(Wrapper *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags) {}; };
  
// Class Proper
  
template<class Wrapper>
class RealTime<Wrapper, std::true_type>
{
public:

  static void callDSP(Wrapper *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags) { x->dsp(dsp64, count, samplerate, maxvectorsize, flags); }
  
  static void callPerform(Wrapper *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size, long flags, void *userparam) {
      x->perform(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam);
  }

  void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    auto& client = static_cast<Wrapper*>(this)->client();
    Wrapper* wrapper = static_cast<Wrapper*>(this);

    audioInputConnections.resize(client.audioChannelsIn());
    std::copy(count,count + client.audioChannelsIn(),audioInputConnections.begin());
    
    audioOutputConnections.resize(client.audioChannelsOut());
    std::copy(count + client.audioChannelsIn(),count + client.audioChannelsIn() + client.audioChannelsOut(),audioOutputConnections.begin());
    mInputs.clear();
    mOutputs.clear();
    mInputs.reserve(client.audioChannelsIn());
    mOutputs.reserve(client.audioChannelsOut());
    std::fill_n(std::back_inserter(mInputs),client.audioChannelsIn(),FluidTensorView<double, 1>(nullptr,0,0));
    std::fill_n(std::back_inserter(mOutputs),client.audioChannelsOut(),FluidTensorView<double, 1>(nullptr,0,0));

    object_method(dsp64, gensym("dsp_add64"), wrapper, ((method) callPerform), 0, nullptr);
  }
  
  void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
  {
      auto& client = static_cast<Wrapper*>(this)->client();
      for(int i = 0; i < numins; ++i)
        if(audioInputConnections[i])
          mInputs[i].reset(ins[i],0,sampleframes);
  
      for(int i = 0; i < numouts; ++i)
        //if(audioOutputConnections[i])
          mOutputs[i].reset(outs[i],0,sampleframes);

     client.process(mInputs,mOutputs);
  }

private:
  std::vector<FluidTensorView<double,1>> mInputs;
  std::vector<FluidTensorView<double,1>> mOutputs;
  std::vector<short> audioInputConnections;
  std::vector<short> audioOutputConnections;
};
  
// Dummy Class
  
template <class Wrapper, typename T>
struct NonRealTime { static void callProcess(Wrapper *x, t_symbol* s, long ac, t_atom* av) {}; };
  
// Class Proper
  
template <class Wrapper>
struct NonRealTime<Wrapper, std::true_type>
{
  void process(t_symbol* s, long ac, t_atom* av)
  {
    //Phase 1: Just take complete buffers as symbols
    std::vector<MaxBufferAdaptor> buffersIn;
    std::vector<MaxBufferAdaptor> buffersOut;
    
    std::vector<BufferProcessSpec> inputs;
    std::vector<BufferProcessSpec> outputs;
    
    auto& wrapper = static_cast<Wrapper&>(*this);
    auto& client = wrapper.client();

    if(ac != client.audioBuffersIn() + client.audioBuffersOut())
      object_error((t_object *)&wrapper, "Wrong number of buffers");
    
    buffersIn.reserve(client.audioBuffersIn());
    buffersOut.reserve(client.audioBuffersOut());
    
    for(int i = 0; i < client.audioBuffersIn(); ++i)
    {
      buffersIn.emplace_back(wrapper, atom_getsym(av + i));
      inputs.emplace_back();
      inputs[i].buffer = &buffersIn[i];
    }
    
    for (int i = client.audioBuffersIn(), j=0; i < client.audioBuffersIn() + client.audioBuffersOut(); ++i,++j)
    {
      buffersOut.emplace_back(wrapper, atom_getsym(av + i));
      outputs.emplace_back();
      outputs[j].buffer= &buffersOut[j];
    }
    
    client.process(inputs, outputs);
  }
  
  static void callProcess(Wrapper *x, t_symbol* s, long ac, t_atom* av)
  {
    x->process(s,ac,av);
  }
};


} // namespace impl

template<typename T> using isRealTime = typename std::is_base_of<Audio,T>::type;
template<typename T> using isNonRealTime = typename std::is_base_of<Offline, T>::type;
  
template <typename Client>
class FluidMaxWrapper
  : public impl::NonRealTime<FluidMaxWrapper<Client>, isNonRealTime<Client>>
  , public impl::RealTime<FluidMaxWrapper<Client>, isRealTime<Client>>
{
  using RT = impl::RealTime<FluidMaxWrapper<Client>, isRealTime<Client>>;
  using NRT = impl::NonRealTime<FluidMaxWrapper<Client>, isNonRealTime<Client>>;
  
public:
  
  FluidMaxWrapper(t_symbol*, long ac, t_atom *av)
  {
      if (mClient.audioChannelsIn())
      {
        dsp_setup(&mObject, mClient.audioChannelsIn());
        // FIX - not sure if we need this assumption??
        //mObject.z_misc = Z_NO_INPLACE;
      }
    
      for (int i = 0; i < mClient.audioChannelsOut(); ++i)
        outlet_new(this, "signal");
  }
    
  FluidMaxWrapper(const FluidMaxWrapper&) = delete;
  FluidMaxWrapper& operator=(const FluidMaxWrapper&) = delete;

  static t_symbol* maxAttrType(FloatT)  { return USESYM(float64);  }
  static t_symbol* maxAttrType(LongT)   { return USESYM(long);  }
  static t_symbol* maxAttrType(BufferT) { return USESYM(symbol);  }
  static t_symbol* maxAttrType(EnumT)   { return USESYM(long);  }

  // Sets up a single attribute
  ///TODO: static assert on T?
  
  template <size_t N, typename T> static void setupAttribute(const T &attr)
  {
    using AttrType = std::remove_reference_t<decltype(attr)>;

    auto setterMethod = &impl::Setter<Client, std::remove_const_t<AttrType>, N>::set;
    auto getterMethod = &impl::Getter<Client, std::remove_const_t<AttrType>, N>::get;
    
    std::string name(attr.name);
    std::transform(name.begin(),name.end(),name.begin(),[](unsigned char c){return std::tolower(c);});

    class_addattr(*getClassPointer<FluidMaxWrapper>(),
    attribute_new(name.c_str(), maxAttrType(attr), 0, (method)getterMethod, (method)setterMethod));
  }

  ///Process the tuple of parameter descriptors
  template <size_t... Is>
  static void processParameters(typename Client::ParamType& params, std::index_sequence<Is...>)
  {
    (void)std::initializer_list<int>{ (setupAttribute<Is>(std::get<Is>(params).first), 0)...};
  }

  static void *create(t_symbol *sym, long ac, t_atom *av)
  {
    // FIX - I removed Owen's try/catch, because everthing is bust if we run out of memory
    void *x = object_alloc(*getClassPointer<Client>());
    new(x) FluidMaxWrapper(sym, ac, av);
    return x;
  }
  
  static void destroy(FluidMaxWrapper * x)
  {
    x->~FluidMaxWrapper();
  }
  
  ///Entry point: sets up the Max class and its attributes
  static void makeClass(t_symbol *nameSpace, const char *className, typename Client::ParamType& params)
  {
    t_class** c = getClassPointer<Client>();
    
    *c = class_new(className, (method)create, (method)destroy, sizeof(FluidMaxWrapper), 0, A_GIMME, 0);

    if (isRealTime<Client>())
    {
      class_dspinit(*c);
      class_addmethod(*c, (method)RT::callDSP, "dsp64", A_CANT, 0);
    }
    
    if (isNonRealTime<Client>())
    {
      class_addmethod(*c,(method)NRT::callProcess, "process", A_GIMME, 0);
    }
    
    class_register(nameSpace, *c);
    processParameters(params, typename Client::ParamIndexList());
  }
  
  Client& client() { return mClient; }

private:
    
  template <class T>
  static t_class **getClassPointer()
  {
    static t_class *C;
    return &C;
  }
    
  // The object structure
    
  t_pxobject mObject;
  Client mClient;
};

namespace impl {
  
/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// We need set + get specialisations for each allowed type (Float,Long, Buffer, Enum, FloatArry, LongArray, BufferArray)
/// Note that set in the fluid base client *returns a function

// Setters
    
template<typename Client, size_t N, typename T, T Method(const t_atom *av)>
struct SetValue
{
  static void set(Client &x, t_object *attr, long ac, t_atom *av)
  {
    x.template setter<N>()(Method(av));
  }
};
  
template <typename Client, size_t N>
struct Setter<Client, FloatT, N> : public SetValue<Client, N, t_atom_float, &atom_getfloat> {};

template <typename Client, size_t N>
struct Setter<Client, LongT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong> {};

template <typename Client, size_t N>
struct Setter<Client, EnumT, N> : public SetValue<Client, N, t_atom_long, &atom_getlong> {};
  
// Getters
  
template<typename Client, size_t N, typename T, t_max_err Method(t_atom *av, T)>
struct GetValue
{
  static void get(Client &x, t_object *attr, long *ac, t_atom **av)
  {
    char alloc;
    atom_alloc(ac, av, &alloc);
    (Method)(*av, x.template get<N>());
  }
};
  
template <typename Client, size_t N>
struct Getter<Client, FloatT, N> : public GetValue<Client, N, double, &atom_setfloat> {};
  
template <typename Client, size_t N>
struct Getter<Client, LongT, N> : public GetValue<Client, N, t_atom_long, &atom_setlong> {};
 
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
  
} // namespace impl

template <typename Client>
void makeMaxWrapper(const char *classname, typename Client::ParamType &params) {
  FluidMaxWrapper<Client>::makeClass(CLASS_BOX, classname, params);
}

} // namespace client
} // namespace fluid
