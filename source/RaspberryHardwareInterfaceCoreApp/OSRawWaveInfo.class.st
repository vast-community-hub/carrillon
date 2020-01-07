Class {
	#name : 'OSRawWaveInfo',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSRawWaveInfo class >> botCB: botCB topCB: topCB botOOL: botOOL topOOL: topOOL deleted: deleted numCB: numCB numBOOL: numBOOL numTOOL: numTOOL [
	"Create a new instance and set the values."

	^self new botCB: botCB; topCB: topCB; botOOL: botOOL; topOOL: topOOL;
		deleted: deleted; numCB: numCB; numBOOL: numBOOL; numTOOL: numTOOL; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSRawWaveInfo class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(botCB topCB botOOL topOLL deleted numCB numBOOL numTOOL)
		types: #(uint16 uint16 uint16 uint16 uint16 uint16 uint16 uint16).

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> botCB [
	"Answer the value of botCB."

	^self uint16At: #botCB.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> botCB: anInt [
	"Set the value of botCB."

	self uint16At: #botCB put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> botOOL [
	"Answer the value of botOOL."

	^self uint16At: #botOOL.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> botOOL: anInt [
	"Set the value of botOOL."

	self uint16At: #botOOL put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> deleted [
	"Answer the value of deleted."

	^self uint16At: #deleted.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> deleted: anInt [
	"Set the value of deleted."

	self uint16At: #deleted put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numBOOL [
	"Answer the value of numBOOL."

	^self uint16At: #numBOOL.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numBOOL: anInt [
	"Set the value of numBOOL."

	self uint16At: #numBOOL put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numCB [
	"Answer the value of numCB."

	^self uint16At: #numCB.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numCB: anInt [
	"Set the value of numCB."

	self uint16At: #numCB put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numTOOL [
	"Answer the value of numTOOL."

	^self uint16At: #numTOOL.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> numTOOL: anInt [
	"Set the value of numTOOL."

	self uint16At: #numTOOL put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> topCB [
	"Answer the value of topCB."

	^self uint16At: #topCB.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> topCB: anInt [
	"Set the value of topCB."

	self uint16At: #topCB put: anInt.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> topOOL [
	"Answer the value of topOOL."

	^self uint16At: #topOOL.

]

{ #category : 'Not categorized' }
OSRawWaveInfo >> topOOL: anInt [
	"Set the value of topOOL."

	self uint16At: #topOOL put: anInt.

]
