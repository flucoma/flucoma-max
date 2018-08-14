//
//  fluid_nmf_tilde_util.h
//  fluid.nmf~
//
//  Created by Owen Green on 02/07/2018.
//

#ifndef fluid_nmf_tilde_util_h
#define fluid_nmf_tilde_util_h

#include "ext.h"
#include "ext_buffer.h"
#include "FluidTensor.hpp"
#include <string>
#include <vector>
namespace fluid{
    namespace nmf{
        
        using real_matrix = fluid::FluidTensor<double,2>; 
        
        struct error_strings
        {
            static constexpr const char* rank_below_one = "Rank < 1 makes no sense";
            static constexpr const char* no_input_buffer_symbol = "Could not extract symbol from input buffer name";
            static constexpr const char* no_out_polybuf_symbol = "Could not extract symbol from output polybuffer name";
            
            static constexpr const char* sources_args = "At least three arguments required: NMF rank, input buffer, and output polybuffer.";
            
            static constexpr const char* filters_args = "At least four arguments required: NMF rank, input buffer, output dictionary polybuffer, and output activations polybuffer.";
            
            static constexpr const char* no_filter_polybuf_symbol = "Could not extract symbol from filters polybuffer name";
            static constexpr const char* no_env_polybuf_symbol = "Could not extract symbol from envelopes polybuffer name"; 
            static constexpr const char* get_buffer_fail = "Could not get buffer for name %s";
            
        private:
            error_strings(){}
        };
        
        

        
        
//        /*****************
//         A template function to reduce duplication in copying back to Max buffers
//         My hope is to render this either obsolete or much simpler once algo code
//         is refactored.
//         At present it needs to be fed a vector of vectors (ugh) and a function that
//         does the copying (see under)
//        *******************/
//        template<typename F>
//        void copy_to_buffer(t_object* obj, int rank, t_symbol* polybuf_name,real_matrix &mtrx,F&& copy_fn, double scale=1.)
//        {
//            for(int i = 0; i < rank; i++)
//            {
//                std::ostringstream ss;
//                ss << polybuf_name->s_name << "." << i+1;
//                const char* buffername = ss.str().c_str();
//                
//                t_buffer_ref* ref = buffer_ref_new(obj, gensym(buffername));
//                t_buffer_obj* this_buffer = buffer_ref_getobject(ref);
//                
//                if(this_buffer)
//                {
//                    float* samps = buffer_locksamples(this_buffer);
//                    if(samps)
//                    {
//                        copy_fn(samps,mtrx,i,scale);
//                        buffer_unlocksamples(this_buffer);
//                    }
//                }
//                
//                if(ref)
//                    object_free(ref);
//                
//            }
//        }
//        
//        void from_cols(float* dst, real_matrix &m, long i,double scale)
//        {
//            for(long j = 0; j< m[0].size(); j++)
//                dst[j] =  m[i][j] * scale;
//        }
//        
//        void from_rows(float* dst,real_matrix &m, long i,double scale)
//        {
//            for(long j = 0; j < m.size(); j++)
//                dst[j] = m[j][i] * scale;
//        }
    }
}
#endif /* fluid_nmf_tilde_util_h */
