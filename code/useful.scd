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




// phuture
// daft punk
// higher state
// 24
// 17
// 53
// 71
// 12

// maybe 19


// good pairs
// 808 			303
// 51 			12, 14, 24
// 27			17

// good 808 patterns
// 51, 18, 22, 24, 27no laser, 29, 33, 35


// 14, 18, 22, 24, 27,
// 29, 30, 33, 34, 35, 39, 41
// 49
// 42 add more claps


// good 303
// acid tracks with screeaaaaming
// acid tracks, da funk
// 12, 14, 17, 24, 28, 52
// 19, 32, 36, 39, 40, 47, 62
// 67, 71, 72. 81, 85, 87

// In 3
// 53, 61

// in 5 64

// three i like... 12, 24
// tuning works well on 24
// 37



// check if prests have keys not in defaults
~type = "303_1";
~path = ("~/Projects/13-11_warp/code/presets/final/02_" ++ ~type ++ "_areyouthere.trackpreset").standardizePath;
~track = x.readTrack(~path);

x.tracks[~type.asSymbol].settings['paramControls'].keysValuesDo { |key, value|
	"--------------".postln;
	key.postln;
	value.postln;
	x.tracks[~type.asSymbol].settings['params'][key].postln;
	"--------------".postln;
};


"~/Projects/13-11_warp/code/presets/final/*.trackpreset".standardizePath.pathMatch.do {|path, i|
	var settings = Object.readArchive(path);
	var defaults = WarpTrack.defaults[settings['type']];

	path.basename.postln;
	settings['type'].postln;
	defaults['paramControls'].keysValuesDo { |key, value|
		if(settings['paramControls'].includesKey(key).not) {
			// settings['paramControls'][key] = value;
			// settings['params'][key] = WarpTrack.defaults[~type.asSymbol]['params'][key];
			// path.basename.postln;
			// key.postln;
		};
	};
};
