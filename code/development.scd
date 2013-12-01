x = WarpTate();
~three = x.addTrack('303', 0, '303a');
x.addTrack('808', 1);
x.addTrack('808hits', 2);

x.on('303', 24);
x.assign('303', 'cutoff', 3);
x.assign('303', 'preamp', 8);
x.assign('303', 'clip', 9);
x.assign('303', 'res', 14);
x.assign('303', 'tuning');



x.tracks['303'].addFunc('filter', {|val|
	x.setParam('303', 'cutoff', val);
	x.setParam('303', 'res', val.linlin(0, 127, 50, 110));
	x.setParam('303', 'clip', val.linlin(0, 127, 50, 30));
	x.setParam('303', 'preamp', val.linlin(0, 127, 50, 30));
});

x.tracks['303'].removeFunc('filter');


a = EZSlider(w, 280@20, label:"label");
a.action_({|ez|
	NetAddr.localAddr.sendMsg("/prox/303a", ez.value * 100);
});


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

x.availableControls.size


~three.assign('tranup');

~three.params.keysValuesDo { |key, value|
	key.postln;
	value.postln;
};

~three.params.writeArchive("/Volumes/Data/Users/arthurc/Projects/13-11_warp/code/presets/303a.params");

~three.loadParams("/Volumes/Data/Users/arthurc/Projects/13-11_warp/code/presets/303a.params");
~three.params

~three.setParam('cutoff', 0);


// Preset...

// Set the synth params
// play the correct note
// Setup the interactions

