

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

MidiEvent class categoriesFor: #'argument:' are: #('instance creation')!
MidiEvent class categoriesFor: #'channel:' are: #('instance creation')!
MidiEvent class categoriesFor: #'classForMessage:' are: #('factory')!
MidiEvent class categoriesFor: #'fromArray:' are: #('instance creation')!
MidiEvent class categoriesFor: #'message' are: #('factory')!

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

MidiEvent categoriesFor: #'argument' are: #('accessing')!
MidiEvent categoriesFor: #'argument:' are: #('accessing')!
MidiEvent categoriesFor: #'channel' are: #('accessing')!
MidiEvent categoriesFor: #'channel:' are: #('accessing')!
MidiEvent categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEvent categoriesFor: #'isAftertouch' are: #('testing')!
MidiEvent categoriesFor: #'isChannelPressure' are: #('testing')!
MidiEvent categoriesFor: #'isControlChange' are: #('testing')!
MidiEvent categoriesFor: #'isNoteOff' are: #('testing')!
MidiEvent categoriesFor: #'isNoteOn' are: #('testing')!
MidiEvent categoriesFor: #'isPitchBend' are: #('testing')!
MidiEvent categoriesFor: #'isProgramChange' are: #('testing')!
MidiEvent categoriesFor: #'isSystemMessage' are: #('testing')!
MidiEvent categoriesFor: #'message' are: #('accessing')!
MidiEvent categoriesFor: #'status' are: #('accessing')!

!MidiEventAftertouch class publicMethods !

message
	^16rA0! !

MidiEventAftertouch class categoriesFor: #'message' are: #('factory')!

!MidiEventAftertouch publicMethods !

isAftertouch
	^true! !

MidiEventAftertouch categoriesFor: #'isAftertouch' are: #('testing')!

!MidiEventChannelPressure class publicMethods !

channel: channel pressure: pressure
	^(self channel: channel) pressure: pressure!

message
	^16rD0! !

MidiEventChannelPressure class categoriesFor: #'channel:pressure:' are: #('instance creation')!
MidiEventChannelPressure class categoriesFor: #'message' are: #('factory')!

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

MidiEventChannelPressure categoriesFor: #'asByteArray' are: #('converting')!
MidiEventChannelPressure categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventChannelPressure categoriesFor: #'isChannelPressure' are: #('testing')!
MidiEventChannelPressure categoriesFor: #'pressure' are: #('accessing')!
MidiEventChannelPressure categoriesFor: #'pressure:' are: #('accessing')!

!MidiEventControlChange class publicMethods !

channel: channel controller: controller value: value
	^(self channel: channel)
			controller: controller;
			value: value!

message
	^16rB0! !

MidiEventControlChange class categoriesFor: #'channel:controller:value:' are: #('instance creation')!
MidiEventControlChange class categoriesFor: #'message' are: #('factory')!

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

MidiEventControlChange categoriesFor: #'asByteArray' are: #('converting')!
MidiEventControlChange categoriesFor: #'controller' are: #('accessing')!
MidiEventControlChange categoriesFor: #'controller:' are: #('accessing')!
MidiEventControlChange categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventControlChange categoriesFor: #'isControlChange' are: #('testing')!
MidiEventControlChange categoriesFor: #'value' are: #('accessing')!
MidiEventControlChange categoriesFor: #'value:' are: #('accessing')!

!MidiEventNoteOff class publicMethods !

message
	^16r80! !

MidiEventNoteOff class categoriesFor: #'message' are: #('factory')!

!MidiEventNoteOff publicMethods !

isNoteOff
	^true! !

MidiEventNoteOff categoriesFor: #'isNoteOff' are: #('testing')!

!MidiEventNoteOn class publicMethods !

message
	^16r90! !

MidiEventNoteOn class categoriesFor: #'message' are: #('factory')!

!MidiEventNoteOn publicMethods !

isNoteOn
	^true! !

MidiEventNoteOn categoriesFor: #'isNoteOn' are: #('testing')!

!MidiEventOnOffAftertouch class publicMethods !

channel: channel note: note pressure: pressure
	^(self channel: channel)
		note: note;
		pressure: pressure!

message
	^nil! !

MidiEventOnOffAftertouch class categoriesFor: #'channel:note:pressure:' are: #('instance creation')!
MidiEventOnOffAftertouch class categoriesFor: #'message' are: #('factory')!

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

