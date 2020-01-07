"
A GPIODeviceDRV8835MotorDrive can drive half of a a DRV8835 motor driver chip (as per the Pololu RaspberryPi Dual Motor Driver). You need to make two for a full pair, setting the correct pins with #speedPin:directionPin:gpioAccessor:
"
Class {
	#name : 'GpioDeviceDRV8835MotorDrive',
	#superclass : 'GpioDevice',
	#instVars : [
		'speedPin',
		'directionPin'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'initialize-release' }
GpioDeviceDRV8835MotorDrive >> setDirectionPinTo: dir [

	library pin: directionPin write: dir.

]

{ #category : 'initialize-release' }
GpioDeviceDRV8835MotorDrive >> setSpeedPinTo: speed [

	library setPwmPin: speedPin value: speed.


]

{ #category : 'initialize-release' }
GpioDeviceDRV8835MotorDrive >> speed: speed [

	"try to run the motor at 'speed' % of whatever the applicable voltage can provide."
	| motorSpeed |
	motorSpeed := speed min: 100 max: -100.
	(motorSpeed between: -1 and: 1)
		ifTrue: ["consider this 0, turn off"
			^ self setSpeedPinTo: 0].

	motorSpeed positive
		ifTrue: ["we want to go forwards"
			self setDirectionPinTo: 1.
			^self setSpeedPinTo: motorSpeed].

	motorSpeed negative
		ifTrue: ["we want to go backwards"
			self setDirectionPinTo: 0.
			^self setSpeedPinTo: motorSpeed negated].

]

{ #category : 'initialize-release',
  #vaVisibility : 'private' }
GpioDeviceDRV8835MotorDrive >> speedPin: sPin directionPin: dPin gpioInterface: aPiGpiodInterface [
	"Set up the two pins - configure pinA for pwm and pinB for digital writing.
		To create a new instance of GpioDeviceDRV8835MotorDrive,
			call RaspberryGpioDaemonInterface>createGpioDeviceDRV8835MotorDrive:directionPin:."

	library := aPiGpiodInterface.
	speedPin := sPin.
	directionPin := dPin.
	library setPin: speedPin direction: GpioOutput; setPwmRangePin: speedPin value: 100.
	library setPin: directionPin direction: GpioOutput.

]
