

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
Object subclass: #MidiInputOutput
    classInstanceVariableNames: ''
    instanceVariableNames: 'peer '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiInputOutput subclass: #MidiInput
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonBase becomeDefault!
MidiInputOutput subclass: #MidiOutput
    classInstanceVariableNames: ''
    instanceVariableNames: ''
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
TestCase subclass: #MidiInputOutputTest
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

channel: anInteger
	^self new channel: anInteger!

classForMessage: anInteger
	^self allSubclasses detect: [:each | each message == anInteger]!

fromArray: bytes
	| message class argument |
	message := bytes first bitAnd: 16rF0.
	argument := bytes first bitAnd: 16r0F.
	class := self classForMessage:message.
	^(class argument: argument) fromBytes: bytes allButFirst
	!

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

fromBytes: aByteArray
!

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

isSystemMessage
	^false!

message
	^self class message!

status
	^ self message bitOr: self argument.
! !

!MidiEventAftertouch class publicMethods !

message
	^16rA0! !

!MidiEventAftertouch publicMethods !

isAftertouch
	^true! !

!MidiEventChannelPressure class publicMethods !

channel: channel pressure: pressure
	^(self channel: channel) pressure: pressure!

message
	^16rD0! !

!MidiEventChannelPressure publicMethods !

asByteArray
	^ByteArray with: self status with: self pressure!

fromBytes: aByteArray
	self
		pressure: aByteArray first!

isChannelPressure
	^true!

pressure
	^pressure!

pressure: anInteger
	pressure := anInteger! !

!MidiEventControlChange class publicMethods !

channel: channel controller: controller value: value
	^(self channel: channel)
			controller: controller;
			value: value!

message
	^16rB0! !

!MidiEventControlChange publicMethods !

asByteArray
	^ByteArray with: self status with: self controller with: self value!

controller
	^controller!

controller: anInteger
	controller := anInteger!

fromBytes: aByteArray
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

channel: channel note: note pressure: pressure
	^(self channel: channel)
		note: note;
		pressure: pressure!

message
	^nil! !

!MidiEventOnOffAftertouch publicMethods !

asByteArray
	^ByteArray with: self status with: self note with: self pressure!

fromBytes: aByteArray
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

channel: channel pitch: pitch
	^(self channel: channel) pitch: pitch!

message
	^16rE0! !

!MidiEventPitchBend publicMethods !

asByteArray
	^ByteArray with: self status with: self pitch!

fromBytes: aByteArray
	self
		pitch: aByteArray first!

isPitchBend
	^true!

pitch
	^pitch!

pitch: anObject
	pitch := anObject! !

!MidiEventProgramChange class publicMethods !

channel: channel program: program
	^(self channel: channel) program: program!

message
	^16rC0! !

!MidiEventProgramChange publicMethods !

asByteArray
	^ByteArray with: self status with: self program!

fromBytes: aByteArray
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
	^16rF0!

type: type data: aByteArray
	^(self argument: type) data: aByteArray! !

!MidiEventSystemMessage publicMethods !

asByteArray
	| answer |
	answer := ByteArray new: self data size + 1.
	answer at: 1 put: self status.
	answer replaceFrom: 2 to: answer size with: self data startingAt: 1.
	^answer!

data
	^data!

data: aByteArray
	data := aByteArray!

fromBytes: aByteArray
	data := aByteArray!

isActiveSensing
	^self argument == 16r0E!

isReset
	^self argument == 16r0F!

isSequenceContinue
	^self argument == 16r0B!

isSequenceStart
	^self argument == 16r0A!

isSequenceStop
	^self argument == 16r0C!

isSystemMessage
	^true!

isTimingClock
	^self argument == 16r08!

isUndefined
	^self isUndefined1 or: [self isUndefined2]!

isUndefined1
	^self argument == 16r09!

isUndefined2
	^self argument == 16r0D!

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

testAftertouchCreation
	| evt  |
	evt := MidiEventAftertouch channel: 16 note: 255 pressure: 0.
	self
		assert: evt  isAftertouch;
		assert: evt channel equals: 16;
		assert: evt note equals: 255;
		assert: evt pressure equals: 0;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rAF 255 0].
!

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

testChannelPressureCreation
	| evt  |
	evt := MidiEventChannelPressure channel: 5 pressure: 100.
	self
		assert: evt  isChannelPressure;
		assert: evt channel equals: 5;
		assert: evt pressure equals: 100;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rD4 100].
		!

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

testControlChangeCreation
	| evt  |
	evt := MidiEventControlChange channel: 1 controller: 100 value: 101.
	self
		assert: evt  isControlChange;
		assert: evt channel == 1;
		assert: evt controller equals: 100;
		assert: evt value equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rB0 100 101].
!

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

testNoteOffCreation
	| evt  |
	evt := MidiEventNoteOff channel: 4 note: 77 pressure: 123.
	self
		assert: evt  isNoteOff;
		assert: evt channel equals: 4;
		assert: evt note equals: 77;
		assert: evt pressure equals: 123;
		deny: evt isNoteOn.
	self assert: evt asByteArray equals: #[16r83 77 123].
!

