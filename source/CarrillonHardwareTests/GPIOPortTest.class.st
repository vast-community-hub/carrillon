Class {
	#name : 'GPIOPortTest',
	#superclass : 'TestCase',
	#instVars : [
		'in',
		'out',
		'port'
	],
	#category : 'CarrillonHardwareTests'
}

{ #category : 'initialization' }
GPIOPortTest >> setUp [
	| device |
	device := I2CDeviceGPIOMCP23017 forTesting. 
	in := device bus in.
	out := device bus out.
	port := GPIOPort on: device bit: 1.
]

{ #category : 'testing' }
GPIOPortTest >> testClear [
	port clear.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testInput [
	in nextPutAll: #(0 2 2 0).
	in reset.
	self
		assert: port value equals: 0;
		assert: port value equals: 1;
		assert: port value equals: 1;
		assert: port value equals: 0.
	out reset.
	self
		assert: out next equals: 16r12;
		assert: out next equals: 16r12;
		assert: out next equals: 16r12;
		assert: out next equals: 16r12.
]

{ #category : 'testing' }
GPIOPortTest >> testPulse [
	port pulseForMilliseconds:5.
	(Delay forMilliseconds: 6) wait.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testPulseCompleted [
	port pulseForMilliseconds:5.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.
	(Delay forMilliseconds: 7) wait.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testPulseIncomplete [
	port pulseForMilliseconds:5.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testSet [
	port set.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testSetClear [
	port
		set;
		clear.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testSetToggle [
	port
		set;
		toggle;
		toggle.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.

]

{ #category : 'testing' }
GPIOPortTest >> testValue [
	port
		value: 1;
		value: 1;
		value: 0.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.

]
