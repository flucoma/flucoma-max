
// this scales the Amplitude Pitch Timbre descriptors conditionally to an hypothesised comparative range
function anything()
{
  if (jsarguments.length != 5) {
    error("metacompose needs the name of the statsobject and the name of the temporary destination stats buffer");
    return;
  }
  // links to the bufstats and the temp stats buffer
  var bufcp = patcher.getnamed(jsarguments[1]);
  var bufst = patcher.getnamed(jsarguments[2]);
  var tempbuf = new Buffer(jsarguments[3]);
  var statsbuf = new Buffer(jsarguments[4]);
  
  //grab settings
  var args = arrayfromargs(messagename,arguments);
  // post(args);
  
  // link all the buffers into a large buffer of time series
  // make a stack buff with the timeseries
  // finds the size of the stack
  var chancount = 0;
  var framecount = 0;
  for (var i = 0; i < 12; i += 3) {
    if (args[i] != "pass") {
      var inbuf = new Buffer(args[i]);
      framecount = inbuf.framecount();
      chancount += args[i+2];
    }
  }
  // resize the stack
  tempbuf.send("sizeinsamps",framecount , chancount);
  
  // assemble the stack
  chancount = 0;
  for (var i = 0; i < 12; i += 3) {
    if (args[i] != "pass") {
      bufcp.source(args[i]);
      bufcp.startchan(args[i+1]);
      bufcp.numchans(args[i+2]);
      bufcp.deststartchan(chancount);
      bufcp.bang();
      chancount += args[i+2];
    }
  }
  // process the stats
  bufst.low(args[21]);
  bufst.high(args[22]);
  bufst.numderivs(args[23]);
  bufst.bang();
  
  // resize the output buffer
  var outbuf = new Buffer(args[12]);
  outbuf.send("sizeinsamps", args[13]);
  
  //pickup which stats to copy
  var whichstats = args.slice(14,21);

  framecount = 0;
  //for each channel, which is each descriptors
  for (var whichchannel = 1; whichchannel <= statsbuf.channelcount(); whichchannel++) {
    //for each stats
    for (var j = 0; j < 7; j++) {
      // if that stat is to be taken
      if (whichstats[j]) {
        //for each derivative
        for (i = 0; i <= args[23]; i++) {
          // var location = (i*7) + j;
          // post(framecount + ' ' + whichchannel+ ' ' +j + ' ' + i + ' ' + location + '\n');
          outbuf.poke(1, framecount, statsbuf.peek(whichchannel,(i*7) + j,1));
          framecount++;
        }
      }
    }
  }
  // done bang
  outlet(0,"bang");
}
