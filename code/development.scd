x = WarpTate();


~three = x.loadTrack('303', '303a', "~/Projects/13-11_warp/code/presets/303a.trackpreset".standardizePath);

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