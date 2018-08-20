#include "fluid_client_nmf.h"
#include "STFT.hpp"
#include "RatioMask.hpp"

namespace fluid{
namespace nmf{
    using fluid::nmf::NMF;
    using fluid::stft::STFT;
    using fluid::stft::ISTFT;
    using fluid::stft::Spectrogram;
    using fluid::FluidTensor;
    
    
    NMFClient::NMFClient(size_t rank,size_t iterations, size_t fft_size, size_t window_size, size_t hop_size):
    m_rank(rank),m_iterations(iterations), m_fft_size(fft_size), m_window_size(window_size), m_hop_size(hop_size), m_has_processed(false), m_has_resynthed(false)
    {}
        
    
    void NMFClient::process(const FluidTensor<double, 1> &data, bool resynthesise)
    {
        m_audio_buffers.resize(m_rank,data.extent(0));
        
        m_has_processed = false;
        m_has_resynthed = false;
        STFT stft(m_window_size,m_fft_size,m_hop_size);
        Spectrogram spec = stft.process(data);
        FluidTensor<double, 2> mag = spec.getMagnitude();
        NMF nmf(m_rank,m_iterations);
        m_model = nmf.process(spec.getMagnitude());
        m_has_processed = true;
        
        if(resynthesise)
        {
            ratiomask::RatioMask mask(m_model.getMixEstimate(),1);
            ISTFT istft(m_window_size, m_fft_size, m_hop_size);
            for(int i = 0; i < m_rank; ++i)
            {
                RealMatrix estimate = m_model.getEstimate(i);
                Spectrogram result(mask.process(spec.mData, estimate));
                RealVector audio = istft.process(result);
                m_audio_buffers.row(i) = audio;
            }
            m_has_resynthed = true;
        }
    }
    
    size_t NMFClient::dictionary_size() const
    {
        return m_has_processed ? m_model.getW().extent(0) : 0 ;
    }
    size_t NMFClient::activations_length() const{
        return m_has_processed ? m_model.getH().extent(1) : 0;
    }
    size_t NMFClient::num_sources() const
    {
        return m_has_resynthed ? m_audio_buffers.size() : 0;
    }
    
    const FluidTensorView<double, 1> NMFClient::dictionary(const size_t idx) const
    {
        assert(m_has_processed && idx < m_model.W.cols());
        return m_model.getW().col(idx);
    }
    
    const FluidTensorView<double, 1> NMFClient::activation(const size_t idx) const
    {
        assert(m_has_processed && idx < m_model.H.rows());
        return m_model.getH().row(idx);
    }
        
    const FluidTensor<double,2> NMFClient::dictionaries() const
    {
        return m_model.getW();
    }
    const FluidTensor<double,2> NMFClient::activations()const
    {
        return m_model.getH();
    }

    
    
    FluidTensorView<const double, 1> NMFClient::source(const size_t idx) const
    {
        assert(idx < m_audio_buffers.rows() && "Range Error");
        return m_audio_buffers.row(idx);
    }
    
//    source_iterator NMFClient::sources_begin() const
//    {
//        return m_audio_buffers.cbegin();
//    }
//    
//    source_iterator NMFClient::sources_end() const
//    {
//        return m_audio_buffers.cend();
//    }
    
    
}//namespace nmf
}//namespace fluid
