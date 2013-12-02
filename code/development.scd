x = WarpTate();

~three = x.loadTrack('303', '303a', "~/Projects/13-11_warp/code/presets/303a.trackpreset".standardizePath);

~three = x.addTrack('303_1', 0, '303');

~three.on(12);

~three.addFunc('303a', 'filter', {|track, val|
	track.setParam('Cutoff', val);
	track.setParam('Resonance', val.linlin(0, 127, 50, 110));
	track.setParam('Distortion Clip', val.linlin(0, 127, 80, 50));
	track.setParam('Distortion Preamp', val.linlin(0, 127, 80, 50));
});

~three.save
~three.addFunc('303b', 'wank', {|track, val|
	track.setParam('Env Mod', val);
});

a = EZSlider(w, 280@20, label:"label");
a.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/303a", ez.value * 100);
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


