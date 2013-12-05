~three = x.loadTrack('303_1', "~/Projects/13-11_warp/code/presets/archive/303_1.trackpreset".standardizePath);
~three.addFunc('303b', 'tuning', {|track, val|
	track.setParam('Tuning', val.linlin(0, 127, 64, 127).round((64/3)).min(127));
});

~eight = x.addTrack('808_1', 2, '808');
~eight.assign('snareverb', 89);
~eight.addFunc('808b','snareverb', {|track, val|
	track.setParam('snareverb', val.linlin(0, 127, 0, 90));
});

~eightKick = x.addTrack('808kick', 3, '808');
~eightKick.settings['fourOn'] = false;
~eightKick.addFunc('808a', 'kick', {|track, val|
	if(val >= (0.25 * 127) && track.settings['fourOn'].not) {
		track.on(13, 1);
		track.settings['fourOn'] = true;
	};
	if(val < (0.25 * 127) && track.settings['fourOn']) {
		track.on(12, 1);
		track.settings['fourOn'] = false;
		track.parent.clock.playNextBar({
			track.on(12, 1);
		});
	};

	track.setParam('Bass Drum Sweep', val.linlin(0, 127, 32, 77));
});


// Acid Tracks
~three_1 = x.addTrack('303_1', 0, '303_1');
~three_1.on(12);
~three_1.setParam('Bus 1', 0);
~three_1.setParam('Bus 2', 0);
~three_1.setParam('Waveform', 127);
~three_1.setParam('Resonance', 115);
~three_1.addFunc('303a', 'sweep', {|track, val|
	track.setParam('Cutoff', val.lincurve(0, 127, 20, 127, 2));
	track.setParam('Bus 2', val.lincurve(30, 127, 0, 90, 2));
	track.setParam('Env Mod', val.lincurve(0, 100, 50, 100, 2));
	track.setParam('Env Attack', val.lincurve(0, 100, 50, 100, 2));
});

~three_1.addFunc('303b', 'tunedist', {|track, val|
	track.setParam('Tuning', val.round(63.5/2).max(64));
	track.setParam('Distortion Preamp', val.lincurve(0, 127, 40, 100, 2));
	track.setParam('Distortion Clip', val.lincurve(0, 127, 90, 45, 2));
	track.setParam('Distortion Size', val.lincurve(0, 127, 50, 85, 2));
	track.setParam('Distortion Density', val.lincurve(0, 127, 30, 90, 2));

});

~eight = x.addTrack('808_1', 2, '808_1');
~eight.on(12);
~eight.setParam('Low Tom Tunning', 25);
~eight.setParam('Low Tom Decay', 86);
~eight.setParam('Low Tom Snappy', 25);
~eight.addFunc('808a', 'bass', {|track, val|
	if(val < 32) {
		track.setParam('Low Tom Level', 100);
		track.setParam('Bass Drum Level', 0);
	} {
		track.setParam('Low Tom Level', 0);
		track.setParam('Bass Drum Level', 100);
	};
});

~eight.addFunc('808b', 'clapverb', {|track, val|
	var thresh = 10;

	if(val > thresh) {
		track.setParam('Hand Clap Level', 127);
		track.setParam('Claves Level', 127);
		track.setParam('Closed Hi Hat Level', 127);
	} {
		track.setParam('Hand Clap Level', 0);
		track.setParam('Claves Level', 0);
		track.setParam('Closed Hi Hat Level', 0);
	};

	track.setParam('Send 1', val.lincurve(thresh, 127, 0, 90, 2));
	track.setParam('Closed Hi Hat Decay', val.lincurve(thresh, 127, 64, 127, 2));
	track.setParam('Hi Hat Filters Freq', val.lincurve(thresh, 127, 20, 110, 2));
});


// da funk

~three.on(14);

~three.assign('echovol', 47);
~three.assign('Bus 3', 48);

~three.setParam('Waveform', 0);
~three.setParam('Resonance', 120);
~three.setParam('Cutoff', 100);
~three.setParam('Slide Time', 50);
~three.setParam('Distortion State', 127);
~three.setParam('Distortion Route', 0);
~three.setParam('Bus 3', 60);


~three.addFunc('303a', 'distchange', {|track, val|
	track.setParam('Distortion Preamp', val.lincurve(0, 100, 30, 115, 4));
	track.setParam('Distortion Clip', val.lincurve(0, 100, 70, 45, 4));
	track.setParam('Distortion Size', val.lincurve(0, 100, 64, 115, 4));
	track.setParam('Distortion Density', val.lincurve(0, 100, 127, 100, 4));
	track.setParam('Distortion Wetness', val.lincurve(0, 100, 100, 80, 4));
	track.setParam('Distortion Brightness', val.lincurve(0, 100, 0, 70, 4));
});

