#ifndef fluid_client_nmf_hpp
#define fluid_client_nmf_hpp

#include "stft.h"
#include "nmf.h"
#include "Eigen/Dense"
#include <vector>

using Eigen::MatrixXd;
using Eigen::MatrixXcd;
using std::vector;

namespace fluid {
    class nmf_client
    {
    public:
        nmf_client(long rank, long iterations, long fft_size, long window_size, long hop_size);
        ~nmf_client();
        void reset();
        bool isReady() const;
        void process(const std::vector<double> &data);
        long get_dictionary_size() const;
        long getActivationLength() const;
        long getNumSources() const;
        long getRank() const;
        void getDictionary(const long idx, std::vector<double> &dict) const;
        void getActivation(const long idx, std::vector<double> &act) const;
        void getSource(const long idx,std::vector<double> &src) const;
    private:
        long m_rank;
        long m_iterations;
        long m_fft_size;
        long m_window_size;
        long m_hop_size;
        bool m_has_processed;
        bool m_has_resynthed;
        nmf::NMFModel m_model;
    };
}




#endif /* fluid_client_nmf_hpp */
