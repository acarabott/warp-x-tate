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
