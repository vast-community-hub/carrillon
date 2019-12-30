Class {
	#name : 'MidiEventPitchBend',
	#superclass : 'MidiEvent',
	#instVars : [
		'pitch'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventPitchBend class >> channel: channel pitch: pitch [
	^(self channel: channel) pitch: pitch
]

{ #category : 'Not categorized' }
MidiEventPitchBend class >> message [
	^16rE0
]

{ #category : 'Not categorized' }
MidiEventPitchBend >> asByteArray [
	^ByteArray with: self status with: self pitch
]

{ #category : 'Not categorized' }
MidiEventPitchBend >> fromBytes: aByteArray [
	self
		pitch: aByteArray first
]

{ #category : 'Not categorized' }
MidiEventPitchBend >> isPitchBend [
	^true
]

{ #category : 'Not categorized' }
MidiEventPitchBend >> pitch [
	^pitch
]

{ #category : 'Not categorized' }
MidiEventPitchBend >> pitch: anObject [
	pitch := anObject
]
