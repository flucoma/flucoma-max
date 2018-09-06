
/**
 @file MaxNonRealTimeBase.hpp
 
 Base classes for non-real time Max wrappers
 
 **/

#pragma once

#include "MaxClass_Base.h"
#include "clients/common/FluidParams.hpp"
#include "data/FluidTensor.hpp"


#include "ext_buffer.h"

#include <sstream>

namespace fluid {
namespace max{
  /***
   RAII for a Max buffer reference
   ***/
  class MaxBufferAdaptor: public parameter::BufferAdaptor
  {
  public:
//    MaxBufferAdaptor(MaxBufferAdaptor&) = delete; 
    
    MaxBufferAdaptor(t_object* x, t_symbol* name):mName(name),mHostObject(x) {}
    
    t_symbol* getName() const
    {
      return mName;
    }
  protected:
    t_symbol* mName;
    t_object* mHostObject;
  };
  
  /***
   RAII for buffer's data
   ***/
  class MaxBufferData: public MaxBufferAdaptor
  {
  public:
    MaxBufferData(t_object* x, t_symbol* name):
    MaxBufferAdaptor(x,name)
    {
      mBufref = buffer_ref_new(mHostObject, mName);
    }
    
    ~MaxBufferData()
    {
      release();
      if (mBufref)
        object_free(mBufref);
    }
    
    MaxBufferData(const MaxBufferData&) = delete;
    MaxBufferData& operator=(const MaxBufferData& other) = delete;
    
    MaxBufferData(MaxBufferData&& other)
      : MaxBufferAdaptor(other.mHostObject, other.mName)
    {
      swap(std::move(other));
    }
    
    MaxBufferData& operator=(MaxBufferData&& other)
    {
      swap(std::move(other));
      return *this;
    }
    
    bool valid() const override
    {
      return getBuffer();
    }
    
    void resize(size_t frames, size_t channels, size_t rank) override
    {
      t_object *buffer = getBuffer();
      
      if (buffer)
      {
        //Do this in two stages so we can set length in samps rather than ms
        release();
        t_atom args[2];
        atom_setfloat(&args[0], 0.);
        atom_setlong(&args[1], rank * channels);
        t_symbol* setSizeMsg = gensym("setsize");
       
        
        object_method_typed(buffer, setSizeMsg, 2, args, nullptr);
        
        t_atom newsize;
        atom_setlong(&newsize, frames);
        t_symbol* sampsMsg = gensym("sizeinsamps");
        object_method_typed(buffer, sampsMsg, 1, &newsize, nullptr);
        buffer_setdirty(buffer);
        acquire();
        
        mRank = rank;
      }
    }
    
    void acquire() override
    {
      mSamps = buffer_locksamples(getBuffer());
      
    }
    
    void release()override
    {
      if (mSamps)
        buffer_unlocksamples(getBuffer());
    }
    
    FluidTensorView<float,1> samps(size_t channel, size_t rankIdx = 0) override
    {
      FluidTensorView<float,2>  v{this->mSamps,0, numFrames(), numChans() * this->mRank};
      
      return v.col(rankIdx  + channel * mRank);
    }
    
    //Return a view of all the data
    FluidTensorView<float,2> samps() override
    {
      return {this->mSamps, 0, numFrames(), numChans() * this->mRank};
    }
    
    FluidTensorView<float,2> samps(size_t offset, size_t nframes, size_t chanoffset, size_t chans) override
    {
      auto s = samps();
      return s(fluid::slice(offset, nframes), fluid::slice(chanoffset, chans));
    }

    size_t numFrames() const override
    {
      return valid() ? buffer_getframecount(getBuffer()) : 0;
    }
    
    size_t numChans() const override
    {
      return valid() ?  buffer_getchannelcount(getBuffer()) / mRank : 0;
    }
    
    size_t rank() const override
    {
      return valid() ? mRank : 0;
    }
    
  protected:
    bool equal(BufferAdaptor* rhs) const override
    {
      MaxBufferData* x = dynamic_cast<MaxBufferData*>(rhs);
      if(x && x->mBufref)
      {
        return mName == x->mName;
      }
      return false;
    }
    
