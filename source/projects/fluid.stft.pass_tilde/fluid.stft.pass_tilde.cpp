/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "MaxClass_Base.h"

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

namespace fluid {
  namespace stft {
    class BaseSTFTWrapper: public MaxClass_Base
    {
      using SignalPointer = std::unique_ptr<signal_wrapper>;
    public:
      static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
      {
//        addMethod<NMFMax,&NMFMax::decompose>(c, "process");
//        makeAttributes<nmf::NMFClient,NMFMax>(c);
        dspInit(c);

        addMethod<BaseSTFTWrapper,&BaseSTFTWrapper::dsp>(c);
      }
      
      BaseSTFTWrapper(t_symbol *s, long argc, t_atom *argv)
      {
        window_size = argc > 0 ? atom_getlong(argv)     : 1024;
        hop_size   = argc > 1 ? atom_getlong(argv + 1) : window_size / 2;
        fft_size   = argc > 2 ? atom_getlong(argv + 2) : window_size;
        dspSetup(1);
        outlet_new(*this, "signal");
      }
      
      void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
      {
//        no audio in left channel? Then no-op
        if(!count[0])
        {
          return;
        }
        
        //Delete old processor
        if(fluid_obj)
          delete fluid_obj;
        //Make new one with appropriate number of channels, pass in STFT params
        fluid_obj = new BaseSTFTClient<double,double>(window_size, hop_size, fft_size);
        
        
        //TODO: Given that this will always be audio signals, all this is redundant
//        if(inputWrapper)
//          delete inputWrapper;
//        if(output_wrappers[0])
//          delete output_wrappers[0];
        
        
        inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        //TODO: I imagine some algorithms will need the sample rate in future as well
        fluid_obj->set_host_buffer_size(maxvectorsize);
        fluid_obj->reset();
        addPerform<BaseSTFTWrapper, &BaseSTFTWrapper::perform>(dsp64);
      }
      
      void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
      {
        inputWrapper[0]->set(ins[0], 0);
        outputWrapper[0]->set(outs[0],0);
        fluid_obj->do_process(inputWrapper.begin(),inputWrapper.end(), outputWrapper.begin(), outputWrapper.end(), sampleframes,1,1);
      }
      
    private:
      audio_client* fluid_obj;
//      signal_wrapper* input_wrappers[1];
//      signal_wrapper* output_wrappers[1];
      std::array<SignalPointer,1> inputWrapper;
      std::array<SignalPointer,1> outputWrapper;
      size_t window_size;
      size_t hop_size;
      size_t fft_size;
    };
  }
}

void ext_main(void *r)
{
  fluid::stft::BaseSTFTWrapper::makeClass<fluid::stft::BaseSTFTWrapper>(CLASS_BOX, "fluid.stft.pass~");
}
