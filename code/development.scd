x = WarpTate();

~three = x.readTrack("~/Projects/13-11_warp/code/presets/final/00_303_1_acidtracks.trackpreset".standardizePath);
~eight = x.readTrack("~/Projects/13-11_warp/code/presets/final/00_808_1_acidtracks.trackpreset".standardizePath);

x.doAdjusts.do {|adjust, i|
	x.doAdjusts[i] = false;
}

~three_1.setParam('Cutoff', 90.lincurve(0, 127, 20, 127, 2));
~three_1.setParam('Bus 2', 90.lincurve(30, 127, 0, 90, 2));
~three_1.setParam('Env Mod', 90.lincurve(0, 100, 50, 100, 2));
~three_1.setParam('Env Attack', 90.lincurve(0, 100, 50, 100, 2));
~three_1.setParam('Tuning', 90.round(63.5/2).max(64));
~three_1.setParam('Distortion Preamp', 90.lincurve(0, 127, 40, 100, 2));
~three_1.setParam('Distortion Clip', 90.lincurve(0, 127, 90, 45, 2));
~three_1.setParam('Distortion Size', 90.lincurve(0, 127, 50, 85, 2));
~three_1.setParam('Distortion Density', 90.lincurve(0, 127, 30, 90, 2));

~three_1.on(12);

x.doAdjusts[x.sensorKeys.indexOf('808b')] = false;

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

~eight.save




~three_1.settings['sensorFuncs'] = IdentityDictionary[]

~three_1.setParam('Tuning', 64);

// upper end
~three_1.setParam('Distortion Preamp', 100);
~three_1.setParam('Distortion Clip', 45);
~three_1.setParam('Distortion Size', 85);
~three_1.setParam('Distortion Density', 90);

// lower end
~three_1.setParam('Distortion Preamp', 20);
~three_1.setParam('Distortion Clip', 110);
~three_1.setParam('Distortion Size', 50);
~three_1.setParam('Distortion Density', 30);







// 303b acid tracks fixed params
~three_1.setParam('Distortion Brightness', 64);
~three_1.setParam('Distortion Wetness', 50);



~three_1.setParam('Cutoff', 0);
~three_1.setParam('Bus 2', 0);
~three_1.setParam('Env Mod', 50);
~three_1.setParam('Env Attack', 50);


x.tempo = 120

x.doAdjusts[0] = false;

(
if(w.notNil){w.close};
w = Window("Sensor Inspector", Rect(100, 100, 400, 300)).front;
w.view.addFlowLayout;

~texts = IdentityDictionary[];
~sensor = '808a';
['sensorVals', 'sensorPrevs', 'sensorMins',
'sensorMaxs'].do {|label, i|
	StaticText(w, (w.bounds.width * 0.5)@20)
		.string_(label.asString);
	w.view.decorator.nextLine;
	~texts[label] = StaticText(w, (w.bounds.width / 2)@40)
		.string_("\t" ++ x.perform(label)[x.sensorKeys.indexOf(~sensor)]);
	w.view.decorator.nextLine;
};
~slider = EZSlider(w, 280@20, label:~sensor.asString);


Tdef(\foo, {
	inf.do {|i|
		var index = x.sensorKeys.indexOf(~sensor);
		['sensorVals', 'sensorPrevs', 'sensorMins', 'sensorMaxs'].do {|label, i|
			~texts[label]
				.string_("\t" ++ x.perform(label)[index]);
		};

		~slider.value = x.sensorVals[index].linlin(
			x.sensorMins[index],
			x.sensorMaxs[index],
			0,
			1
		);
		0.05.wait;
	}
}).play(AppClock);

);

x.sensorMaxs[x.sensorKeys.indexOf('303a')];

x.sensorMaxAdj = 0.01
x.sensorMinAdj = 0.001







