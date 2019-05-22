#include <clients/rt/MFCCClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedMFCCClient>("fluid.bufmfcc~");
}
