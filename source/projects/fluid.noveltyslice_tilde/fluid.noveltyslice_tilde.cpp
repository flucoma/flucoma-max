#include <clients/rt/NoveltySlice.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NoveltySlice>("fluid.noveltyslice~");
}
