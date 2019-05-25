

Application create: #CarrillonBase with:
    (#( AbtViewApplication SUnit)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #CarrillonBase missing: each]])!

CarrillonBase becomeDefault!
Object subclass: #MidiEvent
    classInstanceVariableNames: ''
    instanceVariableNames: 'argument '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventChannelPressure
    classInstanceVariableNames: ''
    instanceVariableNames: 'pressure '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventControlChange
    classInstanceVariableNames: ''
    instanceVariableNames: 'controller value '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventOnOffAftertouch
    classInstanceVariableNames: ''
    instanceVariableNames: 'note pressure '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventAftertouch
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventNoteOff
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventNoteOn
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventPitchBend
    classInstanceVariableNames: ''
    instanceVariableNames: 'pitch '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventProgramChange
    classInstanceVariableNames: ''
    instanceVariableNames: 'program '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiEvent subclass: #MidiEventSystemMessage
    classInstanceVariableNames: ''
    instanceVariableNames: 'data '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
Object subclass: #MidiInput
    classInstanceVariableNames: ''
    instanceVariableNames: 'peer '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
Application subclass: #CarrillonBase
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
TestCase subclass: #MidiEventTest
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!


CarrillonBase becomeDefault!

!CarrillonBase class privateMethods !

abtIsViewApplication

	^true! !

!MidiEvent class publicMethods !

argument: anInteger
	^self new argument: anInteger!

classForMessage: anInteger
	^self allSubclasses detect: [:each | each message == anInteger]!

fromArray: bytes
	| message class argument |
	message := bytes first bitAnd: 16rF0.
	argument := bytes first bitAnd: 16r0F.
	class := self classForMessage:message.
	^(class argument: argument) data: bytes allButFirst
	!

fromStream: strm
	| count bytes |
	count := strm next.
	bytes := strm next: count.
	^ self fromArray: bytes!

message
	^self subclassResponsibility! !

!MidiEvent publicMethods !

argument
	^argument!

argument: anInteger
	argument := anInteger!

channel
	^argument+1!

channel: anInteger
	self argument: anInteger - 1!

data: aByteArray
!

isActiveSensing
	^ self isSystemMessage and: [self argument == 16r0E]!

isAftertouch
	^false!

isChannelPressure
	^false!

isControlChange
	^false!

isNoteOff
	^false!

isNoteOn
	^false!

isPitchBend
	^false!

isProgramChange
	^false!

isReset
	^ self isSystemMessage and: [self argument == 16r0F]!

isSequenceContinue
	^ self isSystemMessage and: [self argument == 16r0B]!

isSequenceStart
	^ self isSystemMessage and: [self argument == 16r0A]!

isSequenceStop
	^ self isSystemMessage and: [self argument == 16r0C]!

isSystemMessage
	^false!

isTimingClock
	^ self isSystemMessage and: [self argument == 16r08]!

isUndefined1
	^ self isSystemMessage and: [self argument == 16r09]!

isUndefined2
	^ self isSystemMessage and: [self argument == 16r0D]!

message
	^self class message! !

!MidiEventAftertouch class publicMethods !

message
	^16rA0! !

!MidiEventAftertouch publicMethods !

isAftertouch
	^true! !

!MidiEventChannelPressure class publicMethods !

message
	^16rD0! !

!MidiEventChannelPressure publicMethods !

data: aByteArray
	self
		pressure: aByteArray first!

isChannelPressure
	^true!

pressure
	^pressure!

pressure: anInteger
	pressure := anInteger! !

!MidiEventControlChange class publicMethods !

message
	^16rB0! !

!MidiEventControlChange publicMethods !

controller
	^controller!

controller: anInteger
	controller := anInteger!

data: aByteArray
	self
		controller: aByteArray first;
		value: aByteArray second!

isControlChange
	^true!

value
	^value!

value: anInteger
	value := anInteger! !

!MidiEventNoteOff class publicMethods !

message
	^16r80! !

!MidiEventNoteOff publicMethods !

isNoteOff
	^true! !

!MidiEventNoteOn class publicMethods !

message
	^16r90! !

!MidiEventNoteOn publicMethods !

isNoteOn
	^true! !

!MidiEventOnOffAftertouch class publicMethods !

message
	^nil! !

!MidiEventOnOffAftertouch publicMethods !

data: aByteArray
	self
		note: aByteArray first;
		pressure: aByteArray second!

note
	^note!

note: anInteger
	note := anInteger!

pressure
	^pressure!

pressure: anObject
	pressure := anObject! !

!MidiEventPitchBend class publicMethods !

message
	^16rE0! !

!MidiEventPitchBend publicMethods !

data: aByteArray
	self
		pitch: aByteArray first!

isPitchBend
	^true!

pitch
	^pitch!

pitch: anObject
	pitch := anObject! !

!MidiEventProgramChange class publicMethods !

message
	^16rC0! !

!MidiEventProgramChange publicMethods !

data: aByteArray
	self
		program: aByteArray first!

isProgramChange
	^true!

program
	^program!

program: anInteger
	program := anInteger! !

!MidiEventSystemMessage class publicMethods !

message
	^16rF0! !

!MidiEventSystemMessage publicMethods !

data
	^data!

data: aByteArray
	data := aByteArray!

isSystemMessage
	^true!

type
	^argument! !

!MidiEventTest publicMethods !

eventWith: a with: b with: c
	^ MidiEvent fromArray: (Array with: a with: b with: c).
!

testAftertouch
	| evt  |
	evt := self eventWith: 16rA4 with: 100 with: 101.
	self
		assert: evt  isAftertouch;
		assert: evt channel == 5;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOff!

testArgument
	| evt |
	evt := MidiEvent argument: 123.
	self assert: evt argument equals: 123!

testChannelPressure
	| evt  |
	evt := self eventWith: 16rD4 with: 100 with: 101.
	self
		assert: evt  isChannelPressure;
		assert: evt channel equals: 5;
		assert: evt pressure equals: 100;
		deny: evt isNoteOff!

testClassForMessage
	self assert: (MidiEvent classForMessage:16r80)  equals: MidiEventNoteOff.
	self assert: (MidiEvent classForMessage:16r90)  equals: MidiEventNoteOn.
	self assert: (MidiEvent classForMessage:16rA0)  equals: MidiEventAftertouch.
	self assert: (MidiEvent classForMessage:16rB0)  equals: MidiEventControlChange.
	self assert: (MidiEvent classForMessage:16rC0)  equals: MidiEventProgramChange.
	self assert: (MidiEvent classForMessage:16rD0)  equals: MidiEventChannelPressure.
	self assert: (MidiEvent classForMessage:16rE0)  equals: MidiEventPitchBend.
	self assert: (MidiEvent classForMessage:16rF0)  equals: MidiEventSystemMessage.
!

testControlChange
	| evt  |
	evt := self eventWith: 16rB4 with: 100 with: 101.
	self
		assert: evt  isControlChange;
		assert: evt channel == 5;
		assert: evt controller equals: 100;
		assert: evt value equals: 101;
		deny: evt isNoteOff!

testFromArray
	| evt |
	evt := MidiEvent fromArray: #[16rF5 12 42].
	self
		assert: evt argument equals: 5;
		assert: evt message equals: 16rF0;
		assert: evt data size equals: 2;
		assert: evt data first equals: 12;
		assert: evt data second equals: 42.!

testFromStream
	| strm  evt |
	strm := ReadStream on: #[3 16rF5 12 42].
	evt := MidiEvent fromStream: strm.
	self
		assert: evt argument equals: 5;
		assert: evt message equals: 16rF0;
		assert: evt data size equals: 2;
		assert: evt data first equals: 12;
		assert: evt data second equals: 42.!

testNoteOff
	| evt  |
	evt := self eventWith: 16r83 with: 100 with: 101.
	self
		assert: evt  isNoteOff;
		assert: evt channel == 4;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOn!

testNoteOn
	| evt  |
	evt := self eventWith: 16r90 with: 100 with: 101.
	self
		assert: evt  isNoteOn;
		assert: evt channel == 1;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOff!

testPitchBend
	| evt  |
	evt := self eventWith: 16rEF with: 100 with: 101.
	self
		assert: evt  isPitchBend;
		assert: evt channel equals: 16;
		assert: evt pitch equals: 100;
		deny: evt isNoteOff!

testProgramChange
	| evt  |
	evt := self eventWith: 16rCF with: 100 with: 101.
	self
		assert: evt  isProgramChange;
		assert: evt channel equals: 16;
		assert: evt program equals: 100;
		deny: evt isNoteOff!

testSystemMessage
	| evt  |
	evt := self eventWith: 16rFF with: 100 with: 101.
	self
		assert: evt  isSystemMessage;
		assert: evt argument equals: 15;
		assert: evt data equals: #(100 101);
		deny: evt isNoteOff! !

!MidiInput class publicMethods !

new
	^ super new initialize! !

!MidiInput publicMethods !

initialize
	| addr socket |
	addr := SciSocketAddress fromString: '127.0.0.1:8383'.
	socket := SciSocket newStreamSocket connect: addr.
	peer := SstSocketStream on: socket.!

nextEvent
	^MidiEvent fromStream:  peer! !

MidiEvent initializeAfterLoad!
MidiEventChannelPressure initializeAfterLoad!
MidiEventControlChange initializeAfterLoad!
MidiEventOnOffAftertouch initializeAfterLoad!
MidiEventAftertouch initializeAfterLoad!
MidiEventNoteOff initializeAfterLoad!
MidiEventNoteOn initializeAfterLoad!
MidiEventPitchBend initializeAfterLoad!
MidiEventProgramChange initializeAfterLoad!
MidiEventSystemMessage initializeAfterLoad!
MidiInput initializeAfterLoad!
CarrillonBase initializeAfterLoad!
MidiEventTest initializeAfterLoad!

CarrillonBase loaded!