MidiEventOnOffAftertouch categoriesFor: #'asByteArray' are: #('converting')!
MidiEventOnOffAftertouch categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventOnOffAftertouch categoriesFor: #'note' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'note:' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'noteFullName' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'noteName' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'octave' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'pressure' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'pressure:' are: #('accessing')!
MidiEventOnOffAftertouch categoriesFor: #'printOn:' are: #('printing')!

!MidiEventPitchBend class publicMethods !

channel: channel pitch: pitch
	^(self channel: channel) pitch: pitch!

message
	^16rE0! !

MidiEventPitchBend class categoriesFor: #'channel:pitch:' are: #('instance creation')!
MidiEventPitchBend class categoriesFor: #'message' are: #('factory')!

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

MidiEventPitchBend categoriesFor: #'asByteArray' are: #('converting')!
MidiEventPitchBend categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventPitchBend categoriesFor: #'isPitchBend' are: #('testing')!
MidiEventPitchBend categoriesFor: #'pitch' are: #('accessing')!
MidiEventPitchBend categoriesFor: #'pitch:' are: #('accessing')!

!MidiEventProgramChange class publicMethods !

channel: channel program: program
	^(self channel: channel) program: program!

message
	^16rC0! !

MidiEventProgramChange class categoriesFor: #'channel:program:' are: #('instance creation')!
MidiEventProgramChange class categoriesFor: #'message' are: #('factory')!

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

MidiEventProgramChange categoriesFor: #'asByteArray' are: #('converting')!
MidiEventProgramChange categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventProgramChange categoriesFor: #'isProgramChange' are: #('testing')!
MidiEventProgramChange categoriesFor: #'program' are: #('accessing')!
MidiEventProgramChange categoriesFor: #'program:' are: #('accessing')!

!MidiEventSystemMessage class publicMethods !

message
	^16rF0!

type: type data: aByteArray
	^(self argument: type) data: aByteArray! !

MidiEventSystemMessage class categoriesFor: #'message' are: #('factory')!
MidiEventSystemMessage class categoriesFor: #'type:data:' are: #('instance creation')!

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

MidiEventSystemMessage categoriesFor: #'asByteArray' are: #('converting')!
MidiEventSystemMessage categoriesFor: #'data' are: #('accessing')!
MidiEventSystemMessage categoriesFor: #'data:' are: #('accessing')!
MidiEventSystemMessage categoriesFor: #'fromBytes:' are: #('initialization')!
MidiEventSystemMessage categoriesFor: #'isActiveSensing' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isReset' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isSequenceContinue' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isSequenceStart' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isSequenceStop' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isSystemMessage' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isTimingClock' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isUndefined' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isUndefined1' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'isUndefined2' are: #('testing')!
MidiEventSystemMessage categoriesFor: #'type' are: #('accessing')!

!MidiInput class publicMethods !

localAddress
	^'127.0.0.1:8383'! !

MidiInput class categoriesFor: #'localAddress' are: #('Not categorized')!

!MidiInput publicMethods !

nextEvent
	| count bytes |
	count := peer next.
	bytes := peer next: count.
	^MidiEvent fromArray: bytes! !

MidiInput categoriesFor: #'nextEvent' are: #('Not categorized')!

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

MidiInputOutput class categoriesFor: #'exampleProxy' are: #('Not categorized')!
MidiInputOutput class categoriesFor: #'exampleProxyChorder' are: #('Not categorized')!
MidiInputOutput class categoriesFor: #'localProxy' are: #('Not categorized')!
MidiInputOutput class categoriesFor: #'peer:' are: #('Not categorized')!

!MidiInputOutput publicMethods !

peer: aStream
	peer := aStream! !

MidiInputOutput categoriesFor: #'peer:' are: #('Not categorized')!

!MidiOutput class publicMethods !

localAddress
	^'127.0.0.1:8384'! !

MidiOutput class categoriesFor: #'localAddress' are: #('Not categorized')!

!MidiOutput publicMethods !

nextEventPut: aMidiEvent
	| bytes |
	bytes := aMidiEvent asByteArray.
	peer nextPut: bytes size; nextPutAll: bytes; flush! !

MidiOutput categoriesFor: #'nextEventPut:' are: #('Not categorized')!

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