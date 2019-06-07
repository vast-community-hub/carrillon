

Application create: #Midi with:
    (#( SstSocketCommunications)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #Midi missing: each]])!

Midi becomeDefault!
Object subclass: #MidiEvent
    classInstanceVariableNames: ''
    instanceVariableNames: 'argument '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventChannelPressure
    classInstanceVariableNames: ''
    instanceVariableNames: 'pressure '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventControlChange
    classInstanceVariableNames: ''
    instanceVariableNames: 'controller value '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventOnOffAftertouch
    classInstanceVariableNames: ''
    instanceVariableNames: 'note pressure '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventAftertouch
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventNoteOff
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEventOnOffAftertouch subclass: #MidiEventNoteOn
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventPitchBend
    classInstanceVariableNames: ''
    instanceVariableNames: 'pitch '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventProgramChange
    classInstanceVariableNames: ''
    instanceVariableNames: 'program '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiEvent subclass: #MidiEventSystemMessage
    classInstanceVariableNames: ''
    instanceVariableNames: 'data '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
Object subclass: #MidiInputOutput
    classInstanceVariableNames: ''
    instanceVariableNames: 'peer '
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiInputOutput subclass: #MidiInput
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
MidiInputOutput subclass: #MidiOutput
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

Midi becomeDefault!
Application subclass: #Midi
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!


Midi becomeDefault!

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

noteFullName
	^self noteName, self octave asString!

noteName
	" 0 is Ce "
	^#('C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B') at: self note \\ 12 + 1!

octave
	" 12 semi-tones per octave "
	^self note // 12 - 1!

pressure
	^pressure!

pressure: anObject
	pressure := anObject!

printOn: strm
	super printOn: strm.
	strm space; nextPutAll: self noteFullName! !

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

exampleProxy
	"
	  self exampleProxy
	"
	| in out |
	in := MidiInput localProxy.
	out := MidiOutput localProxy.
	[true] whileTrue: [out nextEventPut: in nextEvent].
	!

exampleProxyChorder
	"
	  self exampleProxyChorder
	"
	| in out evt |
	in := MidiInput localProxy.
	out := MidiOutput localProxy.
	[[true] whileTrue: [
		evt := in nextEvent.
		out nextEventPut: evt.
		Transcript nextPutAll: 'Received '; nextPutAll: evt printString; cr.
		(evt isNoteOn | evt isNoteOff | evt isAftertouch) ifTrue: [ 
			evt note: evt note + 4.
			out nextEventPut: evt.
			evt note: evt note + 3.
			out nextEventPut: evt.]
	]] forkAt: Processor userBackgroundPriority named: self name.
	
	!

localProxy
	| addr socket peer |
	addr := SciSocketAddress fromString: self localAddress.
	socket := SciSocket newStreamSocket connect: addr.
	peer := SstSocketStream on: socket.
	^self peer: peer

!

peer: strm
	^self new peer: strm! !

!MidiInputOutput publicMethods !

peer: aStream
	peer := aStream! !

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
Midi initializeAfterLoad!

Midi loaded!