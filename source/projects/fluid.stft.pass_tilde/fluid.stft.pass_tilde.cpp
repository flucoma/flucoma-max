/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "ext.h"
#include "z_dsp.h"

#include "clients/rt/BaseSTFTClient.hpp"

//Client class
using fluid::audio::BaseSTFTClient;
//Data container
using fluid::FluidTensorView;

using audio_client = BaseSTFTClient<double, double>;
using audio_signal_wrapper = audio_client::AudioSignal;
using scalar_signal_wrapper = audio_client::ScalarSignal;
using signal_wrapper = audio_client::Signal<double>;
/**********
 Maxy things
 *********/
static t_class* this_class = nullptr;

struct t_fluid_stft_pass {
    t_pxobject    obj;
    audio_client* fluid_obj;
    size_t window_size;
    size_t hop_size;
    size_t fft_size;
    double gain = 1;
    double* norm_buffer;
    signal_wrapper* input_wrappers[1];
    signal_wrapper* output_wrappers[2];
};

/**!
 Perform() method for when there are two audio channels connected
 Returns channel 1 * channel 2
 **/
void fluid_stft_pass_perform(t_fluid_stft_pass* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
    
    x->input_wrappers[0]->set(ins[0], 0);
    //Map 2nd input signal to 2nd audio inlet, and gain attribute
    x->output_wrappers[0]->set(outs[0],0);
    x->output_wrappers[1]->set(x->norm_buffer,1);
    //Process!
    x->fluid_obj->do_process(x->input_wrappers, x->output_wrappers, sampleframes,1,2);
    
    //We need to normalise *after* the overlap add, because of the way we do it
    std::transform(outs[0], outs[0] + sampleframes, x->norm_buffer, outs[0], std::divides<double>()); 
}


/**!
 DSP Setup, sets up client and adds correct perform() fn
 **/
void fluid_stft_pass_dsp64(t_fluid_stft_pass* x, t_object* dsp64, short *count, double samplerate, long maxvectorsize, long flags) {
    
    //no audio in left channel? Then no-op
    if(!count[0])
    {
        return;
    }
    
    //Delete old processor
    if(x->fluid_obj)
        delete x->fluid_obj;
    //Make new one with appropriate number of channels, pass in STFT params
    x->fluid_obj = new BaseSTFTClient<double,double>(x->window_size, x->hop_size,x->fft_size);
    
    //Params get checked and adjusted during construction, we can pass on warning messages:
    std::istringstream param_feedback(x->fluid_obj->getFeedbackString());
    std::string message;
    
    while(std::getline(param_feedback, message, '\n'))
        object_warn((t_object*)x, message.c_str());
    
    
    //TODO: Given that this will always be audio signals, all this is redundant
    if(x->input_wrappers[0])
        delete x->input_wrappers[0];
    if(x->output_wrappers[0])
        delete x->output_wrappers[0];
    if(x->output_wrappers[1])
        delete x->output_wrappers[1];
    if(x->norm_buffer)
        delete x->norm_buffer;
    
    
    x->input_wrappers[0] = new audio_signal_wrapper();
    
    x->output_wrappers[0] = new audio_signal_wrapper();
    x->output_wrappers[1] = new audio_signal_wrapper();
    x->norm_buffer        = new double[maxvectorsize];
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
    
    object_method(dsp64, gensym("dsp_add64"), x, fluid_stft_pass_perform, 0, NULL);
}


void fluid_stft_pass_assist(t_fluid_stft_pass *x, void *b, long m, long a, char *s)
{
    if (m == ASSIST_INLET) {
        switch (a) {
            case 0:
                strcpy(s,"Audio in");
                break;
        }
    }
}



void* fluid_stft_pass_new(t_symbol *s,  short argc, t_atom *argv) {
    t_fluid_stft_pass* x = (t_fluid_stft_pass*)object_alloc(this_class);
    
    x->window_size = argc > 0 ? atom_getlong(argv)     : 1024;
    x->hop_size   = argc > 1 ? atom_getlong(argv + 1) : x->window_size;
    x->fft_size   = argc > 2 ? atom_getlong(argv + 2) : x->window_size; 
    
    if (x->hop_size > x->window_size)
    {
        object_warn((t_object*)x, "Hop size, %ld, can't be bigger than frame size,%ld : setting to %ld", x->hop_size, x->window_size,x->window_size);
        x->hop_size = x->window_size;
    }
    
    
    //1 inlet, 1 outlet
    dsp_setup((t_pxobject*)x, 1);
    outlet_new((t_object *)x, "signal");
    
    x->gain = 1.;
    return x;
}


void fluid_stft_pass_free(t_fluid_stft_pass *x)
{
    dsp_free((t_pxobject*)x);
    if(x->fluid_obj)
        delete x->fluid_obj;
}

void ext_main(void* r) {
    this_class = class_new("fluid.stft.pass~", (method)fluid_stft_pass_new, (method)fluid_stft_pass_free, sizeof(t_fluid_stft_pass), 0,A_GIMME, 0);
    
    class_addmethod(this_class, (method)fluid_stft_pass_dsp64, "dsp64", A_CANT, 0);
    class_addmethod(this_class, (method)fluid_stft_pass_assist,"assist",A_CANT,0);
    
    CLASS_ATTR_DOUBLE   (this_class, "gain", 0, t_fluid_stft_pass, gain);
    CLASS_ATTR_MIN      (this_class, "gain", 0, "0");
    CLASS_ATTR_SAVE     (this_class, "gain", 0);
    
    class_dspinit(this_class);
    
    class_register(CLASS_BOX, this_class);
}



