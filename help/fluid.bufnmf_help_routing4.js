outlets = 2;
var startFrame = 0;
var numFrames = 450000;
var startChan = 0;
var numChans = 2;
var lastSource = 1;

var srcBuffer = jsarguments[1];
var resynthBuffer = jsarguments[2];

function selection(offset,nFrames,chanOffset,nChans)
{
	startFrame = offset;
	numFrames = nFrames;
	startChan = chanOffset;
	numChans = nChans;
	source();
}

function source(s)
{

	if(s == undefined)
		s = lastSource;
 	else lastSource = s;
	outlet(0,'clear');
	switch(s)
	{
		case 0: //resynth
		{
			outlet(0, 2, 0, 1);
			outlet(0, numChans > 1 ? 3 : 2, 1, 1);
			break;
		}
		case 1: //original
		{
			if(numChans == 0) return;
			outlet(0, startChan, 0,1);
			outlet(0, numChans > 1 ? startChan + 1 : startChan, 1, 1);
		}
	};
}

function component(index, state)
{
	var nChans = new Buffer(resynthBuffer).channelcount();

	switch(nChans)
	{
		case 5:
		{
			outlet(1, index, 0, state);
			outlet(1, index, 1, state);
			break;
		}
		case 10:
		{
			outlet(1, index, 0, state);
			outlet(1, index + 5, 1, state);
		}
	};
}
