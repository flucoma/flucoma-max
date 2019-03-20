
#include <clients/nrt/NMFClient.hpp>
#include <FluidMaxWrapper.hpp>


void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NMFClient>("fluid.bufnmf~");
}


