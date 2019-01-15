
//#include "clients/nrt/TransientNRTClient.hpp

#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <clients/rt/TransientClient.hpp>

#include <FluidMaxWrapper.hpp>
#include <ext_obex.h>


void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTClientWrapper<TransientClient<double,float>, decltype(TransientParams), TransientParams>>("fluid.buftransients~", TransientParams);
}


