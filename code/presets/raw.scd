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
