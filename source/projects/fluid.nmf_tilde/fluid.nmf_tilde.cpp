/* Non-real time NMF in Max
 *
 */



#include  "MaxNonRealTimeBase.hpp"
#include "fluid_nmf_tilde_util.h"
#include "version.h"


//#include "algorithms/STFT.hpp"
#include "clients/nrt/NMFClient.hpp"

#include "ext_obex.h"

#include <vector>
#include <array>
#include <algorithm>


namespace fluid {
class NMFMax: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<NMFMax,&NMFMax::decompose>(c, "process");
    makeAttributes<nmf::NMFClient,NMFMax>(c);
  }

  NMFMax(t_symbol *s, long argc, t_atom *argv)
  {
    mParams = nmf::NMFClient::newParameterSet();
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~NMFMax()
  {
    for(auto&& a: mOutlets)
      object_free(a);
    
    for(auto&& p:mParams)
    {
      if(p.getDescriptor().getType() == parameter::Type::Buffer)
      {
        if(p.getBuffer())
          delete p.getBuffer();
      }
    }
  }
  
  
    t_max_err param_set(t_object *attr, long argc, t_atom *argv)
    {
      t_symbol* attrname = (t_symbol *)object_method((t_object *)attr, gensym("getname"));
      
      parameter::Instance& p = parameter::lookupParam(attrname->s_name, mParams);
     
      switch(p.getDescriptor().getType())
      {
        case parameter::Type::Float:
        {
          p.setFloat(atom_getfloat(argv));
          break;
        }
        case parameter::Type::Long:
        {
          p.setLong(atom_getlong(argv));
          break;
        }
        case parameter::Type::Buffer:
        {
          max::MaxBufferAdaptor* b = dynamic_cast<max::MaxBufferAdaptor*>(p.getBuffer());
          
          t_symbol* s = atom_getsym(argv);
          
          //is it a buffer or a poly buffer?
          
          //Test for buffer
          t_buffer_ref* buf_ref = buffer_ref_new(*this, s);
          if(buf_ref && buffer_ref_exists(buf_ref))
          {
            if(b)
              delete b;
            p.setBuffer(new max::MaxBufferData(*this,s));
            break;
          }
          //The s_thing of a polybuffer t_symbol* binds to a class called
          //'polybuffer', not 'polybuffer~', which sits in the CLASS_NOBOX namesapce
          if(s->s_thing && object_classname_compare(s->s_thing, gensym("polybuffer")))
          {
            if(b)
              delete b;
            p.setBuffer(new max::PolyBufferAdaptor(*this,s));
            break;
          }
          
          //Otherwise, let's moan bout not change the param
          object_warn(*this, "Can't find a buffer~ or polybuffer~ with the name %s",s->s_name);
          break;
        }
        default:
        {}
      }
      return 0;
    }
  
  
  t_max_err param_get(t_object *attr, long *argc, t_atom **argv)
  {
    t_symbol* attrname = (t_symbol *)object_method((t_object *)attr, gensym("getname"));
    
    parameter::Instance p = parameter::lookupParam(attrname->s_name, mParams);
    
    char alloc;
//    long size = 0;
    atom_alloc(argc, argv, &alloc);
    
    switch(p.getDescriptor().getType())
    {
      case parameter::Type::Float:
      {
        atom_setfloat(*argv, p.getFloat());
        break;
      }
      case parameter::Type::Long:
      {
        atom_setlong(*argv, p.getLong());
        break;
      }
      case parameter::Type::Buffer:
      {
        if(p.getBuffer())
        {
          max::MaxBufferAdaptor* b = dynamic_cast<max::MaxBufferAdaptor*>(p.getBuffer());
          if(b)
            atom_setsym(*argv, b->getName());
        }
        break;
      }
      default:
        {}
    }
    return 0;
  }
  
  void decompose(t_symbol *s, long ac, t_atom *av)
  {
    
    if(atom_gettype(av) == A_SYM)
    {
      if(mParams[0].getBuffer())
        delete mParams[0].getBuffer();
      
      mParams[0].setBuffer( new max::MaxBufferData(*this, atom_getsym(av)));
    }
    
    if(ac > 1)
    {
      while(ac-- > 1)
      {
        mParams[ac].setLong(atom_getlong(&av[ac]));
      }
    }
    
    
    
    deferMethod<NMFMax,&NMFMax::do_decompose>(s, ac, av);
  }

private:
  
  void do_decompose(t_symbol *s, long ac, t_atom *av)
  {
    bool parametersOk;
    nmf::NMFClient::ProcessModel processModel;
    std::string whatHappened;//this will give us a message to pass back if param check fails
    std::tie(parametersOk,whatHappened,processModel) = nmf::NMFClient::sanityCheck(mParams);
    if(!parametersOk)
    {
      object_error(*this, "fdNMF: %s \n", whatHappened.c_str());
      return;
    }
    //Now, we can proceed
    nmf::NMFClient nmf(processModel);
    nmf.process();
//    mModel = processModel;
  }
  
  std::vector<parameter::Instance> mParams;
  std::vector<t_object*> mOutlets;
//
};
}
void ext_main(void *r)
{
  fluid::NMFMax::makeClass<fluid::NMFMax>(CLASS_BOX, "fluid.nmf~");
}
//
///*********************************************************************************************
//Max struct, forward declarations
// ************************************************************************************************/
//
//typedef struct _nmf {
//    t_object w_obj;
//    void* m_outlet_done;
//    long m_iterations;
//    t_symbol *m_init_w;
//    t_symbol *m_init_h;
//    bool m_update_w;
//    bool m_update_h;
//} t_nmf;
//
//struct fft_args{
//    int window_size;
//    int fft_size;
//    int hop_size;
//};
//
//void *nmf_new(t_symbol *s,  short argc, t_atom *argv);
//void nmf_free(t_nmf *x);
//void nmf_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//void nmf_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//void nmf_fftcheck(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//
//bool validate_polybuffer(t_nmf *x, t_symbol *pb_name);
////Use these as proxies, so that calls are always deferred to main thread
//void call_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//void call_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//
////void call_fftcheck (t_nmf *x, t_symbol *s, long ac, t_atom *av);
//
//bool check_symbol_param(t_object* obj, const t_symbol* param, const char* err_msg);
////void copy_to_buffer(t_object* obj, int rank, t_symbol* polybuf_name,const FluidTensor<double,2> &mtrx);
////static t_symbol *ps_buffer_modified;
//static t_class *s_nmf_class;
//FluidTensorView<double, 1> view_of_polybuffer(t_symbol* polybuffer, size_t index, size_t size);
//
//
///*********************************************************************************************
//Utility functions
// ************************************************************************************************/
//
///***
// Check if a symbol param is non-null. If not, do object_error and return false
// ***/
//bool check_symbol_param(t_object* obj, const t_symbol* param, const char* err_msg)
//{
//    if(! param)
//    {
//        object_error(obj,err_msg);
//        return false;
//    }
//    return true;
//}
///**
// Check that a poly buffe exists
// **/
//bool validate_polybuffer(t_nmf *x, t_symbol *pb_name)
//{
//    t_object* this_obj = (t_object*)x;
//    if(pb_name && pb_name->s_thing)
//    {
//        //The s_thing of a polybuffer t_symbol* binds to a class called
//        //'polybuffer', not 'polybuffer~', which sits in the CLASS_NOBOX namesapce
//        if(object_classname_compare(pb_name->s_thing, gensym("polybuffer")))
//        {
//            return true;
//        }
//        else
//        {
//            t_symbol* itsname = object_classname(pb_name->s_thing);
//            object_error(this_obj,"%s points to a %s object, not a polybuffer",pb_name->s_name,itsname->s_name);
//            return false;
//        }
//    }
//    else
//    {
//        object_error(this_obj, "%s is not bound to an object", pb_name->s_name);
//        return false;
//    }
//}
//
///**
// Validate FFT arguments
// **/
//void process_fft_args(t_object* obj, fft_args* a, long ac, t_atom *av, int offset)
//{
//    a->fft_size = ac > offset ? atom_getlong(av + offset) : 2048;
//    if(a->fft_size < 32)
//    {
//        object_warn(obj, "%ld is not a sensible FFT size, setting to default (2048)");
//        a->fft_size = 2048;
//    }
//    else
//    {
//        double log2_fft_size = log2(a->fft_size);
//        if(log2_fft_size - trunc(log2_fft_size) != 0)
//        {
//            object_warn(obj, "fft_size: %ld is not a power of two. Increasing fft_size to nearest power of two");
//            a->fft_size = pow(2,trunc(log2_fft_size) + 1);
//        }
//    }
//
//    a->window_size = ac > offset+1 ? atom_getlong(av + offset +1) : a->fft_size;
//    if( a->window_size > a->fft_size)
//    {
//        object_warn(obj, "window size can't be greater than fft size: decreasing y to %ld", a->fft_size);
//        a->window_size = a->fft_size;
//    }
//
//    a->hop_size = ac > offset + 2 ? atom_getlong(av + offset + 2) : a->fft_size >> 2;
//    if (a->hop_size > a->fft_size >> 1)
//    {
//        //        hop_size = fft_size >> 1;
//        object_warn(obj, "An overlap factor < 2 may give unpredictable results");
//    }
//}
//
///**
// Clear and add buffers to a polybuffer
// **/
//void add_n_buffers_to_polybuffer(t_symbol *polybuffer_name, int n_buffers, long buffer_length_samps)
//{
//    t_object* polybuffer = polybuffer_name->s_thing;
//
//    //clear polybuff (for now)
//    object_method_typed(polybuffer, gensym("clear"), 0, NULL, NULL);
//
//    //Add buffers. We want exact sample lengths, so this will take two calls
//    t_atom append_args[2];
//    atom_setfloat(&append_args[0], 1);
//    atom_setlong(&append_args[1], 1);
//    for(int i = 0; i < n_buffers; i++)
//    {
//        object_method_typed(polybuffer, gensym("appendempty"), 2, append_args, NULL);
//    }
//
//    t_atom resize_args[3];
//    atom_setlong(&resize_args[0], 0); //send to all
//    atom_setsym(&resize_args[1], gensym("samps"));
//    atom_setlong(&resize_args[2],buffer_length_samps);
//    object_method_typed(polybuffer,gensym("send"),3,resize_args,NULL);
//}
//
//
///*********************************************************************************************
// Max object functions
// ************************************************************************************************/
//
//void ext_main(void *r)
//{
//    t_class *c = class_new("fluid.nmf~", (method)nmf_new, NULL, sizeof(t_nmf), NULL, A_GIMME, 0);
//
//    class_addmethod(c, (method)call_makefilters,        "filters",   A_GIMME, 0);
//    class_addmethod(c, (method)call_makesources,        "sources",  A_GIMME, 0);
//    //    class_addmethod(c, (method)call_fftcheck, "fftcheck", A_GIMME, 0);
//
//    c->c_flags |= CLASS_FLAG_NEWDICTIONARY; //To let us have default attr values
//    CLASS_ATTR_LONG        (c, "iterations", 0, t_nmf, m_iterations);
//    CLASS_ATTR_FILTER_MIN  (c, "iterations", 1);
//    CLASS_ATTR_DEFAULT_SAVE(c, "iterations", 0, "100");
//
//    class_register(CLASS_BOX, c);
//    s_nmf_class = c;
//}
//
//
//void *nmf_new(t_symbol *s,  short argc, t_atom *argv)
//{
//    t_dictionary *d = NULL;
//    if (!(d = object_dictionaryarg(argc,argv)))
//        return NULL;
//
//    t_nmf *x = (t_nmf *)object_alloc(s_nmf_class);
//    x->m_outlet_done = bangout((t_object*)x);
//    attr_dictionary_process(x, d);
//
//    object_post((t_object*)x, "fluid.nmf~ version %s", FLUID_NMF_VERSION_STRING);
//    return (x);
//}
//
//void nmf_free(t_nmf *x){}
//
//
//void call_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av)
//{
//    defer(x, (method)nmf_makefilters, s, ac, av);
//}
//
//void nmf_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av)
//{
//
//    t_object* thisobj = (t_object*)x;
//
//    //up to 7 arguments
//    //rank [required]
//    //in buffer [required]
//    //out polybuffer dictionary [required]
//    //out polybuffer activations [required]
//    //fft size [optional]
//    //window size [optional]
//    //hop size [optional]
//
//    /**********************************
//     Argument checking
//     ***********************************/
//    if (ac < 4)
//    {
//        object_error(thisobj,error_strings::filters_args);
//        return;
//    }
//
//    long rank = ac > 0? atom_getlong(av): 0;
//    if(rank < 1)
//    {
//        object_error(thisobj,error_strings::rank_below_one);
//        return;
//    }
//
//    t_symbol* inbuffer_name         = ac > 1 ? atom_getsym(av + 1) : nullptr;
//    t_symbol* dict_polybuffername   = ac > 2 ? atom_getsym(av + 2) : nullptr;
//    t_symbol* act_polybuffername    = ac > 3 ? atom_getsym(av + 3) : nullptr;
//
//    if(   !check_symbol_param(thisobj, inbuffer_name,       error_strings::no_input_buffer_symbol)
//       || !check_symbol_param(thisobj, dict_polybuffername, error_strings::no_filter_polybuf_symbol)
//       || !check_symbol_param(thisobj, act_polybuffername,  error_strings::no_env_polybuf_symbol))
//    {
//        return;
//    }
//
//    fft_args fft_settings;
//    process_fft_args(thisobj, &fft_settings, ac, av, 4);
//
//    /*********************************
//     Set up buffers
//     *********************************/
//    bool is_ok = true;
//
//    MaxBufferView input_buffer(thisobj,inbuffer_name);
//    if(!input_buffer.m_bufref)
//    {
//        object_error(thisobj, "Could not get buffer for name %s", inbuffer_name->s_name);
//        is_ok = false;
//    }
//
//    //Check that polybuffers are kosher
//    if(!validate_polybuffer(x, dict_polybuffername) || !validate_polybuffer(x, act_polybuffername))
//    {
//        is_ok = false;
//    }
//
//    //DO STUFF!
//    if(is_ok)
//    {
//        //Copy data
//        FluidTensor<double, 1> audio_in(input_buffer.col(0));
//        //Set up NMF
//        NMFClient nmf(rank ,x->m_iterations, fft_settings.fft_size, fft_settings.window_size, fft_settings.hop_size);
//        //Process, no resyntheis
//        nmf.process(audio_in, false);
//        //Add dictionary and activation output buffers
//        add_n_buffers_to_polybuffer(dict_polybuffername, rank, nmf.dictionary_size());
//        add_n_buffers_to_polybuffer(act_polybuffername, rank, nmf.activations_length());
//
//        auto all_activations = nmf.activations();
//
//        //Find maximum activation amplitude to scale activations
//        double h_scale = 1. /  *std::max_element(all_activations.begin(), all_activations.end());
//        object_post(thisobj,"%e",h_scale);
//        //Copy output data
//        for (int i = 0; i < rank; ++i)
//        {
//            //FluidTensorView wrapping polybuffers, FTW (see top of file)
//            PolyBufferView dictbuff(thisobj, dict_polybuffername,i+1);
//            PolyBufferView actbuff(thisobj, act_polybuffername,i+1);
//            dictbuff.col(0) = nmf.dictionary(i);
//            actbuff.col(0) = nmf.activation(i);
//
//            //scale activations
//            actbuff.col(0).apply([&](float& x)
//                                 {
//                                     x *= h_scale;
//                                 });
//
//        }
//        outlet_bang(x->m_outlet_done);
//    }
//}
//
//void call_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av)
//{
//    defer(x,(method)nmf_makesources, s, ac, av);
//}
//
//
//void nmf_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av)
//{
//    t_object* thisobj = (t_object*)x;
//
//    //up to 6 arguments
//    //rank [required]
//    //in buffer [required]
//    //out polybuffer resynths [required]
//    //fft size [optional]
//    //window size [optional]
//    //hop size [optional]
//
//    /**********************************
//     Argument checking
//     ***********************************/
//    if (ac < 3)
//    {
//        object_error(thisobj,error_strings::sources_args);
//        return;
//    }
//
//    long rank = ac > 0? atom_getlong(av): 0;
//    if(rank < 1)
//    {
//        object_error(thisobj, error_strings::rank_below_one);
//        return;
//    }
//
//    t_symbol* inbuffer_name     = ac > 1 ? atom_getsym(av + 1) : nullptr;
//    t_symbol* polybuffername    = ac > 2 ? atom_getsym(av + 2) : nullptr;
//
//    if(   ! check_symbol_param(thisobj, inbuffer_name, error_strings::no_input_buffer_symbol)
//       || ! check_symbol_param(thisobj, polybuffername, error_strings::no_out_polybuf_symbol))
//    {
//        return;
//    }
//
//    fft_args fft_settings;
//    process_fft_args(thisobj, &fft_settings, ac, av, 3);
//
//    /*********************************
//     Set up buffers
//     *********************************/
//    bool is_ok = true;
//    MaxBufferView input_buffer(thisobj,inbuffer_name);
//
//    if(!input_buffer.m_bufref)
//    {
//        object_error(thisobj, "Could not get buffer for name %s", inbuffer_name->s_name);
//        is_ok = false;
//    }
//
//    //Check that polybuffers are kosher
//    if(!validate_polybuffer(x, polybuffername))
//    {
//        is_ok = false;
//    }
//
//    //DO STUFF!
//    if(is_ok)
//    {
//        //Copy data
//        FluidTensor<double,1> audio_in(input_buffer.col(0));
//        //Set NMF
//        NMFClient nmf(rank ,x->m_iterations, fft_settings.fft_size, fft_settings.window_size, fft_settings.hop_size);
//        //Process, with resynthesis
//        nmf.process(audio_in,true);
//        //Make output buffers
//        add_n_buffers_to_polybuffer(polybuffername, rank, input_buffer.n_frames);
//        //Copy output
//        for (int i = 0; i < rank; ++i)
//        {
//            PolyBufferView source(thisobj, polybuffername,i+1);
//            source.col(0) = nmf.source(i);
//
//
//            assert(source.end() == std::find_if(source.begin(), source.end(), std::isnan<double>));
//
//        }
//    }
//    outlet_bang(x->m_outlet_done);
//}

