var freq1 = -1, thresh1 = 0, freq2 = 1, thresh2 = 0, tolerance = 0.03, zone, prevx, prevy;
outlets = 1;

function bang() {
  with (sketch){
    glclearcolor(0.95,0.95,0.95,1.);
    glclear();
    glcolor(0.75,0.75,0.75,1.);
    for (x=-0.8;x<1;x+=0.2) {
      moveto(-2,x,0);
      lineto(2,x,0);
    }
    for (x=-1.6;x<2;x+=0.4) {
      moveto(x,-1,0);
      lineto(x,1,0);
    }
    glcolor(0,0,0,1.);
    moveto(-2,thresh1,0);
    lineto(freq1,thresh1,0);
    lineto(freq2,thresh2,0);
    lineto(2,thresh2,0);
    moveto(freq1,thresh1);
    framecircle(0.02);
    moveto(freq2,thresh2);
    framecircle(0.02);
  }
  refresh();
}

function clear () {
  freq1 = -1;
  thresh1 = 0;
  freq2 = 1;
  thresh2 = 0;
  bang();
  outlet(0,Math.pow(10,(freq1 + 2) * 0.75) * 20,thresh1 * 50,Math.pow(10,(freq2 + 2) * 0.75) * 20,thresh2 * 50);
}

function onclick (x,y) {
  var freq,thresh;
  [freq, thresh] = sketch.screentoworld(x,y);

  if (Math.abs(freq - freq1) < tolerance){
    zone = 2;
  } else if (Math.abs(freq - freq2) < tolerance){
    zone = 4;
  } else if (freq < freq1) {
    zone = 1;
  } else if (freq > freq2) {
    zone = 5;
  } else {
    zone = 3;
    prevx = freq;
    prevy = thresh;
  }
}

function ondrag (x, y) {
  var freq,thresh,dx,dy;
  [freq, thresh] = sketch.screentoworld(x,y);
  switch (zone) {
    case 1:
      thresh1 = thresh;
      break;
    case 2:
      freq1 = Math.min(freq,freq2);
      thresh1 = thresh;
      break;
    case 3:
      dx = freq - prevx;
      dy = thresh - prevy;
      freq1 += dx;
      freq2 += dx;
      thresh1 += dy;
      thresh2 += dy;
      prevx = freq;
      prevy = thresh;
      break;
    case 4:
      freq2 = Math.max(freq,freq1);
      thresh2 = thresh;
      break;
    case 5:
      thresh2 = thresh;
      break;
  }
  bang();
  outlet(0,Math.pow(10,(freq1 + 2) * 0.75) * 20,thresh1 * 50,Math.pow(10,(freq2 + 2) * 0.75) * 20,thresh2 * 50);
}
