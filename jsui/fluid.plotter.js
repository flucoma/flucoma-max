autowatch = 1;
mgraphics.init();
mgraphics.relative_coords = 1;
mgraphics.autofill = 0;

var { colors } = require('./fluid.plotter.colors.js')
var { hexToRGB, scale } = require('./fluid.drawingutils.js')

post(scale)

inlets = 2;
outlets = 2;

setinletassist(0, 'Dictionary of Points');
setinletassist(1, 'Dictionary of Labels');
setoutletassist(0, 'Position of mouse in x/y space');

// Constant Values
var defaultPointColor = [0, 0, 0, 0.8];
var pointSizeScaler = 0.075;

// Internal State for Mousing
var w = [0,0,0];
var vx = 0;
var vy = 0;

// Domain and Range
var _xmin = 0.0,
	_xmax = 1.0,
	_ymin = 0.0, 
	_ymax = 1.0,
	_stored_xmin = 0.0, 
	_stored_xmax = 1.0,
	_stored_ymin = 0.0, 
	_stored_ymax = 1.0;

// Points
var points, 
	_pointsizescale,
	_bgcolor,
	_shape,
	_colorscheme,
	_highlight,
	labelDict,
	labelJSON,
	dataDict,
	colorMap,
	pointColors,
	pointSizes;

// Zoom
var clickstart  = { x:0, y:0 };
var clickend = { x:0, y:0 };
var dragging = 0;
var boxarea = [0, 0, 0, 0];

if (jsarguments.length > 1) {
	_pointsizescale = jsarguments[1];
} else {
	_pointsizescale = 1.0;
}

function clear() {
	_bgcolor = [0.95,0.95,0.95,0.95, 1.0];
	_shape = 'circle'
	_colorscheme = colors.default;
	_highlight = [];
	labelDict = null;
	labelJSON = null;
	dataDict = null;
	colorMap = {};
	points = []
	pointColors = {};
	pointSizes = {};
	_pointsizescale = 1.0;
	mgraphics.redraw();
};

function reset() {
	clear()
}

reset()

function paint() {
	// The paint loop
	mgraphics.set_source_rgba(_bgcolor);
	mgraphics.rectangle(-1, 1, 2, 2);
	mgraphics.fill();

	Object.keys(points).forEach(function(pt) {
		var color = defaultPointColor;
		
		// We also check for the labelJSON and assign here because...
		// ... it allows us to separate the state of points assigned manually + automatically
		if (labelJSON) {
			const label = labelJSON[pt];
			if (label !== undefined) {
				color = colorMap[label]
			}
		}
		if (pointColors.hasOwnProperty(pt)) color = pointColors[pt];
		mgraphics.set_source_rgba(color);
		
		const highlightScale = _highlight.indexOf(pt) != -1 ? 2.3 : 1.0;
		const pointSize = pointSizes.hasOwnProperty(pt) ? pointSizes[pt] : 1.0;

		// calculate the point size from the highlight, point scale and points' size
		const psize = ((_pointsizescale * pointSize)  * highlightScale) * pointSizeScaler;

		const point = points[pt];
		const x = scale(point.x, _xmin, _xmax, -1, 1) - (psize*0.5);
		const y = scale(point.y, _ymin, _ymax, -1, 1) + (psize*0.5);

		if (_shape == 'circle')
			mgraphics.ellipse(x, y, psize, psize);
		else
			mgraphics.rectangle(x, y, psize, psize);
			
		mgraphics.fill();
	});

	if (dragging) {
		mgraphics.set_source_rgba(0, 0, 0, 0.15);
		const w = this.box.rect[2] - this.box.rect[0];
		const h = this.box.rect[3] - this.box.rect[1];
		const x1 = clickstart.x / w * 2 - 1
		const y1 = (clickstart.y / h * 2 - 1) * -1;
		const x2 = clickend.x / w * 2 - 1
		const y2 = (clickend.y / h * 2 - 1) * -1;
		
		const width = Math.abs(x2 - x1);
		const height = Math.abs(y2 - y1);
		if (x1 <= x2 && y1 > y2) { // SE
			mgraphics.rectangle(x1, y1, width, height);
			boxarea = [x1, x2, y1, y2];
		} else if (x1 <= x2 && y1 <= y2) { // NE
			mgraphics.rectangle(x1, y2, width, height);
			boxarea = [x1, x2, y2, y1];
		} else if (x1 > x2 && y1 <= y2) { // NW
			mgraphics.rectangle(x2, y2, width, height)
			boxarea = [x2, x1, y2, y1]
		} else if (x1 > x2 && y1 > y2) { // SW
			mgraphics.rectangle(x2, y1, width, height)
			boxarea = [x2, x1, y1, y2]
		}
		mgraphics.fill()
	}
}

function dictionary(name) {
	if (inlet === 0) {
		setdict(name)
	} 
	else if (inlet === 1) {
		setcategories(name)
	}
}

function setdict(name) {
	dataDict = new Dict(name)
	var fail = false;
	// Check that it is a valid dictionary from flucoma.
	if (!dataDict.contains('data') || !dataDict.contains('cols')) {
		error('Please provide a valid dictionary of data from a fluid.dataset~', '\n');
		fail = true;
	}
	if (dataDict.get('cols') != 2) {
		error('fluid.dataset~ should be exactly two dimensions', '\n');
		fail = true;
	}
	if (!fail) {
		points = {};
		var rawData = JSON.parse(dataDict.stringify()).data;
		Object.keys(rawData).forEach(function(pt) { 
			points[pt] = {
				x : rawData[pt][0],
				y : rawData[pt][1],
				size: 0.1
			}
		})
		mgraphics.redraw();
	}
}

