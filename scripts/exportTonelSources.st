
apps := OrderedCollection new
			add: CarrillonBase;
			add: CarrillonHardware;
			add: CarrillonModel;			
			add: CarrillonSeasideApp;
			add: RaspberryHardwareInterfaceCoreApp;
			yourself.

TonelWriter new
	writeProjectIncluding: apps
	into: ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '../carrillon/').