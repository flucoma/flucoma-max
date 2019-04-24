#include <clients/rt/PitchClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTPitchClient>("fluid.bufpitch~");
}
