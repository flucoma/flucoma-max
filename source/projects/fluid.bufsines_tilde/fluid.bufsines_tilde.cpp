#include <clients/rt/SinesClient.hpp>
#include <clients/nrt/FluidNRTClientWrapper.hpp>

#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  
  makeMaxWrapper<NRTThreadedSines>("fluid.bufsines~");
}
