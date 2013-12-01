WarpTrackPreset {
	var <params;

	*new {|path|
		if(path.notNil) {
			^Object.readArchive(path);
		};

		^super.new.init();
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