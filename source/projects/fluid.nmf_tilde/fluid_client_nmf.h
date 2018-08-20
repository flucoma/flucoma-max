#pragma once

#include "FluidTensor.hpp"
#include "NMF.hpp"
#include <vector>
#include <iterator>

using fluid::FluidTensor;

namespace fluid {
namespace nmf{
    /**
     Integration class for doing NMF filtering and resynthesis
     **/
    class NMFClient
    {
//        using vec_iterator = std::vector<double>::const_iterator;
//        using source_iterator = std::vector<std::vector<double>>::const_iterator;
        
    public:
        //No, you may not construct an empty instance, or copy this, or move this
        NMFClient() = delete;
        NMFClient(NMFClient&)=delete;
        NMFClient(NMFClient&&)=delete;
        NMFClient operator=(NMFClient&)=delete;
        NMFClient operator=(NMFClient&&)=delete;
        
        /**
        You may constrct one by supplying some senisble numbers here
         rank: NMF rank
         iterations: max nmf iterations
         fft_size: power 2 pls
         **/
        NMFClient(size_t rank, size_t iterations, size_t fft_size, size_t window_size, size_t hop_size);
        ~NMFClient()= default;
        //Not implemented
        //void reset();
        //bool isReady() const;
       
        /***
         Take some data, NMF it
         ***/
        void process(const FluidTensor<double,1> &data, bool resynthesise);
        
        /***
         Report the size of a dictionary, in bins (= fft_size/2)
         ***/
        size_t dictionary_size() const;
        
        /***
         Report the length of an activation, in frames
         ***/
        size_t activations_length() const;
        
        /***
         Report the number of sources (i.e. the rank
         ***/
        size_t num_sources() const;
//        size_t rank() const;
        
        /***
         Retreive the dictionary at the given index
         ***/
        const FluidTensorView<double, 1> dictionary(const size_t idx) const;
        
        /***
         Retreive the activation at the given index
         ***/
        const FluidTensorView<double, 1> activation(const size_t idx) const;
        
        /***
         Retreive the resynthesized source at the given index (so long as resyntheiss has happened, mind
         ***/
         FluidTensorView<const double, 1> source(const size_t idx) const;
        
//        source_iterator sources_begin() const ;
//        source_iterator sources_end()const;
        
        /***
         Get the whole of dictionaries / activations as a 2D structure
         ***/
        const FluidTensor<double,2> dictionaries() const;
        const FluidTensor<double,2> activations() const;
    private:
        size_t m_rank;
        size_t m_iterations;
        size_t m_fft_size;
        size_t m_window_size;
        size_t m_hop_size;
        bool m_has_processed;
        bool m_has_resynthed;
        fluid::nmf::NMFModel m_model;
        FluidTensor<double,2> m_audio_buffers;
    };
} //namespace max
} //namesapce fluid
