#include <clients/nrt/BufferStats.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedBufferStats>("fluid.bufstats~");
}
