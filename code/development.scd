// not playing on load...
x = WarpTate();

~three.settings['type']
~three = x.loadTrack('303_1', "~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);
~three.setParam('Tuning', 0.5 * 127)

~three.addFunc('303b', 'tuning', {|track, val|

	track.setParam('Tuning', val.linlin(0, 127, 64, 127).round((64/3)).min(127));
});

~eight = x.addTrack('808_1', 2, '808');
~eight.assign('snareverb', 89);
~eight.settings['params']['snareverb'] = 0;
~eight.addFunc('808b','snareverb', {|track, val|
	track.setParam('snareverb', val.linlin(0, 127, 0, 90));
});

~eightKick = x.addTrack('808kick', 3, '808');
~eightKick.settings['fourOn'] = false;


~eightKick = x.loadTrack('808kick', "~/Desktop/kicktest.trackpreset".standardizePath);

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
~eightKick.settings['sensorFuncs']['808a']['kick']

~eightKick.save

~eight.settings['paramControls']['snareverb']


// three i like... 12, 24
// tuning works well on 24
// 37
~three.on(rrand(12, 107).postln);



~eight.on(14);

~eight.on(14);

~eight.settings['midiChannel']
~eight.assign('snareverb', learn:true);
~eight.setParam('snareverb', 127);

~eight.addFunc('808b','snareverb', {|track, val|
	track.setParam('snareverb', val.linlin(0, 127, 0, 90));
});


~eightKick = x.addTrack('808kick', 3, '808');

~eightKick.initParams();
~eightKick.setParam('Bass Drum Decay', 128*0.75)



~eightKick.setParam('Bass Drum Level', 0, 1);

~eightKick.setParam('Bass Drum Level', 64, 4);




c = EZSlider(w, 280@20, label:"label");

c.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/808a", ez.value * 100);
});


128*0.25

~eightKick.on(13, 1);


~eightKick.on(12, 1);

x.clock.playNextBar({
	~eightKick.on(12, 1);
});

{

	}.fork(x.clock, )


WarpTrack.defaults['808']['paramControls'].keys.select {|key| key.asString.contains("Bass")}

"hihihi".contains("i")

// Turn down the kick after hit
// Turn down kick channel after hit
// Trigger from SC
// Second pattern 808
	//





0.6.round(0.1)


x.out.noteOff(14, 2, 124)
x.out.allNotesOff(3);
~eight.on(14);

~eight.off(16);

~three.save

~three.addFunc('3031', 'wank', {|track, val|
	track.setParam('Env Mod', val);
});

a = EZSlider(w, 280@20, label:"label");
a.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/303a", ez.value * 100);
});

~three.settings['sensorFuncs']['303b'].removeAt('wank');

b = EZSlider(w, 280@20, label:"label");
b.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/303b", ez.value * 100);
});

~three.save


~eight.on(14);
~eight.off(14);

x.availableControls[3].size
// 808 32 resting



~three.settings['notes'].asArray[0]

~four = Routine {
	inf.do {|i|
		x.hit('808hits', 35, 127);
		1.wait;
	};
};

~four.stop
~four.play(x.clock, quant:1);


Tdef(\snarerush).stop;

Tdef(\snarerush, {
	1.wait;
	inf.do {|i|
		x.hit('808hits', 39);
		2.wait;
	}
}).play(x.clock, quant:Quant(1));



~preset = Object.readArchive("~/Desktop/kicktest.trackpreset".standardizePath);

// ~eight = x.addTrack('808_1', 2, '808');
~eight = WarpTrack(x, '808_1');

~preset.keys.reject({|settingKey, i|
	['notes', 'paramControls'].includes(settingKey);
}).do {|presetKey, i|
	~eight.settings[presetKey] = ~preset[presetKey].postln;
};

~eight.assignAll(~preset['paramControls'], false);
~eight.initParams();
~eight.settings['notes'].asArray[0]

