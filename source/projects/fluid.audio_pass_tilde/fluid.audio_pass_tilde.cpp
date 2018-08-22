
/**
 @file
 fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio with gain applied
 */

//Main client code:
#include "clients/rt/GainClient.hpp"
//Max SDK
#include "ext.h"
#include "z_dsp.h"

//Client class
using fluid::audio::GainAudioClient;
//Data container
using fluid::FluidTensorView;


using audio_client = GainAudioClient<double, double>;
using audio_signal = audio_client::audio_signal;
using scalar_signal = audio_client::scalar_signal;
using signal_type = audio_client::signal_type;
/**********
 Maxy things
 *********/
static t_class* this_class = nullptr;

struct t_fluid_audio_pass {
    t_pxobject    obj;
    audio_client* fluid_obj;
    size_t chunk_size;
    double gain = 1;
    signal_type* input_type;
    signal_type* output_type;
};

/**!
 Perform() method for when there are two audio channels connected
 Returns channel 1 * channel 2
 **/
void fluid_audio_pass_perform(t_fluid_audio_pass* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
    
    //Map an audio_signal to our first signal inlet, come what may
    audio_signal input;
    input.set(ins[0],0);
    
    //Make 2 input signals, using whatever we set in dsp() for the second signal
    signal_type* in_sigs[2] {&input, x->input_type};
    //Make 1 output signal (this would always be audio in Max, but could be kr in SC)
    signal_type* out_sigs[1] {x->output_type};
    
    //Map 2nd input signal to 2nd audio inlet, and gain attribute
    x->input_type->set(ins[1], x->gain);
    //Map output signal to first signal outlet
    x->output_type->set(outs[0],0);
    //Process!
    x->fluid_obj->do_process(in_sigs, out_sigs,sampleframes,numins,numouts);
}


/**!
 DSP Setup, sets up client and adds correct perform() fn
 **/
void fluid_audio_pass_dsp64(t_fluid_audio_pass* x, t_object* dsp64, short *count, double samplerate, long maxvectorsize, long flags) {
    
    //no audio in left channel? Then no-op
    if(!count[0])
    {
        return;
    }
    
    //Audio in right inlet?
    size_t inputchannels = count[1] ? 2 : 1;
    
    //Delete old processor
    if(x->fluid_obj)
        delete x->fluid_obj;
    //Make new one with appropriate number of channels
    x->fluid_obj = new GainAudioClient<double,double>(x->chunk_size);
    
    if(x->input_type)
        delete x->input_type;
    if(x->output_type)
        delete x->output_type;
    
    x->output_type = new GainAudioClient<double, double>::audio_signal();
    
    if(inputchannels == 1)
        x->input_type = new GainAudioClient<double, double>::scalar_signal();
    else
        x->input_type = new GainAudioClient<double, double>::audio_signal();
    
    
    
    //TODO: I imagine some algorithms will need the sample rate in future as well
    x->fluid_obj->set_host_buffer_size(maxvectorsize);
    x->fluid_obj->reset();
    
    //TODO: Add perform method for no latency edge case. Maybe. One day.
    //If and only if the following are true,
    //given
    //  fsize = our frame size
    //  vsize = our vector size
    //  fsize <= vsize && fsize % vsize == 0
    // *AND WE HAVE NO OVERLAP*
    // Then no buffering is required and we can use a different method
    // Which of our current use cases does this touch? (Apart from this test case?)
    
    //Meanwhile, one-size-delays-all buffering perform method
//    if(inputchannels == 2)
//    {
        object_method(dsp64, gensym("dsp_add64"), x, fluid_audio_pass_perform, 0, NULL);
//    }
//    else
//    {
//        object_method(dsp64, gensym("dsp_add64"), x, fluid_audio_pass_perform_scalar, 0, NULL);
//    }
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
    
    CLASS_ATTR_DOUBLE   (this_class, "gain", 0, t_fluid_audio_pass, gain);
    CLASS_ATTR_MIN      (this_class, "gain", 0, "0");
    CLASS_ATTR_SAVE     (this_class, "gain", 0);
    
    class_dspinit(this_class);

    class_register(CLASS_BOX, this_class);
}
