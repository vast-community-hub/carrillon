Class {
	#name : 'MidiInputOutputTest',
	#superclass : 'TestCase',
	#category : 'MidiTests'
}

{ #category : 'Not categorized' }
MidiInputOutputTest >> testInputSimple [
	| strm input evt |
	strm := ReadWriteStream on: (ByteArray new: 10).
	input := MidiInput peer: strm.
	strm nextPutAll: #[3 16r81 1 2]; reset.
	evt  := input nextEvent.
	self
		assert: evt isNoteOff;
		assert: evt channel equals: 2;
		assert: evt note equals: 1;
		assert: evt pressure equals: 2.
]

{ #category : 'Not categorized' }
MidiInputOutputTest >> testOutputSimple [
	| strm evt output bytes |
	evt := MidiEventNoteOff channel: 2 note: 1 pressure: 2.
	strm := ReadWriteStream on: (ByteArray new: 4).
	output := MidiOutput peer: strm.
	output nextEventPut: evt.
	bytes := strm reset; upToEnd.
	self assert: bytes equals: #[3 16r81 1 2].
	
]
