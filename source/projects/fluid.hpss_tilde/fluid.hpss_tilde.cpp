
#include <clients/rt/HPSSClient.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<HPSSClient, double, double>("fluid.hpss~", HPSSParams);
}
