#include <clients/rt/NMFMatch.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NMFMatch, double, double>("fluid.nmfmatch~", NMFMatchParams);
}
