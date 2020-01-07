Class {
	#name : 'MidiEventControlChange',
	#superclass : 'MidiEvent',
	#instVars : [
		'controller',
		'value'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventControlChange class >> channel: channel controller: controller value: value [
	^(self channel: channel)
			controller: controller;
			value: value
]

{ #category : 'Not categorized' }
MidiEventControlChange class >> message [
	^16rB0
]

{ #category : 'Not categorized' }
MidiEventControlChange >> asByteArray [
	^ByteArray with: self status with: self controller with: self value
]

{ #category : 'Not categorized' }
MidiEventControlChange >> controller [
	^controller
]

{ #category : 'Not categorized' }
MidiEventControlChange >> controller: anInteger [
	controller := anInteger
]

{ #category : 'Not categorized' }
MidiEventControlChange >> fromBytes: aByteArray [
	self
		controller: aByteArray first;
		value: aByteArray second
]

{ #category : 'Not categorized' }
MidiEventControlChange >> isControlChange [
	^true
]

{ #category : 'Not categorized' }
MidiEventControlChange >> value [
	^value
]

{ #category : 'Not categorized' }
MidiEventControlChange >> value: anInteger [
	value := anInteger
]
