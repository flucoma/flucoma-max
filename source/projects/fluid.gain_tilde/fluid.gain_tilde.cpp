//
///**
// @file
// fluid_audio_pass_tilde - very simple fluid msp object that does nothing except pass audio with gain applied
// */
//
//Main client code:

/*
Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
Copyright 2017-2019 University of Huddersfield.
Licensed under the BSD-3 License.
See license.md file in the project root for full license information.
This project has received funding from the European Research Council (ERC)
under the European Union’s Horizon 2020 research and innovation programme
(grant agreement No 725899).
*/

#include <clients/rt/GainClient.hpp>

#include "FluidMaxWrapper.hpp"

void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<GainClient>("fluid.gain~");
}
