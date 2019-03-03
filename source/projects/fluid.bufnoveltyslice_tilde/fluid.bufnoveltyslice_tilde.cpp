#include <clients/nrt/NoveltyClient.hpp>

#include <FluidMaxWrapper.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<NoveltyClient,double,float>("fluid.bufnoveltyslice~", NoveltyParams); 
 
}


