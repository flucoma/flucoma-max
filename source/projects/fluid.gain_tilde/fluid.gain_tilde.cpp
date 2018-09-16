//
///**
// @file
// fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio with gain applied
// */
//
//Main client code:
#include "clients/rt/GainClient.hpp"
//Max SDK
#include "MaxNonRealTimeBase.hpp"
#include "z_dsp.h"

namespace fluid{

namespace max{
  class FluidGainMax: public max::MaxNonRealTimeBase
  {
    using audio_client = audio::GainAudioClient<double, double>;
    using audio_signal_wrapper = audio_client::AudioSignal;
    using scalar_signal_wrapper = audio_client::ScalarSignal;
    using signal_wrapper = audio_client::Signal;
    using SignalPointer = std::unique_ptr<signal_wrapper>;
    
  public:
    static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
    {
      makeAttributes<audio_client,FluidGainMax>(c);
      dspInit(c);
      addMethod<FluidGainMax,&FluidGainMax::dsp>(c);
    }
    
    FluidGainMax(t_symbol *s, long argc, t_atom *argv):fluid_obj(65536)
    {
      size_t offset = attr_args_offset(argc, argv);
      if(offset)
      {
        auto atom_type = atom_gettype(argv);
        if(atom_type == A_LONG || atom_type == A_FLOAT)
        {
          parameter::lookupParam("winsize", getParams()).setLong(atom_getlong(argv));
          parameter::lookupParam("hopsize", getParams()).setLong(atom_getlong(argv));
        }
      }
      
      attr_args_process(*this, argc, argv + offset);
      
      for(auto&& p: getParams())
      {
        object_attr_setdisabled(*this, gensym(p.getDescriptor().getName().c_str()), p.getDescriptor().instantiation());
      }
      
      
      dspSetup(2);
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
      
      //Make new one with appropriate number of channels, pass in STFT params
      
      inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
      inputWrapper[1] = count[1] ? SignalPointer(new audio_signal_wrapper())
                                 : SignalPointer(new scalar_signal_wrapper());
      outputWrapper[0] = SignalPointer(new audio_signal_wrapper());
      
      bool isOK;
      std::string feedback;
      
      std::tie(isOK, feedback) = fluid_obj.sanityCheck();
      if(!isOK)
      {
        object_error(*this,feedback.c_str());
        return;
      }
      
      
      //TODO: I imagine some algorithms will need the sample rate in future as well
      fluid_obj.set_host_buffer_size(maxvectorsize);
      fluid_obj.reset();
      addPerform<FluidGainMax, &FluidGainMax::perform>(dsp64);
    }
    
    void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
    {
      inputWrapper[0]->set(ins[0], 0);
      inputWrapper[1]->set(ins[1], parameter::lookupParam("gain", getParams()).getFloat());
      outputWrapper[0]->set(outs[0],0);
      fluid_obj.do_process(inputWrapper.begin(),inputWrapper.end(), outputWrapper.begin(), outputWrapper.end(), sampleframes,2,1);
    }
    
    std::vector<parameter::Instance>& getParams()
    {
      return fluid_obj.getParams();
    }
    
  private:
    audio_client fluid_obj;
    std::array<SignalPointer,2> inputWrapper;
    std::array<SignalPointer,1> outputWrapper;
  };
}
}

void ext_main(void *r)
{
  fluid::max::FluidGainMax::makeClass<fluid::max::FluidGainMax>(CLASS_BOX, "fluid.gain~");
}
