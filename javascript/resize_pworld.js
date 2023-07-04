// create a Task event loop detecting bpatcher resizing
// and adjusting pworld presentatin_rect accordingly
var task = new Task(getBpatcherRect, this);
// buffers for comparison
var prevWidth, prevHeight;
// Minimum and maximum intervals (in ms) for the Task.
// It starts out at minInterval, and gradually slows
// down to maxInterval by multiplying the current
// Task.interval by intervalMult on every step.
// It keeps ticking at this low rate until a new
// resize is detected.
var minInterval = 50;
var maxInterval = 1000;
var intervalMult = 1.1;


// the callback function for the Task
function getBpatcherRect() {
	// get bpatcher width and height
	r = this.patcher.box.rect;
	width = r[2] - r[0];
	height = r[3] - r[1];
	// output list for setting the pworld presentation_rect to width & height
	outlet(0, 0, 0, width, height);
	// slow down Task refresh rate if idle
	adjustInterval(width, height);
	// save width & height for comparison
	prevWidth = width;
	prevHeight = height;
}


// slow down Task interval when idle
function adjustInterval(width, height) {
	if (width == prevWidth || height == prevHeight) {
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