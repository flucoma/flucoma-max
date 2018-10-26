/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/
#include "clients/rt/TransientClient.hpp"


#include "MaxNonRealTimeBase.hpp"
#include "ext_obex.h"
#include "z_dsp.h"


namespace fluid {
  namespace stn {
    class Transients_RT: public max::MaxNonRealTimeBase
    {
      using audio_client = TransientsClient<double, double>;
      using audio_signal_wrapper = audio_client::AudioSignal;
      using scalar_signal_wrapper = audio_client::ScalarSignal;
      using signal_wrapper = audio_client::Signal<double>;
      using SignalPointer = std::unique_ptr<signal_wrapper>;
    public:
      static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
      {
        makeAttributes<audio_client,Transients_RT>(c);
        dspInit(c);
        addMethod<Transients_RT,&Transients_RT::dsp>(c);
      }
      
      Transients_RT(t_symbol *s, long argc, t_atom *argv):
      fluid_obj(65536)
      {
        size_t offset = attr_args_offset(argc, argv);
        
        for(size_t i = 0,paramIdx = 0; i < offset; ++i)
        {
          switch(atom_gettype(argv+i))
          {
            case A_FLOAT:
            case A_LONG:
            {
              while((getParams()[paramIdx].getDescriptor().getType() != parameter::Type::kLong
                    && getParams()[paramIdx].getDescriptor().getType() != parameter::Type::kFloat)
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  throw std::invalid_argument("");;
                }
              }
              parameter::Instance& p = getParams()[paramIdx++];
              
              if(p.getDescriptor().getType() == parameter::Type::kLong)
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
              while(getParams()[paramIdx].getDescriptor().getType() != parameter::Type::kBuffer
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  throw std::invalid_argument("");;
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
        outputWrapper[1] = SignalPointer(new audio_signal_wrapper());
       
        for(auto&& p:getParams())
          if(p.getDescriptor().getType() == parameter::Type::kBuffer && p.getBuffer())
            (static_cast<max::MaxBufferAdaptor*>(p.getBuffer()))->update();
        
        bool isOK;
        std::string feedback;
        
        std::tie(isOK, feedback) = fluid_obj.sanityCheck();
        if(!isOK)
        {
          object_error(*this,feedback.c_str());
          return;
        }
        
        //TODO: I imagine some algorithms will need the sample rate in future as well
        fluid_obj.setHostBufferSize(maxvectorsize);
        fluid_obj.reset();
        addPerform<Transients_RT, &Transients_RT::perform>(dsp64);
      }
      
      void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
      {
        inputWrapper[0]->set(ins[0], 0);
        outputWrapper[0]->set(outs[0],0);
        outputWrapper[1]->set(outs[1],0);
        fluid_obj.doProcess(inputWrapper.begin(),inputWrapper.end(), outputWrapper.begin(), outputWrapper.end(), sampleframes,1,2);
      }
      
      std::vector<parameter::Instance>& getParams()
      {
        return fluid_obj.getParams();
      }
    private:
      audio_client fluid_obj;
      std::array<SignalPointer,1> inputWrapper;
      std::array<SignalPointer,2> outputWrapper;
    };
  }
}

void ext_main(void *r)
{
  fluid::stn::Transients_RT::makeClass<fluid::stn::Transients_RT>(CLASS_BOX, "fluid.transients~");
}
