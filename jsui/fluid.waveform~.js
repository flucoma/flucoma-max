if (!Array.prototype.fill) {
  Object.defineProperty(Array.prototype, 'fill', {
    value: function (value) {
      // Steps 1-2.
      if (this == null) {
        throw new TypeError('this is null or not defined');
      }

      var O = Object(this);

      // Steps 3-5.
      var len = O.length >>> 0;

      // Steps 6-7.
      var start = arguments[1];
      var relativeStart = start >> 0;

      // Step 8.
      var k = relativeStart < 0 ?
        Math.max(len + relativeStart, 0) :
        Math.min(relativeStart, len);

      // Steps 9-10.
      var end = arguments[2];
      var relativeEnd = end === undefined ?
        len : end >> 0;

      // Step 11.
      var finalValue = relativeEnd < 0 ?
        Math.max(len + relativeEnd, 0) :
        Math.min(relativeEnd, len);

      // Step 12.
      while (k < finalValue) {
        O[k] = value;
        k++;
      }

      // Step 13.
      return O;
    }
  });
}

inlets = 3;
outlets = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var Fav = require('fav-max').default;
var Signal = Fav.Signal;
var Display = Fav.Display;
var Markers = Fav.Markers; 
var redrawNeeded = true; 

var width = box.rect[2] - box.rect[0];
var height = box.rect[3] - box.rect[1];
var refreshTask = new Task(refresher,this)

function refresher()
{
  if(arguments.callee.task.object)
  {
    if(redrawNeeded) 
    {
        render(); 
        mgraphics.redraw(); 
    }
    redrawNeeded = false; 
    arguments.callee.task.schedule(20); 
  } else {
    arguments.callee.task.cancel()
    argument.callee.task.freepeer()
  }   
}

declareattribute("zoom","getzoom","setzoom")
declareattribute("offset","getoffset","setoffset")

var alllayers = []; 
var layers = [];
var layerData = []; 
var markerlayers = []; 
var labels = [];
var disp = null; 
var zoom = 1; 
var offset = 0; 
var mg = null; 
var img = null; 
var backgroundcolor = [0.254902, 0.254902, 0.254902, 1.]; 


init();
mgraphics.redraw();

function getzoom() { return zoom; }
function setzoom(z) { redrawNeeded = true; zoom = Math.min(1, Math.max(0, z)) }

function getoffset() { return offset; }
function setoffset(o){ redrawNeeded = true; offset = Math.min(1,Math.max(0,o))}

function loadbang() {
  init();
}

function init () {
  disp = null;
  layers = [];
  layerData = []; 
  labels = [];
  markerlayers = []; 
  alllayers = []; 
  redrawNeeded = true; 
  img = null; 
  refresh(); 
  refreshTask.execute(); 
}


function MarkersSpec (source, reference) {
  
  if(!reference) throw "Markers without reference layer or sample rate"
  
  this.source = source; 
  this.reference = reference; 
  this.type = 'markers'

  this.refresh = function(){
      if(!this.source) throw "Markers without source buffer" 
      
      var markers = new Buffer(source); 
      if(!markers) error("Markers: buffer~", source, "not found!\n")  
      var markerdata = markers.peek(1,0,markers.framecount())
      //reference can be either a buffer name or a sampling rate 
      this.fs = null;
      var extent = 0; 
      if(typeof reference === 'string')
      {
        var refbuf = new Buffer(reference); 
        if(!refbuf){
          error("Markers: reference buffer~",reference,"not found!\n"); 
          return; 
        }
        this.fs = 1000.0 * (refbuf.framecount() / refbuf.length()); 
        extent = refbuf.framecount(); 
        if(markerdata[markerdata.length - 1] < extent) markerdata.push(extent)
      }
      else if(typeof reference === 'number')
      {
        this.fs = reference; 
      }      
      if(!this.fs) throw "Markers without sample rate"
      this.data = new Markers(markerdata,this.fs);
      this.length = this.data.length;
  }
  
  this.seletced = false;  
  this.forEach = function (c) { this.data.forEach(c); };
  this.style = this.style = {color: [1., 0.709804, 0.196078, 1.], backgroundcolor: [0, 0, 0, 0],selectedcolor:[ 1., 0.345098, 0.298039, 1.]};

  this.ondrag = function (x, y, button, mod1, shift, caps, opt, mod2)	{
	 	var factor = (this.data.length / getWidth()) * zoom;
    var off = Math.min(offset,1 - zoom) * this.data.length
    var thisMarker = this.data.data.filter(function (m) { return m.selected; });

    if (thisMarker[0]) {
      thisMarker[0].position = off + (x * factor);
      mgraphics.redraw();
    }
  };
}
MarkersSpec.local = 1; 