    t_object *getBuffer() const
    {
      return mBufref ? buffer_ref_getobject(mBufref) : nullptr;
    }
    
    void swap(MaxBufferData&& other)
    {
      mSamps = other.mSamps;
      mBufref = other.mBufref;
      mRank = other.mRank;
      
      other.mSamps = nullptr;
      other.mBufref = nullptr;
    }
    
    float *mSamps;
    t_buffer_ref* mBufref;
    size_t mRank;
  };
  
//  /***
//   Wrap buffer data in a FluidTensorView
//   ***/
//  class MaxBufferView: public MaxBufferData, public FluidTensorView<float, 2>
//  {
//  public:
//    MaxBufferView() = delete;
//    MaxBufferView(MaxBufferView&) = delete;
//    MaxBufferView operator=(MaxBufferView&) = delete;
//
//    MaxBufferView(t_object* x, t_symbol* name):
//    MaxBufferData(x,name),FluidTensorView<float,2>({0,{n_frames,n_chans}},m_samps)
//    {}
//  };
  
  /***
   Construct a polybuffer-buffer name
   ***/
  class PolyBufferName
  {
  public:
//    PolyBufferName()=delete;
//    PolyBufferName(PolyBufferName&)=delete;
//    PolyBufferName operator=(PolyBufferName&)=delete;
    PolyBufferName(t_symbol* name, size_t index)
    {
      std::ostringstream ss;
      ss << name->s_name << "." << index + 1;
      buffer_name = gensym(ss.str().c_str());
    }
    t_symbol* buffer_name;
  };
  
  /***
   View of polybuffer-buffer
   ***/
  class PolyBufferData: public PolyBufferName, public MaxBufferData
  {
  public:
    PolyBufferData(t_object* x, t_symbol* name, size_t idx):
    PolyBufferName(name,idx),MaxBufferData(x,buffer_name){}
  };
  
  class PolyBufferAdaptor: public MaxBufferAdaptor
  {
  public:
    
    PolyBufferAdaptor(t_object* hostObject, t_symbol* name): MaxBufferAdaptor(hostObject, name) {}
    
    void resize(size_t frames, size_t channels, size_t rank) override
    {
      release();
      
      t_object* polybuffer = mName->s_thing;
      mBufs.clear(); 
      //clear polybuff (for now)
      object_method_typed(polybuffer, gensym("clear"), 0, NULL, NULL);
      //Add buffers. We want exact sample lengths, so this will take two calls
      t_atom append_args[2];
      atom_setfloat(&append_args[0], 1);
      atom_setlong(&append_args[1], channels);
      
      mBufs.reserve(rank);
      
      for(int i = 0; i < rank; ++i)
      {
        object_method_typed(polybuffer, gensym("appendempty"), 2, append_args, NULL);
        mBufs.emplace_back(mHostObject,mName,size_t(i));
        mBufs.back().resize(frames, channels, 1);
      }
      
      acquire();
    }
    
    bool valid() const override
    {
      if(mName && mName->s_thing && object_classname_compare(mName->s_thing, gensym("polybuffer")))
         return true;
      return false;
    }

    void acquire() override
    {
      for(auto&& b: mBufs)
      {
        b.acquire();
      }
    }
    
    void release()override
    {
      for(auto&& b: mBufs)
      {
        b.release();
      }
    }
    
    FluidTensorView<float,1> samps(size_t channel, size_t rankIdx = 0) override
    {
      if(valid() && mBufs.size() > 0)
      {
        return mBufs[rankIdx].samps(channel,0); //in polybuffer case, we've already divided by rank
      }
      return FluidTensorView<float,1>(nullptr,0,0);
    }
    
    //Return a view of all the data
    FluidTensorView<float,2> samps() override
    {
      assert("I don't beleive this should happen");
      return FluidTensorView<float,2>(nullptr,0,0,0);
    }
    
