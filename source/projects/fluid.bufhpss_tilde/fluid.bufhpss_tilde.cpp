#include <clients/rt/HPSSClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;

  makeMaxWrapper<NRTHPSS>("fluid.bufhpss~");
}


