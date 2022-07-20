// threshfinder.js : a process handler to find iteratively the required threshold to optain a given number of slices
// This code was made possible thanks to the FluCoMa project ( http://www.flucoma.org/ ) funded by the European Research Council ( https://erc.europa.eu/ ) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899).::
outlets = 2;

var target=10; // the number of slices it aims to create (change with the setTarget function)
var tolerance=0; // the error tolerated (plus or minus) around the target number of slice
var startThresh = 0.1; // the default threshold to start with (change with the argument to reset)
var prevThresh=0;
var prevVal=0;
var iters=0;
var curThresh;

function reset(v) {
	iters=0;//resets the interation count
	if (!v) {
		startThresh = 0.1;
	} else if (v < 0.000001){
		error("threshfinder: starting threshold has to be between 0.000001 and 0.999999\n");
		return;
	} else if (v > 0.999999) {
		error("threshfinder: starting threshold has to be between 0.000001 and 0.999999\n");
		return;
	} else {
		startThresh = v;
	}
	outlet(1,iters);
	outlet(0,startThresh);//sends the initial thresh out
}

function slice_target(v) {
	if (v<1){
		error("threshfinder: the target number of slices should be positive\n");
		return;
	}
	target = Math.floor(v);
}

function slice_tolerance(v) {
	if (v<0){
		error("threshfinder: the tolerance should be positive\n");
		return;
	}
	tolerance = Math.floor(v);
}

function msg_int(v) {
	var dVal, dThresh, nThresh;
	if (iters > 100) { //if we reach the max number of iterations, stops and tell us so
		outlet(1,"failed");
		return;
	} else if (!iters) { //otherwise if we are in the first iteration (aka no past) just make another pass with a threshold half the size, to get a first pair
		prevVal = v;
		prevThresh = startThresh;
		if (prevVal <  target) {
			curThresh = prevThresh * 0.5;
		} else {
			curThresh = prevThresh * 2;
		}
		iters += 1;
		outlet(1,iters);
		outlet(0,curThresh);
	} else { // for all other passes, we have 2 values
		if (Math.abs(target - v) <= tolerance){ //if we have reached the target within the tolerance then call it a victory
			outlet(1,"done");
			return;
		} else { // otherwise
			// what are the different results with the different thresholds of the last 2 iterations
			dVal = v - prevVal;
			dThresh = curThresh - prevThresh;
			if (dVal != 0)  { // if there is a significan difference, make a line between the 2 and interpolates what would be a line towards the target
				nThresh = Math.max(0.000001,Math.min(0.999999,((dThresh / dVal) * (target - v)) + curThresh));
			} else { //otherwise, changes the threshold further in the same direction, to push for a change
				nThresh = Math.max(0.000001,Math.min(0.999999,dThresh + curThresh));
			}
			//passes the values to the various memories for the next iteration computations
			prevThresh = curThresh;
			curThresh = nThresh;
			prevVal = v;
			iters += 1;
			outlet(1,iters);
			outlet(0,nThresh);
		}
	}
}
