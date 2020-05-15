// this scales the Amplitude Pitch Timbre descriptors conditionally to an hypothesised comparative range
function anything()
{
  if (jsarguments.length != 3) {
    error("metacompose needs 2 buffers");
    return;
  }
  var sourceBuf = new Buffer(jsarguments[1]);
  var destBuf = new Buffer(jsarguments[2]);
  
  //grab settings
  var args = arrayfromargs(messagename,arguments);
  // post(args);
  
  var numDer = args.pop();
  var stats = args.slice(1,8);
  
  var numStats = stats.reduce(function(a, b){
    return a + b;
  }, 0);
  
  // post(numDer+'\n');
  // post(stats+'\n');
  // post(numStats+'\n');
  
  //resize dest buf
  destBuf.send("clear");
  destBuf.send("sizeinsamps",numStats * (numDer + 1), sourceBuf.channelcount());
  
  for (whichchannel = 1; whichchannel <= sourceBuf.channelcount();whichchannel++) {
    var whichstat = 0;
    //for each stats
    for (j = 0; j < stats.length; j++) {
      //if that stat is to be taken
      if (stats[j]) {
        //for each derivative
        for (i = 0; i <= numDer; i++) {
          // var location = (i*numStats) + whichstat;
          // post(j + ' ' + i + ' ' + location + '\n');
          destBuf.poke(whichchannel, (i*numStats) + whichstat, sourceBuf.peek(whichchannel,(i*stats.length) + j,1));
        }
        whichstat = whichstat + 1;
      }
    }
  }
  // done bang
  outlet(0,"bang");
}
