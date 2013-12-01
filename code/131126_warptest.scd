p = SerialPort("/dev/cu.usbmodem641", baudrate: 9600, crtscts: true);

w = Window("view", Rect(100, 100, 400, 300)).front;
w.view.addFlowLayout;

a = EZSlider(w, 280@20, label:"linlin");
b = EZSlider(w, 280@20, label:"curve");
c = StaticText(w, 80@80);
d = StaticText(w, 80@80);
e = StaticText(w, 80@80);

Tdef(\foo).stop;

~min = 9999;
~max = 0;

Tdef(\foo, {
	var byte, str, res, prev = 0;
	inf.do {|i|
		if(p.read == 10) {
			str = "";
			while({byte = p.read; byte != 13}, {
				str = str ++ byte.asAscii;
			});
			res = str.asInteger;

			~min = min(~min, res);
			~max = max(~max, res);

			{
				a.value = res.linlin(~min, ~max, 0, 1);
				b.value = res.lincurve(~min, ~max, 0, 1, -20);
				c.string = "prev: " ++ prev;
				d.string = "cur: " ++ res;
				e.string = "diff: " ++ (res - prev).abs;
			}.fork(AppClock);
			// ("read value:" + res).postln;
			prev = res;
		};


		0.001.wait;
	}
}).play(quant:Quant(1));


Env([0, 1], [1], curve:-20).plot