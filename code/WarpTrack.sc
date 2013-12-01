WarpTrack {
	var <parent;
	var <key;
	var <>midiChannel;
	var <notes;
	var <params;
	var <>patternTrack;
	var <sensorFuncs;

	*new {|argParent, argKey, argMidiChannel|
		^super.new.init(argParent, argKey, argMidiChannel);
	}

	init {|argParent, argKey, argMidiChannel|
		parent = argParent;
		key = argKey;
		midiChannel = argMidiChannel;
		notes = Set[];
		params = IdentityDictionary[];
		patternTrack = true;
		sensorFuncs = IdentityDictionary[];
	}

	on {|note, quant=4|

		if(patternTrack) {
			this.allOff();
		} {
			this.off(note);
		};

		notes.add(note);

		{
			parent.noteOn(midiChannel, note, 127);
		}.fork(parent.clock, quant:quant);
	}

	off {|note, quant=1|
		notes.remove(note);
		{
			parent.noteOff(midiChannel, note, 0);
		}.fork(parent.clock, quant:quant);
	}

	hit {|note=60, vel=127, dur=1|
		{
			parent.noteOn(midiChannel, note, vel);
			dur.wait;
			parent.noteOff(midiChannel, note, vel);
		}.fork(parent.clock);
	}

	allOff {
		notes.do {|note, i|
			this.off(note);
		}
	}

	assign {|paramKey, num|
		if(num.notNil) {
			if(parent.isControlAvailable(num)) {
				params[paramKey] = num;
				parent.setControl(num, paramKey);
				{
					parent.control(midiChannel, num, 127);
					0.1.wait;
					parent.control(midiChannel, num, 0);
				}.fork;
				paramKey ++ " assigned to controlNum " ++ num;
			} {
				("this controlNum " ++ num ++ " is already assigned!").postln;
			};
		} {
			parent.assign(key, paramKey);
		};
	}

	setParam {|paramKey, val|
		parent.control(midiChannel, params[paramKey], val);
	}

	loadPreset {|preset|
		preset.params.keysValuesDo { |paramKey, num|
			this.assign(paramKey, num.asInteger);
		};
	}

	sensor {|val|
		sensorFuncs.do {|func, i|
			func.(this, val);
		}
	}

	addFunc {|key, func|
		sensorFuncs[key] = func;
	}

	removeFunc {|key|
		sensorFuncs[key] = nil;
	}
}