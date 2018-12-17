#pragma once

#include "MaxClass_Base.h"

#include <clients/common/OfflineClient.hpp>
#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/ParameterTypes.hpp>

#include <ext.h>
#include <commonsyms.h>
#include <MaxBufferAdaptor.hpp> 

#include <tuple>
#include <utility>

namespace fluid {
namespace client {


//Forward decl
template <typename Client, typename... Ts>
class FluidMaxWrapper;

namespace impl {
// This seems faffy, but comes from Herb Sutter's reccomendation for avoiding
// specialising functions, and hence be seing surprised by the compiler and
// (courting ODR problems in a header-only context)
// http://www.gotw.ca/publications/mill17.htm.
// Specialisations are below the wrapper template, to try and reudce clutter

  
template <typename Client, typename T, size_t N> struct Setter;
template <typename Client, typename T, size_t N> struct Getter;


//Empty template for non-Audio clients
template<typename Wrapper, typename isAudio>
class RealTimeProcessor;

template<typename Wrapper>
class RealTimeProcessor<Wrapper, std::false_type>{
public:
  static void makeClass(t_class* c){}
};

template<typename Wrapper>
class RealTimeProcessor<Wrapper, std::true_type>{
public:
  static void makeClass(t_class* c) {
    Wrapper::dspInit(c);
    class_addmethod(c, (method)callDSP, "dsp64",A_CANT,0);
  }

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

template<typename Wrapper, typename isOffline>
class NonRealTimeProcessor;

template<typename Wrapper>
class NonRealTimeProcessor<Wrapper,std::false_type>
{
public:  static void makeClass(t_class* c){}
};

template<typename Wrapper>
class NonRealTimeProcessor<Wrapper,std::true_type>
{
public:
  static void makeClass(t_class* c){
    class_addmethod(c,(method)callProcess, "process",A_GIMME,0);
  }
  

  
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
      object_error(wrapper, "Wrong number of buffers");
    
    buffersIn.reserve(client.audioBuffersIn());
    buffersOut.reserve(client.audioBuffersOut());
    
    for(int i = 0; i < client.audioBuffersIn(); ++i)
    {
      buffersIn.emplace_back(wrapper,atom_getsym(av + i));
      inputs.emplace_back();
      inputs[i].buffer = &buffersIn[i];
    }

    for(int i = client.audioBuffersIn(),j=0; i < client.audioBuffersIn() + client.audioBuffersOut(); ++i,++j)
    {
      buffersOut.emplace_back(wrapper,atom_getsym(av + i));
      outputs.emplace_back();
      outputs[j].buffer= &buffersOut[j];
    }

    client.process(inputs,outputs);

  }
  
  static void callProcess(Wrapper *x, t_symbol* s, long ac, t_atom* av)
  {
    x->process(s,ac,av);
  }
  
};



} // namespace impl


template<typename T>
using isAudioProcessor = typename std::is_base_of<Audio,T>::type;

template<typename T>
using isOfflineProcessor = typename std::is_base_of<Offline, T>::type;


template <typename Client, typename... Ts>
class FluidMaxWrapper : public MaxClass_Base,  public impl::RealTimeProcessor<FluidMaxWrapper<Client,Ts...>,isAudioProcessor<Client>>,
  public impl::NonRealTimeProcessor<FluidMaxWrapper<Client,Ts...>,isOfflineProcessor<Client>>
{

    using RealTimeProc = impl::RealTimeProcessor<FluidMaxWrapper<Client,Ts...>,isAudioProcessor<Client>>;
    using NonRealTimeProc = impl::NonRealTimeProcessor<FluidMaxWrapper<Client,Ts...>,isOfflineProcessor<Client>>;

public:
  using ClientType = Client;
  
  FluidMaxWrapper(t_symbol*, long ac, t_atom *av) {

      if(mClient.audioChannelsIn())
          dspSetup(mClient.audioChannelsIn());
    
      for(int i = 0; i < mClient.audioChannelsOut(); ++i)
        outlet_new(this, "signal");
  }

  static t_symbol* maxAttrType(FloatT) { return USESYM(float64);  }
  static t_symbol* maxAttrType(LongT) { return USESYM(long);  }
  static t_symbol* maxAttrType(BufferT) { return USESYM(symbol);  }
  static t_symbol* maxAttrType(EnumT) { return USESYM(long);  }

  ///Sets up a single attribute
  ///TODO: static assert on T?
  
  template <typename T, size_t N> static void setupAttribute(const T &attr)
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
  static void processParameters(const std::tuple<Ts...>& params,
                                std::index_sequence<Is...>) {
    (void)std::initializer_list<int>{
        (setupAttribute<typename Ts::first_type, Is>(std::get<Is>(params).first), 0)...};
  }

  
  ///Entry point: sets up the Max class and its attributes
  static void makeClass(t_symbol *nameSpace, const char *className,
                        const std::tuple<Ts...>& params) {
    MaxClass_Base::makeClass<FluidMaxWrapper>(nameSpace, className);
    
    t_class* c = *getClassPointer<FluidMaxWrapper>();
    
    RealTimeProc::makeClass(c);
    NonRealTimeProc::makeClass(c);
    processParameters(params, std::index_sequence_for<Ts...>{});
  
  }
  
  Client& client() { return mClient; }

private:
  /// Max expects attribute variables to be in the object struct.
  /// We're not doing that, but we still need this to keep Max happy when
  /// declaring attributes
//  RealTimeProc mRealTime;
  Client mClient;
//  t_object mDummy;
};

namespace impl {
/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// Protoypes are at top of file.
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

template <typename Client, typename... Ts>
void makeMaxWrapper(const char *classname, const std::tuple<Ts...> &params) {
  FluidMaxWrapper<Client, Ts...>::makeClass(CLASS_BOX, classname, params);
}

} // namespace client
} // namespace fluid

