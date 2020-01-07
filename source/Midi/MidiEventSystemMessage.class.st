Class {
	#name : 'MidiEventSystemMessage',
	#superclass : 'MidiEvent',
	#instVars : [
		'data'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiEventSystemMessage class >> message [
	^16rF0
]

{ #category : 'Not categorized' }
MidiEventSystemMessage class >> type: type data: aByteArray [
	^(self argument: type) data: aByteArray
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> asByteArray [
	| answer |
	answer := ByteArray new: self data size + 1.
	answer at: 1 put: self status.
	answer replaceFrom: 2 to: answer size with: self data startingAt: 1.
	^answer
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> data [
	^data
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> data: aByteArray [
	data := aByteArray
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> fromBytes: aByteArray [
	data := aByteArray
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isActiveSensing [
	^self argument == 16r0E
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isReset [
	^self argument == 16r0F
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isSequenceContinue [
	^self argument == 16r0B
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isSequenceStart [
	^self argument == 16r0A
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isSequenceStop [
	^self argument == 16r0C
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isSystemMessage [
	^true
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isTimingClock [
	^self argument == 16r08
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isUndefined [
	^self isUndefined1 or: [self isUndefined2]
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isUndefined1 [
	^self argument == 16r09
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> isUndefined2 [
	^self argument == 16r0D
]

{ #category : 'Not categorized' }
MidiEventSystemMessage >> type [
	^argument
]
