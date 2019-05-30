#include <clients/rt/RTNoveltySlice.hpp>
#include <FluidMaxWrapper.hpp>


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTRTNoveltySlice>("fluid.bufrtnoveltyslice~");
}
