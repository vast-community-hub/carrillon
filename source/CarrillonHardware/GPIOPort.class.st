Class {
	#name : 'GPIOPort',
	#superclass : 'Object',
	#instVars : [
		'device',
		'bit'
	],
	#category : 'CarrillonHardware'
}

{ #category : 'Not categorized' }
GPIOPort class >> on: aGPIODevice bit: anInteger [
	^self new device: aGPIODevice bit: anInteger
]

{ #category : 'I/O' }
GPIOPort >> clear [
	device clearOutputBit: bit
]

{ #category : 'initialization' }
GPIOPort >> device: aGPIODevice bit: anInteger [
	device := aGPIODevice.
	bit := anInteger.
]

{ #category : 'I/O' }
GPIOPort >> pulseForMilliseconds: anInteger [
	[self set.
	(Delay forMilliseconds: anInteger) wait.
	self clear] fork
]

{ #category : 'I/O' }
GPIOPort >> set [
	device setOutputBit: bit
]

{ #category : 'I/O' }
GPIOPort >> toggle [
	device toggleOutputBit:bit
]

{ #category : 'I/O' }
GPIOPort >> value [
	^device inputBit: bit
]

{ #category : 'I/O' }
GPIOPort >> value: anInteger [
	^device outputBit: bit put: anInteger
]
