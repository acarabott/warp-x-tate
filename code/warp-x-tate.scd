MIDIClient.init;
m = MIDIOut(0);
m.latency = 0;

n = {|num=60, vel=80, dur=0.1|
	{
		m.noteOn(0, num, vel);
		dur.wait;
		m.noteOff(0, num, vel);
	}.fork;
};

n.(60)

m.noteOn(1, 60, 80);


Tdef(\notes, {
	inf.do {|i|
		n.(rrand(40, 100));
		0.25.wait;
	}
}).play(quant:Quant(1));

Tdef(\notes).stop


m.noteOn(0, 12, 80);

// 102-120 unused
m.control(0, 102, 127);
m.control(0, 103, 127);

~sweep = {|secs|
	{
		127.do {|i|
			m.control(0, 102, i);
			m.control(0, 103, i);
			(secs/127).wait;
		}
	}.fork;
}

2/127

~sweep.(10)var sig, verb, mix;

sig = In.ar(0, 2);
verb = FreeVerb2.ar(sig[0], sig[1], 1, 0.85, 0.5);
mix = Mix([sig, verb]);

mix