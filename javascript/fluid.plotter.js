autowatch = 1;
mgraphics.init();
mgraphics.relative_coords = 1;
mgraphics.autofill = 0;

outlets = 2;

setoutletassist(0, 'id of point closest to mouse');
setoutletassist(1, 'raw normalised coordinates');

// Colors
var vbrgb = [1., 1., 1., 1.];
var vfrgb = [0.5,0.5,0.5,1.];
var vrgb2 = [0.7,0.7,0.7,1.];
var red = [1.0, 0.0, 0.0, 1.0];
var green = [0.0, 1.0, 0.0, 1.0];
var black = [0.0, 0.0, 0.0, 1.0];
var white = [1.0, 1.0, 1.0, 1.0];

// Point Management
var points = new Array();
var _pointsize = 1.0;

// Internal State for Mousing
var w = [0,0,0];
var vx = 0;
var vy = 0;
var _bgcolor = [1.0, 1.0, 1.0, 1.0];
var _pointcolor = black;
var _shape = 'square'
var _highlightcolor = red;
var _closest = null;
var labels = new Array();
var colorMap = {};

function paint() {
	
	mgraphics.set_source_rgba(_bgcolor);
	mgraphics.rectangle(-1, 1, 2, 2);
	mgraphics.fill();

	_closest = get_closest(vx, vy);

	for (var i=0; i < points.length; i++) {
		// if (points[i].id == _closest) {
		// 	mgraphics.set_source_rgba(_highlightcolor);
		// } else {
		// 	mgraphics.set_source_rgba(points[i].color);
		// }
		mgraphics.set_source_rgba([0, 0, 0, 1]);

		var x = points[i].x * 2 - 1
		var y = points[i].y * 2 - 1
		var psize = _pointsize * points[i].size
		// Convert box size into a relative portion of screen
		// Subtract that value from the coordinates
		if (_shape == 'square')
			mgraphics.rectangle(x, y, psize, psize)
		else
			mgraphics.ellipse( x, y, psize, psize)

		mgraphics.fill();
	}
}

function setdict(name){
	points = new Array();
	var d = new Dict(name)

	// Check that it is a valid dictionary from flucoma.
	if (!d.contains('data') || !d.contains('cols'))
		error('Please provide a valid dictionary of data from a fluid.dataset~')
	if (d.get('cols') != 2)
		error('fluid.dataset~ should be exactly two dimensions.')

	var keys = d.get('data').getkeys();
	var data = d.get('data')
	for (var i=0; i < keys.length; i++) {
		var k = keys[i]
		points.push({
			id: k,
			x : data.get(k)[0],
			y : data.get(k)[1],
			color : [0, 0, 0, 1],
			size : 0.1
		})
	}
	mgraphics.redraw();
}

function setcategories(name){
	labels = new Array();
	var d = new Dict(name);
	// Check that it is a valid dictionary from flucoma.
	if (!d.contains('data') || !d.contains('cols'))
		error('Please provide a valid dictionary of labels from a fluid.labelset~')
	if (d.get('cols') != 1)
		error('There should only be one column of data which is a label.')
	
	var data = d.get('data');
	var keys = data.getkeys();
	var uniques = new Array();

	var exists = uniques.indexOf('help');
	// returns -1 if it doesnt exist
	// How many unique labels are there?
	for (var i=0; i < keys.length; i++) {
		var key = keys[i];
		var label = data.get(key);
		if (uniques.indexOf(label) == -1)
			uniques.push(label)
	}	
	
	// Map each label to a cluster
	for (var i=0; i < uniques.length; i++) {
		var u = uniques[i];
		colorMap[u] = 
	}
	// for (var i=0; i < keys.length; i++) {
	// 	var key = keys[i];
	// 	labels.push({ id : data[key] })
	// }	
}

