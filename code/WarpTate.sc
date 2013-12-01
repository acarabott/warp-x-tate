WarpTate {
	var <sensorKeys;
	var <clock;
	var <tempo;
	var <out;
	var <tracks;
	var <sensorTracks;
	var <availableControls;
	var <controls;
	var <sensorVals;
	var <sensorPrevs;
	var <sensorMins;
	var <sensorMaxs;
	var <>sensorMinAdj;
	var <>sensorMaxAdj;

	*new {
		^super.new.init;
	}

	init {
		tempo = 120;
		clock = TempoClock.default
			.tempo_(2)
			.permanent_(true);

		MIDIClient.init;
		out = MIDIOut.newByName("IAC Driver", "Bus 1");
		out.latency = 0;

		tracks = IdentityDictionary[];
		sensorKeys = ['303a', '303b', '808a', '808b'];
		sensorTracks = IdentityDictionary.newFrom([sensorKeys, List[]!4].lace);

		availableControls = (0..120).reject({|item, i|
			[ 0, 1, 2, 4, 5, 6, 7, 8, 10, 11, 12, 13, 64, 65, 66, 67, 68, 69,
			70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 84, 91, 92, 93, 94, 95, 96,
			97, 98, 99, 100, 102 ].includes(item)
		});
		controls = IdentityDictionary[];

		this.addOSCdefs();

		CmdPeriod.add({this.stop});
	}

	tempo_ {|aTempo|
		tempo = aTempo;
		clock.tempo = tempo / 60;
	}

	addTrack {|trackKey, sensorKey, channel|
		^this.prAddTrack('new', trackKey, sensorKey);
	}

	loadTrack {|trackKey, sensorKey, path|
		^this.prAddTrack('read', trackKey, sensorKey, path);
	}

	prAddTrack {|call, trackKey, sensorKey, channel|
		tracks[trackKey] = WarpTrack.perform(call, this, trackKey, channel);

		if(sensorKey.notNil) {
			this.addTrackToSensor(trackKey, sensorKey);
		} {
			"Track not assigned to a sensor, make sure to do this later".postln;
		};

		^tracks[trackKey];
	}

	addTrackToSensor {|trackKey, sensorKey|
		sensorTracks[sensorKey].add(tracks[trackKey]);
	}

	removeTrack {|trackKey|
		tracks[trackKey].allOff();
		tracks[trackKey] = nil;
	}

	on {|trackKey, note, quant=1|
		tracks[trackKey].on(note, quant);
	}

	off {|trackKey, note, quant=1|
		tracks[trackKey].off(note, quant);
	}

	hit {|trackKey, note=60, vel=127, dur=1|
		tracks[trackKey].hit(note, vel, dur);
	}

	noteOn {|midiChannel, note, vel|
		out.noteOn(midiChannel, note, vel);
	}

	noteOff {|midiChannel, note, vel|
		out.noteOff(midiChannel, note, vel);
	}

	control {|midiChannel, num, val|
		out.control(midiChannel, num, val);
	}

	stop {
		tracks.do {|track|
			track.allOff();
			out.allNotesOff(track.channel);
		}
	}

	isControlAvailable {|controlNum|
		^controls.keys.includes(controlNum.asSymbol).not;
	}

	setControl {|num, key|
		controls[num.asSymbol] = key;
		availableControls.remove(num);
	}

	assign {|trackKey, paramKey, controlNum|
		if(controlNum.notNil && this.isControlAvailable(controlNum)) {
			tracks[trackKey].assign(paramKey, controlNum);
			availableControls.removeAt(0);
		} {
			if(availableControls.size > 0) {
				tracks[trackKey].assign(paramKey, availableControls[0]);
				availableControls.removeAt(0);
			} {
				"no controls left!".postln;
			};
		};

		"Don't forget to turn off MIDI learn".postln
	}

	setParam {|trackKey, paramKey, val|
		var track, param;

		if((track = tracks[trackKey]).notNil) {
			if(track.params[paramKey].notNil) {
				track.setParam(paramKey, val);
			} {
				"paramKey doesn't exist".postln;
			};
		} {
			"track key doesn't exist".postln;
		};
	}

	addOSCdefs {
		sensorVals = 0!sensorKeys.size;
		sensorPrevs = 0!sensorKeys.size;
		sensorMins = 9999!sensorKeys.size;
		sensorMaxs = 0!sensorKeys.size;
		sensorMinAdj = sensorMinAdj ?? { 0.005 };
		sensorMaxAdj = sensorMaxAdj ?? { 0.01 };

		sensorKeys.do {|sensorKey, i|
			OSCdef(("sensor_" ++ sensorKey).asSymbol, {|msg, time, addr, recvPort|
				var val = msg[1];


				sensorPrevs[i] = sensorVals[i];
				sensorVals[i] = val;

				sensorMins[i] = min(val, sensorMins[i]);
				sensorMaxs[i] = max(val, sensorMaxs[i]);

				if(val < sensorMaxs[i]) {
					sensorMaxs[i] = sensorMaxs[i] - sensorMaxAdj;
				};

				if(val > sensorMins[i]) {
					sensorMins[i] = sensorMins[i] + sensorMinAdj;
				};

				sensorTracks[sensorKey].do {|trk, j|
					trk.sensor(val.linlin(sensorMins[i], sensorMaxs[i], 0, 127));
				};
			}, ("/prox/" ++ sensorKey).asSymbol);
		}
	}
}