~three.addFunc('303b', 'envchange', {|track, val|
	track.setParam('Env Attack', val.lincurve(0, 100, 30, 120, 2));
	track.setParam('Env Mod', val.lincurve(0, 127, 30, 120, 2));
	track.setParam('Tuning', val.round(64).clip(64, 127));
	track.setParam('echovol', val.lincurve(80, 127, 0, 80, 2));
	track.setParam('Slide Time', val.lincurve(0, 80, 50, 0, 2));
});

~three = x.addTrack('303_1', 0, '303_1');

x.tempo = 111;

~three.on(14);

~three.assign('echovol', 47);
~three.assign('Bus 3', 48);

~three.setParam('Waveform', 0);
~three.setParam('Resonance', 120);
~three.setParam('Cutoff', 100);
~three.setParam('Slide Time', 50);
~three.setParam('Distortion State', 127);
~three.setParam('Distortion Route', 0);
~three.setParam('Bus 3', 60);


~three.addFunc('303a', 'distchange', {|track, val|
	track.setParam('Distortion Preamp', val.lincurve(0, 100, 30, 115, 4));
	track.setParam('Distortion Clip', val.lincurve(0, 100, 70, 45, 4));
	track.setParam('Distortion Size', val.lincurve(0, 100, 64, 115, 4));
	track.setParam('Distortion Density', val.lincurve(0, 100, 127, 100, 4));
	track.setParam('Distortion Wetness', val.lincurve(0, 100, 100, 80, 4));
	track.setParam('Distortion Brightness', val.lincurve(0, 100, 0, 70, 4));
});

~three.addFunc('303b', 'envchange', {|track, val|
	track.setParam('Env Attack', val.lincurve(0, 100, 30, 120, 2));
	track.setParam('Env Mod', val.lincurve(0, 127, 30, 120, 2));
	track.setParam('Tuning', val.round(64).clip(64, 127));
	track.setParam('echovol', val.lincurve(80, 127, 0, 80, 2));
	track.setParam('Slide Time', val.lincurve(0, 80, 50, 0, 2));
});


~eight = x.addTrack('808_1', 2, '808_1');

~eight.on(13);

~eight.setParam('Send 1', 90);
~eight.setParam('Hi Conga Tunning', 90);
~eight.setParam('Mid Conga Tunning', 90);
~eight.setParam('Low Conga Tunning', 90);
~eight.setParam('Low Tom Tunning', 100);
~eight.setParam('Low Tom Decay', 100);
~eight.setParam('Low Tom Snappy', 100);

~eight.setParam('Snare Drum Level', 70);
~eight.setParam('Snare Drum Tone', 100);
~eight.setParam('Snare Drum Decay', 80);
~eight.setParam('Snare Drum Snappy', 110);
~eight.setParam('Rim Shot Level', 90);
~eight.setParam('Rim Shot Tunning', 40);
~eight.setParam('Rim Shot Decay', 110);
~eight.setParam('Maracas Level', 90);
~eight.setParam('Maracas Tone', 30);
~eight.setParam('Hand Clap Level', 100);
~eight.setParam('Cow Bell Level', 100);
~eight.setParam('Cow Bell Tunning', 110);
~eight.setParam('Cow Bell Decay', 110);
~eight.setParam('Laser Gun Level', 90);
~eight.setParam('Laser Gun Tone', 90);
~eight.setParam('Laser Gun Decay', 90);
~eight.setParam('Cymbal Tone', 90);
~eight.setParam('Cymbal Decay', 90);

~eight.addFunc('808a', 'tomroll', {|track, val|
	['Hi Conga Level', 'Mid Conga Level',
	'Low Conga Level', 'Low Tom Level'].do {|paramKey, i|
		track.setParam(paramKey, val.linlin(30, 100, 0, 85))
	};

	if(val < 10) {
		track.setParam('Bass Drum Level', 30);
	} {
		track.setParam('Bass Drum Level', 64);
	};
});

~eight.addFunc('808b', 'hiend', {|track, val|
	track.setParam('Maracas Level', val.lincurve(0, 50, 0, 127, 2));
	['Snare Drum Level', 'Rim Shot Level', 'Hand Clap Level',
	'Cow Bell Level', 'Laser Gun Level', 'Cymbal Level',
	'Claves Level'].do {|paramKey, i|
		track.setParam(paramKey, val.lincurve(30, 100, 0, 100, 2));
	};
});