function setcategories(name) {
	labels = new Array();
	labelDict = new Dict(name);
	// Check that it is a valid dictionary from flucoma.
	if (!labelDict.contains('data') || !labelDict.contains('cols')) {
		labelDict = null;
		error('Please provide a valid dictionary of labels from a fluid.labelset~', '\n');
	}
	if (labelDict.get('cols') != 1) {
		labelDict = null;
		error('There should only be one column of data which is a label', '\n');
	}

	// Convert the internal representation to a JSON object for speedier referencing.
	labelJSON = JSON.parse(labelDict.stringify()).data;
	constructColorScheme();
}

function constructColorScheme() {
	if (labelDict) {
		var labelDictAsJson = JSON.parse(labelDict.stringify());
		var data = labelDictAsJson.data;
		var keys = Object.keys(data)
		var uniques = []

		// How many unique labels are there?
		keys.forEach(function(key) {
			var label = data[key]
			if (uniques.indexOf(label[0]) == -1) {
				uniques.push(label[0])
			}
		})
		uniques = uniques.removeDuplicates()
		uniques.sort();

		var scheme = _colorscheme
		colorMap = {}
		colorMap = uniques.reduce(function(map, u, i) {
			const color = hexToRGB(scheme[i % scheme.length], 1.0);
			map[u] = color;
			return map;
		}, {});

		// Strip any of the points from the pointColors if they have been assigned here
		keys.forEach(function(pt) {
			if (pointColors.hasOwnProperty(pt)) {
				delete pointColors[pt]
			}
		})
		
		mgraphics.redraw();
	}
}

function colorscheme(scheme) {
	if (colors[scheme]) {
		_colorscheme = colors[scheme]
	}
	constructColorScheme();
}

function pointUpdate(id, x, y) {
	points[id] = {
		x: x,
		y: y
	};
	mgraphics.redraw();
}

function addpoint(id, x, y) {
	if (!points.hasOwnProperty(id))
		pointUpdate(id, x, y);
	else
		error('The identifier:', id, 'already exists', '\n');
}

function setpoint(id, x, y) {
	pointUpdate(id, x, y)
}

function pointcolor(id, r, g, b, a) {
	var r = 0 || r;
	var g = 0 || g;
	var b = 0 || b;
	var a = 1 || a;
	pointColors[id] = [r, g, b, a];
	mgraphics.redraw();
}

function pointsize(id, size) {
	pointSizes[id] = size;
	mgraphics.redraw();
}

function pointsizescale(v) { 
	_pointsizescale = v;
    mgraphics.redraw();
};

function xrange(min, max) {
	// Set the domain on the x axis
	_xmin = min;
	_xmax = max;
	_stored_xmin = _xmin;
	_stored_xmax = _xmax;
	mgraphics.redraw();
}

function yrange(min, max) {
	// Set the domain on the y axis
	_ymin = min;
	_ymax = max;
	_stored_ymin = _ymin;
	_stored_ymax = _ymax;
	mgraphics.redraw();
}

function range(min, max) {
	// Set the domain on both axis simultaneously
	xrange(min, max);
	yrange(min, max);
	mgraphics.redraw();
}

function shape(x) {
	_shape = x;
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

function bang() {
	outlet(0, vx, vy);
}

function onclick(x,y, button, mod1, shift, capslock, option, mod2) {
	ondrag(x, y, button, mod1, shift, capslock, option, mod2)
	clickstart = { x:x, y:y }
}
onclick.local = 1; //private. could be left public to permit 'synthetic' events

function ondrag(x,y, button, mod1, shift, capslock, option, mod2) {
	const width = box.rect[2] - box.rect[0];
	const height = box.rect[3] - box.rect[1];
	if (x<0) x = 0;
	else if (x>width) x = width;
	if (y<0) y = 0;
	else if (y>height) y = height;
	
	w = sketch.screentoworld(x,y);
	vx = x / width;
	vy = 1- y/height;
	vx = scale(vx, 0, 1, _xmin, _xmax);
	vy = scale(vy, 0, 1, _ymin, _ymax);
	mgraphics.redraw();
	if (!button && option) {
		const _new_xmin = scale(boxarea[0], -1, 1, _xmin, _xmax);
		const _new_xmax = scale(boxarea[1], -1, 1, _xmin, _xmax);
		const _new_ymin = scale(boxarea[2], -1, 1, _ymin, _ymax);
		const _new_ymax = scale(boxarea[3], -1, 1, _ymin, _ymax);

		_xmin = _new_xmin;
		_xmax = _new_xmax;
		_ymin = _new_ymax; // invert y axis
		_ymax = _new_ymin; // invert y axis
		outlet(1, 'zoomxrange', [_xmin, _xmax]);
		outlet(1, 'zoomyrange', [_ymin, _ymax]);
	}
	
	clickend = { x:x, y:y };
	dragging = button && option;
	if (dragging == 0) {
		clickend = { x:0, y:0 };
		clickstart = { x:0, y:0 };
	}; // reset

	if (button && mod2) {
		_xmin = _stored_xmin;
		_xmax = _stored_xmax;
		_ymin = _stored_ymin;
		_ymax = _stored_ymax;
		outlet(1, 'xrange', [_xmin, _xmax]);
		outlet(1, 'yrange', [_ymin, _ymax]);
	}

	if (!option && button) {
		notifyclients();
		bang();
	}
}
ondrag.local = 1; //private. could be left public to permit 'synthetic' events

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

Array.prototype.removeDuplicates = function() {
	var uniqueArray = [];
	for (var i = 0; i < this.length; i++) {
		if (uniqueArray.indexOf(this[i]) === -1) {
			uniqueArray.push(this[i]);
		}
	}
	return uniqueArray;
};
