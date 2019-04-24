#include <clients/rt/MFCCClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<MFCCClient>("fluid.bufmfcc~");
}
