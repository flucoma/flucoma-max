#include <clients/rt/SinesClient.hpp>

#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74

void ext_main(void*)
{
  using namespace fluid::client;

  makeMaxWrapper<NRTThreadedSinesClient>("fluid.bufsines~");
}
