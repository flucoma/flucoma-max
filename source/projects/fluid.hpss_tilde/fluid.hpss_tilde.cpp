/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "MaxClass_Base.h"

#include "ext.h"
#include "z_dsp.h"

#include "clients/rt/HPSSClient.hpp"

//Client class

//Data container
using fluid::FluidTensorView;

//using audio_client = BaseSTFTClient<double, double>;
//using audio_signal_wrapper = audio_client::AudioSignal;
//using scalar_signal_wrapper = audio_client::ScalarSignal;
//using signal_wrapper = audio_client::Signal<double>;

namespace fluid {
  namespace hpss {
    class HPSS_RT: public MaxClass_Base
    {
      using audio_client = HPSSClient<double, double>;
      using audio_signal_wrapper = audio_client::AudioSignal;
      using scalar_signal_wrapper = audio_client::ScalarSignal;
      using signal_wrapper = audio_client::Signal<double>;
      
      
      using SignalPointer = std::unique_ptr<signal_wrapper>;
    public:
      static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
      {
//        addMethod<NMFMax,&NMFMax::decompose>(c, "process");
//        makeAttributes<nmf::NMFClient,NMFMax>(c);
        dspInit(c);
        addMethod<HPSS_RT,&HPSS_RT::dsp>(c);
      }
      
      HPSS_RT(t_symbol *s, long argc, t_atom *argv)
      {
        pSize =       argc > 0 ? atom_getlong(argv) : 3;
        hSize =       argc > 1 ? atom_getlong(argv + 1): 3;
        window_size = argc > 2 ? atom_getlong(argv + 2) : 1024;
//        hop_size   =  argc > 3 ? atom_getlong(argv + 3) : -1;
//        fft_size   =  argc > 4 ? atom_getlong(argv + 4) : -1;
        dspSetup(1);
        outlet_new(*this, "signal");
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
        fluid_obj = new HPSSClient<double,double>(65536);
        inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrapper[1] = SignalPointer(new audio_signal_wrapper());
        fluid_obj->getParams()[0].setLong(pSize);
        fluid_obj->getParams()[1].setLong(hSize);
        fluid_obj->getParams()[2].setLong(window_size);
//        fluid_obj->getParams()[3].setLong(hop_size);
//        fluid_obj->getParams()[4].setLong(fft_size);
        
        
        bool isOK;
        std::string feedback;
        
        std::tie(isOK, feedback) = fluid_obj->sanityCheck();
        if(!isOK)
        {
          object_error(*this,feedback.c_str());
          return;
        }
        
        
        //TODO: I imagine some algorithms will need the sample rate in future as well
        fluid_obj->set_host_buffer_size(maxvectorsize);
        fluid_obj->reset();
        addPerform<HPSS_RT, &HPSS_RT::perform>(dsp64);
      }
      
      void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
      {
        inputWrapper[0]->set(ins[0], 0);
        outputWrapper[0]->set(outs[0],0);
        outputWrapper[1]->set(outs[1],0);
        fluid_obj->do_process(inputWrapper.begin(),inputWrapper.end(), outputWrapper.begin(), outputWrapper.end(), sampleframes,1,2);
      }
      
    private:
      audio_client* fluid_obj;
//      signal_wrapper* input_wrappers[1];
//      signal_wrapper* output_wrappers[1];
      std::array<SignalPointer,1> inputWrapper;
      std::array<SignalPointer,2> outputWrapper;
      
      size_t pSize;
      size_t hSize;
      size_t window_size;
      size_t hop_size;
      size_t fft_size;
    };
  }
}

void ext_main(void *r)
{
  fluid::hpss::HPSS_RT::makeClass<fluid::hpss::HPSS_RT>(CLASS_BOX, "fluid.hpss~");
}
