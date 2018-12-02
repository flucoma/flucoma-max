#pragma once

#include "MaxClass_Base.h"

#include <clients/common/FluidBaseClient.hpp>
#include <clients/common/ParameterTypes.hpp>

#include "ext.h"

#include <tuple>
#include <utility>

namespace fluid {
namespace client {

namespace impl {
// This seems faffy, but comes from Herb Sutter's reccomendation for avoiding
// specialising functions, and hence be seing surprised by the compiler and
// (courting ODR problems in a header-only context)
// http://www.gotw.ca/publications/mill17.htm.
// Specialisations are below the wrapper template, to try and reudce clutter
template <typename Client, typename T, size_t N> struct SetterDispatchImpl;
template <typename Client, typename T, size_t N> struct GetterDispatchImpl;
} // namespace impl

template <typename Client, typename... Ts>
class FluidMaxWrapper : public MaxClass_Base {
public:
  FluidMaxWrapper(t_symbol*, long ac, t_atom *av) {
    dspSetup(2);
    outlet_new(this, "signal");
  }

  /// Overloads for declaring attributes of the correct type
  static void declareAttr(FloatT t) {
    CLASS_ATTR_DOUBLE(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                      FluidMaxWrapper, mDummy);
  };

  static void declareAttr(LongT t) {
    CLASS_ATTR_LONG(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                    FluidMaxWrapper, mDummy);
  }

  static void declareAttr(BufferT t) {
    CLASS_ATTR_SYM(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                   FluidMaxWrapper, mDummy);
  }

  static void declareAttr(EnumT t) {
    CLASS_ATTR_LONG(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                    FluidMaxWrapper, mDummy);
  }

  /// Static dispatchers, used for generating getters and setters for attributes
  template <typename T, size_t N>
  static void getterDispatch(FluidMaxWrapper *x, t_object *attr, long *ac, t_atom **av) {
    char alloc;
    atom_alloc(ac, av, &alloc);
    impl::GetterDispatchImpl<Client, std::remove_const_t<T>, N>::f(x->mClient, attr, ac,
                                                                   av);
  }


  template <typename T, size_t N>
  static void setterDispatch(FluidMaxWrapper *x, t_object *attr, long ac, t_atom *av) {
     impl::SetterDispatchImpl<Client, std::remove_const_t<T>, N>::f(x->mClient, attr, ac,
                                                                   av);
  }

  



  ///Sets up a single attribute
  ///TODO: static assert on T?
  template <typename T, size_t N> static void setupAttribute(T &attr) {
    declareAttr(attr);
    using AttrType = std::remove_reference_t<decltype(attr)>;
    CLASS_ATTR_ACCESSORS(*getClassPointer<FluidMaxWrapper>(), attr.name,
                         (getterDispatch<AttrType, N>),
                         (setterDispatch<AttrType, N>));
  }

  ///Process the tuple of parameter descriptors
  template <size_t... Is>
  static void processParameters(std::tuple<Ts...> params,
                                std::index_sequence<Is...>) {
    (void)std::initializer_list<int>{
        (setupAttribute<Ts, Is>(std::get<Is>(params)), 0)...};
  }

  
  ///Entry point: sets up the Max class and its attributes
  static void makeClass(t_symbol *nameSpace, const char *className,
                        const std::tuple<Ts...> params) {
    MaxClass_Base::makeClass<FluidMaxWrapper>(nameSpace, className);
    
    t_class* c = *getClassPointer<FluidMaxWrapper>();
    
    processParameters(params, std::index_sequence_for<Ts...>{});
    
    dspInit(c);
    addMethod<FluidMaxWrapper,&FluidMaxWrapper::dsp>(c);
  }
  
  void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
  {
    addPerform<FluidMaxWrapper, &FluidMaxWrapper::perform>(dsp64);
  }




  void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
  {
  
      FluidTensorView<double,1> inputs[2]{{ins[0],0,sampleframes},{ins[0],0,sampleframes}};
      FluidTensorView<double,1> outputs[1]{{outs[0],0,sampleframes}};
  
      mClient.process(inputs,outputs);
  }

private:
  /// Max expects attribute variables to be in the object struct.
  /// We're not doing that, but we still need this to keep Max happy when
  /// declaring attributes
  Client mClient;
  t_object mDummy;
};

namespace impl {
/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// Protoypes are at top of file.
/// We need set + get specialisations for each allowed type (Float,Long, Buffer, Enum, FloatArry, LongArray, BufferArray)
/// Note that set in the fluid base client *returns a function

///Setters
template <typename Client, size_t N>
struct SetterDispatchImpl<Client, FloatT, N> {
  static void f(Client &x, t_object *attr, long ac, t_atom *av) {
    x.template setter<N>()(atom_getfloat(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, LongT, N> {
  static void f(Client &x, t_object *attr, long ac, t_atom *av) {
    x.template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, BufferT, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, EnumT, N> {
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

///Getters
template <typename Client, size_t N>
struct GetterDispatchImpl<Client, FloatT, N> {
  static void f(Client &x, t_object *attr, long *ac, t_atom **av) {
    atom_setfloat(*av, x.template get<N>());
  }
};

template <typename Client, size_t N>
struct GetterDispatchImpl<Client, LongT, N> {
  static void f(Client &x, t_object *attr, long *ac, t_atom **av) {
    atom_setfloat(*av, x.template get<N>());
  }
};
} // namespace impl

template <typename Client, typename... Ts>
void makeMaxWrapper(const char *classname, const std::tuple<Ts...> &params) {
  FluidMaxWrapper<Client, typename Ts::first_type...>::makeClass(CLASS_BOX, classname, ParameterDescriptors<Ts...>::get(params));
}

} // namespace client
} // namespace fluid
