autowatch = 1;
mgraphics.init();
mgraphics.relative_coords = 1;
mgraphics.autofill = 0;

sketch.ortho3d();
// Colors
var vbrgb = [1., 1., 1., 1.];
var vfrgb = [0.5,0.5,0.5,1.];
var vrgb2 = [0.7,0.7,0.7,1.];
var red = [1.0, 0.0, 0.0, 1.0];
var green = [0.0, 1.0, 0.0, 1.0];
var black = [0.0, 0.0, 0.0, 1.0];
var white = [1.0, 1.0, 1.0, 1.0];

// Point Management
var points = [];
var pointSize = 2.0;

// Internal State for Mousing
var w = [0,0,0];
var vx = 0;
var vy = 0;
var _bgcolor = [1.0, 1.0, 1.0, 1.0];
var _pointcolor = black;
var _shape = 'square'
var _highlightcolor = red;
var _closest = null;

function paint() {
	
	mgraphics.set_source_rgba(_bgcolor);
	mgraphics.rectangle(-1, 1, 2, 2);
	mgraphics.fill();

	_closest = get_closest(vx, vy);

	for (var i=0; i < points.length; i++) {
		if (points[i].id == _closest) {
			mgraphics.set_source_rgba(_highlightcolor);
		} else {
			mgraphics.set_source_rgba(points[i].color);
		}
		
		if (_shape == 'square')
		{
			mgraphics.rectangle(
				points[i].x*2-1, 
				points[i].y*2-1, 
				pointSize * points[i].size, 
				pointSize * points[i].size
			)
		} 
		else 
		{
			mgraphics.ellipse(
				points[i].x*2-1, 
				points[i].y*2-1, 
				pointSize * points[i].size, 
				pointSize * points[i].size
			)
		}
		mgraphics.fill();
	}
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
	pointSize = v;
    mgraphics.redraw();
};

function clear() { 
	points = [];
    mgraphics.redraw();
};

function bang() {
	outlet(0, _closest);
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

function setvalueof(x,y)
{
	list(x,y);
}

function getvalueof()
{
	var a = new Array(vx,vy);
	
	return a;
}

function setlist(x, y)
{
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

function onclick(x,y,but,cmd,shift,capslock,option,ctrl)
{
	ondrag(x, y)
}
onclick.local = 1; //private. could be left public to permit "synthetic" events

function calcAspect() {
    var width = this.box.rect[2] - this.box.rect[0];
    var height = this.box.rect[3] - this.box.rect[1];
    return width /height;
  }

function ondrag(x,y)
{

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

function forcesize(w,h)
{
	if (w!=h) {
		h = w;
		box.size(w,h);
	}
}
forcesize.local = 1; //private

function onresize(w, h)
{
	forcesize(w, h);
    mgraphics.redraw();
}
onresize.local = 1; //private
