
//#include "c74_msp.h"
#include <vector>
#include <algorithm>
#include "stft.h"
#include "nmf.h"
#include <Eigen/Dense>
#include "ext.h"
//#include "z_dsp.h"
//#include "math.h"
#include "ext_buffer.h"
#include "fluid_nmf_tilde_util.h"
#include "version.h"
//#include "ext_atomic.h"
//#include "ext_obex.h"

//using namespace c74::max;


//using std::runtime_error;
//using std::cout;
using stft::STFT;
using stft::ISTFT;
using stft::Spectrogram;
using stft:: audio_buffer_t;
using stft:: magnitude_t;
using nmf::NMF;
using nmf::NMFModel;
using Eigen::MatrixXcd;
using Eigen::MatrixXd;
using std::complex;
using util::stlVecVec2Eigen;
using util::Eigen2StlVecVec;
using std::numeric_limits;

using fluid::nmf_max_client::error_strings;
using fluid::nmf_max_client::copy_to_buffer;
using fluid::nmf_max_client::from_rows;
using fluid::nmf_max_client::from_cols;
using fluid::nmf_max_client::check_symbol_param;

typedef struct _nmf {
    t_object w_obj;
    void* m_outlet_done;
    long m_iterations;
    t_symbol *m_init_w;
    t_symbol *m_init_h;
    bool m_update_w;
    bool m_update_h;
} t_nmf;

struct fft_args{
    int window_size;
    int fft_size;
    int hop_size;
};

void *nmf_new(t_symbol *s,  short argc, t_atom *argv);
void nmf_free(t_nmf *x);
//t_max_err nmf_notify(t_nmf *x, t_symbol *s, t_symbol *msg, void *sender, void *data);
//void nmf_assist(t_nmf *x, void *b, long m, long a, char *s);
//void nmf_limits(t_nmf *x);
//void nmf_set(t_nmf *x, t_symbol *s, long ac, t_atom *av);
//void nmf_float(t_nmf *x, double f);
//void nmf_int(t_nmf *x, long n);
//void nmf_dblclick(t_nmf *x);
//void nmf_perform64(t_nmf *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam);
//void nmf_dsp64(t_nmf *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags);

void nmf_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av);
void nmf_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av);

void nmf_fftcheck(t_nmf *x, t_symbol *s, long ac, t_atom *av);

bool validate_polybuffer(t_nmf *x, t_symbol *pb_name);
//Use these as proxies, so that calls are always deferred to main thread
void call_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av);
void call_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av);

void call_fftcheck (t_nmf *x, t_symbol *s, long ac, t_atom *av);

//static t_symbol *ps_buffer_modified;
static t_class *s_nmf_class;


void ext_main(void *r)
{
    t_class *c = class_new("fluid.nmf~", (method)nmf_new, NULL, sizeof(t_nmf), NULL, A_GIMME, 0);
    
    //    class_addmethod(c, (method)nmf_dsp64,        "dsp64",    A_CANT, 0);
    //    class_addmethod(c, (method)nmf_float,        "float",    A_FLOAT, 0);
    //    class_addmethod(c, (method)nmf_int,            "int",        A_LONG, 0);
    //    class_addmethod(c, (method)nmf_set,            "set",        A_GIMME, 0);
    //    class_addmethod(c, (method)nmf_assist,        "assist",    A_CANT, 0);
    //    class_addmethod(c, (method)nmf_dblclick,    "dblclick",    A_CANT, 0);
    //    class_addmethod(c, (method)nmf_notify,        "notify",    A_CANT, 0);
    
    class_addmethod(c, (method)call_makefilters,        "filters",   A_GIMME, 0);
    class_addmethod(c, (method)call_makesources,        "sources",  A_GIMME, 0);
    
    class_addmethod(c, (method)call_fftcheck, "fftcheck", A_GIMME, 0);
    
    c->c_flags |= CLASS_FLAG_NEWDICTIONARY; //To let us have default attr values
    
    CLASS_ATTR_LONG        (c, "iterations", 0, t_nmf, m_iterations);
    CLASS_ATTR_FILTER_MIN  (c, "iterations", 1);
    CLASS_ATTR_DEFAULT_SAVE(c, "iterations", 0, "100");
    
    
    
    //    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_nmf_class = c;
    
    //    ps_buffer_modified = gensym("buffer_modified");
}


