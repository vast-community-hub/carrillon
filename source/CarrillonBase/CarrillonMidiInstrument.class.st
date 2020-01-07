Class {
	#name : 'CarrillonMidiInstrument',
	#superclass : 'Object',
	#instVars : [
		'notes',
		'pump'
	],
	#classVars : [
		'Escobar'
	],
	#category : 'CarrillonBase'
}

{ #category : 'Not categorized' }
CarrillonMidiInstrument class >> escobar [
	Escobar ifNil: [self initializeEscobar].
	^ Escobar
]

{ #category : 'Not categorized' }
CarrillonMidiInstrument class >> escobarOn: gpioDevice1 and: gpioDevice2 [
	| pinOrder answer baseNote port |
	answer := self new.
	baseNote := 57.
	pinOrder := #(3 2 1 0 15 14 13 12 4 5 6 7 8 9 10 11 4 5).
	
	(1 to: 16) do: [:i |
		port := GPIOPort on: gpioDevice1 bit: (pinOrder at: i).
		answer notes at: baseNote + i - 1 put: port].
	(17 to: 18) do: [:i |
		port := GPIOPort on: gpioDevice2 bit: (pinOrder at: i).
		answer notes at: baseNote + i - 1 put: port].
	
	answer pump: (GPIOPort on: gpioDevice2 bit: 6).
	^answer
]

{ #category : 'Not categorized' }
CarrillonMidiInstrument class >> initializeEscobar [
	| dev1 dev2 gpioInterface |
	gpioInterface := RaspberryGpioDaemonInterface raspberryGpioStart.
	dev1 := gpioInterface createI2cDevice: I2CDeviceGPIOMCP23017 slaveAddress:16r20.
	dev2 := gpioInterface createI2cDevice: I2CDeviceGPIOMCP23017 slaveAddress:16r21.
	dev1 allOutputs.
	dev2 allOutputs.
	Escobar := self escobarOn: dev1 and: dev2
]

{ #category : 'Not categorized' }
CarrillonMidiInstrument class >> new [
	^super new initialize
]

{ #category : 'accessing' }
CarrillonMidiInstrument >> bestFor: midiNote [
	^ notes
			at: midiNote
			ifAbsent: [
				| closest |
				closest := self closestMidiFor:midiNote.
				notes at: closest]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
CarrillonMidiInstrument >> closestMidiFor: midiNote [
	| candidates octave |
	octave := 12.
	candidates := notes keys select: [:each |
		(each \\ octave) = (midiNote \\ octave)].
	^(candidates sorted: [:a :b | (a - midiNote) abs < (b - midiNote) abs]) first
]

{ #category : 'initialization' }
CarrillonMidiInstrument >> initialize [
	notes := Dictionary new
]

{ #category : 'playing' }
CarrillonMidiInstrument >> midiLoop [
	" ([self escobarForTesting midiLoop] forkAt: Processor userBackgroundPriority) inspect."
	| input |
	input := MidiInput localProxy.
	[true] whileTrue: [
		| event |
		event := input nextEvent.
		"Transcript nextPutAll: event printString; cr."
		event isNoteOn ifTrue: [
			self play: event note]
	]
]

{ #category : 'accessing' }
CarrillonMidiInstrument >> notes [
	^notes
]

{ #category : 'playing' }
CarrillonMidiInstrument >> play: midiNote [
	| note |
	note := self bestFor:midiNote.
	note pulseForMilliseconds: 500.
]

{ #category : 'accessing' }
CarrillonMidiInstrument >> pump [
	^ pump
]

{ #category : 'accessing' }
CarrillonMidiInstrument >> pump: aGPIOPort [
	pump := aGPIOPort
]
