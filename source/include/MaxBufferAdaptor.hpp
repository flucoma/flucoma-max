/*
Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
Copyright 2017-2019 University of Huddersfield.
Licensed under the BSD-3 License.
See license.md file in the project root for full license information.
This project has received funding from the European Research Council (ERC)
under the European Union’s Horizon 2020 research and innovation programme
(grant agreement No 725899).
*/

#pragma once
// We get lots of this warning because C74 macros, and can't (AFAICS) do
// anything else but mute them:
#ifdef __clang__
#pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"
#endif

#include <clients/common/BufferAdaptor.hpp>
#include <data/FluidTensor.hpp>
#include <atomic>
#include <ext_buffer.h>
#include <ext_systhread.h>

namespace fluid {
namespace client {
class MaxBufferAdaptor : public BufferAdaptor
{
public:
  MaxBufferAdaptor(t_object* x, t_symbol* name)
      : mHostObject(x), mName(name), mImmediate(false),
        mSamps(nullptr), mBufref{buffer_ref_new(mHostObject, mName)},
        mLock(false)
  {}

  ~MaxBufferAdaptor()
  {
//    while (!tryLock())
//      ;
    lock(); 
    release();
    t_buffer_ref* tmp{nullptr};
    using std::swap;
    swap(tmp,mBufref);
    if (tmp) object_free(tmp);
  }

  MaxBufferAdaptor(const MaxBufferAdaptor&) = delete;
  MaxBufferAdaptor& operator=(const MaxBufferAdaptor& other) = delete;

  MaxBufferAdaptor(MaxBufferAdaptor&& x) noexcept { *this = std::move(x); }

  MaxBufferAdaptor& operator=(MaxBufferAdaptor&& x) noexcept
  {
    if (this != &x) swap(std::move(x));
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

  void immediate(bool immediate) { mImmediate = immediate; }

  const Result resize(index frames, index channels,
                      double newSampleRate) override
  {

    if (frames == numFrames() && channels == numChans()) return {};

    t_object* buffer = getBuffer();

    if (buffer)
    {
      if (systhread_ismainthread() && !mImmediate)
      {
        unlockSamps();
        t_atom args[2];
        atom_setlong(&args[1], static_cast<t_atom_long>(channels));
        atom_setlong(&args[0], static_cast<t_atom_long>(frames));
        t_symbol* sampsMsg = gensym("sizeinsamps");
        object_method_typed(buffer, sampsMsg, 2, args, nullptr);

        t_atom sr;
        atom_setfloat(&sr, newSampleRate);
        t_symbol* srMsg = gensym("sr");
        object_method_typed(buffer, srMsg, 1, &sr, nullptr);
        buffer_setdirty(buffer);
        lockSamps();

        if (frames != numFrames() || channels != numChans())
          return {Result::Status::kError, "Could not resize ", mName->s_name};

        assert(frames == numFrames() && channels == numChans());

        return {};
      }
      else
      {
        if (channels > numChans())
          return {Result::Status::kError,
                  "Can't resize buffers outside main thread. Not enough "
                  "channels in ",
                  mName->s_name,
                  ": has ",
                  numChans(),
                  " need ",
                  channels};
        if (frames > numFrames())
          return {
              Result::Status::kError,
              "Can't resize buffers outside main thread. Not enough frames in ",
              mName->s_name,
              ": has ",
              numFrames(),
              " need ",
              frames};

        if (sampleRate() != newSampleRate)
        {
          t_atom sr;
          atom_setfloat(&sr, newSampleRate);
          t_symbol* srMsg = gensym("sr");
          object_method_typed(buffer, srMsg, 1, &sr, nullptr);
          object_method(buffer, gensym("dirty"));
        }

        return {};
      }
    }

    return {Result::Status::kError, "Resize on null buffer"};
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

  void release() const override
  {
    unlockSamps();
    releaseLock();
  }

  FluidTensorView<float, 2> allFrames() override
  {

    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v.transpose();
  }

  FluidTensorView<const float, 2> allFrames() const override
  {
    FluidTensorView<const float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v.transpose();
  }

  FluidTensorView<float, 1> samps(index channel) override
  {
    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans()};

    return v.col(channel);
  }

  FluidTensorView<float, 1> samps(index offset, index nframes,
                                  index chanoffset) override
  {
    FluidTensorView<float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v(Slice(offset, nframes), Slice(chanoffset, 1)).col(0);
  }

  FluidTensorView<const float, 1> samps(index channel) const override
  {
    FluidTensorView<const float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v.col(channel);
  }

  FluidTensorView<const float, 1> samps(index offset, index nframes,
                                        index chanoffset) const override
  {
    FluidTensorView<const float, 2> v{this->mSamps, 0, numFrames(), numChans()};
    return v(Slice(offset, nframes), Slice(chanoffset, 1)).col(0);
  }

  t_max_err notify(t_symbol* s, t_symbol* msg, void* sender, void* data) const
  {
    t_symbol* buffer_name =
        (t_symbol*) object_method((t_object*) sender, gensym("getname"));
    return buffer_name == mName
               ? buffer_ref_notify(mBufref, s, msg, sender, data)
               : MAX_ERR_NONE;
  }

  index numFrames() const override
  {
    return valid() ? static_cast<index>(buffer_getframecount(getBuffer())) : 0;
  }

  index numChans() const override
  {
    return valid() ? static_cast<index>(buffer_getchannelcount(getBuffer()))
                   : 0;
  }

  double sampleRate() const override
  {
    return valid() ? buffer_getsamplerate(getBuffer()) : 0;
  }

  std::string asString() const override { return mName->s_name; }

  void refresh() override
  {
    t_object* buffer = getBuffer();
    if (buffer) buffer_setdirty(buffer);
  }
  
  void view()
  {
    buffer_view(getBuffer());
  }

private:
  void lockSamps() const
  {
    t_object* buffer = getBuffer();
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

  bool tryLock() const {
//  return compareExchange(false, true);
      return !mLock.load(std::memory_order_relaxed) &&
             !mLock.exchange(true, std::memory_order_acquire);
  }

  void lock() noexcept {
   for(;;) {
      if(!mLock.exchange(true, std::memory_order_acquire)) return;
      while(mLock.load(std::memory_order_relaxed)) {
        // pause?
      }
   }
  
  }

  void releaseLock() const {
     mLock.store(false, std::memory_order_release);
//    compareExchange(true, false);
  }

  bool compareExchange(bool compare, bool exchange) const
  {
    return mLock.compare_exchange_strong(compare, exchange);
  }

  t_object* getBuffer() const { return buffer_ref_getobject(mBufref); }

  void swap(MaxBufferAdaptor&& other) noexcept
  {
    if (this == &other) return;
    lock();
//    while (!tryLock())
//      ;

    release();
    object_free(mBufref);

    mHostObject = other.mHostObject;
    mName = other.mName;
    mSamps = other.mSamps;
    mBufref = other.mBufref;

    other.mHostObject = nullptr;
    other.mName = nullptr;
    other.mSamps = nullptr;
    other.mBufref = nullptr;
    releaseLock();
  }

  t_object*                 mHostObject;
  t_symbol*                 mName;
  bool                      mImmediate;
  mutable float*            mSamps;
  t_buffer_ref*             mBufref;
  mutable std::atomic<bool> mLock;
};
} // namespace client
} // namespace fluid
