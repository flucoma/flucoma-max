#include <clients/rt/TransientSlice.hpp>
#include <FluidMaxWrapper.hpp>


void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<TransientsSlice>("fluid.transientslice~");
}
