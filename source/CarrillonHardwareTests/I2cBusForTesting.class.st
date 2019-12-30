Class {
	#name : 'I2cBusForTesting',
	#superclass : 'Object',
	#instVars : [
		'in',
		'out'
	],
	#category : 'CarrillonHardwareTests'
}

{ #category : 'Not categorized' }
I2cBusForTesting class >> new [
	^super new initialize
]

{ #category : 'Not categorized' }
I2cBusForTesting >> in [
	^in
]

{ #category : 'Not categorized' }
I2cBusForTesting >> initialize [
	in := ReadWriteStream on: OrderedCollection new.
	out := ReadWriteStream on: OrderedCollection new.

]

{ #category : 'Not categorized' }
I2cBusForTesting >> out [
	^out
]

{ #category : 'Not categorized' }
I2cBusForTesting >> register16: aSmallInteger [

	out nextPut: aSmallInteger.
	^in next
]

{ #category : 'Not categorized' }
I2cBusForTesting >> register16: index value: value [
	out nextPut: index; nextPut: value
]
