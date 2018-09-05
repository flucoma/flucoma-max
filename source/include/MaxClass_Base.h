
#ifndef __MAX_BASE_H__
#define __MAX_BASE_H__

#include <ext.h>
#include <ext_obex.h>
#include <ext_obex_util.h>
#include <z_dsp.h>
#include <string>

// This is a very lightweight C++ template wrapper for writing max objects as C++ classes
// This work is loosely based on https://github.com/grrrwaaa/maxcpp by Graham Wakefield

class MaxClass_Base
{

public:
    
    // Default Constructor
    
    MaxClass_Base() {}
    
    // Template static functions, defintions to forward Max messages to class methods and methods to add Max methods to the class
    
    static void addMethod(t_class *c, method F, const char *name) { class_addmethod(c, F, name, A_CANT, 0); }
    
    template <class T> struct NoArgs { typedef void (T::*Method)(); };
    template <class T, typename NoArgs<T>::Method F> static void call(T *x) { ((x)->*F)(); }
    template <class T, typename NoArgs<T>::Method F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, 0); }
    
    template <class T>struct Gimme { typedef void (T::*MethodGimme) (t_symbol *s, long ac, t_atom *av); };
    template <class T, typename Gimme<T>::MethodGimme F> static void call(T *x, t_symbol *s, long ac, t_atom *av) {((x)->*F)(s, ac, av); };
    template <class T, typename Gimme<T>::MethodGimme F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_GIMME, 0); }
    
    template <class T> struct Long { typedef void (T::*MethodLong)(t_atom_long v); };
    template <class T, typename Long<T>::MethodLong F> static void call(T *x, t_atom_long v) { ((x)->*F)(v); }
    template <class T, typename Long<T>::MethodLong F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_LONG, 0); }
    
    template <class T> struct Float { typedef void (T::*MethodFloat)(double v); };
    template <class T, typename Float<T>::MethodFloat F> static void call(T *x, double v) { ((x)->*F)(v); }
    template <class T, typename Float<T>::MethodFloat F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_FLOAT, 0); }
    
    template <class T> struct Sym { typedef void (T::*MethodSym)(t_symbol *s); };
    template <class T, typename Sym<T>::MethodSym F> static void call(T *x, t_symbol *s) { ((x)->*F)(s); }
    template <class T, typename Sym<T>::MethodSym F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_DEFSYM, 0); }
    
    template <class T> struct Assist { typedef void (T::*MethodAssist)(void *b, long msg, long a, char *dst); };
    template <class T, typename Assist<T>::MethodAssist F> static void call(T *x, void *b, long msg, long a, char *dst) { ((x)->*F)(b, msg, a, dst); }
    template <class T, typename Assist<T>::MethodAssist F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_CANT, 0); }
    
    template <class T> struct Subpatch { typedef void *(T::*MethodSubPatch)(long index, void *arg); };
    template <class T, typename Subpatch<T>::MethodSubPatch F> static void *call(T *x, long index, void *arg) { return ((x)->*F)(index, arg); }
    template <class T, typename Subpatch<T>::MethodSubPatch F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_CANT, 0); }
    
    template <class T> struct ParentPatch { typedef void (T::*MethodParentPatch)(t_object **parent); };
    template <class T, typename ParentPatch<T>::MethodParentPatch F> static void call(T *x, t_object **parent) { ((x)->*F)(parent); }
    template <class T, typename ParentPatch<T>::MethodParentPatch F> static void addMethod(t_class *c, const char *name) { class_addmethod(c, (method) call<T, F>, name, A_CANT, 0); }

    template <class T> struct DSP { typedef void (T::*MethodDSP)(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags); };
    template <class T, typename DSP<T>::MethodDSP F> static void call(T *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags) { ((x)->*F)(dsp64, count, samplerate, maxvectorsize, flags); }
    template <class T, typename DSP<T>::MethodDSP F> static void addMethod(t_class *c) { class_addmethod(c, (method) call<T, F>, "dsp64", A_CANT, 0); }
    
    template <class T>  struct Perform { typedef void (T::*MethodPerform)(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size, long flags, void *userparam); };
    template <class T, typename Perform<T>::MethodPerform F> static void call(T *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long vec_size, long flags, void *userparam) { ((x)->*F)(dsp64, ins, numins, outs, numouts, vec_size, flags, userparam); }
    template <class T, typename Perform<T>::MethodPerform F> void addPerform(t_object *dsp64) { object_method(dsp64, gensym("dsp_add64"), this, ((method) call<T, F>), 0, nullptr); }
    
    // Static Methods for class initialisation, object creation and deletion
    
    template <class T> static t_class **getClassPointer()
    {
        static t_class *C;
        
        return &C;
    }
    
    template <class T> static std::string *accessClassName()
    {
        static std::string str;
        
        return &str;
    }

    template <class T> static void makeClass(t_symbol *nameSpace, const char *classname)
    {
        t_class **C = getClassPointer<T>();
        
        *C = class_new(classname, (method)create<T>, (method)destroy<T>, sizeof(T), 0, A_GIMME, 0);
        T::classInit(*C, nameSpace, classname);
        class_register(nameSpace, *C);
        *accessClassName<T>() = std::string(classname);
    }
    
    template <class T> static void *create(t_symbol *sym, long ac, t_atom *av)
    {
        void *x = object_alloc(*getClassPointer<T>());
        new(x) T(sym, ac, av);
        return x;
    }
    
    template <class T> static void destroy(t_object * x)
    {
        ((T *)x)->~T();
    }
    
    // Stub for an object with no additional methods (N.B. - inheriting classes should first call through to the inherited class version)
    
    static void classInit(t_class *c, t_symbol *nameSpace, const char *classname) {}
    
    static void dspInit(t_class *c) { class_dspinit(c); }
    
    void dspSetup(long numAudioIns, short flags = 0)
    {
        dsp_setup(&mObject, numAudioIns);
        mObject.z_misc = Z_NO_INPLACE | flags;
    }
    
    void dspFree() { dsp_free(&mObject); }
    
    long getInlet() { return proxy_getinlet(*this); }
    
    // Allows type conversion to a t_object
    
    operator t_object&() { return mObject.z_ob; }
    
    // Allows type conversion to a t_object pointer
    
    operator t_object* () { return (t_object *) this; }
    
private:
    
    // Deleted
    
    MaxClass_Base(const MaxClass_Base&) = delete;
    MaxClass_Base& operator=(const MaxClass_Base&) = delete;
    
    // The object structure
    
    t_pxobject mObject;
};
    
#endif
