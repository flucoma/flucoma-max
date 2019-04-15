#include <clients/rt/SpectralShapeClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTSpectralShapeClient>("fluid.bufspectralshape~");
}