void *nmf_new(t_symbol *s,  short argc, t_atom *argv)
{
    t_dictionary *d = NULL;
    if (!(d = object_dictionaryarg(argc,argv)))
        return NULL;
    
    t_nmf *x = (t_nmf *)object_alloc(s_nmf_class);
    x->m_outlet_done = bangout((t_object*)x);
    attr_dictionary_process(x, d);
    
    object_post((t_object*)x, "fluid.nmf~ version %s", FLUID_NMF_VERSION_STRING);
    return (x);
}


void nmf_free(t_nmf *x)
{
    //    dsp_free((t_pxobject *)x);
    
    // must free our buffer reference when we will no longer use it
    //    object_free(x->w_buf);
}

bool validate_polybuffer(t_nmf *x, t_symbol *pb_name)
{
    t_object* this_obj = (t_object*)x;
    if(pb_name && pb_name->s_thing)
    {
        //The s_thing of a polybuffer t_symbol* binds to a class called
        //'polybuffer', not 'polybuffer~', which sits in the CLASS_NOBOX namesapce
        if(object_classname_compare(pb_name->s_thing, gensym("polybuffer")))
        {
            return true;
        }
        else
        {
            t_symbol* itsname = object_classname(pb_name->s_thing);
            object_error(this_obj,"%s points to a %s object, not a polybuffer",pb_name->s_name,itsname->s_name);
            return false;
        }
    }
    else
    {
        object_error(this_obj, "%s is not bound to an object", pb_name->s_name);
        return false;
    }
}

void process_fft_args(t_object* obj, fft_args* a, long ac, t_atom *av, int offset)
{
    a->fft_size = ac > offset ? atom_getlong(av + offset) : 2048;
    if(a->fft_size < 32)
    {
        object_warn(obj, "%ld is not a sensible FFT size, setting to default (2048)");
        a->fft_size = 2048;
    }
    else
    {
        double log2_fft_size = log2(a->fft_size);
        if(log2_fft_size - trunc(log2_fft_size) != 0)
        {
            object_warn(obj, "fft_size: %ld is not a power of two. Increasing fft_size to nearest power of two");
            a->fft_size = pow(2,trunc(log2_fft_size) + 1);
        }
    }
    //    aframe_size = (fft_size >> 1) + 1;
    
    a->window_size = ac > offset+1 ? atom_getlong(av + offset +1) : a->fft_size;
    if( a->window_size > a->fft_size)
    {
        object_warn(obj, "window size can't be greater than fft size: decreasing y to %ld", a->fft_size);
        a->window_size = a->fft_size;
    }
    
    a->hop_size = ac > offset + 2 ? atom_getlong(av + offset + 2) : a->fft_size >> 2;
    if (a->hop_size > a->fft_size >> 1)
    {
        //        hop_size = fft_size >> 1;
        object_warn(obj, "An overlap factor < 2 may give unpredictable results");
    }
}

void add_n_buffers_to_polybuffer(t_symbol *polybuffer_name, int n_buffers, long buffer_length_samps)
{
    t_object* polybuffer = polybuffer_name->s_thing;
    
    //clear polybuff (for now)
    object_method_typed(polybuffer, gensym("clear"), 0, NULL, NULL);
    
    //Add buffers. We want exact sample lengths, so this will take two calls
    t_atom append_args[2];
    atom_setfloat(&append_args[0], 1);
    atom_setlong(&append_args[1], 1);
    for(int i = 0; i < n_buffers; i++)
    {
        object_method_typed(polybuffer, gensym("appendempty"), 2, append_args, NULL);
    }
    
    t_atom resize_args[3];
    atom_setlong(&resize_args[0], 0);
    atom_setsym(&resize_args[1], gensym("samps"));
    atom_setlong(&resize_args[2],buffer_length_samps);
    object_method_typed(polybuffer,gensym("send"),3,resize_args,NULL);
}