~three = x.readTrack("~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);
~eightone = x.readTrack("~/Projects/13-11_warp/code/presets/808_1.trackpreset".standardizePath);

x.addSection(0, 120, ~three.settings, ~eightone.settings);

~threetwo = ~three.settings.copy;
~threetwo['params']['Distortion Clip'] = 10;
~eighttwo = ~eightone.settings.copy;
~eighttwo['params']['Main Volume'] = 90;

x.addSection(1, 140, ~threetwo, ~eighttwo);

x.sections[0].keys

{
	x.sections.do {|section, i|
		x.tempo = section['tempo'];
		['303_1', '808_1'].do {|trackKey, j|
			x.tracks[trackKey].loadPreset(section[trackKey], false);
		};
		16.wait;
	}
}.fork;
// TODO at error wtf
// TODO addsection has 'tempo' and 'tracks'

~three.settings

~eightonePreset = Object.readArchive("~/Projects/13-11_warp/code/presets/808_1.trackpreset".standardizePath);

~eightonePreset['key'] = '808_1'

~eighttwoPreset = Object.readArchive("~/Projects/13-11_warp/code/presets/808_2.trackpreset".standardizePath);
~eighttwoPreset['key'] = '808_2'



~eighttwo = x.readTrack("~/Projects/13-11_warp/code/presets/808_2.trackpreset".standardizePath);

nil.writeArchive("~/Desktop/fuck.test".standardizePath);
~eightonePreset.writeArchive("~/Projects/13-11_warp/code/presets/808_1.trackpreset".standardizePath)

~eighttwoPreset.writeArchive("~/Projects/13-11_warp/code/presets/808_2.trackpreset".standardizePath)

// phuture
// daft punk
// higher state
// 24 - 12 = 12
// 17 - 12 = 5
// 53 - 12 = 41
// 71 - 12 = 59
// 12 - 12 = 0

// maybe 19

~eightone.on(51);
~three.on(12);

~eight.on(51);




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


w = Window("Fake Sensors", Rect(100, 100, 400, 300)).front;
w.view.addFlowLayout;

x.doAdjusts[x.sensorKeys.indexOf('303b')] = false;
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


~eightone.settings['params']['snareverb']


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





x = WarpTate();

~three_1 = x.addTrack('303_1', 0, '303');
~three_1.initParams();

~three_1.on(24);
~three_1.setParam('Distortion State', 0);
~three_1.setParam('Cutoff', 110);
~three_1.setParam('Resonance', 100);
~three_1.setParam('Env Mod', 100);
~three_1.setParam('Env Attack', 100);


~three_1.addFunc('303a', 'step', {|track, val|
	track.setParam('Step Length', val);
});

~three_1.removeFunc('303a', 'cutoff');

~three_1.save

w = Window("Fake Sensors", Rect(100, 100, 400, 300)).front;
w.view.addFlowLayout;

~sliders = ["303a", "303b", "808a", "808b"].collect {|sensorKey, i|
	var slider = EZSlider(w, 280@20, label:sensorKey);

	slider.action_({|ez|
		NetAddr.localAddr.sendMsg("/prox/" ++ sensorKey, ez.value * 100);
	});
};

~eight_1 = x.addTrack('808_1', 2, '808');
~eight_1.on(51);
~eight_1.setParam('Hand Clap Level', 127);
~eight_1.setParam('Hand Clap Level', 127)

~eight_1.addFunc('808a', 'clapverb', {|track, val|
	track.setParam('Hand Clap Reverb', val);
});

~eight_1.save

~eight_2 = x.addTrack('808_1', 2, '808');

~eight_2.on(51);
~eight_2.setParam('Bass Drum Decay', 127);
~eight_2.setParam('Bass Drum Sweep', 127);

~eight_2.assign('snarebig', 89, false);

~eight_2.addFunc('808a', 'clapverb', {|track, val|
	track.setParam('snarebig', val.linlin(0, 127, 0, 90));
});

~eight_2.save

x = WarpTate();

~presets = IdentityDictionary[];

"~/Projects/13-11_warp/code/presets/seq/*".standardizePath.pathMatch.sort.do {|path, i|
	var name = path.basename.splitext[0],
		key = name.asSymbol,
		preset = Object.readArchive(path);

	~presets.add(key -> preset);

};


x.sections.add([~presets['00_808_1'], ~presets['00_303_1']]);
x.sections.add([~presets['01_808_1'], ~presets['01_303_1']]);

x.addTrack('303_1', 0, '303');
x.addTrack('808_1', 2, '808');

{
	x.sections.do {|section, i|
		x.tracks['303_1'].loadPreset(section[0], false);
		x.tracks['808_1'].loadPreset(section[1], false);

		"change".postln;
		16.wait;
	}
}.fork;

x.tracks['303_1'].loadPreset(~presets['00_303_1'], false)

x.tracks['808_1'].loadPreset(~presets['00_808_1'], false)


x.control(2, 3, 100);

x.out.control(15, 3, 120 - 50);

120

x.tracks['303_1']


x.tempo = 120