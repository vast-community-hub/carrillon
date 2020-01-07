Class {
	#name : 'MidiEventProgramChange',
	#superclass : 'MidiEvent',
	#instVars : [
		'program'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventProgramChange class >> channel: channel program: program [
	^(self channel: channel) program: program
]

{ #category : 'Not categorized' }
MidiEventProgramChange class >> message [
	^16rC0
]

{ #category : 'Not categorized' }
MidiEventProgramChange >> asByteArray [
	^ByteArray with: self status with: self program
]

{ #category : 'Not categorized' }
MidiEventProgramChange >> fromBytes: aByteArray [
	self
		program: aByteArray first
]

{ #category : 'Not categorized' }
MidiEventProgramChange >> isProgramChange [
	^true
]

{ #category : 'Not categorized' }
MidiEventProgramChange >> program [
	^program
]

{ #category : 'Not categorized' }
MidiEventProgramChange >> program: anInteger [
	program := anInteger
]
