"
This is an abstract class to support an assortment of Raspberry Pi GPIO devices such as the 8833PWP dual H-bridge motor driver chip.  Most of them use two or more pins and may need to carefully  correlate the values for each of them to prevent escape of magic smoke.
"
Class {
	#name : 'GpioDevice',
	#superclass : 'Object',
	#instVars : [
		'library'
	],
	#pools : [
		'RaspberryGpioConstants'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
GpioDevice class >> new [
	"#new cannot be used to create a GpioDevice.
		To create a new instance of GpioDeviceDRV8835MotorDrive,
			call RaspberryGpioDaemonInterface>createGpioDeviceDRV8835MotorDrive:directionPin:.
		To create a new instance of GpioDeviceHBridge,
			call RaspberryGpioDaemonInterface>createGpioDeviceHBridge:pinB:."

	^self shouldNotImplement.

]
