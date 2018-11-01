/**
 @file MaxNonRealTimeBase.hpp
 
 Base classes for non-real time Max wrappers
 **/
#pragma once
#pragma clang system_header
#include "MaxClass_Base.h"
#include "clients/common/FluidParams.hpp"
#include "data/FluidTensor.hpp"

#include "ext_buffer.h"

#include <sstream>

namespace fluid {
namespace max{
  
namespace {
  class MaxBufferRef
  {
  public:
    //    MaxBufferAdaptor(MaxBufferAdaptor&) = delete;
    
    MaxBufferRef(t_object* x, t_symbol* name):mName(name),mHostObject(x) {}
    
    t_symbol* name() const
    {
      return mName;
    }
  protected:
    t_symbol* mName;
    t_object* mHostObject;
  };
  
  class MaxBufferView: public MaxBufferRef
  {
  public:
    using MaxBufferRef::MaxBufferRef;
    
    virtual void acquire() = 0;
    virtual void release() = 0;
    virtual bool valid() const   = 0;
    virtual void resize(size_t frames, size_t channels, size_t rank) = 0;
    virtual t_max_err notify(t_symbol* s, t_symbol* msg, void* sender, void* data) = 0;
    //Return a slice of the buffer
    virtual FluidTensorView<float,1> samps(size_t channel, size_t rankIdx = 1) = 0;
    //Return a view of all the data
//    virtual FluidTensorView<float,2> samps() = 0;
    virtual FluidTensorView<float,1> samps(size_t offset, size_t nframes, size_t chanoffset) = 0;
    
    virtual size_t numFrames() const = 0;
    virtual size_t numChans() const = 0;
    virtual size_t rank() const = 0;
  };
  
  /***
   RAII for buffer's data
   ***/
  class MaxBufferData:  public MaxBufferView
  {
  public:
    MaxBufferData(t_object* x, t_symbol* name) : MaxBufferView(x, name), mSamps(nullptr), mRank(1)
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
    
    MaxBufferData(MaxBufferData&& other) : MaxBufferView(other.mHostObject, other.mName)
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
        assert(frames == numFrames() && channels * rank == numChans()); 
        mRank = rank;
      }
    }
    
