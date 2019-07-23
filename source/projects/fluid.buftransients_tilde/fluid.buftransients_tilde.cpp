
//#include "clients/nrt/TransientNRTClient.hpp

#include <clients/nrt/FluidNRTClientWrapper.hpp>
#include <clients/rt/TransientClient.hpp>

#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74
#include <ext_obex.h>


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedTransients>("fluid.buftransients~");
}


