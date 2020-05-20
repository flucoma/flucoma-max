

inlets = 1; 
outlets = 1; 

source = null; 
destination = null; 
indices = [-1]; 
channels = [-1]; 

declareattribute("source")
declareattribute("destination") 
declareattribute("indices")
declareattribute("channels")

function bang()
{
	if(source == null) error("source not set"); 
	if(destination == null) error("destination not set"); 

	var sourceBuffer = new Buffer(source); 
	var destinationBuffer  = new Buffer(destination); 
	
	var indexMap = Array.isArray(indices) ? indices : [indices]; 
	var channelMap = Array.isArray(channels) ? channels : [channels]; 
	
	var indexCount = (indexMap.length === 1 && indexMap[0] === -1)  ? 
		sourceBuffer.framecount() : indexCount = indexMap.length;
			
	var channelCount = (channelMap.length === 1 && channelMap[0] === -1) ? 
		 sourceBuffer.channelcount() :  channelMap.length; 

	channelMap = channelMap[0] === -1 ? 
 			Array.apply(null, {length: sourceBuffer.channelcount()}).map(Number.call, Number)
			: channelMap; 
			
	indexMap = indexMap[0] === -1 ? 
 			Array.apply(null, {length: sourceBuffer.framecount()}).map(Number.call, Number)
			: indexMap; 

	destinationBuffer.send("samps", indexCount, channelCount); 
	
	for(var i = 0; i < channelCount; i++)
		for (var j = 0; j < indexCount; j++)
			destinationBuffer.poke(i+1, j, sourceBuffer.peek(channelMap[i], indexMap[j], 1)); 
	outlet(0,'bang'); 			
}