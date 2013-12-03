WarpTrack.defaults['808']['paramControls'].asArray.sort.do {|value, i|
	var key = WarpTrack.defaults['808']['paramControls'].findKeyForValue(value);
	("<assign CC=\"" ++ value ++ "\" param=\"" ++ key.asString ++ "\"/>").postln;
}

x.sensorKeys.collectAs({|sensorKey, i| (sensorKey -> IdentityDictionary[])}, IdentityDictionary);

~three.addFunc('303a', 'filter', {|track, val|
	track.setParam('Cutoff', val);
	track.setParam('Resonance', val.linlin(0, 127, 50, 110));
	track.setParam('Distortion Clip', val.linlin(0, 127, 80, 50));
	track.setParam('Distortion Preamp', val.linlin(0, 127, 80, 50));
});
