//
///**
// @file
// fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio with gain applied
// */
//
//Main client code:

#include <clients/rt/GainClient.hpp>

#include "FluidMaxWrapper.hpp"

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<GainClient>("fluid.gain~");
}
