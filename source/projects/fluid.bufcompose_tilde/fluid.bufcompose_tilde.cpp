#include <clients/nrt/BufferComposeNRT.hpp>
#include <FluidMaxWrapper.hpp>

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedBufferCompose>("fluid.bufcompose~");
}
