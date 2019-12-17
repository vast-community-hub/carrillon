"
1. Download TwitterBoostrapForSeaside .dat from VASTGoodies and import it.
"

#(
  'z.ST: Server Smalltalk (SST) - Seaside Testing'
  'z.ST: Server, SST'
  'z.ST: SUnit'
  'Platform Portability'
  'ENVY/Image IPC ES-X/MOTIF'
  'ENVY/Image Batch Runtime'
  'ENVY/Image JSON'
  'ENVY/Image Batch Runtime'
  'TwitterBoostrapForSeaside'
 ) do: [:each | (EmConfigurationMap editionsFor: each) first loadWithRequiredMaps ].


"You must have Tonel tools loaded, available at <https://github.com/vasmalltalk/tonel-vast>"

reader := TonelReader new readPackagesFrom: ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '../carrillon/').
 (TonelLoader on:  reader) 
	loadApplicationsNamed: 
		#('CarrillonBase' 'CarrillonHardware' 'CarrillonModel' 'CarrillonSeasideApp' 'RaspberryHardwareInterfaceCoreApp').
	
		


