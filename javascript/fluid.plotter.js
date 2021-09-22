autowatch = 1;
mgraphics.init();
mgraphics.relative_coords = 1;
mgraphics.autofill = 0;

outlets = 2;

setoutletassist(0, 'id of point closest to mouse');
setoutletassist(1, 'raw normalised coordinates');

// Colors - These are taken directly from d3.js
// https://github.com/d3/d3-scale-chromatic
var colors = {
	cat : "1f77b4ff7f0e2ca02cd627289467bd8c564be377c27f7f7fbcbd2217becf",
	accent : "7fc97fbeaed4fdc086ffff99386cb0f0027fbf5b17666666",
	dark : "1b9e77d95f027570b3e7298a66a61ee6ab02a6761d666666",
	paired : "a6cee31f78b4b2df8a33a02cfb9a99e31a1cfdbf6fff7f00cab2d66a3d9affff99b15928",
	scheme : "e41a1c377eb84daf4a984ea3ff7f00ffff33a65628f781bf999999",
	tableau : "4e79a7f28e2ce1575976b7b259a14fedc949af7aa1ff9da79c755fbab0ab"
}

// Point Management
var points = new Array();
var _pointsize = 0.25;

// Internal State for Mousing
var w = [0,0,0];
var vx = 0;
var vy = 0;
var _bgcolor = [1.0, 1.0, 1.0, 1.0];
var _shape = 'square'
var _closest = null;
var _colorscheme = colors.cat;
var _highlight = [];
var _xrange = [0, 1];
var _yrange = [0, 1];
var labels = new Array();
var labelDict = null;
var dataDict = null;
var colorMap = {};


function hexToRGB(hex, a) {
	// Converts HEX values to an array of rgba values
	var a = a || 1.0;
    var r = parseInt(hex.slice(1, 3), 16) / 256.0,
        g = parseInt(hex.slice(3, 5), 16) / 256.0,
        b = parseInt(hex.slice(5, 7), 16) / 256.0;
	return [r, g, b, a];
}

function strChunk(str, size) {
	const numChunks = Math.ceil(str.length / size)
	const chunks = new Array(numChunks)
  
	for (var i=0, o=0; i < numChunks; ++i, o += size) {
	  chunks[i] = str.substr(o, size)
	}
  
	return chunks
}

function scale(v, iMin, iMax, oMin, oMax) {
	return ((v - iMin) / (iMax - iMin)) * (oMax - oMin) + oMin
}

function paint() {
	
	mgraphics.set_source_rgba(_bgcolor);
	mgraphics.rectangle(-1, 1, 2, 2);
	mgraphics.fill();

	points.forEach(function(point) {
		var color;
		if (labelDict) {
			var label = labelDict.get('data').get(point.id);
			color = colorMap[label] || [0,0,0,0.65]
		} 
		else {
			color = [0,0,0,0.65]
		}
		mgraphics.set_source_rgba(color);

		var highlightScale = _highlight.indexOf(point.id) != -1 ? 2.3 : 1.0
		var psize = (_pointsize * point.size) * highlightScale;

		var x = scale(point.x, _xrange[0], _xrange[1], -1, 1)
		var y = scale(point.y, _yrange[0], _yrange[1], -1, 1)

		if (_shape == 'square') {
			mgraphics.rectangle(x, y, psize, psize)
		}
		else {
			mgraphics.ellipse(x, y, psize, psize)
		}
		mgraphics.fill();	
	})
}

function calcAspect() {
    var width = this.box.rect[2] - this.box.rect[0];
    var height = this.box.rect[3] - this.box.rect[1];
	post(width, height)
    return width /height;
}