function LayerSpec () {
  this.type = null;
  this.source = null;
  this.name = null;
  this.style = {color: [0.823529, 0.823529, 0.823529, 1.], backgroundcolor: [0, 0, 0, 0]};
  this.range = -1;
  this.channels = -1;
}
LayerSpec.local = 1;

function LayerData() {
  this.data = [];
  this.favlayer = []; 
  this.dirty = true; 
  this.peakcache = []; 
  this.img = null; 
  // this.signal = []; 
}
LayerData.local = 1; 

function find (_name) {
  if (!_name) return null;
	// this is stricter than parseInt
  return /^\d+$/.test(_name) ? parseInt(_name) : labels.indexOf(_name);
}
find.local = 1;

function addlayer (type, source, _name) {
  if (!type || !source) error('layer must have a type (symbol) and a source (buffer name)\n');
  const index = find(_name ? _name : source); 

  var layerTypes = {
    'imagebuffer' : 'image',
    'featurebuffer' : 'line',
    'audiobuffer' : 'wave',
    'line' : 'line',
    'image' : 'image',
    'wave' : 'wave'
  }

  var translatedType = layerTypes[type]

  if(index < 0)
  {
    var l = new LayerSpec();
    l.type = translatedType;
    l.source = source;
    layers.push(l);
    alllayers.push(l);   
    labels.push(_name ? _name : source);  
  } 
  else 
  {
    var l = alllayers[index]; 
    l.type = translatedType;
    l.source = source;    
  }
  refresh(); 
}

function addmarkers(source, reference, _name)
{
  if (!reference || !source) error('marker layer must have a source (buffer) and a reference (buffer or sample rate)\n');

  const index = find(_name ? _name : source); 
  if(index < 0)
  {  
    var l = new MarkersSpec(source, reference)//markerdata,fs,referenceLength)  
    l.type = 'markers';
    markerlayers.push(l);
    alllayers.push(l); 
    labels.push(_name ? _name : source);
  }
  else 
  {
    var l = alllayers[index];
    l.source = source; 
    l.reference = reference; 
  }
  refresh(); 
}

function removelayer (_name) {
  if (!_name) return;
  var index = find(_name);
  if (index < 0) return;
  alllayers.splice(index, 1);
  labels.splice(index, 1);
  layers = alllayers.filter(function(l){return l instanceof LayerSpec}); 
  markerlayers = alllayers.filter(function(l){return l instanceof MarkersSpec}); 
  refresh(); 
}

function clear() {
  init();   
}

function getlayers () {
  outlet(0, 'layers', labels);
}

function set () {
  var args = arrayfromargs(arguments);
  if (args.length < 3) return;

  var index = find(args[0]);
  if (index < 0) return;
  var _name = args[0]
  var property = args[1];
  var value = args.slice(2);
  value = value.length === 1 ? value[0] : value;
  if (typeof layers[index][property] !== 'undefined') {
    alllayers[index][property] = value;
  } else		{
    error('layer', _name, 'has no property', property, '\n');
    dumpobj(layers[index])
  }
}

function color() 
{
  var args = arrayfromargs(arguments)
  if (args.length >= 2)
  {
    const index = find(args[0])    
    if(index >= 0)
    {
      const n = Math.min(args.length,5)  
      for(var i = 1; i < n; i++)
      {
        alllayers[index]['style']['color'][i - 1] = args[i]
      }      
      refresh(); 
    } else error('layer',args[0],'not found\n'); 
  }else error('color: not enough arguments'); 
}

function selcolor()
{
  var args = arrayfromargs(arguments)
  if (args.length >= 2)
  {
    const index = find(args[0])    
    if(index >= 0)
    {
      // post(index)
      const n = Math.min(args.length,5)  
      for(var i = 1; i < n; i++)
      {
        alllayers[index]['style']['selectedcolor'][i - 1] = args[i]
      }      
      refresh(); 
    } else error('layer',args[0],'not found\n'); 
  }else error('selcolor: not enough arguments'); 
}

function bgcolor() 
{
  var args = arrayfromargs(arguments)
  if (args.length >= 1)
  {
    const n = Math.min(args.length,4)  
    for(var i = 0; i < n; i++)
    {
      backgroundcolor[i] = args[i]
    }      
    refresh(); 
  }else error('bgcolor: not enough arguments'); 
}

