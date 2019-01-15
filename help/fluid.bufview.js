//adapted from warpy2
//canvas setup
mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;
var w = box.rect[2] - box.rect[0];
var h = box.rect[3] - box.rect[1];
var vz = 1.;
var nchan = 1;
var bufsize = 1.;
var dsbufamp = [0];
var groups = [0];
var groupscolours = [[0.4,0.4,0.4],[0.5,0.,0.],[0.,0.5,0.],[0.,0.,0.5]];
var ngroup = 1;
var isBipolar = 0;

function loadbang(){
	bang();
}

function paint(){
	var u,v;
	with (mgraphics) {
		// background
		set_source_rgb(0.1,0.1,0.1);
		rectangle(0,0,w,h);
		fill();
		// wave
		if (isBipolar) {
			for (v = 1; v <= nchan; v++){
				set_source_rgb(groupscolours[groups[v-1]]);
				for (u = 0; u < w; u++){
					move_to(u,h*(v - 0.5)/nchan);
					line_to(u,h*(v - 0.5)/nchan - Math.max(Math.min(dsbufamp[u+(w*(v-1))]*(h/nchan)*vz*0.5, h*0.5/nchan),h * -0.5/nchan));
					stroke();
				}
			}
		} else {
			for (v = 1; v <= nchan; v++){
				set_source_rgb(groupscolours[groups[v-1]]);
				for (u = 0; u < w; u++){
					move_to(u,v*h/nchan);
					line_to(u,v*h/nchan - Math.min(dsbufamp[u+(w*(v-1))]*(h/nchan)*vz, h/nchan));
					stroke();
				}
			}
		}
	}
}

function onclick(x, y, button, mod1, shift, caps, opt, mod2){
	var track;
	if (shift){
		track = Math.floor(y*nchan/h);
		if (groups[track]){
			groups[track] = 0;
		} else {
			groups[track] = ngroup;
		}
	}
	bang();
}

function bang()
{
	mgraphics.redraw();
}

function bipolar(flag)
{
	isBipolar = (flag != 0);
	downsamplebuffer();
}

function vzoom(x){
	vz = Math.max(x, 0.);
	bang();
}

function getgroups(){
	outlet(0,groups);
}

function nextgroup(x){
	ngroup = Math.max(Math.min(3,Math.floor(x)),1);
}

function setbuffer(buffer){
	var u;

	buf = new Buffer(buffer);
	bufsize = buf.framecount();
	nchan = buf.channelcount();
	groups.length = 0;
	for (u = 0; u < nchan; u++){
		groups.push(0);
	}
	downsamplebuffer();
}

function downsamplebuffer(){
	var u,v,x, bank;
	var samperpix = bufsize/w;
	var nsamps = Math.max(Math.floor(samperpix),1);
	post(samperpix + ' ' + nsamps + '\n');
	dsbufamp.length = 0;
	for(x = 1; x <= nchan; x++){
		if (isBipolar) {
			for(u = 0; u<w; u++){
				var accum = 0, accumN = 0;
				bank = buf.peek(x, Math.floor(u*samperpix), nsamps);
				// compensating for Max's api not returning arrays of 1
				if (!Array.isArray(bank)) {
					bank = [bank];
				}
				for(v = 0; v<nsamps; v++){
					if (bank[v] >= 0) {
						accum = Math.max(accum, bank[v]);
					} else {
						accumN = Math.min(accumN, bank[v]);
					}
				}
				if (Math.abs(accumN)> accum) {
					dsbufamp.push(accumN);
				} else {
					dsbufamp.push(accum);
				}
			}
		} else {
			for(u = 0; u<w; u++){
				var accum = 0;
				bank = buf.peek(x, Math.floor(u*samperpix), nsamps);
				// compensating for Max's api not returning arrays of 1
				if (!Array.isArray(bank)) {
					bank = [bank];
				}
				for(v = 0; v<nsamps; v++){
					accum = Math.max(accum, Math.abs(bank[v]));
				}
				dsbufamp.push(accum);
			}
		}
	}
	bang();
}

function onresize(){
	w = box.rect[2] - box.rect[0];
	h = box.rect[3] - box.rect[1];
	downsamplebuffer();
}
