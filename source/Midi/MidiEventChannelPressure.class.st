Class {
	#name : 'MidiEventChannelPressure',
	#superclass : 'MidiEvent',
	#instVars : [
		'pressure'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventChannelPressure class >> channel: channel pressure: pressure [
	^(self channel: channel) pressure: pressure
]

{ #category : 'Not categorized' }
MidiEventChannelPressure class >> message [
	^16rD0
]

{ #category : 'Not categorized' }
MidiEventChannelPressure >> asByteArray [
	^ByteArray with: self status with: self pressure
]

{ #category : 'Not categorized' }
MidiEventChannelPressure >> fromBytes: aByteArray [
	self
		pressure: aByteArray first
]

{ #category : 'Not categorized' }
MidiEventChannelPressure >> isChannelPressure [
	^true
]

{ #category : 'Not categorized' }
MidiEventChannelPressure >> pressure [
	^pressure
]

{ #category : 'Not categorized' }
MidiEventChannelPressure >> pressure: anInteger [
	pressure := anInteger
]
