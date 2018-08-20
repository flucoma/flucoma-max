/*!
 @file fluid.audio.gainclient
 
 Simple multi-input client, just does modulation of signal 1 by signal 2, or sclar
 gain change

 */
#ifndef fluid_audio_gainclient_h
#define fluid_audio_gainclient_h

#include "FluidTensor.hpp"
#include "fluid.audio.baseclient.hpp"

namespace fluid {
namespace audio {
    template <typename T>
    class GainAudioClient: public BaseAudioClient<T>
    {
        using tensor_type = fluid::FluidTensor<T,2>;
        using view_type = fluid::FluidTensorView<T,2>;
    public:
        GainAudioClient() = delete;
        GainAudioClient(GainAudioClient&) = delete;
        GainAudioClient operator=(GainAudioClient&) = delete;
        
        GainAudioClient(size_t chunk_size,size_t inputchannels):
        BaseAudioClient<T>(chunk_size,inputchannels,1), output(chunk_size,1) //this has two input channels, one output
        {}
        
        virtual view_type process(view_type data)
        {
            assert(output.rows() == data.rows());
            assert(data.cols() == BaseAudioClient<T>::channelsIn());
            
            //For now, we'll branch on the number of input channels.
            //This feels filthy though, so I intended to come up with
            //something cleverererer that allows us to write process() once,cleanly
            
        
            output = data.col(0);
            
            if(BaseAudioClient<T>::channelsIn() == 2)
            {
                //First row is audio input, 2nd is gain vector
                output.col(0).apply(data.col(1),[](double& x, double g){
                    x *= g;
                });
            }
            else
            {
                output.col(0).apply([&](double& x){
                    x*= m_scalar_gain;
                });
            }
            return output;
        }
        
        void set_gain(const T gain)
        {
            m_scalar_gain = gain; 
        }
        
    private:
        tensor_type output;
            T m_scalar_gain = 1.;
    }; // class
} //namespace audio
} //namespace fluid


#endif /* fluid_audio_gainclient_h */
