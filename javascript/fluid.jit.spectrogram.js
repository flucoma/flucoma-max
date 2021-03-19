inlets = 1; 
outlets = 1; 

var mat = new JitterMatrix(1,"float32",1,1); 

//plenty of room for improvement here 
function buffer(b) 
{
	var buf = new Buffer(b); 
	var chans = buf.channelcount(); 
	var frames = buf.framecount(); 	
	mat.dim = [frames, chans]; 
	
	for(i = 1; i <= chans; i++) 
	{
	 	var c = buf.peek(i,0,frames); 
		c = c.map(function(x){ return 20 * (Math.log(x + 0.001)/Math.log(10)) ;}) 
		for(j = 0; j < frames; j++) 
		{
			mat.setcell2d(j,chans - (i-1),c[j]); 		
		}
	}
	
	outlet(0,"jit_matrix",mat.name) ; 		
}