void call_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av)
{
    defer(x, (method)nmf_makefilters, s, ac, av);
}

void nmf_makefilters(t_nmf *x, t_symbol *s, long ac, t_atom *av)
{
    
    t_object* thisobj = (t_object*)x;
    
    //up to 7 arguments
    //rank [required]
    //in buffer [required]
    //out polybuffer dictionary [required]
    //out polybuffer activations [required]
    //fft size [optional]
    //window size [optional]
    //hop size [optional]
    
    /**********************************
     Argument checking
     ***********************************/
    if (ac < 4)
    {
        object_error(thisobj,error_strings::filters_args);
        return;
    }
    
    long rank = ac > 0? atom_getlong(av): 0;
    if(rank < 1)
    {
        object_error(thisobj,error_strings::rank_below_one);
        return;
    }
    
    t_symbol* inbuffer_name         = ac > 1 ? atom_getsym(av + 1) : nullptr;
    t_symbol* dict_polybuffername   = ac > 2 ? atom_getsym(av + 2) : nullptr;
    t_symbol* act_polybuffername    = ac > 3 ? atom_getsym(av + 3) : nullptr;
    
    if(   !check_symbol_param(thisobj, inbuffer_name,       error_strings::no_input_buffer_symbol)
       || !check_symbol_param(thisobj, dict_polybuffername, error_strings::no_filter_polybuf_symbol)
       || !check_symbol_param(thisobj, act_polybuffername,  error_strings::no_env_polybuf_symbol))
    {
        return;
    }
    
    fft_args fft_settings;
    process_fft_args(thisobj, &fft_settings, ac, av, 4);
    
    /*********************************
     Set up buffers
     *********************************/
    bool is_ok = true;
    
    t_buffer_ref* input_buffer_ref = buffer_ref_new(thisobj, inbuffer_name);
    t_buffer_obj* input_buffer = buffer_ref_getobject(input_buffer_ref);
    
    if(!input_buffer)
    {
        object_error(thisobj, "Could not get buffer for name %s", inbuffer_name->s_name);
        is_ok = false;
    }
    
    long in_samps   = buffer_getframecount(input_buffer);
    long in_channs  = buffer_getchannelcount(input_buffer);
    //long n_frames = trunc(in_samps )
    
    //Check that polybuffers are kosher
    if(!validate_polybuffer(x, dict_polybuffername) || !validate_polybuffer(x, act_polybuffername))
    {
        is_ok = false;
    }
    
    
    //DO STUFF!
    if(is_ok)
    {
        std::vector<double> audio_in(in_samps);
        
        float* samps = buffer_locksamples(input_buffer);
        if(samps)
        {
            for(long i = 0, j = 0; i < in_samps; i++, j+=in_channs)
            {
                audio_in[i] = samps[j];
            }
            
            buffer_unlocksamples(input_buffer);
            
            STFT stft(fft_settings.window_size,fft_settings.fft_size,fft_settings.hop_size);
            Spectrogram spec = stft.process(audio_in);
            magnitude_t mag = spec.magnitude();
            NMF nmfProcessor(rank, x->m_iterations);
            NMFModel decomposition = nmfProcessor.process(mag);
            //            long n_dicts = decomposition.W.size();
            long n_activations = decomposition.H.size();
            //            MatrixXd W = stlVecVec2Eigen<double>(decomposition.W);
            MatrixXd H = stlVecVec2Eigen<double>(decomposition.H);
            double h_scalefactor = H.maxCoeff();
            //magnitude_t tamed_activations =  Eigen2StlVecVec<double>(scale_activations);
            add_n_buffers_to_polybuffer(dict_polybuffername, rank, decomposition.W[0].size());
            add_n_buffers_to_polybuffer(act_polybuffername, rank, n_activations);
            //copy data
            copy_to_buffer(thisobj, rank, dict_polybuffername, decomposition.W, from_cols);
            copy_to_buffer(thisobj, rank, act_polybuffername,  decomposition.H, from_rows, 1. / h_scalefactor);
            outlet_bang(x->m_outlet_done);
        }
    }
    //finally
    if(input_buffer_ref)
        object_free(input_buffer_ref);
}

