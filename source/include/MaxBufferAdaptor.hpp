#pragma once

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
      , mSamps(nullptr)
      , mRank(1)
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

  MaxBufferAdaptor(MaxBufferAdaptor &&other) //: MaxBufferView(other.mHostObject, other.mName)
  {
    swap(std::move(other));
  }

  MaxBufferAdaptor &operator=(MaxBufferAdaptor &&other)
  {
    swap(std::move(other));
    return *this;
  }

  t_symbol *const name() { return mName; }

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

  void resize(size_t frames, size_t channels, size_t rank) override
  {
    t_object *buffer = getBuffer();

    if (buffer)
    {
      // Do this in two stages so we can set length in samps rather than ms
      unlockSamps();
      buffer_edit_begin(buffer);

      t_atom args[2];
      atom_setfloat(&args[0], 0.);
      atom_setlong(&args[1], rank * channels);
      t_symbol *setSizeMsg = gensym("setsize");
      auto      res        = object_method_typed(buffer, setSizeMsg, 2, args, nullptr);
      object_method(buffer, gensym("dirty"));
      t_atom newsize;
      atom_setlong(&newsize, frames);
      t_symbol *sampsMsg = gensym("sizeinsamps");
      object_method_typed(buffer, sampsMsg, 1, &newsize, nullptr);

      object_method(buffer, gensym("dirty"));
      buffer_edit_end(buffer, 1);
      lockSamps();
      mRank = rank;
      assert(frames == numFrames() && channels == numChans());
    }
  }

  bool acquire() override
  {
    bool lock = tryLock();
      
    if (lock)
    {
      lockSamps();
      return true;
    }
      
    return false;
  }

  void release() override
  {
    unlockSamps();
    releaseLock();
  }

  FluidTensorView<float, 1> samps(size_t channel, size_t rankIdx = 0) override
  {
    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans() * this->mRank};

    return v.col(rankIdx + channel * mRank);
  }

  FluidTensorView<float, 1> samps(size_t offset, size_t nframes, size_t chanoffset) override
  {
    auto s = FluidTensorView<float, 2>(this->mSamps, 0, numFrames(), numChans() * this->mRank);
    return s(Slice(offset, nframes), Slice(chanoffset, 1)).col(0);
  }

  t_max_err notify(t_symbol *s, t_symbol *msg, void *sender, void *data)
  {
    return buffer_ref_notify(mBufref, s, msg, sender, data);
  }

  size_t numFrames() const override { return valid() ? buffer_getframecount(getBuffer()) : 0; }

  size_t numChans() const override { return valid() ? buffer_getchannelcount(getBuffer()) / mRank : 0; }

  size_t rank() const override { return valid() ? mRank : 0; }

private:
    
  void lockSamps()
  {
    t_object *buffer = getBuffer();
    if (buffer) mSamps = buffer_locksamples(buffer);
  }
    
  void unlockSamps()
  {
    if (mSamps)
    {
      buffer_unlocksamples(getBuffer());
      mSamps = nullptr;
    }
  }

  bool tryLock()
  {
    return compareExchange(false, true);
  }
  
  void releaseLock()
  {
    compareExchange(true, false);
  }
    
  bool compareExchange(bool compare, bool exchange)
  {
    return mLock.compare_exchange_strong(compare, exchange);
  }
    
  t_object *getBuffer() const { return buffer_ref_getobject(mBufref); }

  void swap(MaxBufferAdaptor &&other)
  {
    while (!tryLock());
      
    release();
    object_free(mBufref);

    mSamps  = other.mSamps;
    mBufref = other.mBufref;
    mRank   = other.mRank;

    other.mSamps  = nullptr;
    other.mBufref = nullptr;
    releaseLock();
  }

  t_object *mHostObject;
  t_symbol *mName;

  float *       mSamps;
  t_buffer_ref *mBufref;
  size_t        mRank;
  mutable std::atomic<bool> mLock;
};
} // namespace client
} // namespace fluid

