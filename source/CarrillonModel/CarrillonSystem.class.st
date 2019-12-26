Class {
	#name : 'CarrillonSystem',
	#superclass : 'GRObject',
	#instVars : [
		'configuration',
		'player',
		'pump'
	],
	#classVars : [
		'Current'
	],
	#category : 'CarrillonModel'
}

{ #category : 'Instance Creation' }
CarrillonSystem class >> current [

	^Current ifNil: [Current := self defaultNewInstance]
]

{ #category : 'Instance Creation' }
CarrillonSystem class >> defaultNewInstance [

	^self new
		configuration: CarrillonConfiguration defaultNewInstance;
		player: CarrillonPlayer defaultNewInstance;
		pumpOff;
		yourself
]

{ #category : 'Resetting' }
CarrillonSystem class >> reset [

	Current := nil
]

{ #category : 'Instance Creation' }
CarrillonSystem class >> songs [

	^CarrillonSong songs
]

{ #category : 'accessing' }
CarrillonSystem >> configuration [
	^configuration
]

{ #category : 'accessing' }
CarrillonSystem >> configuration: anObject [
	configuration := anObject
]

{ #category : 'Initialization' }
CarrillonSystem >> initializePump [
	pump := GPIOPortMock new.
	self pumpOff
]

{ #category : 'accessing' }
CarrillonSystem >> isPumpRunning [
	pump ifNil: [self initializePump].
	^ pump value == 1
]

{ #category : 'accessing' }
CarrillonSystem >> player [
	^player
]

{ #category : 'accessing' }
CarrillonSystem >> player: anObject [
	player := anObject
]

{ #category : 'Initialization' }
CarrillonSystem >> pumpForEscobar [
	pump := CarrillonMidiInstrument escobar pump
]

{ #category : 'accessing' }
CarrillonSystem >> pumpOff [
	pump ifNotNil: [pump clear]
]

{ #category : 'accessing' }
CarrillonSystem >> pumpOn [
	pump set
]

{ #category : 'accessing' }
CarrillonSystem >> pumpToggle [
	pump toggle
]

{ #category : 'Database' }
CarrillonSystem >> songs [

	^CarrillonSong songs
]
