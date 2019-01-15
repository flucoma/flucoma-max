//
///**
// @file
// fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio with gain applied
// */
//
//Main client code:
#include "FluidMaxWrapper.hpp"
#include <clients/rt/GainClient.hpp>

void ext_main(void *r)
{
  using namespace fluid::client;
  makeMaxWrapper<GainClient<double>>("fluid.gain~", GainParams);
}
