x = WarpTate();
y = WarpUtil(x);

y.curSensor = '808b';
y.calibrate;
y.stopCalibrate;

~three = x.addTrack('303_1', 0, '303_1');
~three.on(15);

~three.settings['areyouthereprev'] = 0;

~three.addFunc('303a', 'sweep', {|track, val|
	var thresh = 117;

	track.setParam('Cutoff', val.lincurve(0, thresh, 30, 120, 2));
	// track.setParam('Bus 2', val.lincurve(30, 127, 0, 90, 2));
	track.setParam('Env Mod', val.lincurve(0, 100, 50, 100, 2));
	track.setParam('Env Attack', val.lincurve(0, 100, 50, 100, 2));

	if(track.settings['areyouthereprev'] < thresh && (val >= thresh)) {
		track.parent.tracks['exs_1'].hit([36, 37].wchoose([0.7, 0.3]));
	};

	track.settings['areyouthereprev'] = val;
});

~exs = x.addTrack('exs_1', 4);
~exs.settings['patternTrack'] = false;


x.tempo = 132;

~three2 = x.addTrack('303_2', 1, '303_2');
~three2.on(15);

~three2.setParam('Waveform', 127);
~three2.setParam('Tuning', 96);
~three2.setParam('Slide Time', 110);
~three2.setParam('Cutoff', 100);
~three2.setParam('Resonance', 100);
~three2.setParam('Env Mod', 75);
~three2.setParam('Env Attack', 0);
~three2.setParam('Env Decay', 10);
~three2.setParam('Accent Decay', 0);
~three2.setParam('Env Accent', 45);
~three2.setParam('Step Length', 115);
~three2.setParam('Arpe Chord', 30);
~three2.setParam('Arpe Mode', 50);
~three2.setParam('Arpe Range Sub 1', 0);
~three2.setParam('Arpe Range Zero', 127);
~three2.setParam('Arpe Range Add 1', 127);
~three2.setParam('Arpe Range Add 2', 127);
~three2.setParam('Arpe Multiplier', 0);
~three2.setParam('Distortion State', 127);
~three2.setParam('Distortion Route', 127);
~three2.setParam('Distortion Preamp', 50);
~three2.setParam('Distortion Size', 110);
~three2.setParam('Distortion Density', 30);
~three2.setParam('Distortion Clip', 110);
~three2.setParam('Distortion Wetness', 127);
~three2.setParam('Distortion Brightness', 70);

~three2.addFunc('303b', 'arpehell', {|track, val|
	var thresh1 = 90,
		thresh2 = 110;
	track.setParam('Main Volume', val.lincurve(0, 30, 0, 90, -2));
	if(val <= thresh1) {
		track.setParam('Arpe Multiplier', 0);
	};
	if(val > thresh1) {
		track.setParam('Arpe Multiplier', 70);
	};

	track.setParam('Env Mod', val.lincurve(thresh1, 127, 75, 127, 2));
});

~eight = x.addTrack('808_1', 2, '808_1');
~eight.setParam('Send 1', 0);

~eight.on(14);

~eight.addFunc('808a', 'basscrush', {|track, val|
	track.setParam('bitcrusher', val.lincurve(0, 110, 0, 60, 2));
	track.setParam('Bass Drum Decay', val.lincurve(0, 110, 70, 50, 2));

	track.parent.tracks['808_2'].setParam(
		'Bass Drum Decay',
		val.lincurve(0, 110, 70, 50, 2)
	);

	track.parent.tracks['808_2'].setParam(
		'Bass Drum Level',
		val.lincurve(0, 110, 0, 90, 2)
	);
});

~eight.addFunc('808b', 'clapvol', {|track, val|
	var thresh = 60,
		thresh2 = 110;
	if(val > 30) {
		track.parent.tracks['808_2'].setParam('Hand Clap Level', 90);
	} {
		track.parent.tracks['808_2'].setParam('Hand Clap Level', 0);
	};

	if(val <= thresh) {
		track.parent.tracks['808_2'].setParam('Send 2', 0);
	};
	if(val > thresh) {
		track.parent.tracks['808_2'].setParam('Send 2', 90);
	};
	if(val <= thresh2) {
		track.parent.tracks['808_2'].setParam('Send 3', 0);
	};
	if(val > thresh2) {
		track.parent.tracks['808_2'].setParam('Send 3', 90);
	};
});


~eight2 = x.addTrack('808_2', 3, '808_2');
~eight2.setParam('Bass Drum Decay', 30);
~eight2.setParam('Send 1', 90);
~eight2.setParam('Hand Clap Reverb', 0);

~eight2.on(14);





~three.setParam('echovol', 0);
// 51, 18, 22, 24, 27no laser, 29, 33, 35

~calibrate.();
~stopCalibrate.();


x.out

~three.settings['sensorFuncs']['303b']




// phuture
// daft punk
// higher state
// 24 - 12 = 12
// 17 - 12 = 5
// 53 - 12 = 41
// 71 - 12 = 59
// 12 - 12 = 0

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



~three = x.readTrack("~/Projects/13-11_warp/code/presets/final/00_303_1_acidtracks.trackpreset".standardizePath);
~eight = x.readTrack("~/Projects/13-11_warp/code/presets/final/00_808_1_acidtracks.trackpreset".standardizePath);