function setdict(name) {
	points = new Array();
	dataDict = new Dict(name)
	var fail = false;
	// Check that it is a valid dictionary from flucoma.
	if (!dataDict.contains('data') || !dataDict.contains('cols')) {
		error('Please provide a valid dictionary of data from a fluid.dataset~', '\n')
		fail = true;
	}
	if (dataDict.get('cols') != 2) {
		error('fluid.dataset~ should be exactly two dimensions.', '\n')
		fail = true;
	}
	if (!fail) {
		var keys = dataDict.get('data').getkeys();
		var data = dataDict.get('data')
		keys.forEach(function(key) {
			points.push({
				id: key,
				x : data.get(key)[0],
				y : data.get(key)[1],
				color : [0, 0, 0, 1],
				size : 0.1
			})
		})
		mgraphics.redraw();
	}
}

function setcategories(name) {
	labels = new Array();
	labelDict = new Dict(name);
	// Check that it is a valid dictionary from flucoma.
	if (!labelDict.contains('data') || !labelDict.contains('cols'))
		error('Please provide a valid dictionary of labels from a fluid.labelset~')
	if (labelDict.get('cols') != 1)
		error('There should only be one column of data which is a label.')

	constructColorScheme()
}

function colorscheme(scheme) {

	if (colors[scheme]) {
		_colorscheme = colors[scheme]
	}
	constructColorScheme();
}

function xrange(min, max) {
	_xrange = [min, max];
	mgraphics.redraw();
}

function yrange(min, max) {
	_yrange = [min, max];
	mgraphics.redraw();
}

function range(min, max) {
	_yrange = [min, max];
	_xrange = [min, max];
	mgraphics.redraw();
}

function constructColorScheme() {
	if (labelDict) {
		var data = labelDict.get('data');
		var keys = data.getkeys();
		var uniques = new Array();

		// How many unique labels are there?
		keys.forEach(function(key) {
			var label = data.get(key);
			if (uniques.indexOf(label) == -1) {
				uniques.push(label)
			}
		})
		
		colorMap = {};
		var scheme = strChunk(_colorscheme, 6);
		uniques.forEach(function(u, i) {
			if (i < scheme.length) {
				colorMap[u] = hexToRGB(scheme[i], 0.8); // wrap around the colour scheme over and over
			} 
			else {
				colorMap[u] = [ Math.random(), Math.random(), Math.random(), 0.9 ];
			} 
		})
		mgraphics.redraw();
	}
}

function eudist(x1, y1, x2, y2) {
	return Math.pow((x2-x1), 2) + Math.pow((y2-y1), 2)
}

function shape(x) {
	_shape = x;
	mgraphics.redraw();
}

function pointcolor(r, g, b, a) {
	_pointcolor = [r, g, b, a]
	mgraphics.redraw();
}

function bgcolor(r, g, b, a) { 
	_bgcolor = [r, g, b, a];
	mgraphics.redraw();
}

function highlight() {
	_highlight = []; // sanity
	_highlight = arrayfromargs(arguments)
    mgraphics.redraw();
}

function addpoint(id, x, y, size) {
	var size = size || 1.0
	var point = {
		id : id,
		x : x,
		y : y,
		size : 0.1
	}
	points.push(point);
	mgraphics.redraw();
}

function pointsize(v) { 
	_pointsize = v;
    mgraphics.redraw();
};

function clear() { 
	colorMap = {};
	points = new Array();
	labelSet = null;
    mgraphics.redraw();
};

function bang() {
	outlet(0, vx, vy);
    mgraphics.redraw();
}

function onclick(x,y,but,cmd,shift,capslock,option,ctrl) {
	ondrag(x, y)
}
onclick.local = 1; //private. could be left public to permit "synthetic" events

function ondrag(x,y) {
	var width = box.rect[2] - box.rect[0];
	var height = box.rect[3] - box.rect[1];
		
	if (x<0) x = 0;
	else if (x>width) x = width;
	if (y<0) y = 0;
	else if (y>height) y = height;
	
	w = sketch.screentoworld(x,y);

	vx = x / width;
	vy = 1- y/height;
	vx = scale(vx, 0, 1, _xrange[0], _xrange[1]);
	vy = scale(vy, 0, 1, _yrange[0], _yrange[1]);
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
}
onresize.local = 1; //private
