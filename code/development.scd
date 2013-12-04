// not playing on load...
x = WarpTate();

// three i like... 12, 24
// tuning works well on 24
// 37


w = Window("Fake Sensors", Rect(100, 100, 400, 300)).front;
w.view.addFlowLayout;

~sliders = ["303a", "303b", "808a", "808b"].collect {|sensorKey, i|
	var slider = EZSlider(w, 280@20, label:sensorKey);

	slider.action_({|ez|
		NetAddr.localAddr.sendMsg("/prox/" ++ sensorKey, ez.value * 100);
	});
};

~start = nil;
~rec = List[];
~prev = 0;
~sliders[0].action_({|ez|
	if(~start.isNil) {
		~start = Main.elapsedTime;
		"~start: ".post; (~start).postln;
	};

	~now = Main.elapsedTime - ~start;
	~wait = (Main.elapsedTime - ~start) - ~prev;

	~rec.add([~wait, ez.value]);
	~wait.postln;

	~prev = ~now;
});

z = {
	~rec.do {|item, i|
		var wait = item[0],
			val = item[1];

		~sliders[0].value = val;
		wait.wait;
	}
}.fork(AppClock);


x = WarpTate();

~three.assign('vibe', learn:true);

~three.addFunc('303b', 'vibe', {|track, val|
	track.setParam('vibe', val.linlin(0, 50, 0, 90));
});
~three.save

~three = x.loadTrack('303_1', "~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);
~eightone = x.loadTrack('808_1', "~/Projects/13-11_warp/code/presets/808_1.trackpreset".standardizePath);
~eighttwo = x.loadTrack('808_2', "~/Projects/13-11_warp/code/presets/808_2.trackpreset".standardizePath);

~eightone.settings['params']['snareverb']

~eightone.on(14);
~eighttwo.on(13);
~eighttwo.settings['params']

x.tracks['303_1'].on(24)

x.tracks['303_1'].initParams();
x.tracks['303_1'].settings['paramControls']

~preset = Object.readArchive("~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);

x.tracks['303_1'].settings['params'] = WarpTrack.defaults['303']['params']


x.tracks['303_1'].save

x.loadTrack('303_1', "~/Desktop/test.trackpreset".standardizePath);

~preset = Object.readArchive("~/Desktop/test.trackpreset".standardizePath);

~preset['params']

x.tracks['303_1']
~preset.keys.reject{ |settingKey, i| ['notes', 'paramControls'].includes(settingKey)}.do {|presetKey, i|

}


s.boot;

r = Routine {
	inf.do {|i|
		Synth(\beep, [\freq, [1320, 880, 880, 880].wrapAt(i), \amp, 0.2, \pan, 0, \out, 0]);
		1.wait;
	}
};

r.play(quant:4);




TempoClock.default.schedAbs(TempoClock.default.nextBar - 0.5, {Synth(\beep, [\freq, 440, \amp, 0.2, \pan, 0, \out, 0]);})

TempoClock.default.beats2bars(3.5)
this.bars2beats(this.beats2bars(beat).ceil);

(TempoClock.beats % TempoClock.beatsPerBar) +

(TempoClock.bar * TempoClock.beatsPerBar) + .postln; TempoClock.beats.postln;

TempoClock.beats + (TempoClock.timeToNextBeat(quant) - 0.1)