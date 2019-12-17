Class {
	#name : 'GpioBusDevice',
	#superclass : 'Object',
	#instVars : [
		'bus'
	],
	#pools : [
		'RaspberryGpioConstants'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
GpioBusDevice >> bus [
	"Answer the devices bus object."

	^bus.

]

{ #category : 'Not categorized' }
GpioBusDevice >> release [
	"Release any external library connections etc."

	bus release.

]

{ #category : 'Not categorized' }
GpioBusDevice >> shutDown [
	"Release any external library connections etc."

	bus release.

]
