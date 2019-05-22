#include <clients/rt/TransientSlice.hpp>
#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedTransientSlice>("fluid.buftransientslice~");
}