void call_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av)
{
    defer(x,(method)nmf_makesources, s, ac, av);
}

void nmf_makesources(t_nmf *x, t_symbol *s, long ac, t_atom *av)
{
    t_object* thisobj = (t_object*)x;
    
    //up to 6 arguments
    //rank [required]
    //in buffer [required]
    //out polybuffer resynths [required]
    //fft size [optional]
    //window size [optional]
    //hop size [optional]
    
    /**********************************
     Argument checking
     ***********************************/
    if (ac < 3)
    {
        object_error(thisobj,error_strings::sources_args);
        return;
    }
    
    long rank = ac > 0? atom_getlong(av): 0;
    if(rank < 1)
    {
        object_error(thisobj, error_strings::rank_below_one);
        return;
    }
    
    t_symbol* inbuffer_name     = ac > 1 ? atom_getsym(av + 1) : nullptr;
    t_symbol* polybuffername    = ac > 2 ? atom_getsym(av + 2) : nullptr;
    
    if(   ! check_symbol_param(thisobj, inbuffer_name, error_strings::no_input_buffer_symbol)
       || ! check_symbol_param(thisobj, polybuffername, error_strings::no_out_polybuf_symbol))
    {
        return;
    }
    
    fft_args fft_settings;
    process_fft_args(thisobj, &fft_settings, ac, av, 3);
    
    /*********************************
     Set up buffers
     *********************************/
    bool is_ok = true;
    
    t_buffer_ref* input_buffer_ref = buffer_ref_new(thisobj, inbuffer_name);
    t_buffer_obj* input_buffer = buffer_ref_getobject(input_buffer_ref);
    
    if(!input_buffer)
    {
        object_error(thisobj, "Could not get buffer for name %s", inbuffer_name->s_name);
        is_ok = false;
    }
    
    long in_samps   = buffer_getframecount(input_buffer);
    long in_channs  = buffer_getchannelcount(input_buffer);
    //long n_frames = trunc(in_samps )
    
    //Check that polybuffers are kosher
    if(!validate_polybuffer(x, polybuffername))
    {
        is_ok = false;
    }
    
    //DO STUFF!
    if(is_ok)
    {
        std::vector<double> audio_in(in_samps);
        
        float* samps = buffer_locksamples(input_buffer);
        if(samps)
        {
            for(long i = 0, j = 0; i < in_samps; i++, j+=in_channs)
            {
                audio_in[i] = samps[j];
            }
            
            buffer_unlocksamples(input_buffer);
            
            STFT stft(fft_settings.window_size,fft_settings.fft_size,fft_settings.hop_size);
            Spectrogram spec = stft.process(audio_in);
            magnitude_t mag = spec.magnitude();
            NMF nmfProcessor(rank, x->m_iterations);
            NMFModel decomposition = nmfProcessor.process(mag);
            ISTFT istft(fft_settings.window_size,fft_settings.fft_size,fft_settings.hop_size);
            //
            MatrixXd W = stlVecVec2Eigen<double>(decomposition.W);
            MatrixXd H = stlVecVec2Eigen<double>(decomposition.H);
            
            MatrixXd V = W * H;
            
            add_n_buffers_to_polybuffer(polybuffername, rank, in_samps);
            
            for (int i = 0; i < rank; i++)
            {
                MatrixXd source = W.col(i) * H.row(i);
                MatrixXd filter = source.cwiseQuotient(V);
                MatrixXcd specMatrix = stlVecVec2Eigen(spec.mData);
                specMatrix = specMatrix.cwiseProduct(filter);
                Spectrogram resultS(Eigen2StlVecVec<complex<double>>(specMatrix));
                
                audio_buffer_t result = istft.process(resultS);
                std::ostringstream ss;
                ss << polybuffername->s_name << "." << i+1;
                const char* buffer_name = ss.str().c_str();
                
                t_buffer_ref* out_buf_ref =   buffer_ref_new(thisobj, gensym(buffer_name));
                t_buffer_obj* out_buf = buffer_ref_getobject(out_buf_ref);
                float* out_samps = buffer_locksamples(out_buf);
                long out_nsamps = buffer_getframecount(out_buf);
                assert(in_samps == out_nsamps);
                
                //I'd prefer to use stl here, but Windoze might moan
                //about precision loss (Mac doesn't)
                if(out_samps)
                    for(int j = 0; j < in_samps; j++)
                    {
                        out_samps[j] = result[j];
                    }
                
                buffer_unlocksamples(out_buf);
                if(out_buf_ref)
                    object_free(out_buf_ref);
                
            }
            
            outlet_bang(x->m_outlet_done);
        }
    }
    //finally
    if(input_buffer_ref)
        object_free(input_buffer_ref);
}

