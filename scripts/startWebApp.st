"To fill some dummy songs (mandatory for now)"
CarrillonSong exampleEmptyAndFillSomeSongs.

"Set custom configuration object"
CarrillonSystem current configuration:  (CarrillonConfiguration defaultNewInstance
		mediaUrlPreffix: '/media';
		staticFilesPath: '/home/emaringolo/Instantiations/VASmalltalk/carrillon/web/media';
		midiPortName: 'Midi2TCP';
		"midiPortName: 'Synth input port';"
		"midiPortName: 'Midi Through';"
		yourself).


"To register Seaside"
CarrillonRootComponent register.

"To start Seaside"
CarrillonSeasideEntryPoint startSeasideAdaptors.

"To enter from the browser without nginx"
http://localhost:9999/carrillon

"To enter from the browser with nginx"
http://localhost:6767/carrillon

"To stop Seaside"
WASstServerManager default adaptors do: [:each | 
	WASstServerManager default unregister: each
].





