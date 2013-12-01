WarpTrackPreset {
	var <>key;
	var <>params;
	var <>sensorFuncs;
	var <>patternTrack;
	var <>midiChannel;
	var <>notes;

	*new {
		^super.new.init();
	}

	*read {|path|
		^Object.readArchive(path);
	}

	init {
	}

	loadParams {|path|
		params = Object.readArchive(path);
	}

	save {
		Dialog.savePanel({|path|
			this.writeArchive(path);
		});
	}
}