

Application create: #CarrillonBase with:
    (#( CarrillonHardware Midi)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #CarrillonBase missing: each]])!

CarrillonBase becomeDefault!
Object subclass: #CarrillonMidiInstrument
    classInstanceVariableNames: ''
    instanceVariableNames: 'notes '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
Application subclass: #CarrillonBase
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
TestCase subclass: #CarrillonMidiInstrumentTest
    classInstanceVariableNames: ''
    instanceVariableNames: 'carrillon '
    classVariableNames: ''
    poolDictionaries: ''!


CarrillonBase becomeDefault!

!CarrillonBase class privateMethods !

abtIsViewApplication

	^true! !

!CarrillonMidiInstrument class publicMethods !

escobar
	| dev1 dev2 gpioInterface |
	RaspberryGpioDaemonInterface defaultIP: '127.0.0.1' andPort: '8888'.
	gpioInterface := RaspberryGpioDaemonInterface raspberryGpioStart.
	dev1 := gpioInterface createI2cDevice: I2CDeviceGPIOMCP23017 slaveAddress:16r20.
	dev2 := gpioInterface createI2cDevice: I2CDeviceGPIOMCP23017 slaveAddress:16r21.
	^ self escobarOn: dev1 and: dev2!

escobarForTesting
	| dev1 dev2 |
	dev1 := I2CDeviceGPIOMCP23017 forTesting.
	dev2 := I2CDeviceGPIOMCP23017 forTesting.
	^ self escobarOn: dev1 and: dev2!

escobarOn: gpioDevice1 and: gpioDevice2
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
	
	^answer!

new
	^super new initialize! !

!CarrillonMidiInstrument publicMethods !

bestFor: midiNote
	^ notes
			at: midiNote
			ifAbsent: [
				| closest |
				closest := self closestMidiFor:midiNote.
				notes at: closest]!

initialize
	notes := Dictionary new!

midiLoop
	" self escobarForTesting midiLoop "
	| input |
	input := MidiInput localProxy.
	[true] whileTrue: [
		| event |
		event := input nextEvent.
		Transcript nextPutAll: event printString; cr.
		event isNoteOn ifTrue: [
			self play: event note]
	]!

notes
	^notes!

play: midiNote
	| note |
	note := self bestFor:midiNote.
	note pulseForMilliseconds: 500.! !

!CarrillonMidiInstrument privateMethods !

closestMidiFor:midiNote
	| candidates octave |
	octave := 12.
	candidates := notes keys select: [:each |
		(each \\ octave) = (midiNote \\ octave)].
	^(candidates sorted: [:a :b | (a - midiNote) abs < (b - midiNote) abs]) first! !

!CarrillonMidiInstrumentTest publicMethods !

setUp
	carrillon := CarrillonMidiInstrument new.!

testClosestMidiForExisting
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57)
		equals: 57.!

testClosestMidiForHi
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 57+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57+96)
		equals: 57+24.!

testClosestMidiForLow
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57-12)
		equals: 57.!

testClosestMidiForMidle
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 57+36 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57+24)
		equals: 57+12.!

testClosestMidiForNotExisting
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		should:[carrillon closestMidiFor:56]
		raise: Error.! !

CarrillonMidiInstrument initializeAfterLoad!
CarrillonBase initializeAfterLoad!
CarrillonMidiInstrumentTest initializeAfterLoad!

CarrillonBase loaded!