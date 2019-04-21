#include <clients/rt/NMFFilter.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NMFFilter>("fluid.nmffilter~");
}