testNoteOn
	| evt  |
	evt := self eventWith: 16r90 with: 100 with: 101.
	self
		assert: evt  isNoteOn;
		assert: evt channel == 1;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOff!

testNoteOnCreation
	| evt  |
	evt := MidiEventNoteOn channel: 4 note: 77 pressure: 123.
	self
		assert: evt  isNoteOn;
		assert: evt channel equals: 4;
		assert: evt note equals: 77;
		assert: evt pressure equals: 123;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16r93 77 123].
!

testPitchBend
	| evt  |
	evt := self eventWith: 16rEF with: 100 with: 101.
	self
		assert: evt  isPitchBend;
		assert: evt channel equals: 16;
		assert: evt pitch equals: 100;
		deny: evt isNoteOff!

testPitchBendCreation
	| evt  |
	evt := MidiEventPitchBend channel: 2 pitch: 101.
	self
		assert: evt  isPitchBend;
		assert: evt channel equals: 2;
		assert: evt pitch equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rE1  101].
!

testProgramChange
	| evt  |
	evt := self eventWith: 16rCF with: 100 with: 101.
	self
		assert: evt  isProgramChange;
		assert: evt channel equals: 16;
		assert: evt program equals: 100;
		deny: evt isNoteOff!

testProgramChangeCreation
	| evt  |
	evt := MidiEventProgramChange channel: 2 program: 101.
	self
		assert: evt  isProgramChange;
		assert: evt channel equals: 2;
		assert: evt program equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rC1  101].
!

testSystemMessage
	| evt  |
	evt := self eventWith: 16rFF with: 100 with: 101.
	self
		assert: evt  isSystemMessage;
		assert: evt argument equals: 15;
		assert: evt data equals: #(100 101);
		assert: evt isReset;
		deny: evt isNoteOff!

testSystemMessageCreation
	| evt  |
	evt := MidiEventSystemMessage type: 15 data: #[1 2 3 4 5].
	self
		assert: evt  isSystemMessage;
		assert: evt argument equals: 15;
		assert: evt data equals: #[1 2 3 4 5];
		assert: evt isReset;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rFF 1 2 3 4 5].
!

testSystemMessageTypes
	| evt  |
	evt := self eventWith: 16rF8 with: 100 with: 101.
	self assert: evt isTimingClock.
	evt := self eventWith: 16rF9 with: 100 with: 101.
	self assert: evt isUndefined1; assert: evt isUndefined.
	evt := self eventWith: 16rFA with: 100 with: 101.
	self assert: evt isSequenceStart.
	evt := self eventWith: 16rFB with: 100 with: 101.
	self assert: evt isSequenceContinue.
	evt := self eventWith: 16rFC with: 100 with: 101.
	self assert: evt isSequenceStop.
	evt := self eventWith: 16rFD with: 100 with: 101.
	self assert: evt isUndefined2; assert: evt isUndefined.
	evt := self eventWith: 16rFE with: 100 with: 101.
	self assert: evt isActiveSensing.
	evt := self eventWith: 16rFF with: 100 with: 101.
	self assert: evt isReset.
! !

!MidiInput class publicMethods !

localAddress
	^'127.0.0.1:8383'! !

!MidiInput publicMethods !

nextEvent
	| count bytes |
	count := peer next.
	bytes := peer next: count.
	^MidiEvent fromArray: bytes! !

!MidiInputOutput class publicMethods !

localProxy
	| addr socket peer |
	addr := SciSocketAddress fromString: self localAddress.
	socket := SciSocket newStreamSocket connect: addr.
	peer := SstSocketStream on: socket.
	^self peer: peer!

peer: strm
	^self new peer: strm! !

!MidiInputOutput publicMethods !

peer: aStream
	peer := aStream! !

!MidiInputOutputTest publicMethods !

testInputSimple
	| strm input evt |
	strm := ReadWriteStream on: (ByteArray new: 10).
	input := MidiInput peer: strm.
	strm nextPutAll: #[3 16r81 1 2]; reset.
	evt  := input nextEvent.
	self
		assert: evt isNoteOff;
		assert: evt channel equals: 2;
		assert: evt note equals: 1;
		assert: evt pressure equals: 2.!

testOutputSimple
	| strm evt output bytes |
	evt := MidiEventNoteOff channel: 2 note: 1 pressure: 2.
	strm := ReadWriteStream on: (ByteArray new: 4).
	output := MidiOutput peer: strm.
	output nextEventPut: evt.
	bytes := strm reset; upToEnd.
	self assert: bytes equals: #[3 16r81 1 2].
	! !

!MidiOutput class publicMethods !

localAddress
	^'127.0.0.1:8384'! !

!MidiOutput publicMethods !

nextEventPut: aMidiEvent
	| bytes |
	bytes := aMidiEvent asByteArray.
	peer nextPut: bytes size; nextPutAll: bytes; flush! !

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
MidiInputOutput initializeAfterLoad!
MidiInput initializeAfterLoad!
MidiOutput initializeAfterLoad!
CarrillonBase initializeAfterLoad!
MidiEventTest initializeAfterLoad!
MidiInputOutputTest initializeAfterLoad!

CarrillonBase loaded!