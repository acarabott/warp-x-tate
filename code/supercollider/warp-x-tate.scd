// Create necessary objects
x = WarpTate();
y = WarpUtil(x);

(
// Load sections from presets
~sections = [];
~tempos = [120, 111, 132];

~presets = (Platform.userExtensionDir ++ "/warp-x-tate/presets/*.trackpreset").pathMatch;
~presets.do {|path, i|
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

// calibrate each sensor, run the code then move hand furthest and closest
// required distance

y.curSensor = '808a';
// y.curSensor = '808b';
// y.curSensor = '303a';
// y.curSensor = '303b';
y.calibrate;
y.stopCalibrate;


// Play the tunes.
x.tracks;	// check the tracks
x.play;		// play