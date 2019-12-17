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



reader := TonelReader new readPackagesFrom:  (CfsPath named: 'C:\Users\Esteban\desarrollo\VAST\tensorflow-vast').
 (TonelLoader on:  reader) 
	loadApplicationsNamed: 
		#('TensorFlowApp'
			'TensorFlowKernelApp' 
			'TestTensorFlowApp' 
			'TensorFlowTestsApp' 
			'TensorFlowExamplesApp').


