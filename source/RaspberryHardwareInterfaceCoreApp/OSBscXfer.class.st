Class {
	#name : 'OSBscXfer',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSBscXfer class >> control: control rxCnt: rxCnt rxBuf: rxBuf txCnt: txCnt txBuf: txBuf [
	"Create a new instance and set the values."

	^self new control: control; rxCnt: rxCnt; rxBuf: rxBuf; txCnt: txCnt; txBuf: txBuf; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSBscXfer class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(control rxCnt rxBuf txCnt txBuf)
		types: #(uint32 int32 'TCHAR[512]' int32 'TCHAR[512]').

]

{ #category : 'Not categorized' }
OSBscXfer >> control [
	"Answer the value of control."

	^self uint32At: #control.

]

{ #category : 'Not categorized' }
OSBscXfer >> control: anInt [
	"Set the value of control."

	self uint32At: #control put: anInt.

]

{ #category : 'Not categorized' }
OSBscXfer >> rxBuf [
	"Answer the member: CHAR[512] rxBuf."

	^self stringAt: #rxBuf size: 512.

]

{ #category : 'Not categorized' }
OSBscXfer >> rxBuf: aValue [
	"Set the member: CHAR[512] rxBuf."

	self stringAt: #rxBuf put: aValue size: 512.

]

{ #category : 'Not categorized' }
OSBscXfer >> rxCnt [
	"Answer the value of rxCnt."

	^self int32At: #rxCnt.

]

{ #category : 'Not categorized' }
OSBscXfer >> rxCnt: anInt [
	"Set the value of rxCnt."

	self int32At: #rxCnt put: anInt.

]

{ #category : 'Not categorized' }
OSBscXfer >> txBuf [
	"Answer the member: CHAR[512] txBuf."

	^self stringAt: #txBuf size: 512.

]

{ #category : 'Not categorized' }
OSBscXfer >> txBuf: aValue [
	"Set the member: CHAR[512] txBuf."

	self stringAt: #txBuf put: aValue size: 512.

]

{ #category : 'Not categorized' }
OSBscXfer >> txCnt [
	"Answer the value of txCnt."

	^self int32At: #txCnt.

]

{ #category : 'Not categorized' }
OSBscXfer >> txCnt: anInt [
	"Set the value of txCnt."

	self int32At: #txCnt put: anInt.

]