    void acquire() override
    {
      if(getBuffer())
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
    
//    //Return a view of all the data
//    FluidTensorView<float,2> samps() override
//    {
//      return {this->mSamps, 0, numFrames(), numChans() * this->mRank};
//    }
    
    FluidTensorView<float,1> samps(size_t offset, size_t nframes, size_t chanoffset) override
    {
      auto s = FluidTensorView<float,2>(this->mSamps, 0, numFrames(), numChans() * this->mRank);
      return s(fluid::slice(offset, nframes), fluid::slice(chanoffset, 1)).col(0);
    }

    t_max_err notify(t_symbol* s, t_symbol* msg, void* sender, void* data) override
    {
      return (mName == s) && valid()? buffer_ref_notify(mBufref, s, msg, sender, data): 0;
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
//    bool equal(MaxBufferRef* rhs) const override
//    {
//      MaxBufferData* x = dynamic_cast<MaxBufferData*>(rhs);
//      if(x && x->mBufref)
//      {
//        return mName == x->mName;
//      }
//      return false;
//    }
    
    t_object *getBuffer() const
    {
      return mBufref && buffer_ref_exists(mBufref) ? buffer_ref_getobject(mBufref) : nullptr;
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
  
//  /***
//   View of polybuffer-buffer
//   ***/
//  class PolyBufferData: public PolyBufferName, public MaxBufferData
//  {
//  public:
//    PolyBufferData(t_object* x, t_symbol* name, size_t idx):
//    PolyBufferName(name,idx),MaxBufferData(x,buffer_name){}
//  };
//
//  class PolyBufferAdaptor: public MaxBufferView
//  {
//  public:
//
//    PolyBufferAdaptor(t_object* hostObject, t_symbol* name) : MaxBufferView(hostObject, name)
//    {
//      //if polybuffer name points towards an extent instance, fill mBufs with its babies
//      if(valid())
//      {
////        t_object* polybuffer = mName->s_thing;
////        mBufs.clear();
//
//
//        for(size_t i = 0;;++i)
//        {
//          mBufs.emplace_back(mHostObject,mName,i);
//          if(!mBufs.back().valid())
//          {
//            mBufs.pop_back();
//            break;
//          }
//        }
//      }
//    }
//
//    void resize(size_t frames, size_t channels, size_t rank) override
//    {
//      release();
//
//      t_object* polybuffer = mName->s_thing;
//      mBufs.clear();
//      //clear polybuff (for now)
//      object_method_typed(polybuffer, gensym("clear"), 0, NULL, NULL);
//      //Add buffers. We want exact sample lengths, so this will take two calls
//      t_atom append_args[2];
//      atom_setfloat(&append_args[0], 1);
//      atom_setlong(&append_args[1], channels);
//
//      mBufs.reserve(rank);
//
//      for(int i = 0; i < rank; ++i)
//      {
//        object_method_typed(polybuffer, gensym("appendempty"), 2, append_args, NULL);
//        mBufs.emplace_back(mHostObject,mName,size_t(i));
//        mBufs.back().resize(frames, channels, 1);
//        assert(mBufs[i].numFrames() == frames && mBufs[i].numChans() == channels);
//      }
//
//      acquire();
//    }
//
//    bool valid() const override
//    {
//      if(mName && mName->s_thing && object_classname_compare(mName->s_thing, gensym("polybuffer")))
//         return true;
//      return false;
//    }
//
//    void acquire() override
//    {
//      for(auto&& b: mBufs)
//      {
//        b.acquire();
//      }
//    }
//
//    void release()override
//    {
//      for(auto&& b: mBufs)
//      {
//        b.release();
//      }
//    }
//
//    FluidTensorView<float,1> samps(size_t channel, size_t rankIdx = 0) override
//    {
//      if(valid() && mBufs.size() > 0)
//      {
//        return mBufs[rankIdx].samps(channel,0); //in polybuffer case, we've already divided by rank
//      }
//      return FluidTensorView<float,1>(nullptr,0,0);
//    }
//
////    //Return a view of all the data
////    FluidTensorView<float,2> samps() override
////    {
////      assert("I don't beleive this should happen");
////      return FluidTensorView<float,2>(nullptr,0,0,0);
////    }
//
//    FluidTensorView<float,1> samps(size_t offset, size_t nframes, size_t chanoffset) override
//    {
//      if(valid() && mBufs.size() > 0 && chanoffset < mBufs.size())
//      {
//        //TODO this isn't ideal
//        return mBufs[chanoffset].samps(offset,nframes,0);
//      }
//      return FluidTensorView<float,1>(nullptr,0,0,0);
//    }
//
//    size_t numFrames() const override
//    {
//      if (valid() && mBufs.size() > 0)
//      {
//        const PolyBufferData& shortestBuffer = *std::min_element(mBufs.begin(),mBufs.end(), [] (const PolyBufferData& lhs, const PolyBufferData& rhs)->bool{
//          return lhs.numFrames() < rhs.numFrames();
//        } );
//
//        return shortestBuffer.numFrames();
//      }
//      return 0;
//    }
//
//
//    t_max_err notify(t_symbol* s, t_symbol* msg, void* sender, void* data) override
//    {
//      if(valid() && mBufs.size() > 0)
//      {
//        for(auto&& b: mBufs)
//          b.notify(s, msg, sender,data);
//      }
//      return 0;
//    }
//
//    size_t numChans() const override
//    {
//      if (valid() && mBufs.size() > 0)
//      {
//        const PolyBufferData& narrowestBuffer = *std::min_element(mBufs.begin(),mBufs.end(), [] (const PolyBufferData& lhs, const PolyBufferData& rhs)->bool{
//          return lhs.numChans() < rhs.numChans();
//        } );
//
//        return narrowestBuffer.numChans() * rank();
//      }
//      return 0;
//    }
//
//    size_t rank() const override
//    {
//      if (valid())
//      {
//        return mBufs.size();
//      }
//      return 0;
//    }
//  protected:
////    bool equal(parameter::BufferAdaptor& rhs) const override
////    {
////      PolyBufferAdaptor* x = dynamic_cast<PolyBufferAdaptor*>(rhs);
////      if(x && x->mName)
////      {
////        return mName == x->mName;
////      }
////      return false;
////    }
//  private:
//    std::vector<PolyBufferData> mBufs;
//  };
} //anonymous namespace
  
  /***
   RAII for a Max buffer reference
   ***/
  class MaxBufferAdaptor: public parameter::BufferAdaptor, public MaxBufferRef
  {
  public:
    //    MaxBufferAdaptor(MaxBufferAdaptor&) = delete;
    
    MaxBufferAdaptor(t_object* x, t_symbol* name): MaxBufferRef(x, name)
    {
      update(); 
    }
    
    void acquire() override
    {
      if(mData)
         mData->acquire();
    }
    
    void update()
    {
//      //Test for buffer
//      t_buffer_ref* buf_ref = buffer_ref_new(mHostObject, mName);
//      if(buf_ref && buffer_ref_exists(buf_ref))
//      {
//        
        std::unique_ptr<MaxBufferView> p(new MaxBufferData(mHostObject,mName));
        mData = std::move(p);
        
//        object_free(buf_ref);
//
//      }
//      //The s_thing of a polybuffer t_symbol* binds to a class called
//      //'polybuffer', not 'polybuffer~', which sits in the CLASS_NOBOX namesapce
//      else if(mName->s_thing && object_classname_compare(mName->s_thing, gensym("polybuffer")))
//      {
//        std::unique_ptr<MaxBufferView> p(new PolyBufferAdaptor(mHostObject,mName));
//        mData = std::move(p);
//      }
    }
    
    
    void release() override
    {
      if(mData)
        mData->release();
    }
    
    void notify(t_symbol* s, t_symbol* msg, void* sender, void* data)
    {
      if(mData)
        mData->notify(s, msg, sender, data);
    }
    
    bool valid() const override
    {
      return mData? mData && mData->valid() : false;
    }
    
    void resize(size_t frames, size_t channels, size_t rank) override
    {
      if(mData)
        mData->resize(frames,channels,rank);
    }
    
    FluidTensorView<float,1> samps(size_t channel, size_t rankIdx = 0) override
    {
      
      return mData ?  mData->samps(channel, rankIdx) : emptyView() ;
    }
    
//    //Return a view of all the data
//    FluidTensorView<float,2> samps() override
//    {
//      return mData? mData->samps() : FluidTensorView<float,2>(emptyView());
//    }
    
    FluidTensorView<float,1> samps(size_t offset, size_t nframes, size_t chanoffset) override
    {
      return  mData ? mData->samps(offset, nframes,chanoffset) : emptyView();
    }
    
    size_t numFrames() const override
    {
      return mData ? mData->numFrames(): 0;
    }
    
    size_t numChans() const override
    {
      return mData? mData->numChans() : 0;
    }
    
    size_t rank() const override
    {
      return mData? mData->rank() : 0;
    }
    
    
    
  private:
    
    static  FluidTensorView<float,1> emptyView()
    {
      static FluidTensorView<float,1> empty {nullptr,0,0};
      return empty;
    }


    
    bool equal(parameter::BufferAdaptor* rhs) const override
    {
      MaxBufferAdaptor* a = dynamic_cast<MaxBufferAdaptor*>(rhs);
      
      return a && mData && (mData->name() == a->name());
    }
    
    std::unique_ptr<MaxBufferView> mData;
    
   
  };
  
  
  class MaxNonRealTimeBase: public MaxClass_Base
  {
    using parameters = std::vector<parameter::Instance>&;
  public:

    template <class T>
    struct Notify{ typedef t_max_err (T::*MethodNotify) (t_symbol*,t_symbol*,void*,void*,parameters); };
    template <class T, parameters (T::*P)()>
    static t_max_err notifyDispatch(T *x, t_symbol *s, t_symbol *msg, void *sender, void *data) {
      return x->notify(s, msg, sender, data,(x->*P)());
    }
    template <class T, parameters (T::*P)()>
    static void addNotify(t_class *c) { class_addmethod(c, (method) notifyDispatch<T, P>, "notify", A_CANT, 0); }
    
    
    
//    template <class T, typename Gimme<T>::MethodGimme F>
//    static void call(T* x, t_symbol* s, long argc, t_atom* argv) { ((x)->*F)(s, argc, argv);};
    
    

    
    t_max_err notify(t_symbol* s, t_symbol* msg, void *sender, void *data,parameters params)
    {
      t_symbol* sender_name = (t_symbol*)object_method((t_object*)sender,gensym("getname"));

      for(auto&& p: params)
      {
        if(p.getDescriptor().getType() == parameter::Type::Buffer)
        {
          auto b = static_cast<MaxBufferAdaptor*>(p.getBuffer());
          if(b)
            b->notify(s, msg, sender, data);
        }
      }
      return 0;
    }
    
    
    
    template <class T, typename Gimme<T>::MethodGimme F>
    void deferMethod(t_symbol* s, long argc, t_atom* av)
    {
      defer(this, (method)MaxClass_Base::call<T,F>, s, argc, av); 
    }
    
    template<typename Wrapper, std::vector<parameter::Instance>&(Wrapper::*F)()>
    static void getterDispatch(Wrapper* x, t_object *attr, long *ac, t_atom **av)
    {
      x->param_get(attr, ac, av,(x->*F)());
    }
    
    template<typename Wrapper, std::vector<parameter::Instance>&(Wrapper::*F)()>
    static void setterDispatch(Wrapper* x, t_object *attr, long ac, t_atom *av)
    {
      x->param_set(attr, ac, av,(x->*F)());
    }
     
    t_max_err param_set(t_object *attr, long argc, t_atom *argv, std::vector<parameter::Instance>& params)
    {
      t_symbol* attrname = (t_symbol *)object_method((t_object *)attr, gensym("getname"));
      
      parameter::Instance& p = parameter::lookupParam(attrname->s_name, params);
      
      switch(p.getDescriptor().getType())
      {
        case parameter::Type::Float:
        {
          p.setFloat(atom_getfloat(argv));
          p.checkRange();
          break;
        }
        case parameter::Type::Long:
        {
          p.setLong(atom_getlong(argv));
          p.checkRange();
          break;
        }
        case parameter::Type::Buffer:
        {
          t_symbol* s = atom_getsym(argv);
          p.setBuffer(new max::MaxBufferAdaptor(*this,s));
          break;
        }
        default:
        {}
      }
      return 0;
    }
    
    
    t_max_err param_get(t_object *attr, long *argc, t_atom **argv,std::vector<parameter::Instance>& params)
    {
      t_symbol* attrname = (t_symbol *)object_method((t_object *)attr, gensym("getname"));
      
      parameter::Instance& p = parameter::lookupParam(attrname->s_name, params);
      
      char alloc;
      //    long size = 0;
      atom_alloc(argc, argv, &alloc);
      
      switch(p.getDescriptor().getType())
      {
        case parameter::Type::Float:
        {
          atom_setfloat(*argv, p.getFloat());
          break;
        }
        case parameter::Type::Long:
        {
          atom_setlong(*argv, p.getLong());
          break;
        }
        case parameter::Type::Buffer:
        {
          if(p.getBuffer())
          {
            max::MaxBufferAdaptor* b = dynamic_cast<max::MaxBufferAdaptor*>(p.getBuffer());
            if(b)
              atom_setsym(*argv, b->name());
          }
          break;
        }
        default:
        {}
      }
      return 0;
    }
    
    
    
    template <typename Client, typename Wrapper>
    static void makeAttributes(t_class* c, bool hideInstantiation = false)
    {
      
      MaxNonRealTimeBase::addNotify<Wrapper, &Wrapper::getParams>(c);
      
      
      for(auto&& d: Client::getParamDescriptors())
      {
        std::cout << d<< '\n';
        //Attributes = parameters
        if(!(d.instantiation() && !d.hasDefault())){
          switch(d.getType())
          {
            case parameter::Type::Float :
            
              CLASS_ATTR_DOUBLE(c, d.getName().c_str(), 0, Wrapper, mDummy);
              break;

            case parameter::Type::Long :
            {
              CLASS_ATTR_LONG(c, d.getName().c_str(), 0, Wrapper, mDummy);
              break;
            }
              
            case parameter::Type::Buffer :
            {
              CLASS_ATTR_SYM(c, d.getName().c_str(), 0, Wrapper, mDummy);
              break;
            }
              
            case parameter::Type::Enum :
            {
//              CLASS_ATTR_ENUM(c, d.getName(), 0, mObject);
              break;
            }
          }
          
          CLASS_ATTR_ACCESSORS(c, d.getName().c_str(), (getterDispatch<Wrapper, &Wrapper::getParams>), (setterDispatch<Wrapper, &Wrapper::getParams>));
          CLASS_ATTR_LABEL(c, d.getName().c_str(), 0, d.getDisplayName().c_str());
          
          if(d.instantiation() && hideInstantiation)
          {
            CLASS_ATTR_INVISIBLE(c,d.getName().c_str(),0);
          }
        }
      }
    }
  private:
    t_object mDummy;
  };
} //namespace max
} //namespace fluid
