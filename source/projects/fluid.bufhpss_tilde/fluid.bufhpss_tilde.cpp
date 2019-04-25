#include <clients/rt/HPSSClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;

  makeMaxWrapper<NRTHPSS>("fluid.bufhpss~");
}


