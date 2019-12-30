Class {
	#name : 'MidiEventNoteOn',
	#superclass : 'MidiEventOnOffAftertouch',
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventNoteOn class >> message [
	^16r90
]

{ #category : 'Not categorized' }
MidiEventNoteOn >> isNoteOn [
	^true
]
