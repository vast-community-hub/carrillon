Class {
	#name : 'OSI2cMsg',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSI2cMsg class >> addr: addr flags: flags len: len buf: buf [
	"Create a new instance and set the values."

	^self new addr: addr; flags: flags; len: len; buf: buf; yourself.

]

{ #category : 'Not categorized' }
OSI2cMsg class >> fromArray: anArray [
	"Create a new instance and set the values.  If there is more than one message, answer an array with the messages."
	| messageCnt messages aCnt |

	aCnt := anArray size.
	messageCnt := (aCnt + 3) // 4.
	messages := Array new: messageCnt.
	1 to: messageCnt do: [:p | | i f l b message flags len buf |
		i := ((p - 1) * 4) + 1.
		f := i + 1.
		l := i + 2.
		b := i + 3.
		flags := (f <= aCnt) ifTrue: [anArray at: f] ifFalse: [0].
		len := (l <= aCnt) ifTrue: [anArray at: l] ifFalse: [0].
		buf := (b <= aCnt) ifTrue: [anArray at: b] ifFalse: [0].
		message := self addr: (anArray at: i) flags: flags len: len buf: buf.
		messages at: p put: message.
	].
	^(messageCnt = 1) ifTrue: [messages first] ifFalse: [messages].

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSI2cMsg class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(addr flags len buf)
		types: #(uint16 uint16 uint16 uint8).

]

{ #category : 'Not categorized' }
OSI2cMsg >> addr [
	"Answer the value of addr."

	^self uint16At: #addr.

]

{ #category : 'Not categorized' }
OSI2cMsg >> addr: anInt [
	"Set the value of addr."

	self uint16At: #addr put: anInt.

]

{ #category : 'Not categorized' }
OSI2cMsg >> buf [
	"Answer the value of buf."

	^self uint8At: #buf.

]

{ #category : 'Not categorized' }
OSI2cMsg >> buf: anInt [
	"Set the value of buf."

	self uint16At: #buf put: anInt.

]

{ #category : 'Not categorized' }
OSI2cMsg >> flags [
	"Answer the value of flags."

	^self uint16At: #flags.

]

{ #category : 'Not categorized' }
OSI2cMsg >> flags: anInt [
	"Set the value of flags."

	self uint16At: #flags put: anInt.

]

{ #category : 'Not categorized' }
OSI2cMsg >> len [
	"Answer the value of len."

	^self uint16At: #len.

]

{ #category : 'Not categorized' }
OSI2cMsg >> len: anInt [
	"Set the value of len."

	self uint16At: #len put: anInt.

]
