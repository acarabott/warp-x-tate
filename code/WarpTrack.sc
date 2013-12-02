// A WarpTrack represents a single layer in an interaction
// e.g. a 303 playing patterns
//

WarpTrack {
	classvar <defaults;

	var <parent;
	var <key;
	var <sensorFuncs;
	var <settings;

	*initClass {
		defaults = IdentityDictionary[
			'303' -> IdentityDictionary[
				'paramControls' -> IdentityDictionary[
					'tuning' -> 9,
					'slidetime' -> 14,
					'cutoff' -> 15,
					'res' -> 16,
					'sweep' -> 17,
					'envmod' -> 18,
					'envatt' -> 19,
					'envdec' -> 20,
					'accdec' -> 21,
					'envacc' -> 22,
					'accvol' -> 23,
					'steplen' -> 24,
					'distpre' -> 27,
					'distsize' -> 28,
					'distden' -> 29,
					'distclip' -> 30,
					'distwet' -> 31,
					'distbright' -> 32,
					'waveform' -> 3,
					'diston' -> 25,
					'distmode' -> 26,
					'vol' -> 33,
				],
				'params' -> IdentityDictionary[
					'tuning' 		-> 64,
					'slidetime' 	-> 64,
					'cutoff' 		-> 90,
					'res' 			-> 127,
					'sweep' 		-> 127,
					'envmod' 		-> 0,
					'envatt' 		-> 0,
					'envdec' 		-> 0,
					'accdec' 		-> 0,
					'envacc' 		-> 30,
					'accvol' 		-> 3,
					'steplen' 		-> 77,
					'distpre' 		-> 51,
					'distsize' 		-> 110,
					'distden' 		-> 23,
					'distclip' 		-> 55,
					'distwet' 		-> 127,
					'distbright' 	-> 71,
					'waveform' 		-> 30,
					'diston' 		-> 127,
					'distmode' 		-> 23,
					'vol' 			-> 127
				]
			],
			'808' -> IdentityDictionary[
				'params' -> IdentityDictionary[],
				'paramControls' -> IdentityDictionary[]
			]
		];
	}

	*new {|argParent, argKey, argMidiChannel, argType|
		^super.new.init(argParent, argKey, argMidiChannel, argType);
	}

	*read {|argParent, argKey, path|
		^super.new.init(argParent, argKey).loadPreset(path);
	}

	init {|argParent, argKey, argMidiChannel, argType|
		parent = argParent;
		key = argKey;

		settings = IdentityDictionary[
			'midiChannel'	-> argMidiChannel,
			'notes'			-> Set[],
			'params'		-> IdentityDictionary[],
			'paramControls'	-> IdentityDictionary[],
			'patternTrack'	-> true,
			'sensorFuncs'	-> IdentityDictionary[];
		];

		if(argType.notNil) {
			settings['type'] = argType;
			if(WarpTrack.defaults.keys.includes(argType)) {
				['paramControls', 'params'].do {|key, i|
					settings[key] = WarpTrack.defaults[argType][key];
				}
			};

			this.initParams();
		};
	}

	on {|note, quant=4|

		if(settings['patternTrack']) {
			this.allOff();
		} {
			this.off(note);
		};

		settings['notes'].add(note);

		{
			parent.noteOn(settings['midiChannel'], note, 127);
		}.fork(parent.clock, quant:quant);
	}

	off {|note, quant=1|
		settings['notes'].remove(note);
		{
			parent.noteOff(settings['midiChannel'], note, 0);
		}.fork(parent.clock, quant:quant);
	}

	hit {|note=60, vel=127, dur=1|
		{
			parent.noteOn(settings['midiChannel'], note, vel);
			dur.wait;
			parent.noteOff(settings['midiChannel'], note, vel);
		}.fork(parent.clock);
	}

	allOff {
		settings['notes'].do {|note, i|
			this.off(note);
		}
	}

	assign {|paramKey, num, learn=false|
		if(num.notNil) {
			this.assignAll(IdentityDictionary[paramKey -> num], learn);
		} {
			parent.assign(key, paramKey);
		};
	}

	assignAll {|paramControls, learn=false, callback|
		var action = {
			paramControls.keysValuesDo { |paramKey, num|
				if(parent.isControlAvailable(num)) {
					settings['paramControls'][paramKey] = num;
					parent.setControl(num, paramKey);
					if(learn) {
						parent.control(settings['midiChannel'], num, 127);
						0.05.wait;
						parent.control(settings['midiChannel'], num, 0);
					};
					paramKey ++ " assigned to controlNum " ++ num;
				} {
					("this controlNum " ++ num ++ " is already assigned!").postln;
				};
			};

			callback.();
		};

		if(learn) {
			{
				action.();
			}.fork;
		} {
			action.();
		};

	}

	initParams {
		settings['params'].keysValuesDo { |key, value|
			this.setParam(key, value);
		};
	}

	setParam {|paramKey, val|
		parent.control(settings['midiChannel'], settings['paramControls'][paramKey], val);
	}

	loadPreset {|path|
		var preset = Object.readArchive(path);

		{
			settings['midiChannel'] 	= preset['midiChannel'];
			settings['sensorFuncs'] 	= preset['sensorFuncs'];
			settings['patternTrack'] 	= preset['patternTrack'];
			settings['params'] 			= preset['params'];

			if(settings['patternTrack']) {
				settings['notes'] = preset['notes'];
			};

			this.assignAll(preset['paramControls'], false);

			this.initParams();
			this.on(settings['notes'].asArray[0]);

		}.fork;
	}

	sensor {|val|
		settings['sensorFuncs'].do {|func, i|
			func.(this, val);
		}
	}

	addFunc {|funcKey, func|
		settings['sensorFuncs'][funcKey] = func;
	}

	removeFunc {|funcKey|
		settings['sensorFuncs'][funcKey] = nil;
	}

	save {
		Dialog.savePanel({|path|
			settings.writeArchive(path);
		});
	}
}