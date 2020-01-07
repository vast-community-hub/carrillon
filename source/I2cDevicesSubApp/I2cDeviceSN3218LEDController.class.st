"
An I2CDeviceSN3218LEDController drives an SN3218 LED DRiver chip; see spec sheet by googling it

"
Class {
	#name : 'I2cDeviceSN3218LEDController',
	#superclass : 'I2cDevice',
	#category : 'I2cDevicesSubApp'
}

{ #category : 'initialize-release' }
I2cDeviceSN3218LEDController >> initializeRegisters [
	"SN3218 doesn't do whoAmI, so we have to trust"

	bus register: 0 value: 1;			"set normal operation mode"
		register: 16r13 value: 16r3F; 	"enable outputs 1-6"
		register: 16r14 value: 16r3F; 	"enable outputs 7-12"
		register: 16r15 value: 16r3F;	"enable outputs 13-18"
		register: 16r16 value: 0			"update all above values"
]

{ #category : 'initialize-release' }
I2cDeviceSN3218LEDController >> led: ledNum value: brightness [
	"set led to brightness and update the device"

	bus register: (ledNum min: 18 max: 1) value: (brightness min:255 max: 0).
	bus register: UpdateRegister value: 0.

]
