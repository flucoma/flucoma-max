#include <clients/rt/TransientSlice.hpp>
#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTSliceAdaptor<TransientsSlice<double,float>>>("fluid.buftransientslice~", TransientParams);
}


