// not playing on load...
x = WarpTate();

~three = x.loadTrack('303', "~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);

~eight = x.addTrack('808', 2, '808');

// three i like... 12, 24
// tuning works well on 24
~three.on(36);

~three.setParam('Tuning', 0.5 * 127)

~three.addFunc('303b', 'tuning', {|track, val|

	track.setParam('Tuning', val.linlin(0, 127, 64, 127).round((64/3)).min(127));
});

~eight.on(24);

~eightKick = x.addTrack('808kick', 3, '808');

~eightKick.initParams();
~eightKick.setParam('Bass Drum Decay', 128*0.75)

~eightKick.settings['fourOn'] = false;

~eightKick.addFunc('808a', 'kick', {|track, val|
	if(val >= 0.25 && track.settings['fourOn'].not) {
		track.on(13, 1);
		track.settings['fourOn'] = true;
	};
	if(val < 0.25 && track.settings['fourOn']) {
		track.on(12, 1);
		track.settings['fourOn'] = false;
		track.parent.clock.playNextBar({
			track.on(12, 1);
		});
	};
});

c = EZSlider(w, 280@20, label:"label");
c.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/808a", ez.value * 100);
});

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

~eight = x.addTrack('808', 2, '808');
~eight.assign(){|paramKey, num, learn=false|

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


