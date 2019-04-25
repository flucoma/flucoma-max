/*!
 @file fluid.stft_pass_tilde
 
 Pass through STFT Max object
 
**/

#include <clients/rt/BaseSTFTClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<BaseSTFTClient>("fluid.stftpass~");
}
