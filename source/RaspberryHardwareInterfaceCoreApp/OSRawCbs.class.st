Class {
	#name : 'OSRawCbs',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSRawCbs class >> info: info src: src dst: dst length: length stride: stride next: next [
	"Create a new instance and set the values."

	^self new info: info; src: src; dst: dst; length: length; stride: stride; next: next; yourself.

]

{ #category : 'Not categorized' }
OSRawCbs class >> info: info src: src dst: dst length: length stride: stride next: next pad: pad [
	"Create a new instance and set the values."

	^self new info: info; src: src; dst: dst; length: length; stride: stride; next: next; pad: pad; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSRawCbs class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(info src dst length stride next pad)
		types: #(uint32 uint32 uint32 uint32 uint32 uint32 'uint32[2]').

]

{ #category : 'Not categorized' }
OSRawCbs >> dst [
	"Answer the value of dst."

	^self uint32At: #dst.

]

{ #category : 'Not categorized' }
OSRawCbs >> dst: anInt [
	"Set the value of dst."

	self uint32At: #dst put: anInt.

]

{ #category : 'Not categorized' }
OSRawCbs >> info [
	"Answer the value of info."

	^self uint32At: #info.

]

{ #category : 'Not categorized' }
OSRawCbs >> info: anInt [
	"Set the value of info."

	self uint32At: #info put: anInt.

]

{ #category : 'Not categorized' }
OSRawCbs >> length [
	"Answer the value of length."

	^self uint32At: #length.

]

{ #category : 'Not categorized' }
OSRawCbs >> length: anInt [
	"Set the value of length."

	self uint32At: #length put: anInt.

]

{ #category : 'Not categorized' }
OSRawCbs >> next [
	"Answer the value of next."

	^self uint32At: #next.

]

{ #category : 'Not categorized' }
OSRawCbs >> next: anInt [
	"Set the value of next."

	self uint32At: #next put: anInt.

]

{ #category : 'Not categorized' }
OSRawCbs >> pad [
	"Answer the member: DWORD[2] pad."

	^self arrayAt: #pad size: 2 type: OSUInt32.

]

{ #category : 'Not categorized' }
OSRawCbs >> pad: aValue [
	"Set the member: DWORD[2] pad."

	self arrayAt: #pad put: aValue size: 2.

]

{ #category : 'Not categorized' }
OSRawCbs >> src [
	"Answer the value of src."

	^self uint32At: #src.

]

{ #category : 'Not categorized' }
OSRawCbs >> src: anInt [
	"Set the value of src."

	self uint32At: #src put: anInt.

]

{ #category : 'Not categorized' }
OSRawCbs >> stride [
	"Answer the value of stride."

	^self uint32At: #stride.

]

{ #category : 'Not categorized' }
OSRawCbs >> stride: anInt [
	"Set the value of stride."

	self uint32At: #stride put: anInt.

]
