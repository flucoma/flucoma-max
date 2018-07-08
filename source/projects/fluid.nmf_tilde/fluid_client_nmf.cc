#include "fluid_client_nmf.h"
#include <Eigen/Dense>

using nmf::NMF;
using stft::STFT;
using stft::Spectrogram;

namespace fluid{
    

    
    nmf_client::nmf_client(long rank,long iterations, long fft_size, long window_size, long hop_size):
    m_rank(rank),m_iterations(iterations), m_fft_size(fft_size), m_window_size(window_size), m_hop_size(hop_size), m_has_processed(false), m_has_resynthed(false)
    {}
    
    nmf_client::~nmf_client(){}
    
    void nmf_client::process(const std::vector<double> &data)
    {
        STFT stft(m_window_size,m_fft_size,m_hop_size);
        Spectrogram spec = stft.process(data);
        NMF nmf(m_rank,m_iterations);
        m_model = nmf.process(spec.magnitude());
    }
    
    long nmf_client::get_dictionary_size() const
    {
        return 0;
    }
    const long getActivationLength();
    void getDictionary(const long idx, std::vector<double> &dict);
    void getActivation(const long idx, std::vector<double> &act);
    
    
}
