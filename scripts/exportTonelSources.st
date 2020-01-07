| apps |
apps := OrderedCollection new
			add: CarrillonBase;
			add: CarrillonHardware;
			add: CarrillonModel;			
			add: CarrillonSeasideApp;
			add: RaspberryHardwareInterfaceCoreApp;
			add: Midi;
			add: CarrillonBaseTests;
			add: CarrillonHardwareTests;
			add: CarrillonSeasidePackagingInstructionsApp;
			add: MidiTests;
			yourself.

TonelWriter new
	clearsSourcesDirectory: true;
	writeProjectIncluding: apps
	into: (CfsPath named: 'z:\Instantiations\carrillon\carrillon\')
	
