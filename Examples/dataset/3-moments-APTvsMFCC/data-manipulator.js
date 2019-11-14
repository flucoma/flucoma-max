// this scales the Amplitude Pitch Timbre descriptors conditionally to an hypothesised comparative range
function bang()
{
  if (jsarguments.length != 5) {
    error("data-manipulator needs 4 buffers");
    return;
  }
  var destBuf = new Buffer(jsarguments[1]);
  var loudBuf = new Buffer(jsarguments[2]);
  var pitchBuf = new Buffer(jsarguments[3]);
  var centroBuf = new Buffer(jsarguments[4]);

  var loudArray = loudBuf.peek(1,0,loudBuf.framecount());
  var pitchArray = pitchBuf.peek(1,0,pitchBuf.framecount());
  var confArray = pitchBuf.peek(2,0,pitchBuf.framecount());
  var centrArray = centroBuf.peek(1,0,centroBuf.framecount());
  var stdDevArray = centroBuf.peek(2,0,centroBuf.framecount());

  for (var i = 0; i < loudArray.length; i++) {
    if (loudArray[i] < -110) { //if silence, give default values
      loudArray[i] = -110; //silence
      pitchArray[i] = 15.486821; //20 Hz in MIDI for fundamental
      centrArray[i] = 69.281526; // central MIDI between 20Hz and 10kHz
    } else {
      loudArray[i] = Math.min(loudArray[i],0);
      if (confArray[i] > 0.5) {
        pitchArray[i] = pitchArray[i];
      } else {
        pitchArray[i] = 15.486821; //20Hz in MIDI if confidence is not good enough
      }
      if (stdDevArray[i] < 6200) {
        centrArray[i] = (Math.log(centrArray[i] / 440.) / 0.057762265046662) + 69.0; //conversion to midi
      } else {
        centrArray[i] = 69.281526; //central MIDI note between 20Hz and 10kHz if the spread is so wide it makes no sense to keep it
      }
    }
  }

  // post(loudArray+"\n");
  // post(pitchArray+"\n");
  // post(centrArray+"\n");
  destBuf.send("samps", loudArray.length, 3)
  destBuf.poke(1,0,loudArray);
  destBuf.poke(2,0,pitchArray);
  destBuf.poke(3,0,centrArray);
  // done bang
  outlet(0,"bang");
}
