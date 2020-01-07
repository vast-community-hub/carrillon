Class {
	#name : 'XDCarrillonPackagingInstructions',
	#superclass : 'AbtXDSingleImagePackagingInstructions',
	#category : 'CarrillonSeasidePackagingInstructionsApp'
}

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> allGreaseApplicationNamesToPackage [

	^((OrderedCollection new)
		add: #GreaseCoreApp;
		add: #GreaseVASTCoreApp;
		yourself)
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> allProjectApplicationNamesToPackage [

	^OrderedCollection new
		add: #Midi;
		add: #CarrillonBase;
		add: #CarrillonHardware;
		add: #RaspberryHardwareInterfaceCoreApp;
		add: #CarrillonModel;
		add: #CarrillonSeasideApp;
		yourself
]

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> allSeasideApplicationNamesToPackage [

	^((OrderedCollection new)
		add: #SeasideAdaptorsSstApp;
		add: #SeasideCanvasApp;
		add: #SeasideComponentApp;
		add: #SeasideCoreApp;
		"add: #SeasideEmailApp;"
		add: #SeasideEnvironmentApp;
		add: #SeasideFlowApp;
		add: #SeasideInternetExplorerApp;
		"add: #SeasideJSONCoreApp;"
		add: #SeasideRenderLoopApp;
		"add: #SeasideRESTCoreApp;"
		add: #SeasideSecurityApp;
		add: #SeasideSessionApp;
		"add: #SeasideToolsCoreApp;"
		add: #SeasideVASTContinuationApp;
		add: #SeasideVASTCoreApp;
		add: #SeasideVASTEmailApp;
		add: #SeasideVASTEnvironmentApp;
		add: #SeasideVASTFlowApp;
		add: #SeasideVASTJSONCoreApp;
		add: #SeasideVASTRESTCoreApp;
		add: #SeasideVASTSecurityApp;
		add: #SeasideVASTWidgetsApp;
		add: #SeasideWidgetsApp;
		"add: #RSSCoreApp;
		add: #RSSExamplesApp;"
		add: #JavascriptCoreApp;
		add: #JavascriptVASTCoreApp;
		add: #JQueryCoreApp;
		"add: #JQueryJSONApp;"
		"add: #JQueryUIApp;"
		add: #JQueryVASTCoreApp;
		"add: #PrototypeCoreApp;
		add: #ScriptaculousComponentsApp;
		add: #ScriptaculousCoreApp;"
		yourself)
]

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> applicationLaunchBlock [

	^[
	"To fill some dummy songs (mandatory for now)"
		CarrillonSong initializeFromPath: CarrillonSystem current configuration staticFilesPath.

		"To register seaide"
		CarrillonRootComponent registerForProd.

		"To start seaside"
		CarrillonSeasideEntryPoint startSeasideAdaptors.

		"Initialize hardware interface"
		RaspberryGpioDaemonInterface
			defaultIP: CarrillonSystem current configuration raspberryPiIp
			andPort: CarrillonSystem current configuration raspberryPiPigpiodPort.
		
		"Configure Pump for Escobar"
		CarrillonSystem current pumpForEscobar.
		
		"To srart MIDI Server"
		[CarrillonMidiInstrument escobar midiLoop] forkAt: Processor userBackgroundPriority]
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> applicationLaunchCode [

	^'%1 value' bindWith: self applicationLaunchBlock epBlockPrintString
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> applicationNamesToPackage [

	^super applicationNamesToPackage
		"add: #SstDebuggingSupport;"
		add: #EsStackDumperSupport;
		add: #EswSwapperCFSSupport;
		add: #NeoJSONCoreApp;
		add: #NeoJSONVASTCoreApp;
		addAll: self allGreaseApplicationNamesToPackage;
		addAll: self allSeasideApplicationNamesToPackage;
		addAll: self allProjectApplicationNamesToPackage;
		yourself
]

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> controlPanelName [

	^ 'Carrillon Headless Image'
]

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> description [

	^ 'XD Single Runtime-reduced Headless Carrillon Image'
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> dumperOptions [

	^EpDumperOptions new
		createSnapshot;
		removeCategories;
		removeSourcePointers;
		optimizeAssociations;
		uniqueEmptyMethodDictionary;
		dumperClass: EsRomerImageDumper;
		outputDirectoryName: ''; "$NON-NLS$"
		makeMessageCatalogsResident;
		correctManagerStructures;
		removeUnusedMetaclasses;
		enable: EpAllStatistics;
		imageFileName: self imageFileName;
		yourself
]

{ #category : 'Not categorized' }
XDCarrillonPackagingInstructions class >> imageFileName [

	^'carrillon.icx'
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> isKeptByDefault [

	^false
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> isSavedByDefault [

	^false
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> packagingRulesFor: aRuleCreationInterface [

	super packagingRulesFor: aRuleCreationInterface.
	self applicationNamesToPackage
		do: [:each | aRuleCreationInterface doNotReduceSubApplicationNamed: each]
]

{ #category : 'EP-API (Modifiable)' }
XDCarrillonPackagingInstructions class >> startUpClassName [

	^#AbtStackDumpStartUp
	
	
	
]
