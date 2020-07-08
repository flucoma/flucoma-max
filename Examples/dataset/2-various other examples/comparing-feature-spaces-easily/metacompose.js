if (jsarguments.length != 7) {
  error("metacompose needs the name of the statsobject and the name of the 3 temporary destination stats buffer");
}
// links to the bufstats and the temp stats buffer
var bufcp = patcher.getnamed(jsarguments[1]);
var bufst = patcher.getnamed(jsarguments[2]);
var tempbuf = new Buffer(jsarguments[3]);
var statsbuf1 = new Buffer(jsarguments[4]);
var statsbuf2 = new Buffer(jsarguments[5]);
var statsbuf3 = new Buffer(jsarguments[6]);

// this scales the Amplitude Pitch Timbre descriptors conditionally to an hypothesised comparative range
function anything()
{
  //grab settings
  var args = arrayfromargs(messagename,arguments);
  
  // link all the buffers into a large buffer of time series
  // make a stack buff with the timeseries
  // finds the size of the stack
  var chancount = 0;
  
  if (args[0] != "pass"){ // if loudness
    chancount += (args[1] + 1);
    var inbuf = new Buffer(args[0]);
  } 
  if (args[4] != "pass"){ // if pitch
    chancount += (args[5] + 1);
    var inbuf = new Buffer(args[4]);  
  } 
  if (args[8] != "pass"){ // if mfcc
    chancount += (args[9] + args[10] - 1);
    var inbuf = new Buffer(args[8]);
  } 
  if (args[11] != "pass"){ // if spectralshapes
    var whichshapes = args.slice(12,19);
    chancount += whichshapes.reduce(mySum);
    var inbuf = new Buffer(args[11]);
  }
  
  if (chancount == 0) {
    error("metacompose: no input to the process\n");
    return;
  }
  
  var framecount = inbuf.framecount(); //assumes all buffers have the same number of frames so takes the latest
  // resize the stack
  tempbuf.send("sizeinsamps",framecount , chancount);
  
  // assemble the stack
  chancount = 0;
  
  if (args[0] != "pass"){ // if loudness
    bufcp.source(args[0]);
    bufcp.startchan(0);
    bufcp.numchans(args[1] + 1);
    bufcp.deststartchan(chancount);
    bufcp.bang();
    chancount += (args[1] + 1);
  } 
  if (args[4] != "pass"){ // if pitch
    bufcp.source(args[4]);
    bufcp.startchan(0);
    bufcp.numchans(args[5] + 1);
    bufcp.deststartchan(chancount);
    bufcp.bang();
    chancount += (args[5] + 1);
  } 
  if (args[8] != "pass"){ // if mfcc
    bufcp.source(args[8]);
    bufcp.startchan(1 - args[9]);
    bufcp.numchans(args[9] + args[10] - 1);
    bufcp.deststartchan(chancount);
    bufcp.bang();
    chancount += (args[9] + args[10] - 1);
  } 
  if (args[11] != "pass"){ // if spectralshapes
    bufcp.source(args[11]);
    bufcp.numchans(1); 
    for (var shape = 0; shape < 7; shape++){
      if (whichshapes[shape]) {
        bufcp.startchan(shape);
        bufcp.deststartchan(chancount);
        bufcp.bang();
        chancount += 1;
      }
    }
  }
  // process the stats
  bufst.low(args[27]);
  bufst.high(args[28]);
  bufst.numderivs(args[29]);
  var numStatsFrames = 0;
  if (args[31] != 0) {
    bufst.stats(jsarguments[4]);
    bufst.startframe(args[30]);
    bufst.numframes(args[31]);
    bufst.bang();
    numStatsFrames += 1;
  }
  if (args[33] != 0) {
    bufst.stats(jsarguments[5]);
    bufst.startframe(args[32]);
    bufst.numframes(args[33]);
    bufst.bang();
    numStatsFrames += 1;
  }
  if (args[35] != 0) {
    bufst.stats(jsarguments[6]);
    bufst.startframe(args[34]);
    bufst.numframes(args[35]);
    bufst.bang();
    numStatsFrames += 1;
  }
  
  if (numStatsFrames == 0) {
    error("metacompose: no valid statistics window define\n");
    return;
  }
  
  // resize the output buffer
  //pickup which stats to copy
  var whichstats = args.slice(20,27);
  var outbuf = new Buffer(args[19]);
  outbuf.send("sizeinsamps", (chancount * (args[29] + 1) * whichstats.reduce(mySum) * numStatsFrames));
  
  framecount = 0;
  //for each channel, which is each descriptors
  for (var whichchannel = 1; whichchannel <= (7 * (args[29] + 1)); whichchannel++) {
    // for each stats
    for (var j = 0; j < 7; j++) {
      // if that stat is to be taken
      if (whichstats[j]) {
        //for each derivative
        for (i = 0; i <= args[29]; i++) {
          if (args[31]!= 0) {
            outbuf.poke(1, framecount, statsbuf1.peek(whichchannel,(i*7) + j,1));
            framecount++;
          }
          if (args[33]!= 0) {
            outbuf.poke(1, framecount, statsbuf2.peek(whichchannel,(i*7) + j,1));
            framecount++;
          }
          if (args[35]!= 0) {
            outbuf.poke(1, framecount, statsbuf3.peek(whichchannel,(i*7) + j,1));
            framecount++;
          }
        }
      }
    }
  }
  // done bang
  outlet(0,"bang");
}

private:
function mySum(total, num) {
  return total + num;
}
