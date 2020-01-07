Class {
	#name : 'MidiEventAftertouch',
	#superclass : 'MidiEventOnOffAftertouch',
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventAftertouch class >> message [
	^16rA0
]

{ #category : 'Not categorized' }
MidiEventAftertouch >> isAftertouch [
	^true
]
