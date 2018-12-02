/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include "clients/rt/NMFMatch.hpp"


#include "MaxNonRealTimeBase.hpp"

#include "ext.h"
#include "z_dsp.h"



namespace fluid {
  namespace nmf {
    
    class NMFMatcher: public max::MaxNonRealTimeBase
    {
      
      class InPerform
      {
      public:
        InPerform(t_int32_atomic* state): mState(state)
        { ATOMIC_INCREMENT(mState); }
        
        ~InPerform() {ATOMIC_DECREMENT(mState); }
        
//        operator bool() { return mState; };
        
      private:
        t_int32_atomic* mState;
      };
      
      using audio_client = NMFMatch<double, double>;
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
              while((getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Long
                     && getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Float)
                    || !(getParams()[paramIdx].getDescriptor().instantiation() && !getParams()[paramIdx].getDescriptor().hasDefault()))
              {
                if(++paramIdx >= getParams().size())
                {
                  object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
                  throw std::invalid_argument("");
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
        
        activationAtoms.reset(new t_atom[sizeLimit()]);
        
      }

      
      
      void param_set(t_object *attr, long argc, t_atom *argv, std::vector<parameter::Instance> &params)
      {
         while(inPerform);
        bufferValid = false;
      
        MaxNonRealTimeBase::param_set(attr, argc, argv, params);

        t_symbol* attrname = (t_symbol *)object_method((t_object *)attr, gensym("getname"));
        
        mMaxRank = parameter::lookupParam("maxrank", params).getLong();
        
        
        auto filterBuffer = parameter::lookupParam("filterbuf", params).getBuffer();
       
        
        //validate
        if(hasValidated && (std::string("filterbuf").compare(attrname->s_name)==0))
        {
          long fftsize = parameter::lookupParam("fftsize", params).getLong();
          mMaxRank = parameter::lookupParam("maxrank", params).getLong();

          parameter::BufferAdaptor::Access buf(filterBuffer);
          
          if(buf.numFrames() != (fftsize / 2) + 1)
          {
            object_error(*this, "Filters buffer needs to be FFT Size / 2 + 1 frames");
          }
          
          mRank = std::min<long>(buf.numChans(),mMaxRank);
        }
        while(inPerform);
        bufferValid = true;
      }
      
      void dsp(t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
      {
        hasValidated = false;
//        no audio in left channel? Then no-op
        if(!count[0])
        {
          return;
        }
      
        
        for(auto&& p:getParams())
          if(p.getDescriptor().getType() == parameter::Type::Buffer && p.getBuffer())
            (static_cast<max::MaxBufferAdaptor*>(p.getBuffer()))->update();
        

        mMaxRank = parameter::lookupParam("maxrank", getParams()).getLong();
        auto filterBuffer = parameter::lookupParam("filterbuf", getParams()).getBuffer();
        parameter::BufferAdaptor::Access buf(filterBuffer);
        mRank = std::min<long>(buf.numChans(),mMaxRank);
        
        
        
        inputWrapper[0] = SignalPointer(new audio_signal_wrapper());
        outputWrappers.resize(mMaxRank);
        for(auto&& w:outputWrappers)
          w.reset(new scalar_signal_wrapper());
        
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
        hasValidated = true;
        
        
        
        //TODO: I imagine some algorithms will need the sample rate in future as well
        fluid_obj.set_host_buffer_size(maxvectorsize);
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
        InPerform spinlock(&inPerform);
        
        auto filterBuffer = parameter::lookupParam("filterbuf", getParams()).getBuffer();
        
        if(!(filterBuffer && bufferValid))
          return;
        
        inputWrapper[0]->set(ins[0], 0);
//        outputWrapper[0]->set(outs[0],0);
        fluid_obj.do_process_noOLA(inputWrapper.begin(),inputWrapper.end(),outputWrappers.begin(), outputWrappers.end(), sampleframes,1,mMaxRank);
        
        parameter::BufferAdaptor::Access buf(filterBuffer);
        
        mRank = std::min( mMaxRank, buf.numChans()); 
        
        for(size_t i = 0; i < mRank; ++i)
          atom_setfloat(&activationAtoms[i], outputWrappers[i]->next());

        for(size_t i = mRank; i < mMaxRank ; ++i)
          atom_setfloat(&activationAtoms[i], 0.);

        schedule_delay(*this, (method) &NMFMatcher::toOutletExternal, 0.0, nullptr, mMaxRank, &activationAtoms[0]);
      }
      
      std::vector<parameter::Instance>& getParams()
      {
        return fluid_obj.getParams();
      }
      
    private:
      
      size_t sizeLimit()
      {
         return std::min<size_t>(parameter::lookupParam("maxrank", getParams()).getLong(),32767);
      }
      
      audio_client fluid_obj;
//      signal_wrapper* input_wrappers[1];
      std::array<SignalPointer,1> inputWrapper;
      std::vector<std::unique_ptr<scalar_signal_wrapper>> outputWrappers;
      void* listOutlet;
      std::unique_ptr<t_atom[]> activationAtoms;
      size_t mRank;
      size_t mMaxRank = 0 ;
//      parameter::Instance* filterBuffer;
      bool hasValidated;
      t_int32_atomic inPerform;
      bool bufferValid;
//      std::array<SignalPointer,1> outputWrapper;
//      size_t window_size;
//      size_t hop_size;
//      size_t fft_size;
    };
  }
}

void ext_main(void *r)
{
  fluid::nmf::NMFMatcher::makeClass<fluid::nmf::NMFMatcher>(CLASS_BOX, "fluid.nmfmatch~");
}
