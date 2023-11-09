exports.scale = function(v, iMin, iMax, oMin, oMax) {
	// Scales <v> from the input range to the output range
	// Exactly the same as the scale object
	return ((v - iMin) / (iMax - iMin)) * (oMax - oMin) + oMin
}

exports.hexToRGB = function(hex, alpha) {
	const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
	return result ? [
		parseInt(result[1], 16) / 255.0,
		parseInt(result[2], 16) / 255.0,
		parseInt(result[3], 16) / 255.0,
		alpha
		] : [0, 0, 0, alpha];
}