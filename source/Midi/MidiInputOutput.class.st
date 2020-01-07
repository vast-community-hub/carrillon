Class {
	#name : 'MidiInputOutput',
	#superclass : 'Object',
	#instVars : [
		'peer'
	],
	#category : 'Midi'
}

{ #category : 'Not categorized' }
MidiInputOutput class >> exampleProxy [
	"
	  self exampleProxy
	"
	| in out |
	in := MidiInput localProxy.
	out := MidiOutput localProxy.
	[true] whileTrue: [out nextEventPut: in nextEvent].
	
]

{ #category : 'Not categorized' }
MidiInputOutput class >> exampleProxyChorder [
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
	
	
]

{ #category : 'Not categorized' }
MidiInputOutput class >> localProxy [
	| addr socket peer |
	addr := SciSocketAddress fromString: self localAddress.
	socket := SciSocket newStreamSocket connect: addr.
	peer := SstSocketStream on: socket.
	^self peer: peer


]

{ #category : 'Not categorized' }
MidiInputOutput class >> peer: strm [
	^self new peer: strm
]

{ #category : 'Not categorized' }
MidiInputOutput >> peer: aStream [
	peer := aStream
]
