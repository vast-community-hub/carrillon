Class {
	#name : 'CarrillonMidiInstrumentTest',
	#superclass : 'TestCase',
	#instVars : [
		'carrillon'
	],
	#category : 'CarrillonBaseTests'
}

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> setUp [
	carrillon := CarrillonMidiInstrument new.
]

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> testClosestMidiForExisting [
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57)
		equals: 57.
]

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> testClosestMidiForHi [
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 57+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57+96)
		equals: 57+24.
]

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> testClosestMidiForLow [
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57-12)
		equals: 57.
]

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> testClosestMidiForMidle [
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 57+36 put: 157+24.
	self
		assert: (carrillon closestMidiFor: 57+24)
		equals: 57+12.
]

{ #category : 'Not categorized' }
CarrillonMidiInstrumentTest >> testClosestMidiForNotExisting [
	carrillon notes
		at: 57 put: 157;
		at: 57+12 put: 157+12;
		at: 157+24 put: 157+24.
	self
		should:[carrillon closestMidiFor:56]
		raise: Error.
]
