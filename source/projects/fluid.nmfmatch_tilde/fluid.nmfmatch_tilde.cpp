/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "clients/rt/NMFMatch.hpp"


#include "MaxNonRealTimeBase.hpp"

#include "ext.h"
#include "z_dsp.h"



namespace fluid {
  namespace wrapper {
    
    class NMFMatcher: public max::MaxNonRealTimeBase
    {
      using audio_client = client::NMFMatch<double, double>;
      using audio_signal_wrapper = audio_client::AudioSignal;
      using scalar_signal_wrapper = audio_client::ScalarSignal;
      using signal_wrapper = audio_client::Signal<double>;
      using SignalPointer = std::unique_ptr<signal_wrapper>;
    public:
      static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
      {
//        addMethod<NMFMax,&NMFMax::decompose>(c, "process");
        makeAttributes<audio_client,NMFMatcher>(c);
        dspInit(c);

        addMethod<NMFMatcher,&NMFMatcher::dsp>(c);
      }
      
      NMFMatcher(t_symbol *s, long argc, t_atom *argv):fluid_obj(65536)
      {
        size_t offset = attr_args_offset(argc, argv);
        
        for(size_t i = 0,paramIdx = 0; i < offset; ++i)
        {
          switch(atom_gettype(argv+i))
          {
            case A_FLOAT:
            case A_LONG:
            {
              while((getParams()[paramIdx].getDescriptor().getType() != client::Type::kLong
                     && getParams()[paramIdx].getDescriptor().getType() != client::Type::kFloat)
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  throw std::invalid_argument("");
                }
              }
              client::Instance& p = getParams()[paramIdx++];
              
              if(p.getDescriptor().getType() == client::Type::kLong)
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
              while(getParams()[paramIdx].getDescriptor().getType() != client::Type::kBuffer
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
        
        listOutlet = listout(*this);
        
      }

      
      void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
      {
//        no audio in left channel? Then no-op
        if(!count[0])
        {
          return;
        }
        
        mRank = client::lookupParam("rank", getParams()).getLong();

        inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrappers.resize(mRank);
        for(auto&& w:outputWrappers)
          w.reset(new scalar_signal_wrapper());
        
        
//        fluid_obj.getParams()[0].setLong(window_size);
//        fluid_obj->getParams()[1].setLong(hop_size);
//        fluid_obj->getParams()[2].setLong(fft_size);
        
        for(auto&& p:getParams())
          if(p.getDescriptor().getType() == client::Type::kBuffer && p.getBuffer())
            (static_cast<max::MaxBufferAdaptor*>(p.getBuffer()))->update();

        
        bool isOK;
        std::string feedback;
        
        
        std::tie(isOK, feedback) = fluid_obj.sanityCheck();
        if(!isOK)
        {
          object_error(*this,feedback.c_str());
          return;
        }
        
        
        activationAtoms.reset(new t_atom[sizeLimit()]);
        
        //TODO: I imagine some algorithms will need the sample rate in future as well
        fluid_obj.setHostBufferSize(maxvectorsize);
        fluid_obj.reset();
        addPerform<NMFMatcher, &NMFMatcher::perform>(dsp64);
      }
      
      void toOutlet(t_symbol *s, short ac, t_atom *av)
      {
        outlet_list(listOutlet, nullptr, sizeLimit(), activationAtoms.get());
      }
      
      static void toOutletExternal(NMFMatcher *x,t_symbol *s, short ac, t_atom *av)
      {
        x->toOutlet(s, ac, av);
      }
      
      void perform(t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
      {
        inputWrapper[0]->set(ins[0], 0);
//        outputWrapper[0]->set(outs[0],0);
        fluid_obj.doProcessNoOla(inputWrapper.begin(),inputWrapper.end(),outputWrappers.begin(), outputWrappers.end(), sampleframes,1,mRank);
        
        
        for(size_t i = 0; i < mRank; ++i)
          atom_setfloat(&activationAtoms[i], outputWrappers[i]->next());
        
        schedule_delay(*this, (method) &NMFMatcher::toOutletExternal, 0.0, nullptr, mRank, &activationAtoms[0]);
      }
    
      
      std::vector<client::Instance>& getParams()
      {
        return fluid_obj.getParams();
      }
      
    private:
      
      size_t sizeLimit()
      {
         return std::min<size_t>(client::lookupParam("rank", getParams()).getLong(),32767);
      }
      
      audio_client fluid_obj;
//      signal_wrapper* input_wrappers[1];
      std::array<SignalPointer,1> inputWrapper;
      std::vector<std::unique_ptr<scalar_signal_wrapper>> outputWrappers;
      void* listOutlet;
      std::unique_ptr<t_atom[]> activationAtoms;
      size_t mRank;
//      std::array<SignalPointer,1> outputWrapper;
//      size_t window_size;
//      size_t hop_size;
//      size_t fft_size;
    };
  }
}

void ext_main(void *r)
{
  fluid::wrapper::NMFMatcher::makeClass<fluid::wrapper::NMFMatcher>(CLASS_BOX, "fluid.nmfmatch~");
}
