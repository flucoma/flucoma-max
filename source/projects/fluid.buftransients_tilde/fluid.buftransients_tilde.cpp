
//#include "clients/nrt/TransientNRTClient.hpp

#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <clients/rt/TransientClient.hpp>

#include <FluidMaxWrapper.hpp>
#include <ext_obex.h>


void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTStreamAdaptor<TransientClient<double,float>>>("fluid.buftransients~", TransientParams);
}