    FluidTensorView<float,2> samps(size_t offset, size_t nframes, size_t chanoffset, size_t chans) override
    {
      assert("I don't beleive this should happen");
      return FluidTensorView<float,2>(nullptr,0,0,0);
    }
    
    size_t numFrames() const override
    {
      if (valid() && mBufs.size() > 0)
      {
        return mBufs[0].numFrames();
      }
      return 0;
    }
    
    size_t numChans() const override
    {
      if (valid())
      {
        return this->numChans();
      }
      return 0;
    }
      
    size_t rank() const override
    {
      if (valid())
      {
        return mBufs.size();
      }
      return 0;
    }
  protected:
    bool equal(BufferAdaptor* rhs) const override
    {
      PolyBufferAdaptor* x = dynamic_cast<PolyBufferAdaptor*>(rhs);
      if(x && x->mName)
      {
        return mName == x->mName;
      }
      return false;
    }
  private:
    std::vector<PolyBufferData> mBufs;
  };
  
  
  class MaxNonRealTimeBase: public MaxClass_Base
  {
  public:
   
    template <class T>struct AttrAccessor { typedef t_max_err (T::*MethodAttrAccessor) (t_object *attr, long ac, t_atom *av); };
    
    template <class T> struct AttrGetter { typedef  t_max_err (T::*MethodAttrGetter) (t_object *attr, long *argc, t_atom **argv);};
    
    template <class T, typename AttrAccessor<T>::MethodAttrAccessor F>
    static void call(T *x, t_object *attr, long ac, t_atom *av) {((x)->*F)(attr, ac, av); };
    
    template <class T, typename AttrGetter<T>::MethodAttrGetter F>
    static void call(T *x, t_object *attr, long *ac, t_atom **av) {((x)->*F)(attr, ac, av); };
    
    
    template <class T, typename AttrGetter<T>::MethodAttrGetter GET, typename AttrAccessor<T>::MethodAttrAccessor SET>
    static void attrAccessors(t_class *c, const char *attrname)
    {
      CLASS_ATTR_ACCESSORS(c, attrname, ((method)call<T,GET>), ((method)call<T,SET>));
    }

    template <class T, typename Gimme<T>::MethodGimme F>
    static void call(T* x, t_symbol* s, long argc, t_atom* argv) { ((x)->*F)(s, argc, argv);};
    
    template <class T, typename Gimme<T>::MethodGimme F>
    void deferMethod(t_symbol* s, long argc, t_atom* av)
    {
      defer(this, (method)call<T,F>, s, argc, av); 
    }
    
     
    
//    template<class T, typename Gimme<T>::MethodGimme F>
//    static void Defer(t_symbol* s, short argc, t_atom* av)
//    {
//      defer(T *x, (method)call<T,F>, s, argc, av);
//    }
   
    
    
    
    template <typename T, typename U>
    static void makeAttributes(t_class* c)
    {
      
      
      
      for(auto&& d: T::getParamDescriptors())
      {
        std::cout << d<< '\n';
        //Make attributes out of parameters marked not instantiation only. Hum.
        if(!d.instatiation()){
          switch(d.getType())
          {
            case parameter::Type::Float :
            
              CLASS_ATTR_DOUBLE(c, d.getName().c_str(), 0, U, mDummy);
              break;

            case parameter::Type::Long :
            {
              CLASS_ATTR_LONG(c, d.getName().c_str(), 0, U, mDummy);
              break;
            }
              
            case parameter::Type::Buffer :
            {
              CLASS_ATTR_SYM(c, d.getName().c_str(), 0, U, mDummy);
              break;
            }
              
            case parameter::Type::Enum :
            {
//              CLASS_ATTR_ENUM(c, d.getName(), 0, mObject);
              break;
            }
          }
          std::cerr << d.getName() << '\n'; 
          attrAccessors<U, &U::param_get, &U::param_set>(c, d.getName().c_str());
//          CLASS_ATTR_SAVE(c, d.getName().c_str(), 0);
        }
      }
    }
  private:
    t_object mDummy;
  };
  
  
  
} //namespace max
} //namespace fluid