void call_fftcheck (t_nmf *x, t_symbol *s, long ac, t_atom *av){
    defer(x, (method)nmf_fftcheck, s, ac, av);
}

void nmf_fftcheck (t_nmf *x, t_symbol *s, long ac, t_atom *av)
{
    //NOT MEANT FOR PUBLIC CONSUMPTION.
    //used for checking consistency of stft. Comment out line addmethod
    //in main() for release code
    //args: inbuffer, outbuffer, fft args (window, fftsize, hopsize)
    t_object* thisobj = (t_object*)x;

    if(ac < 5)
    {
        object_error(thisobj, "Not enough args:inbuffer, outbuffer, fft args (fftsize, window, hopsize)");
        return;
    }
    
    t_symbol* in_buf_name = atom_getsym(av);
    t_symbol* out_buf_name = atom_getsym(av+1);
    
    fft_args fft_settings;
    process_fft_args(thisobj, &fft_settings, ac, av, 2);
    
    
    t_buffer_ref* in_buf_ref  = buffer_ref_new(thisobj, in_buf_name);
    t_buffer_ref* out_buf_ref = buffer_ref_new(thisobj, out_buf_name);

    t_buffer_obj* in_buf_obj = buffer_ref_getobject(in_buf_ref);
    STFT stft(fft_settings.window_size, fft_settings.fft_size,fft_settings.hop_size);
    ISTFT istft(fft_settings.window_size, fft_settings.fft_size,fft_settings.hop_size);
    
    
    float* in_samps = buffer_locksamples(in_buf_obj);
    if(in_samps)
    {
        long in_count = buffer_getframecount(in_buf_obj);
        std::vector<double> tmp_vec(in_count);
        
        for(int i = 0; i < in_count; i++)
            tmp_vec[i] = in_samps[i];
        buffer_unlocksamples(in_buf_obj);
        
        Spectrogram spec = stft.process(tmp_vec);
        std::vector<double>  out_vec = istft.process(spec);
        

        object_attr_setlong(out_buf_name->s_thing, gensym("samps"), in_count);

       
        t_buffer_obj* out_buf_obj = buffer_ref_getobject(out_buf_ref);
        
//        t_atom temp_atom[2];
//        atom_setlong(temp_atom, in_count);
        
//        object_method_typed ((t_object *)out_buf_obj, gensym("sizeinsamps"), 1L, temp_atom, temp_atom + 1);
        float* out_samps = buffer_locksamples(out_buf_obj);
        if(out_samps)
        {
            for(int i = 0; i < in_count; i++)
                out_samps[i] =  out_vec[i];
        }
    }
    
    if(in_buf_ref) object_free(in_buf_ref);
    if(out_buf_ref)object_free(out_buf_ref);
    
}



