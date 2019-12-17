Class {
	#name : 'GPIOPortMock',
	#superclass : 'GPIOPort',
	#instVars : [
		'value'
	],
	#category : 'CarrillonModel'
}

{ #category : 'I/O' }
GPIOPortMock >> clear [
	self value: 0
]

{ #category : 'I/O' }
GPIOPortMock >> set [
	self value: 1
]

{ #category : 'I/O' }
GPIOPortMock >> toggle [
	self value: 1 - self value 
]

{ #category : 'I/O' }
GPIOPortMock >> value [
	^ value
]

{ #category : 'I/O' }
GPIOPortMock >> value: anInteger [
	value := anInteger
]
