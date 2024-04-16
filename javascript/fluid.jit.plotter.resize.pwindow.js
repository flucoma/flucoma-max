outlets = 2;
// create a Task event loop detecting bpatcher resizing
// and adjusting pwindow presentatin_rect accordingly
var task = new Task(getBpatcherRect, this);
// buffers for comparison
var prevWidthPatching, prevHeightPatching, prevWidthPresentation, prevHeightPresentation, prevPresentation;
// Minimum and maximum intervals (in ms) for the Task.
// It starts out at minInterval, and gradually slows
// down to maxInterval by multiplying the current
// Task.interval by intervalMult on every step.
// It keeps ticking at this low rate until a new
// resize is detected.
var minInterval = 10;
var maxInterval = 1000;
var intervalMult = 1.1;
// optionally force square aspect ratio (kind of janky)
var forceSquareBpatcher = true;


// the callback function for the Task
function getBpatcherRect() {
	// force square aspect ratio
	if (this.patcher.box != null && forceSquareBpatcher) {
		forceSquareAR();
	}
	// get bpatcher width and height - in patching and presentation
	patchingRect = this.patcher.box.getboxattr("patching_rect"); // [x, y, width, height]
	presentationRect = this.patcher.box.getboxattr("presentation_rect"); // [x, y, width, height]
	// check if we are in presentation mode
	presentation = this.patcher.parentpatcher.getattr("presentation");
	// get width and height
	patchingWidth = patchingRect[2];
	patchingHeight = patchingRect[3];
	presentationWidth = presentationRect[2];
	presentationHeight = presentationRect[3];
	// output list for setting the pworld presentation_rect to width & height
	if (presentation == 1) {
		outlet(0, 0, 0, presentationWidth, presentationHeight);
	} else {
		outlet(0, 0, 0, patchingWidth, patchingHeight);
	}
	// output the parent's window location on 2nd outlet
	outlet(1, this.patcher.parentpatcher.wind.location);
	// slow down Task refresh rate if idle
	adjustInterval(patchingWidth, patchingHeight, presentationWidth, presentationHeight, presentation);
	// save width & height & presentation for comparison
	prevWidthPatching = patchingWidth;
	prevHeightPatching = patchingHeight;
	prevWidthPresentation = presentationWidth;
	prevHeightPresentation = presentationHeight;
	prevPresentation = presentation;
}


function forceSquareAR() {
	// get bpatcher width and height - in patching and presentation
	patchingRect = this.patcher.box.getboxattr("patching_rect"); // [x, y, width, height]
	presentationRect = this.patcher.box.getboxattr("presentation_rect"); // [x, y, width, height]
	// get width and height
	patchingWidth = patchingRect[2];
	patchingHeight = patchingRect[3];
	presentationWidth = presentationRect[2];
	presentationHeight = presentationRect[3];
	// force it in patching
	if (patchingWidth == prevWidthPatching || patchingHeight == prevHeightPatching) {
		longestSide = patchingWidth >= patchingHeight ? patchingWidth : patchingHeight;
		this.patcher.box.setboxattr("patching_rect", [patchingRect[0], patchingRect[1], longestSide, longestSide]);
	}
	// force it in presentation
	if (presentationWidth == prevWidthPresentation || presentationHeight == prevHeightPresentation) {
		longestSide = presentationWidth >= presentationHeight ? presentationWidth : presentationHeight;
		this.patcher.box.setboxattr("presentation_rect", [presentationRect[0], presentationRect[1], longestSide, longestSide]);
	}
}


// slow down Task interval when idle
function adjustInterval(patchingWidth, patchingHeight, presentationWidth, presentationHeight, presentation) {
	if (patchingWidth == prevWidthPatching && patchingHeight == prevHeightPatching && presentationWidth == prevWidthPresentation && presentationHeight == prevHeightPresentation && presentation == prevPresentation) {
		task.interval = Math.min(task.interval * intervalMult, maxInterval);
	} else {
		// reset to fast refresh if width or height changes
		task.interval = minInterval;
	}
}


// start the task loop
function start() {
		// if not in a subpatcher
		if (this.patcher.box == null) {
			return;
		}
		task.cancel();
		task.interval = minInterval;
		task.repeat();
}


// stop the task loop
function stop() {
		task.cancel();
}