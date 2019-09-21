outlets = 2;
var myUrn = [];
var size = 10;
var temp;
var n;
var i;
var count;

if (jsarguments.length < 2) {
  error("big_urn needs a size as argument, reverting to default of 10");
} else {
  size = jsarguments[1];
}

clear();

for (i = 0; i < size; i++) {
  myUrn[i] = i;
}

function clear() {
  for (i = size - 1; i > 0; i--) {
    n = Math.floor(Math.random() * (i + 2));
    temp = myUrn[i];
    myUrn[i] = myUrn[n];
    myUrn[n] = temp;
  }
  count = size;
}

function bang() {
  if (count) {
    outlet(0,myUrn[--count]);
  } else {
    outlet(1,"bang");
  }
}
