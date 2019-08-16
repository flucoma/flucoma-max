
#include <clients/nrt/ProviderTest.hpp>
#include <clients/nrt/SubscriberTest.hpp>
#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedProviderTest>("fluid.providertest");
  makeMaxWrapper<NRTThreadedSubscriberTest>("fluid.subscribertest");
}
