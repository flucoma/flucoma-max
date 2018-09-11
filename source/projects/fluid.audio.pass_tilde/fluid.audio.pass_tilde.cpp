
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
using audio_signal_wrapper = audio_client::audio_signal;
using scalar_signal_wrapper = audio_client::scalar_signal;
using signal_wrapper = audio_client::signal_type;
/**********
 Maxy things
 *********/
static t_class* this_class = nullptr;

struct t_fluid_audio_pass {
  t_pxobject    obj;
  audio_client* fluid_obj;
  size_t chunk_size;
  size_t hop_size;
  double gain = 1;
  signal_wrapper* input_wrappers[2];
  signal_wrapper* output_wrappers[1];
};

/**!
 Perform() method for when there are two audio channels connected
 Returns channel 1 * channel 2
 **/
void fluid_audio_pass_perform(t_fluid_audio_pass* x, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
  
  x->input_wrappers[0]->set(ins[0], 0);
  //Map 2nd input signal to 2nd audio inlet, and gain attribute
  x->input_wrappers[1]->set(ins[1], x->gain);
  //Map output signal to first signal outlet
  x->output_wrappers[0]->set(outs[0],0);
  //Process!
  x->fluid_obj->do_process(std::begin(x->input_wrappers),std::end(x->output_wrappers),std::begin(x->output_wrappers), std::end(x->output_wrappers), sampleframes,numins,numouts);
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
  size_t inputsignals = count[1] ? 2 : 1;
  
  //Delete old processor
  if(x->fluid_obj)
    delete x->fluid_obj;
  //Make new one with appropriate number of channels
  x->fluid_obj = new GainAudioClient<double,double>(x->chunk_size);
  
  if(x->input_wrappers[0])
    delete x->input_wrappers[0];
  if(x->input_wrappers[1])
    delete x->input_wrappers[1];
  if(x->output_wrappers[0])
    delete x->output_wrappers[0];
  
  x->input_wrappers[0] = new audio_signal_wrapper();
  
  x->output_wrappers[0] = new audio_signal_wrapper();
  
  if(inputsignals == 1)
    x->input_wrappers[1] = new scalar_signal_wrapper();
  else
    x->input_wrappers[1] = new audio_signal_wrapper();
  
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
  
  object_method(dsp64, gensym("dsp_add64"), x, fluid_audio_pass_perform, 0, NULL);
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
  
  short nargs = attr_args_offset(argc,argv);
  
  x->chunk_size = nargs > 0 ? atom_getlong(argv)     : 1024;
  x->hop_size   = nargs > 1 ? atom_getlong(argv + 1) : x->chunk_size;
  x->gain = 1.;
  attr_args_process(x, argc, argv);
  if (x->hop_size > x->chunk_size)
  {
    object_warn((t_object*)x, "Hop size, %ld, can't be bigger than frame size,%ld : setting to %ld", x->hop_size, x->chunk_size,x->chunk_size);
    x->hop_size = x->chunk_size;
  }
  

  //2 inlets, 1 outlet
  dsp_setup((t_pxobject*)x, 2);
  outlet_new((t_object *)x, "signal");
  
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
