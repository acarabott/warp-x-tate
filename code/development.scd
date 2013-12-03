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


// x = WarpTate();

// x.loadTrack('303_1', "~/Projects/13-11_warp/code/presets/303_1.trackpreset".standardizePath);
// x.loadTrack('808_1', "~/Projects/13-11_warp/code/presets/808_1.trackpreset".standardizePath);
// x.loadTrack('808_2', "~/Projects/13-11_warp/code/presets/808_2.trackpreset".standardizePath);