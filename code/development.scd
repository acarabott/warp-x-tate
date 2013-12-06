x = WarpTate();
y = WarpUtil(x);

(
~sections = [];
~tempos = [120, 111, 132];
"~/Projects/13-11_warp/code/presets/final/*.trackpreset".standardizePath.pathMatch.do {|path, i|
	var index = path.basename[0..1].asInteger,
		new;

	if(index > (~sections.size - 1)) {
		new = Array.newClear(index + 1);
		~sections.do {|section, i|
			new[i] = section;
		};

		~sections = new;
		~sections[index] = List[];
	};
	~sections[index].add(Object.readArchive(path));
};
)

~sections.do {|section, i|
	x.addSection(i, ~tempos[i], section);
}

x.tracks
x.play

y.curSensor = '808b';
y.calibrate;
y.stopCalibrate;


~track.save;

// phuture
// daft punk
// higher state
// 24 - 12 = 12
// 17 - 12 = 5
// 53 - 12 = 41
// 71 - 12 = 59
// 12 - 12 = 0

// maybe 19




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