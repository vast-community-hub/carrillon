Class {
	#name : 'MidiEventOnOffAftertouch',
	#superclass : 'MidiEvent',
	#instVars : [
		'note',
		'pressure'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch class >> channel: channel note: note pressure: pressure [
	^(self channel: channel)
		note: note;
		pressure: pressure
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch class >> message [
	^nil
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> asByteArray [
	^ByteArray with: self status with: self note with: self pressure
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> fromBytes: aByteArray [
	self
		note: aByteArray first;
		pressure: aByteArray second
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> note [
	^note
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> note: anInteger [
	note := anInteger
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> noteFullName [
	^self noteName, self octave asString
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> noteName [
	" 0 is Ce "
	^#('C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B') at: self note \\ 12 + 1
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> octave [
	" 12 semi-tones per octave "
	^self note // 12 - 1
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> pressure [
	^pressure
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> pressure: anObject [
	pressure := anObject
]

{ #category : 'Not categorized' }
MidiEventOnOffAftertouch >> printOn: strm [
	super printOn: strm.
	strm space; nextPutAll: self noteFullName
]
