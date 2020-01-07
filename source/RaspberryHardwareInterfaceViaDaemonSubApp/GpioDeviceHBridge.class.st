Class {
	#name : 'GpioDeviceHBridge',
	#superclass : 'GpioDevice',
	#instVars : [
		'pinA',
		'pinB',
		'activePin'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
GpioDeviceHBridge >> configPin: pinNumber [

	library setPin: pinNumber direction: GpioOutput; setPwmRangePin: pinNumber value: 100.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
GpioDeviceHBridge >> pinA: pinANumber pinB: pinBNumber gpioInterface: aRaspberryGpioDaemonInterface [
	"Set up the two pins - configure them for pwm.
		To create a new instance of GpioDeviceHBridge,
			call RaspberryGpioDaemonInterface>createGpioDeviceHBridge:pinB:."

	library := aRaspberryGpioDaemonInterface.
	pinA := pinANumber.
	pinB := pinBNumber.
	self configPin: pinA; configPin: pinB.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
GpioDeviceHBridge >> setActivePinTo: speed [

	"Set the active pin value. Don't use except from #speed:
		soft PWM pins will be configured by the RaspberryGpioDaemonInterface"

	activePin ifNotNil: [library setPwmPin: activePin value: speed].

]

{ #category : 'Not categorized' }
GpioDeviceHBridge >> speed: speed [

	"Try to run the motor at 'speed' % of whatever the applicable voltage can provide.
		We need to choose the appropriate pin to pwm wiggle, and make sure that the unused on is set to 0 before firing up the 'live' pin"
	| motorSpeed |

	motorSpeed := speed min: 100 max: -100.
	(motorSpeed between: -1 and: 1)
		ifTrue: ["consider this 0, turn off"
			^ activePin
				ifNotNil: [self setActivePinTo: 0.
					activePin := nil]].

	motorSpeed positive
		ifTrue: ["we want to go forwards; first make sure we're not currently going backwards"
			activePin = pinB
				ifTrue: [self setActivePinTo: 0].
			activePin := pinA.
			^ self setActivePinTo: motorSpeed].

	motorSpeed negative
		ifTrue: ["we want to go backwards; first make sure we're not currently going forwards"
			activePin = pinA
				ifTrue: [self setActivePinTo: 0].
			activePin := pinB.
			self setActivePinTo: motorSpeed abs].


]
