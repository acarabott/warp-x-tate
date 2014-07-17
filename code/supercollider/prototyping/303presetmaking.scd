// <Pattern application="Phoscyon" name="Pattern 41" length="10" shuffle="0"
//          tempo="120">
//   <Step note="11" octaveUp="0" octaveDown="0" gate="1" accent="0" slide="0"
//   		gateLevel="0" accentLevel="0"slideLevel="0"/>
// </Pattern>
(
~name = "Are You There?";
~shuffle = 0;
~length = 10;
~tempo = 120;

~defaults = IdentityDictionary[
	'octaveUp'		-> (0!~length),
	'octaveDown'	-> (0!~length),
	'accent'		-> (0!~length),
	'gate'			-> (1!~length),
	'slide'			-> (0!~length),
	'gateLevel'		-> (0!~length),
	'accentLevel'	-> (0!~length),
	'slideLevel'	-> (0!~length),
	'note'			-> (0!~length)
];

~new = IdentityDictionary[
	'note' -> 		[3, 2, 1, 2, 4, 4, 4, 3, 1, 3],
	'octaveUp' -> 	[1, 1, 1, 1, 1, 0, 0, 1, 0, 1],
	'slide'		->	[0, 0, 0, 0, 1, 1, 0, 1, 1, 0]
];


~mix = ~defaults ++ ~new;

("<Pattern application=\"Phoscyon\" name=\"" ++ ~name ++ "\" length=\"" ++ ~length ++ "\" shuffle=\"" ++ ~shuffle ++ "\"\n\t\ttempo=\"" ++ ~tempo ++ "\">").postln;

~length.do {|i|
	"<Step ".post;

	['note', 'octaveUp', 'octaveDown', 'gate', 'accent', 'slide', 'gateLevel',
	'accentLevel', 'slideLevel'].do {|key, j|
		(key.asString ++ "=\"" ++ ~mix[key][i] ++ "\" ").post;
		if(key == 'slide') {
			"\n\t\t".post;
		};
	};

	"/>".postln;
};
"</Pattern>".postln;
)