Class {
	#name : 'MidiOutput',
	#superclass : 'MidiInputOutput',
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiOutput class >> localAddress [
	^'127.0.0.1:8384'
]

{ #category : 'Not categorized' }
MidiOutput >> nextEventPut: aMidiEvent [
	| bytes |
	bytes := aMidiEvent asByteArray.
	peer nextPut: bytes size; nextPutAll: bytes; flush
]
