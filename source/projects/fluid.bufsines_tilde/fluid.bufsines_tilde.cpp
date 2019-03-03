#include <clients/rt/SinesClient.hpp>
#include <clients/nrt/FluidNRTClientWrapper.hpp>

#include <FluidMaxWrapper.hpp>



void ext_main(void *r)
{
  using namespace fluid::client;
  
  makeMaxWrapper<NRTSines,double, float>("fluid.bufsines~", NRTSineParams);
}
