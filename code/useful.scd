WarpTrack.defaults['808']['paramControls'].asArray.sort.do {|value, i|
	var key = WarpTrack.defaults['808']['paramControls'].findKeyForValue(value);
	("<assign CC=\"" ++ value ++ "\" param=\"" ++ key.asString ++ "\"/>").postln;
}
