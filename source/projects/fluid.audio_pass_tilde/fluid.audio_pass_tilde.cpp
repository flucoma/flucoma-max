
/**
 @file
 fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio
 
 SINGLE CHANNEL FOR NOW. DON'T @ ME
 
 */

#include "fluid.audio.gainclient.hpp"
#include "ext.h"
#include "z_dsp.h"

using fluid::audio::GainAudioClient;
using fluid::FluidTensorView;

static t_class* this_class = nullptr;


struct t_fluid_audio_pass {
    t_pxobject    obj;
    GainAudioClient<double>* fluid_obj;
    size_t chunk_size;
    double gain = 1;
};


void fluid_audio_pass_perform_vector(t_fluid_audio_pass* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {

    x->fluid_obj->do_process(ins, outs,sampleframes,numins,numouts);

}

void fluid_audio_pass_perform_scalar(t_fluid_audio_pass* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
    x->fluid_obj->set_gain(x->gain); 
    x->fluid_obj->do_process(ins, outs,sampleframes,1,numouts);
    
}


void fluid_audio_pass_dsp64(t_fluid_audio_pass* x, t_object* dsp64, short *count, double samplerate, long maxvectorsize, long flags) {
    
    size_t inputchannels = count[1] ? 2 : 1;
    
    //If we've got two signals connected but only a mono processor, make a new one
    if(x->fluid_obj)
        delete x->fluid_obj;
    
    x->fluid_obj = new GainAudioClient<double>(x->chunk_size,inputchannels); 
    
    
    //TODO: I imagine some algorithms will need the sample rate in future as well
    x->fluid_obj->set_host_buffer_size(maxvectorsize);
    x->fluid_obj->reset();
    
    //TODO: Add perform method for no latency edge case
    //If and only if the following are true,
    //given
    //  fsize = our frame size
    //  vsize = our vector size
    //  fsize <= vsize && fsize % vsize == 0
    // *AND WE HAVE NO OVERLAP*
    // Then no buffering is required and we can use a different method
    // Which of our current use cases does this touch? (Apart from this test case?)
    
    //Meanwhile, one-size-delays-all buffering perform method
    if(inputchannels == 2)
    {
        object_method(dsp64, gensym("dsp_add64"), x, fluid_audio_pass_perform_vector, 0, NULL);
    }
    else
    {
        object_method(dsp64, gensym("dsp_add64"), x, fluid_audio_pass_perform_scalar, 0, NULL);
    }
}


void fluid_audio_pass_assist(t_fluid_audio_pass *x, void *b, long m, long a, char *s)
{
    if (m == ASSIST_INLET) {
        switch (a) {
            case 0:
                strcpy(s,"Audio in");
                break;
        }
    }
}



void* fluid_audio_pass_new(t_symbol *s,  short argc, t_atom *argv) {
    t_fluid_audio_pass* x = (t_fluid_audio_pass*)object_alloc(this_class);
    
    x->chunk_size = argc > 0 ? atom_getlong(argv) : 1024;
    //x->fluid_obj = new GainAudioClient<double>(x->chunk_size);
    
    //2 inlets, 1 outlet
    dsp_setup((t_pxobject*)x, 2);
    outlet_new((t_object *)x, "signal");
    x->gain = 1. ;
    return x;
}


void fluid_audio_pass_free(t_fluid_audio_pass *x)
{
    dsp_free((t_pxobject*)x);
    if(x->fluid_obj)
        delete x->fluid_obj;
}

void ext_main(void* r) {
    this_class = class_new("fluid.audio_pass~", (method)fluid_audio_pass_new, (method)fluid_audio_pass_free, sizeof(t_fluid_audio_pass), 0,A_GIMME, 0);
    
    
    class_addmethod(this_class, (method)fluid_audio_pass_dsp64, "dsp64", A_CANT, 0);
    class_addmethod(this_class, (method)fluid_audio_pass_assist,"assist",A_CANT,0);
    
    CLASS_ATTR_DOUBLE(this_class, "gain", 0, t_fluid_audio_pass, gain);
    CLASS_ATTR_MIN(this_class, "gain", 0, "0");
    CLASS_ATTR_SAVE(this_class, "gain", 0);
    
    class_dspinit(this_class);

    class_register(CLASS_BOX, this_class);
}
