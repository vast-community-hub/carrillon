Class {
	#name : 'MidiInput',
	#superclass : 'MidiInputOutput',
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiInput class >> localAddress [
	^'127.0.0.1:8383'
]

{ #category : 'Not categorized' }
MidiInput >> nextEvent [
	| count bytes |
	count := peer next.
	bytes := peer next: count.
	^MidiEvent fromArray: bytes
]
