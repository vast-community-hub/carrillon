"
1. Download TwitterBoostrapForSeaside .dat from VASTGoodies and import it.
2. You must have Tonel imported, available at <https://github.com/vasmalltalk/tonel-vast> 
"

#(
  'z.ST: Server Smalltalk (SST) - Seaside Testing'
  'z.ST: Server, SST'
  'ENVY/Image IPC ES-X/MOTIF'
  'ENVY/Image Batch Runtime'
  'ENVY/Image JSON'
  'TwitterBoostrapForSeaside'
  'Tonel' 
 ) do: [:each | (EmConfigurationMap editionsFor: each) first loadWithRequiredMaps ].


reader := TonelReader new readPackagesFrom: (CfsPath named: 'z:\Instantiations\carrillon\carrillon\').
 (TonelLoader on:  reader) 
	loadApplicationsNamed: 
		#(
		'Midi'
		'CarrillonBase'
		'CarrillonHardware' 
		'CarrillonModel' 
		'CarrillonSeasideApp' 
		'RaspberryHardwareInterfaceCoreApp'
		'CarrillonSeasidePackagingInstructionsApp'
		'CarrillonBaseTests'
		'CarrillonHardwareTests'
		'MidiTests'
		).
