Class {
	#name : 'MidiEventTest',
	#superclass : 'TestCase',
	#category : 'MidiTests'
}

{ #category : 'Not categorized' }
MidiEventTest >> eventWith: a with: b with: c [
	^ MidiEvent fromArray: (Array with: a with: b with: c).

]

{ #category : 'Not categorized' }
MidiEventTest >> testAftertouch [
	| evt  |
	evt := self eventWith: 16rA4 with: 100 with: 101.
	self
		assert: evt  isAftertouch;
		assert: evt channel == 5;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testAftertouchCreation [
	| evt  |
	evt := MidiEventAftertouch channel: 16 note: 255 pressure: 0.
	self
		assert: evt  isAftertouch;
		assert: evt channel equals: 16;
		assert: evt note equals: 255;
		assert: evt pressure equals: 0;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rAF 255 0].

]

{ #category : 'Not categorized' }
MidiEventTest >> testArgument [
	| evt |
	evt := MidiEvent argument: 123.
	self assert: evt argument equals: 123
]

{ #category : 'Not categorized' }
MidiEventTest >> testChannelPressure [
	| evt  |
	evt := self eventWith: 16rD4 with: 100 with: 101.
	self
		assert: evt  isChannelPressure;
		assert: evt channel equals: 5;
		assert: evt pressure equals: 100;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testChannelPressureCreation [
	| evt  |
	evt := MidiEventChannelPressure channel: 5 pressure: 100.
	self
		assert: evt  isChannelPressure;
		assert: evt channel equals: 5;
		assert: evt pressure equals: 100;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rD4 100].
		
]

{ #category : 'Not categorized' }
MidiEventTest >> testClassForMessage [
	self assert: (MidiEvent classForMessage:16r80)  equals: MidiEventNoteOff.
	self assert: (MidiEvent classForMessage:16r90)  equals: MidiEventNoteOn.
	self assert: (MidiEvent classForMessage:16rA0)  equals: MidiEventAftertouch.
	self assert: (MidiEvent classForMessage:16rB0)  equals: MidiEventControlChange.
	self assert: (MidiEvent classForMessage:16rC0)  equals: MidiEventProgramChange.
	self assert: (MidiEvent classForMessage:16rD0)  equals: MidiEventChannelPressure.
	self assert: (MidiEvent classForMessage:16rE0)  equals: MidiEventPitchBend.
	self assert: (MidiEvent classForMessage:16rF0)  equals: MidiEventSystemMessage.

]

{ #category : 'Not categorized' }
MidiEventTest >> testControlChange [
	| evt  |
	evt := self eventWith: 16rB4 with: 100 with: 101.
	self
		assert: evt  isControlChange;
		assert: evt channel == 5;
		assert: evt controller equals: 100;
		assert: evt value equals: 101;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testControlChangeCreation [
	| evt  |
	evt := MidiEventControlChange channel: 1 controller: 100 value: 101.
	self
		assert: evt  isControlChange;
		assert: evt channel == 1;
		assert: evt controller equals: 100;
		assert: evt value equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rB0 100 101].

]

{ #category : 'Not categorized' }
MidiEventTest >> testFromArray [
	| evt |
	evt := MidiEvent fromArray: #[16rF5 12 42].
	self
		assert: evt argument equals: 5;
		assert: evt message equals: 16rF0;
		assert: evt data size equals: 2;
		assert: evt data first equals: 12;
		assert: evt data second equals: 42.
]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteFullName [
	| evt |
	evt := MidiEventNoteOn channel: 0 note: 60 pressure: 0.
	self assert: evt noteFullName equals: 'C4'.
	evt note: 0.
	self assert: evt noteFullName equals: 'C-1'.
	evt note: 127.
	self assert: evt noteFullName equals: 'G9'.

]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteName [
	| evt |
	evt := MidiEventNoteOn channel: 0 note: 60 pressure: 0.
	self assert: evt noteName equals: 'C'.
	evt note: 1.
	self assert: evt noteName equals: 'C#'.
	evt note: 127.
	self assert: evt noteName equals: 'G'.

]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteOctave [
	| evt |
	evt := MidiEventNoteOn channel: 0 note: 60 pressure: 0.
	self assert: evt octave equals: 4.
	evt note: 0.
	self assert: evt octave equals: -1.
	evt note: 127.
	self assert: evt octave equals: 9.

]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteOff [
	| evt  |
	evt := self eventWith: 16r83 with: 100 with: 101.
	self
		assert: evt  isNoteOff;
		assert: evt channel == 4;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOn
]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteOffCreation [
	| evt  |
	evt := MidiEventNoteOff channel: 4 note: 77 pressure: 123.
	self
		assert: evt  isNoteOff;
		assert: evt channel equals: 4;
		assert: evt note equals: 77;
		assert: evt pressure equals: 123;
		deny: evt isNoteOn.
	self assert: evt asByteArray equals: #[16r83 77 123].

]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteOn [
	| evt  |
	evt := self eventWith: 16r90 with: 100 with: 101.
	self
		assert: evt  isNoteOn;
		assert: evt channel == 1;
		assert: evt note == 100;
		assert: evt pressure == 101;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testNoteOnCreation [
	| evt  |
	evt := MidiEventNoteOn channel: 4 note: 77 pressure: 123.
	self
		assert: evt  isNoteOn;
		assert: evt channel equals: 4;
		assert: evt note equals: 77;
		assert: evt pressure equals: 123;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16r93 77 123].

]

{ #category : 'Not categorized' }
MidiEventTest >> testPitchBend [
	| evt  |
	evt := self eventWith: 16rEF with: 100 with: 101.
	self
		assert: evt  isPitchBend;
		assert: evt channel equals: 16;
		assert: evt pitch equals: 100;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testPitchBendCreation [
	| evt  |
	evt := MidiEventPitchBend channel: 2 pitch: 101.
	self
		assert: evt  isPitchBend;
		assert: evt channel equals: 2;
		assert: evt pitch equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rE1  101].

]

{ #category : 'Not categorized' }
MidiEventTest >> testPrintOn [
	| evt |
	evt := MidiEventNoteOn channel: 0 note: 60 pressure: 0.
	self assert: evt printString equals: 'a MidiEventNoteOn C4'.
	evt := MidiEventNoteOff channel: 0 note: 0 pressure: 0.
	self assert: evt printString equals: 'a MidiEventNoteOff C-1'.
	evt := MidiEventAftertouch channel: 0 note:127 pressure: 0.
	self assert: evt printString equals: 'a MidiEventAftertouch G9'.

]

{ #category : 'Not categorized' }
MidiEventTest >> testPrintOnSharp [
	| evt |
	evt := MidiEventNoteOn channel: 0 note: 61 pressure: 0.
	self assert: evt printString equals: 'a MidiEventNoteOn C#4'.
	evt := MidiEventNoteOff channel: 0 note: 1 pressure: 0.
	self assert: evt printString equals: 'a MidiEventNoteOff C#-1'.
	evt := MidiEventAftertouch channel: 0 note:126 pressure: 0.
	self assert: evt printString equals: 'a MidiEventAftertouch F#9'.

]

{ #category : 'Not categorized' }
MidiEventTest >> testProgramChange [
	| evt  |
	evt := self eventWith: 16rCF with: 100 with: 101.
	self
		assert: evt  isProgramChange;
		assert: evt channel equals: 16;
		assert: evt program equals: 100;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testProgramChangeCreation [
	| evt  |
	evt := MidiEventProgramChange channel: 2 program: 101.
	self
		assert: evt  isProgramChange;
		assert: evt channel equals: 2;
		assert: evt program equals: 101;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rC1  101].

]

{ #category : 'Not categorized' }
MidiEventTest >> testSystemMessage [
	| evt  |
	evt := self eventWith: 16rFF with: 100 with: 101.
	self
		assert: evt  isSystemMessage;
		assert: evt argument equals: 15;
		assert: evt data equals: #(100 101);
		assert: evt isReset;
		deny: evt isNoteOff
]

{ #category : 'Not categorized' }
MidiEventTest >> testSystemMessageCreation [
	| evt  |
	evt := MidiEventSystemMessage type: 15 data: #[1 2 3 4 5].
	self
		assert: evt  isSystemMessage;
		assert: evt argument equals: 15;
		assert: evt data equals: #[1 2 3 4 5];
		assert: evt isReset;
		deny: evt isNoteOff.
	self assert: evt asByteArray equals: #[16rFF 1 2 3 4 5].

]

{ #category : 'Not categorized' }
MidiEventTest >> testSystemMessageTypes [
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

]
