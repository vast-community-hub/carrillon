Class {
	#name : 'MidiEvent',
	#superclass : 'Object',
	#instVars : [
		'argument'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEvent class >> argument: anInteger [
	^self new argument: anInteger
]

{ #category : 'Not categorized' }
MidiEvent class >> channel: anInteger [
	^self new channel: anInteger
]

{ #category : 'Not categorized' }
MidiEvent class >> classForMessage: anInteger [
	^self allSubclasses detect: [:each | each message == anInteger]
]

{ #category : 'Not categorized' }
MidiEvent class >> fromArray: bytes [
	| message class argument |
	message := bytes first bitAnd: 16rF0.
	argument := bytes first bitAnd: 16r0F.
	class := self classForMessage:message.
	^(class argument: argument) fromBytes: bytes allButFirst
	
]

{ #category : 'Not categorized' }
MidiEvent class >> message [
	^self subclassResponsibility
]

{ #category : 'Not categorized' }
MidiEvent >> argument [
	^argument
]

{ #category : 'Not categorized' }
MidiEvent >> argument: anInteger [
	argument := anInteger
]

{ #category : 'Not categorized' }
MidiEvent >> channel [
	^argument+1
]

{ #category : 'Not categorized' }
MidiEvent >> channel: anInteger [
	self argument: anInteger - 1
]

{ #category : 'Not categorized' }
MidiEvent >> fromBytes: aByteArray [

]

{ #category : 'Not categorized' }
MidiEvent >> isAftertouch [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isChannelPressure [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isControlChange [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isNoteOff [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isNoteOn [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isPitchBend [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isProgramChange [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> isSystemMessage [
	^false
]

{ #category : 'Not categorized' }
MidiEvent >> message [
	^self class message
]

{ #category : 'Not categorized' }
MidiEvent >> status [
	^ self message bitOr: self argument.

]
