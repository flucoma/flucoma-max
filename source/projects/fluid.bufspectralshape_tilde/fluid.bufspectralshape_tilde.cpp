#include <clients/rt/SpectralShapeClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTSpectralShapeClient>("fluid.bufspectralshape~");
}