function dump () {
  var d = new Dict();
  var wrapper = {layers: alllayers};	
  d.parse(JSON.stringify(wrapper));
  outlet(0, 'dictionary', d.name);
}

function refresh () {
  disp = null;
  layerData = []; 
  jsuiObj = this;

  layers.forEach(function (l, i) {  
 
    var buf = new Buffer(l.source);
    if (!buf) return;     
    var srcChans = buf.channelcount();
    var srcLen = buf.framecount();
    if (srcLen < 1) return;
    var fs = 1000 * (srcLen / buf.length());
    var chans = [];

    if (l.channels instanceof Array) 
    {
      chans = l.channels.map(function (c) { Math.min(srcChans - 1, c); });
    }
    else 
    {
      if (l.channels === -1) {
        chans.length = srcChans;
        chans.fill(0);
        chans = chans.map(function (x, i) { return i; });
      } 
      else 
        if (typeof l.channels === 'number') 
          chans = [Math.min(srcChans - 1, l.channels)];
    }
        

    //for images (rank 2 signals), layer.data is Signal of arrays 
    // for everything else layers.data is array of Signals of rank-1
    // (this is how fav thinks of things)      
    var ld = new LayerData(); 
    var data = [];
    if(l.type === 'image')      
    {
      chans.forEach(function (c) {
       var s = buf.peek(c + 1, 0, buf.framecount());
       data.push(s instanceof Array ? s : [s]);
      });
      
      ld.data = new Signal(data, fs);   
    }
    else 
    {
      ld.data = []; 
      
      chans.forEach(function (c) {
       var s = buf.peek(c + 1, 0, buf.framecount());
       s = s instanceof Array ? s : [s];
       ld.data.push(new Signal(s,fs)); 
       ld.peakcache.push(null); 
      });        
    }
    if (disp !== null) { 
      disp.addLayer(l.type, 0);
      ld.favlayer = disp.layers[disp.layers.length - 1]; 
    }
    else {        
      disp = new Display(jsuiObj, l.type, width, height);
      ld.favlayer = disp.layers[0]; 
    }    
    
    layerData.push(ld);
    
  }); //layers for each
  
  markerlayers.forEach(function (l, i) {    
    l.refresh(); 
    var ld = new LayerData() 
    if (!disp) 
      disp = new Display(jsuiObj, 'markers', width, height, 0, null);
    else  
      disp.addLayer('marker',0);
  })        
  redrawNeeded = true; 
}

function dictionary (d) {
	// because I'm nice, I will eventually accept stripped back structures that replace arrays with single objects

  var ddict = new Dict(d);
  var input = JSON.parse(ddict.stringify());

  // There must be an array under root called 'layers'
  if (typeof input['layers'] === 'undefined') 	{
    error('Parse Error: No layers found\n'); return;
  }

  if (!Array.isArray(input['layers'])) 	{
    error('Parse Error: layers, expected array\n'); return;
  }

  input['layers'].forEach(function (l) {
		// no object assign
    var newlayer = new LayerSpec();
    Object.keys(newlayer).forEach(function (k) {
      newlayer[k] = l[k];
    });
    alllayers.push(l);
    layers = alllayers.filter(function(l){return l instanceof LayerSpec}); 
    markerlayers = alllayers.filter(function(l){return l instanceof MarkersSpec});  
  });
  
  refresh();
}

function dumpobj (obj) {
  do {
    	post(Object.getOwnPropertyNames(obj), '\n');
  	} while ((obj = Object.getPrototypeOf(obj)));
}

function getContext () {
  return mg;  
}
getContext.local = 1; 

function getLongestDuration() {
  var durs = layerData.map(function (l) {
    if(l.data instanceof Signal)
      return l.data.length / l.data.sampleRate; 
    else return 0;
  }); 
  var longest = durs.reduce(function(a,b) {return Math.max(a,b);}); 
  return longest; 
}
getLongestDuration.local = 1; 

function getWidth () {
  return box.rect[2] - box.rect[0];
}
getWidth.local = 1; 

function getHeight () {
  return box.rect[3] - box.rect[1];
}
getHeight.local = 1; 

function buffer (b) {
  addlayer('wave',b);    
}

function markers () {
  var args = arrayfromargs(arguments);  
  addmarkers(args[0],args[1]);    
}

