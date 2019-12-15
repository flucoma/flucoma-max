#pragma once
//We get lots of this warning because C74 macros, and can't (AFAICS) do anything else but mute them:
#pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"


#include <clients/common/BufferAdaptor.hpp>
#include <data/FluidTensor.hpp>
#include <ext_buffer.h>
#include <atomic>

namespace fluid {
namespace client {
class MaxBufferAdaptor : public BufferAdaptor
{
public:
  MaxBufferAdaptor(t_object *x, t_symbol *name)
      : mHostObject(x)
      , mName(name)
      , mImmediate(false)
      , mSamps(nullptr)
      , mBufref{buffer_ref_new(mHostObject, mName)}
      , mLock(false)
  {}

  ~MaxBufferAdaptor()
  {
    while (!tryLock());

    release();
    if (mBufref) object_free(mBufref);
  }

  MaxBufferAdaptor(const MaxBufferAdaptor &) = delete;
  MaxBufferAdaptor &operator=(const MaxBufferAdaptor &other) = delete;

  MaxBufferAdaptor(MaxBufferAdaptor &&x) noexcept { *this = std::move(x); }

  MaxBufferAdaptor &operator=(MaxBufferAdaptor &&x) noexcept
  {
    if(this != &x) swap(std::move(x));
    return *this;
  }

  t_symbol* name() const { return mName; }

  bool exists() const override
  {
    // return getBuffer(); <--Doesn't work on 0-size buffers
    return buffer_ref_exists(mBufref);
  }

  bool valid() const override
  {
    return mSamps;
    //      return getBuffer();
  }

  void immediate(bool immediate)
  {
    mImmediate = immediate;
  }
    
  const Result resize(Index frames, Index channels, double newSampleRate) override
  {
    t_object *buffer = getBuffer();
    
    if (buffer)
    {
      if (!mImmediate)
      {
        // Do this in two stages so we can set length in samps rather than ms
        unlockSamps();
        buffer_edit_begin(buffer);
        t_atom args[2];
        atom_setfloat(&args[0], 0.);
        atom_setlong(&args[1], static_cast<t_atom_long>(channels));
        t_symbol *setSizeMsg = gensym("setsize");
        /*auto      res        = */object_method_typed(buffer, setSizeMsg, 2, args, nullptr);
        object_method(buffer, gensym("dirty"));
        t_atom newsize;
        atom_setlong(&newsize, static_cast<t_atom_long>(frames));
        t_symbol *sampsMsg = gensym("sizeinsamps");
        object_method_typed(buffer, sampsMsg, 1, &newsize, nullptr);
        t_atom sr;
        atom_setfloat(&sr, newSampleRate);
        t_symbol *srMsg = gensym("sr");
        object_method_typed(buffer,srMsg,1,&sr,nullptr);
        object_method(buffer, gensym("dirty"));
        buffer_edit_end(buffer, 1);
        lockSamps();
        
        if(frames != numFrames() || channels != numChans() )
          return {Result::Status::kError, "Could not resize"};
        
        assert(frames == numFrames() && channels == numChans());
        
        return {};
      }
      else
      {
        if (channels > numChans())
          return {Result::Status::kError, "Not enough channels in buffer"};
        if (frames > numFrames())
          return {Result::Status::kError, "Not enough space in buffer"};
        
        if (sampleRate() != newSampleRate)
        {
          t_atom sr;
          atom_setfloat(&sr, newSampleRate);
          t_symbol *srMsg = gensym("sr");
          object_method_typed(buffer,srMsg,1,&sr,nullptr);
          object_method(buffer, gensym("dirty"));
        }
        
        return {};
      }
    }
    
    return {Result::Status::kError,"Resize on null buffer"};
  }

  bool acquire() const override
  {
    bool lock = tryLock();

    if (lock)
    {
      lockSamps();
      return true;
    }

    return false;
  }

  void release() const  override
  {
    unlockSamps();
    releaseLock();
  }

  FluidTensorView<float, 1> samps(Index channel) override
  {
    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans()};

    return v.col(channel);
  }

  FluidTensorView<float, 1> samps(Index offset, Index nframes, Index chanoffset) override
  {
    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v(Slice(offset, nframes), Slice(chanoffset, 1)).col(0);
  }
  
  FluidTensorView<const float, 1> samps(Index channel) const override
  {
    FluidTensorView<const float, 2> v{this->mSamps, 0, numFrames(), numChans()};

    return v.col(channel);
  }

  FluidTensorView<const float, 1> samps(Index offset, Index nframes, Index chanoffset) const override
  {
    FluidTensorView<const float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v(Slice(offset, nframes), Slice(chanoffset, 1)).col(0);
  }

  t_max_err notify(t_symbol *s, t_symbol *msg, void *sender, void *data) const
  {
    t_symbol *buffer_name = (t_symbol *)object_method((t_object *)sender, gensym("getname"));
    return buffer_name == mName ? buffer_ref_notify(mBufref, s, msg, sender, data) : MAX_ERR_NONE;
  }

  Index numFrames() const override { return valid() ? static_cast<Index>(buffer_getframecount(getBuffer())) : 0; }

  Index numChans() const override { return valid() ? static_cast<Index>(buffer_getchannelcount(getBuffer())) : 0; }

  double sampleRate() const override { return valid() ? buffer_getsamplerate(getBuffer()) : 0; }

  std::string asString() const override { return mName->s_name; }
  
  void refresh() override
  {
    t_object *buffer = getBuffer();
    if(buffer) object_method(buffer, gensym("dirty"));
  }
  
private:

  void lockSamps() const
  {
    t_object *buffer = getBuffer();
    if (buffer) mSamps = buffer_locksamples(buffer);
  }

  void unlockSamps() const
  {
    if (mSamps)
    {
      buffer_unlocksamples(getBuffer());
      mSamps = nullptr;
    }
  }

  bool tryLock() const
  {
    return compareExchange(false, true);
  }

  void releaseLock() const
  {
    compareExchange(true, false);
  }

  bool compareExchange(bool compare, bool exchange) const
  {
    return mLock.compare_exchange_strong(compare, exchange);
  }

  t_object *getBuffer() const { return buffer_ref_getobject(mBufref); }

  void swap(MaxBufferAdaptor &&other) noexcept
  {

    if(this == &other) return;

    while (!tryLock());

    release();
    object_free(mBufref);

    mHostObject = other.mHostObject;
    mName   = other.mName;
    mSamps  = other.mSamps;
    mBufref = other.mBufref;

    other.mHostObject = nullptr;
    other.mName   = nullptr;
    other.mSamps  = nullptr;
    other.mBufref = nullptr;
    releaseLock();
  }

  t_object *mHostObject;
  t_symbol *mName;

  bool mImmediate;
  mutable float* mSamps;
  t_buffer_ref* mBufref;
  mutable std::atomic<bool> mLock;
};
} // namespace client
} // namespace fluid
