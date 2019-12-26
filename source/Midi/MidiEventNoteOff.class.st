Class {
	#name : 'MidiEventNoteOff',
	#superclass : 'MidiEventOnOffAftertouch',
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventNoteOff class >> message [
	^16r80
]

{ #category : 'Not categorized' }
MidiEventNoteOff >> isNoteOff [
	^true
]
