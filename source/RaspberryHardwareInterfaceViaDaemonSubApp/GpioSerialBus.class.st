Class {
	#name : 'GpioSerialBus',
	#superclass : 'Object',
	#instVars : [
		'library',
		'handle'
	],
	#pools : [
		'RaspberryGpioConstants'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
GpioSerialBus class >> new [
	"#new cannot be used to create a GpioSerialBus or its sub classes.
		See RaspberryGpioDaemonInterface>createI2cBus: for I2CGpioSerialBus and
		RaspberryGpioDaemonInterface>createSpiBusChannel:speed:flags: for SPIGpioSerialBus."

	^self shouldNotImplement.

]

{ #category : 'Not categorized' }
GpioSerialBus >> handle [
	"Answer the handle we are connected with."

	^handle.

]

{ #category : 'Not categorized' }
GpioSerialBus >> interface [
	"Answer our RaspberryGpioDaemonInterface.
		#interface is probably a better name than #library but a lot of code from the original Squeak interface uses #library."

	^library.

]
