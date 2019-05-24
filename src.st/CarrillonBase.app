

Application create: #CarrillonBase with:
    (#( AbtViewApplication SUnit)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #CarrillonBase missing: each]])!

CarrillonBase becomeDefault!
Object subclass: #MidiEvent
    classInstanceVariableNames: ''
    instanceVariableNames: 'bytes '
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

eventNames
	^ Dictionary new
			at: 16r80 put: 'Note Off';
			at: 16r90 put: 'Note On';
			at: 16rA0 put: 'Aftertouch';
			at: 16rB0 put: 'Control Change';
			at: 16rC0 put: 'Program Change';
			at: 16rD0 put: 'Channel Pressure';
			at: 16rE0 put: 'Pitch Bend Change';
			at: 16rF0 put: 'System Message';
			yourself!

fromArray: bytes
	^ self new bytes: bytes!

fromStream: strm
	| count bytes |
	count := strm next.
	bytes := strm next: count.
	^ self fromArray: bytes! !

!MidiEvent publicMethods !

argument
	^bytes first bitAnd: 16r0F!

bytes
	^bytes!

bytes: aByteArray
	bytes := aByteArray!

channel
	^self argument + 1!

data
	^bytes allButFirst!

eventName
	^self class eventNames at: self message!

isActiveSensing
	^ self isSystemMessage and: [self argument == 16r0E]!

isAftertouch
	^self message == 16rA0!

isChannelPressure
	^self message == 16rD0!

isControlChange
	^self message == 16rB0!

isNoteOff
	^self message == 16r80!

isNoteOn
	^self message == 16r90!

isPitchBendChange
	^self message == 16rE0!

isProgramChange
	^self message == 16rC0!

isReset
	^ self isSystemMessage and: [self argument == 16r0F]!

isSequenceContinue
	^ self isSystemMessage and: [self argument == 16r0B]!

isSequenceStart
	^ self isSystemMessage and: [self argument == 16r0A]!

isSequenceStop
	^ self isSystemMessage and: [self argument == 16r0C]!

isSystemMessage
	^self message == 16rF0!

isTimingClock
	^ self isSystemMessage and: [self argument == 16r08]!

isUndefined1
	^ self isSystemMessage and: [self argument == 16r09]!

isUndefined2
	^ self isSystemMessage and: [self argument == 16r0D]!

message
	^bytes first bitAnd: 16rF0!

note
	^bytes second!

pressure
	^bytes third!

printOn: aStream
	super printOn: aStream.
	aStream 
		space; 
		nextPut: $(;
		nextPutAll: self eventName;
		nextPut: $).! !

!MidiEventTest publicMethods !

eventWith: a with: b with: c
	^ MidiEvent fromArray: (Array with: a with: b with: c).
!

testFromArray
	| evt |
	evt := MidiEvent fromArray: #[129 1 2].
	self
		assert: evt bytes size == 3;
		assert: evt bytes first == 129;
		assert: evt bytes second == 1;
		assert: evt bytes third == 2.
		!

testFromStream
	| strm  evt |
	strm := ReadStream on: #[3 129 1 2].
	evt := MidiEvent fromStream: strm.
	self
		assert: evt bytes size == 3;
		assert: evt bytes first == 129;
		assert: evt bytes second == 1;
		assert: evt bytes third == 2!

testNoteOff
	| evt  |
	evt := self eventWith: 16r83 with: 100 with: 101.
	self
		assert: evt  isNoteOff;
		assert: evt channel == 4;
		assert: evt note == 100;
		assert: evt pressure == 101!

testNoteOn
	| evt  |
	evt := self eventWith: 16r90 with: 100 with: 101.
	self
		assert: evt  isNoteOn;
		assert: evt channel == 1;
		assert: evt note == 100;
		assert: evt pressure == 101! !

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
MidiInput initializeAfterLoad!
CarrillonBase initializeAfterLoad!
MidiEventTest initializeAfterLoad!

CarrillonBase loaded!