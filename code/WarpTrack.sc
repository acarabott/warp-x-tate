WarpTrack {
	classvar <defaults;

	var <parent;
	var <key;
	var <settings;

	*initClass {
		defaults = IdentityDictionary[
			'303' -> IdentityDictionary[
				'paramControls' -> IdentityDictionary[
					'Tuning' -> 3,
					'Slide Time' -> 9,
					'Cutoff' -> 14,
					'Resonance' -> 15,
					'Sweep Time' -> 16,
					'Env Mod' -> 17,
					'Env Attack' -> 18,
					'Env Decay' -> 19,
					'Accent Decay' -> 20,
					'Env Accent' -> 21,
					'Accent Volume' -> 22,
					'Step Length' -> 23,
					'Distortion Preamp' -> 24,
					'Distortion Size' -> 25,
					'Distortion Density' -> 26,
					'Distortion Clip' -> 27,
					'Distortion Wetness' -> 28,
					'Distortion Brightness' -> 29,
					'Waveform' -> 30,
					'Accent Mode' -> 31,
					'Sweep Mode' -> 32,
					'Distortion State' -> 33,
					'Distortion Route' -> 34,
					'Main Volume' -> 35,
					'Arpe Chord' -> 36,
					'Arpe Mode' -> 37,
					'Arpe Shuffle' -> 38,
					'Arpe Range Sub 1' -> 39,
					'Arpe Range Zero' -> 40,
					'Arpe Range Add 1' -> 41,
					'Arpe Range Add 2' -> 42,
					'Arpe Multiplier' -> 43,
					'Arpe Repeater' -> 44
				],
				'params' -> IdentityDictionary[
					'Tuning' -> 64,
					'Slide Time' -> 64,
					'Cutoff' -> 90,
					'Resonance' -> 127,
					'Sweep Time' -> 127,
					'Env Mod' -> 0,
					'Env Attack' -> 0,
					'Env Decay' -> 0,
					'Accent Decay' -> 0,
					'Env Accent' -> 30,
					'Accent Volume' -> 3,
					'Step Length' -> 76,
					'Distortion Preamp' -> 51,
					'Distortion Size' -> 110,
					'Distortion Density' -> 23,
					'Distortion Clip' -> 55,
					'Distortion Wetness' -> 126,
					'Distortion Brightness' -> 70,
					'Waveform' -> 29,
					'Accent Mode' -> 0,
					'Sweep Mode' -> 127,
					'Distortion State' -> 127,
					'Distortion Route' -> 23,
					'Main Volume' -> 95,
					'Arpe Chord' -> 0,
					'Arpe Mode' -> 0,
					'Arpe Shuffle' -> 0,
					'Arpe Range Sub 1' -> 127,
					'Arpe Range Zero' -> 127,
					'Arpe Range Add 1' -> 127,
					'Arpe Range Add 2' -> 127,
					'Arpe Multiplier' -> 0,
					'Arpe Repeater' -> 0
				]
			],
			'808' -> IdentityDictionary[
				'params' -> IdentityDictionary[
					'Bass Drum Level' -> 64,
					'Snare Drum Level' -> 64,
					'Low Conga Level' -> 64,
					'Mid Conga Level' -> 64,
					'Hi Conga Level' -> 64,
					'Low Tom Level' -> 64,
					'Mid Tom Level' -> 64,
					'Hi Tom Level' -> 64,
					'Claves Level' -> 64,
					'Rim Shot Level' -> 64,
					'Maracas Level' -> 64,
					'Hand Clap Level' -> 64,
					'Cow Bell Level' -> 64,
					'Laser Gun Level' -> 64,
					'Cymbal Level' -> 64,
					'Open Hi Hat Level' -> 64,
					'Closed Hi Hat Level' -> 64,
					'Accent Level' -> 64,
					'Bass Drum Tone' -> 64,
					'Bass Drum Decay' -> 64,
					'Bass Drum Sweep' -> 64,
					'Snare Drum Tone' -> 64,
					'Snare Drum Decay' -> 64,
					'Snare Drum Snappy' -> 64,
					'Low Conga Tunning' -> 64,
					'Low Conga Decay' -> 64,
					'Mid Conga Tunning' -> 64,
					'Mid Conga Decay' -> 64,
					'Hi Conga Tunning' -> 64,
					'Hi Conga Decay' -> 64,
					'Low Tom Tunning' -> 64,
					'Low Tom Decay' -> 64,
					'Low Tom Snappy' -> 127,
					'Mid Tom Tunning' -> 64,
					'Mid Tom Decay' -> 64,
					'Mid Tom Snappy' -> 127,
					'Hi Tom Tunning' -> 64,
					'Hi Tom Decay' -> 64,
					'Hi Tom Snappy' -> 127,
					'Claves Tunning' -> 64,
					'Claves Decay' -> 64,
					'Rim Shot Tunning' -> 64,
					'Rim Shot Decay' -> 64,
					'Maracas Tone' -> 64,
					'Hand Clap Tone' -> 64,
					'Hand Clap Reverb' -> 127,
					'Cow Bell Tunning' -> 64,
					'Cow Bell Decay' -> 127,
					'Laser Gun Depth' -> 127,
					'Laser Gun Decay' -> 127,
					'Laser Gun Sweep' -> 127,
					'Cymbal Tone' -> 64,
					'Cymbal Decay' -> 64,
					'Open Hi Hat Tone' -> 64,
					'Open Hi Hat Decay' -> 64,
					'Closed Hi Hat Tone' -> 64,
					'Closed Hi Hat Decay' -> 64,
					'Hi Hat Filters Freq' -> 64,
					'Main Volume' -> 127
				],
				'paramControls' -> IdentityDictionary[
					'Bass Drum Level' -> 3,
					'Snare Drum Level' -> 9,
					'Low Conga Level' -> 14,
					'Mid Conga Level' -> 15,
					'Hi Conga Level' -> 16,
					'Low Tom Level' -> 17,
					'Mid Tom Level' -> 18,
					'Hi Tom Level' -> 19,
					'Claves Level' -> 20,
					'Rim Shot Level' -> 21,
					'Maracas Level' -> 22,
					'Hand Clap Level' -> 23,
					'Cow Bell Level' -> 24,
					'Laser Gun Level' -> 25,
					'Cymbal Level' -> 26,
					'Open Hi Hat Level' -> 27,
					'Closed Hi Hat Level' -> 28,
					'Accent Level' -> 29,
					'Bass Drum Tone' -> 30,
					'Bass Drum Decay' -> 31,
					'Bass Drum Sweep' -> 32,
					'Snare Drum Tone' -> 33,
					'Snare Drum Decay' -> 34,
					'Snare Drum Snappy' -> 35,
					'Low Conga Tunning' -> 36,
					'Low Conga Decay' -> 37,
					'Mid Conga Tunning' -> 38,
					'Mid Conga Decay' -> 39,
					'Hi Conga Tunning' -> 40,
					'Hi Conga Decay' -> 41,
					'Low Tom Tunning' -> 42,
					'Low Tom Decay' -> 43,
					'Low Tom Snappy' -> 44,
					'Mid Tom Tunning' -> 45,
					'Mid Tom Decay' -> 46,
					'Mid Tom Snappy' -> 47,
					'Hi Tom Tunning' -> 48,
					'Hi Tom Decay' -> 49,
					'Hi Tom Snappy' -> 50,
					'Claves Tunning' -> 51,
					'Claves Decay' -> 52,
					'Rim Shot Tunning' -> 53,
					'Rim Shot Decay' -> 54,
					'Maracas Tone' -> 55,
					'Hand Clap Tone' -> 56,
					'Hand Clap Reverb' -> 57,
					'Cow Bell Tunning' -> 58,
					'Cow Bell Decay' -> 59,
					'Laser Gun Depth' -> 60,
					'Laser Gun Decay' -> 61,
					'Laser Gun Sweep' -> 62,
					'Cymbal Tone' -> 63,
					'Cymbal Decay' -> 80,
					'Open Hi Hat Tone' -> 81,
					'Open Hi Hat Decay' -> 82,
					'Closed Hi Hat Tone' -> 83,
					'Closed Hi Hat Decay' -> 85,
					'Hi Hat Filters Freq' -> 86,
					'Main Volume' -> 87,
				]
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
			'sensorFuncs'	-> IdentityDictionary[]
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
		{
			if(settings['patternTrack']) {
				this.allOff();
			} {
				this.off(note, quant);
			};
			settings['notes'].add(note);
			parent.noteOn(settings['midiChannel'], note, 127);
		}.fork(parent.clock, quant:quant);
	}

	off {|note, quant=1|
		{
			settings['notes'].remove(note);
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
			parent.assign(key, paramKey, learn);
		};
	}

	assignAll {|paramControls, learn=false, callback|
		var action = {
			var channel = settings['midiChannel'];

			paramControls.keysValuesDo { |paramKey, num|
				if(parent.isControlAvailable(channel, num)) {
					settings['paramControls'][paramKey] = num;
					parent.setControl(channel, num, paramKey);
					if(learn) {
						parent.control(channel, num, 127);
						0.05.wait;
						parent.control(channel, num, 0);
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
		settings['paramControls'].keysValuesDo { |key, value|
			parent.setControl(settings['midiChannel'], value, key);
		};
	}

	setParam {|paramKey, val, quant|
		var func = {
			parent.control(
				settings['midiChannel'],
				settings['paramControls'][paramKey],
				val
			);
		};

		if(quant.notNil) {
			{
				func.();
			}.fork(parent.clock, quant:quant);
		} {
			func.();
		};
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

	sensor {|sensorKey, val|
		settings['sensorFuncs'][sensorKey].do {|func, i|
			func.(this, val);
		}
	}

	addFunc {|sensorKey, funcKey, func|
		if(settings['sensorFuncs'].includesKey(sensorKey).not) {
			settings['sensorFuncs'][sensorKey] = IdentityDictionary[];
		};

		settings['sensorFuncs'][sensorKey][funcKey] = func;
	}

	removeFunc {|sensorKey, funcKey|
		settings['sensorFuncs'][sensorKey].removeAt(funcKey);

		if(settings['sensorFuncs'][sensorKey].isEmpty) {
			settings['sensorFuncs'].removeAt(sensorKey);
		};
	}

	availableControls {
		^parent.availableControls[settings['midiChannel']].copy;
	}

	save {
		Dialog.savePanel({|path|
			settings.writeArchive(path);
		});
	}
}