function get_closest(x1, y1) {
	var min = Math.pow(2, 64);
	var minID = null;

	for (var i=0; i<points.length; i++) {
		var x2 = points[i].x;
		var y2 = points[i].y;
		var distance = (
			Math.pow((x2-x1), 2) 
			+ 
			Math.pow((y2-y1), 2)
		)

		if (distance <= min) {
			min = distance;
			points[i].distance = distance;
			minID = points[i].id;
		}
	}
	return minID;
}

function highlightcolor(r, g, b, a) {
	_highlightcolor = [r, g, b, a]
	mgraphics.redraw();
}

function shape(x) {
	_shape = x;
	mgraphics.redraw();
}

function pointcolor(r, g, b, a){
	_pointcolor = [r, g, b, a]
	mgraphics.redraw();
}

function bgcolor(r, g, b, a){ 
	_bgcolor = [r, g, b, a];
	mgraphics.redraw();
}

function highlight(id) {
	for (var i=0; i<points.length; i++) {
		if (id == points[i].id) {
			points[i].color = green
		}
	}
    mgraphics.redraw();
}

function addpoint(id, x, y, size) {
	var size = size || 1.0
	var point = {
		'id': id,
		'x' : x,
		'y' : y,
		'color' : _pointcolor,
		'size' : size * 0.1
	}
	points.push(point);
	mgraphics.redraw();
}

function pointsize(v) { 
	_pointsize = v;
    mgraphics.redraw();
};

function clear() { 
	points = [];
    mgraphics.redraw();
};

function bang() {
	if (_closest) {
		outlet(0, _closest);
	}
	outlet(1, vx, vy);
    mgraphics.redraw();
}

function list()
{
	var width = box.rect[2] - box.rect[0];
	var height = box.rect[3] - box.rect[1];

	if (arguments.length>0)
		vx = arguments[0];
	if (arguments.length>1)
		vy = arguments[1];
		
	if (vx<0) vx = 0;
	else if (vx>1) vx = 1;
	if (vy<0) vy = 0;
	else if (vy>1) vy = 1;
	
	w = sketch.screentoworld(vx*width,(1.-vy)*height);
	notifyclients();
	bang();
}

function set()
{
	if (arguments.length == 1) {
		if (inlet == 0)
			setlist(arguments[0],vy)
		else
			setlist(vx,arguments[0]);
	} else if (arguments.length == 2) {
		setlist(arguments[0], arguments[1]);
	}
}

function setvalueof(x,y) {
	list(x,y);
}

function getvalueof() {
	var a = new Array(vx,vy);
	return a;
}

function setlist(x, y) {
	var width = box.rect[2] - box.rect[0];
	var height = box.rect[3] - box.rect[1];
	
	vx = x;
	vy = y;
	
	if (vx<0) vx = 0;
	else if (vx>1) vx = 1;
	if (vy<0) vy = 0;
	else if (vy>1) vy = 1;
	
	w = sketch.screentoworld(vx*width,(1.-vy)*height);
	notifyclients();
    mgraphics.redraw();
}

function onclick(x,y,but,cmd,shift,capslock,option,ctrl) {
	ondrag(x, y)
}
onclick.local = 1; //private. could be left public to permit "synthetic" events

function calcAspect() {
    var width = this.box.rect[2] - this.box.rect[0];
    var height = this.box.rect[3] - this.box.rect[1];
    return width /height;
  }

function ondrag(x,y) {
	var width = box.rect[2] - box.rect[0];
	var height = box.rect[3] - box.rect[1];
		
	if (x<0) x = 0;
	else if (x>width) x = width;
	if (y<0) y = 0;
	else if (y>height) y = height;
	
	w = sketch.screentoworld(x,y);

	vx = x/width;
	vy = 1- y/height;
	notifyclients();
	bang();
}
ondrag.local = 1; //private. could be left public to permit "synthetic" events

function forcesize(w,h) {
	if (w!=h) {
		h = w;
		box.size(w,h);
	}
}
forcesize.local = 1; //private

function onresize(w, h) {
	forcesize(w, h);
    mgraphics.redraw();
}
onresize.local = 1; //private
