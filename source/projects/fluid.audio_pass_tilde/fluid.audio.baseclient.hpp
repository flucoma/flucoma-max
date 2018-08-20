/***!
 @file fluid::audio::BaseAudioClient
 
 Provides buffering services, and performs simple pass through (i.e. is a concrete class).
 
 Whilst the buffering classes can do overlap and stuff, we're not set up for these here yet.
 
 Override do_proccess in derived classes to implement algorithms
 
 ***/

#pragma once

#include "FluidTensor.hpp"
#include "FluidBuffers.hpp"

namespace fluid {
namespace audio {
    template <typename T>
    class BaseAudioClient
    {
        //Type aliases, mostly for aesthetics
        using source_buffer_type = fluid::FluidSource<T>;
        using sink_buffer_type = fluid::FluidSink<T>;
        using tensor_type = fluid::FluidTensor<T,2>; 
        using view_type = fluid::FluidTensorView<T,2>;
        using const_view_type = const fluid::FluidTensorView<T,2>;
    public:
        //No default construction
        BaseAudioClient()= delete;
        //No copying
        BaseAudioClient(BaseAudioClient&)= delete;
        BaseAudioClient operator=(BaseAudioClient&)= delete;
        //Default destuctor
        virtual ~BaseAudioClient()=default;
        
        /**!
         New instance taking maximum frame size and the number of channels
         
         You *must* set host buffer size and call reset before attemping to use
         **/
        BaseAudioClient(size_t max_frame_size, size_t n_channels_in = 1, size_t n_channels_out = 1):
            m_max_frame_size(max_frame_size),  m_frame(m_max_frame_size,n_channels_in),
            m_source(max_frame_size,n_channels_in), m_sink(max_frame_size, n_channels_out),
            m_channels_in(n_channels_in), m_channels_out(n_channels_out)
        {}
        
        /**
         TODO: This works for Max /PD, but wouldn't for SC. Come up with something SCish
         
         - Pushes a buffer from the host into our source buffer
         - Pulls some frames out from the source and processes them
         - Pushes these to the sink buffer
         – Reads back to host buffer
         
         Don't override this? Maybe? Doesn't seem like a good idea anyway
         
         Do override process() though. That's what it's for
         **/
        template<typename U>
        void do_process(const U * const * input,U** output,size_t nsamps, size_t channels_in, size_t channels_out)
        {
            assert(channels_in == m_channels_in);
            assert(channels_out == m_channels_out);
            
            m_source.push(input,nsamps, channels_in);
            
            //I had imagined we could delegate knowing about the time into the frame
            //to the buffers, but for cases where chunk_size % host_buffer_size !=0
            //we don't call the same number of times each tick
            
            //When we come to worry about overlap, and variable delay times
            // (a) (for overlap) m_max_frame_size size in this look will need to change to take a variable, from somewhere (representing the hop size for this frame _start_)
            // (b) (for varying frame size) the num rows of the view passed in
            // will need to change.
            for(; m_frame_time < m_host_buffer_size; m_frame_time+=m_max_frame_size)
            {
                m_source.pull(m_frame,m_frame_time);
                
                m_sink.push(process(m_frame),m_frame_time);
            }

            m_frame_time = m_frame_time < m_host_buffer_size?
                m_frame_time : m_frame_time - m_host_buffer_size;
            
            m_sink.pull(output,nsamps,channels_out);
        }
        
        /**
         Base procesisng method. A no-op in this case
         **/
        virtual view_type process(view_type x) {return x;}
        
        /**
         Sets the host buffer size. Yes we do need to know this
         
         Call this from host DSP setup
         **/
        void set_host_buffer_size(const size_t size){
            m_host_buffer_size = size;
            m_source.set_host_buffer_size(size);
            m_sink.set_host_buffer_size(size);
        }
        
        /**
         Reset everything. Call this from host dsp setup
         **/
        void reset()
        {
            m_frame_time = 0;
            m_source.reset();
            m_sink.reset();
        }
        
        size_t channelsOut()
        {
            return m_channels_out;
        }
        
        size_t channelsIn()
        {
            return m_channels_in; 
        }
        
    private:
        size_t m_host_buffer_size;
        size_t m_max_frame_size;
        tensor_type m_frame;
        source_buffer_type m_source;
        sink_buffer_type m_sink;
        size_t m_frame_time;
        size_t m_channels_in;
        size_t m_channels_out;
    };
}
}