function render() 
{
  mg = new MGraphics(width,height); 
  with(mg){
    init(); 
    relative_coords = 0; 
    autofill = 0; 
    rectangle(0,0,width,height); 
    set_source_rgba(backgroundcolor[0], backgroundcolor[1], backgroundcolor[2], backgroundcolor[3]);
    fill();
  }
  var size = this.box.rect;
  var off = Math.min(offset,1 - zoom)

  layers.forEach(function (l, i) 
  {
    var sig =  layerData[i].data ; 
    var zsig = null; 
    
    const zoomSlice = function(sig){
      return sig.slice(off * len,Math.max(1,len * (off + zoom)))
    }

    if(l.type !== 'image')
    {
      const channelCount = layerData[i].data.length; 
      const vHop = (height / channelCount) | 0;  
      
      for(var chan = 0; chan < channelCount;  chan++)
      {        
        sig = layerData[i].data[chan];  
        len = sig.length; 
                
        //really idiotic caching; improves matters for files up to a few minutes
        //but better long term solution needed (implies refactor)
        if(l.type === 'wave' && len / width > 128)
        {
          if(layerData[i].peakcache[chan] === null)
          {
            layerData[i].peakcache[chan] = [
              sig.sample(128,'min'), sig.sample(128,'max')
            ]  
          }

          sig = layerData[i].peakcache[chan]; 
          len = sig[0].length;  
          zsig = [zoomSlice(sig[0]), zoomSlice(sig[1])]
        }
        else
        {
          zsig = zoomSlice(sig); 
        }        
        disp.layers[i].setRange([0, chan * vHop, width,vHop]); 
        disp.draw(zsig, l.style, disp.layers[i]);        
      }
    }
    else 
    {
      var len = sig.length
      zsig = new Signal(sig.data.slice(off * len,Math.max(1,len * (off + zoom))))
      disp.draw(zsig, l.style, disp.layers[i]);        
    }
  
  });
  
  markerlayers.forEach(function(l,i){
    if(layers.length > 0)
    { 
      var sig =layerData[0].data[0]; 
      l.data.extent = [0, sig.rank === 2 ? sig.nBands : sig.length]; 
    }
    else l.data.extent = [0,l.data[l.data.length - 1]]; 
    var sig = l.data.slice(off * l.data.length, l.data.length * (zoom + off))    
    disp.layers[i + layers.length].setRange([0, 0, width,height]);  
    disp.draw(sig,l.style,disp.layers[i + layers.length])
  })
  img = new Image(mg); 
}


function paint () {
  var size = this.box.rect;
  var off = Math.min(offset,1 - zoom)  
  gc();   
  if(redrawNeeded){ 
    render(); 
    redrawNeeded = false; 
  }

  mgraphics.image_surface_draw(img); 
}

function onidleout (x, y, button, mod1, shift, caps, opt, mod2) {
  markerlayers.forEach(function(l) {
    l.data.data.forEach(function (m) {
        m.selected = false
    })
  });
  redrawNeeded = true; 
}

function onclick (x, y, button, mod1, shift, caps, opt, mod2) {
   	
  if(markerlayers.length > 0)
  {
    var l = markerlayers[markerlayers.length - 1];       
    var factor = (l.data.length / getWidth()) * zoom;
    var off = Math.min(offset,1 - zoom) * l.data.length;       

    if(shift && !mod1) l.data.add(off + (x * factor));       
    else if(shift && mod1) 
    {
      //someting should be selected 
      var sel = l.data.data.filter(function(m){return m.selected}); 
      if(sel[0])
        l.data.remove(sel[0]); 
    }  
  }
  redrawNeeded = true; 
}

function ondrag (x, y, button, mod1, shift, caps, opt, mod2) {
  markerlayers.forEach(function(l,i){
    l.ondrag(x, y, button, mod1, shift, caps, opt, mod2)
  })
  redrawNeeded = true; 
}

function onresize (x, y, button, mod1, shift, caps, opt, mod2) {
  width = box.rect[2] - box.rect[0];
  height = box.rect[3] - box.rect[1];

  if (disp) {
    disp.canvas.width = width;
    disp.canvas.height = height;     
  }
  redrawNeeded = true;
}

function onidle (x, y, button, mod1, shift, caps, opt, mod2) {
  var off = Math.min(offset,1 - zoom)
  markerlayers.forEach(function(l,i){
      var m = disp.layers[i + layers.length]
      .search(l.data.slice(off * l.data.length,l.data.length * (zoom + off)),x); 
      if(m !== null) redrawNeeded = true; 
  });
}

/* function save()
{
	embedmessage("dictionary",d.getgalueof());
} */
