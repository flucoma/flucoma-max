#pragma once

#include "MaxClass_Base.h"

#include <clients/common/FluidClient_Base.hpp>
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
  FluidMaxWrapper(t_symbol *, long ac, t_atom *av) {}

  /// Overloads for declaring attributes of the correct type
  static void declareAttr(Float_t t) {
    CLASS_ATTR_DOUBLE(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                      FluidMaxWrapper, mDummy);
  };

  static void declareAttr(Long_t t) {
    CLASS_ATTR_LONG(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                    FluidMaxWrapper, mDummy);
  }

  static void declareAttr(Buffer_t t) {
    CLASS_ATTR_SYM(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                   FluidMaxWrapper, mDummy);
  }

  static void declareAttr(Enum_t t) {
    CLASS_ATTR_LONG(*getClassPointer<FluidMaxWrapper>(), t.name, 0,
                    FluidMaxWrapper, mDummy);
  }

  /// Static dispatchers, used for generating getters and setters for attributes
  template <typename T, size_t N>
  static void getterDispatch(Client *x, t_object *attr, long *ac, t_atom **av) {
    char alloc;
    atom_alloc(ac, av, &alloc);
    impl::GetterDispatchImpl<Client, std::remove_const_t<T>, N>::f(x, attr, ac,
                                                                   av);
  }

  template <typename T, size_t N>
  static void setterDispatch(Client *x, t_object *attr, long ac, t_atom *av) {
    impl::SetterDispatchImpl<Client, std::remove_const_t<T>, N>::f(x, attr, ac,
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
    processParameters(params, std::index_sequence_for<Ts...>{});
  }

private:
  /// Max expects attribute variables to be in the object struct.
  /// We're not doing that, but we still need this to keep Max happy when
  /// declaring attributes
  t_object mDummy;
};

namespace impl {
/// Specialisations for managing the compile-time dispatch of Max attributes to Fluid Parameters
/// Protoypes are at top of file.
/// We need set + get specialisations for each allowed type (Float,Long, Buffer, Enum, FloatArry, LongArray, BufferArray)
/// Note that set in the fluid base client *returns a function

///Setters
template <typename Client, size_t N>
struct SetterDispatchImpl<Client, Float_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getfloat(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, Long_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, Buffer_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, Enum_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, FloatArray_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};


template <typename Client, size_t N>
struct SetterDispatchImpl<Client, LongArray_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

template <typename Client, size_t N>
struct SetterDispatchImpl<Client, BufferArray_t, N> {
  static void f(Client *x, t_object *attr, long ac, t_atom *av) {
    x->template setter<N>()(atom_getlong(av));
  }
};

///Getters
template <typename Client, size_t N>
struct GetterDispatchImpl<Client, Float_t, N> {
  static void f(Client *x, t_object *attr, long *ac, t_atom **av) {
    atom_setfloat(*av, x->template get<N>());
  }
};

template <typename Client, size_t N>
struct GetterDispatchImpl<Client, Long_t, N> {
  static void f(Client *x, t_object *attr, long *ac, t_atom **av) {
    atom_setfloat(*av, x->template get<N>());
  }
};
} // namespace impl

template <typename Client, typename... Ts>
void makeMaxWrapper(const char *classname, const std::tuple<Ts...> &params) {
  FluidMaxWrapper<Client, Ts...>::makeClass(CLASS_BOX, classname, params);
}

} // namespace client
} // namespace fluid
