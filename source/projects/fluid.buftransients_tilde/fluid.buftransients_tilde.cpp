
//#include "clients/nrt/TransientNRTClient.hpp

#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <clients/rt/TransientClient.hpp>

#include <FluidMaxWrapper.hpp>
#include <ext_obex.h>


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTTransients>("fluid.buftransients~");
}


