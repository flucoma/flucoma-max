/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "MaxNonRealTimeBase.hpp"

#include "ext.h"
#include "z_dsp.h"

#include "clients/rt/BaseSTFTClient.hpp"

//Client class
using fluid::audio::BaseSTFTClient;
//Data container
using fluid::FluidTensorView;



namespace fluid {
  namespace stft {
    
    class BaseSTFTWrapper: public max::MaxNonRealTimeBase
    {
      using audio_client = BaseSTFTClient<double, double>;
      using audio_signal_wrapper = audio_client::AudioSignal;
      using scalar_signal_wrapper = audio_client::ScalarSignal;
      using signal_wrapper = audio_client::Signal<double>;
      using SignalPointer = std::unique_ptr<signal_wrapper>;
    public:
      static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
      {
//        addMethod<NMFMax,&NMFMax::decompose>(c, "process");
        makeAttributes<audio_client,BaseSTFTWrapper>(c);
        dspInit(c);

        addMethod<BaseSTFTWrapper,&BaseSTFTWrapper::dsp>(c);
      }
      
      BaseSTFTWrapper(t_symbol *s, long argc, t_atom *argv):fluid_obj(65536)
      {
        size_t offset = attr_args_offset(argc, argv);
        
        for(size_t i = 0,paramIdx = 0; i < offset; ++i)
        {
          switch(atom_gettype(argv+i))
          {
            case A_FLOAT:
            case A_LONG:
            {
              while((getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Long
                     && getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Float)
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  return;
                }
              }
              parameter::Instance& p = getParams()[paramIdx++];
              
              if(p.getDescriptor().getType() == parameter::Type::Long)
              {
                p.setLong(atom_getlong(argv + i));
              }
              else
              {
                p.setFloat(atom_getfloat(argv+i));
              }
              break;
            }
            case A_SYM:
            {
              while(getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Buffer
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  return;
                }
              }
              getParams()[paramIdx++].setBuffer(new max::MaxBufferAdaptor(*this, atom_getsym(argv + i)));
              break;
            }
          }
        }
        
        attr_args_process(*this, argc, argv + offset);
        
        for(auto&& p: getParams())
        {
          object_attr_setdisabled(*this, gensym(p.getDescriptor().getName().c_str()), p.getDescriptor().instantiation());
        }
        
        
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

        inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrapper[0] = SignalPointer(new audio_signal_wrapper());
//        fluid_obj.getParams()[0].setLong(window_size);
//        fluid_obj->getParams()[1].setLong(hop_size);
//        fluid_obj->getParams()[2].setLong(fft_size);
        
        
        
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
        addPerform<BaseSTFTWrapper, &BaseSTFTWrapper::perform>(dsp64);
      }
      
      void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
      {
        inputWrapper[0]->set(ins[0], 0);
        outputWrapper[0]->set(outs[0],0);
        fluid_obj.do_process(inputWrapper.begin(),inputWrapper.end(), outputWrapper.begin(), outputWrapper.end(), sampleframes,1,1);
      }
      
      std::vector<parameter::Instance>& getParams()
      {
        return fluid_obj.getParams();
      }
      
    private:
      audio_client fluid_obj;
//      signal_wrapper* input_wrappers[1];
//      signal_wrapper* output_wrappers[1];
      std::array<SignalPointer,1> inputWrapper;
      std::array<SignalPointer,1> outputWrapper;
//      size_t window_size;
//      size_t hop_size;
//      size_t fft_size;
    };
  }
}

void ext_main(void *r)
{
  fluid::stft::BaseSTFTWrapper::makeClass<fluid::stft::BaseSTFTWrapper>(CLASS_BOX, "fluid.stftpass~");
}
