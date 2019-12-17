"
An LSM9DS1 magnetometer sensor is a slave part of the I2CDeviceLSM9DS1IMUSensor class/device. 

Read the unprocessed values with #readMagnetometerRaw
"
Class {
	#name : 'I2cDeviceLSM9DS1MagnetometerSensor',
	#superclass : 'I2cDevice',
	#instVars : [
		'chosenCompassSampleRate',
		'compassScale',
		'chosenCompassFSR',
		'magnetometerX',
		'magnetometerY',
		'magnetometerZ'
	],
	#category : 'I2cDevicesSubApp'
}

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> initialize [
	"set some values that should really be derived from a config file; later, young Padawan"
	chosenCompassSampleRate := 5.
	chosenCompassFSR := 0
]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> initializeRegisters [
	"check the whoAmI value"

	bus whoAmI = self whoAmI
		ifTrue: ["power up, set data rate"
			self
				setCompassCtrl1;
				setCompassCtrl2;
				setCompassCtrl3]
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> magnetometerX [
	"read the raw x values from the accelerometer"
	^self readMagnetometerRawX * compassScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> magnetometerY [
	"read the raw x values from the accelerometer"
	^self readMagnetometerRawY * compassScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> magnetometerZ [
	"read the raw x values from the accelerometer"
	^self readMagnetometerRawZ * compassScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> readMagnetometerRaw [
	"read the raw x,y,z values from the accelerometer"

	magnetometerX := bus registerPairSigned: MagnetometerXOutputRegister.
	magnetometerY := bus registerPairSigned: MagnetometerYOutputRegister.
	magnetometerZ := bus registerPairSigned: MagnetometerZOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> readMagnetometerRawX [
	"read the raw x values from the accelerometer"

	^magnetometerX := bus registerPairSigned: MagnetometerXOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> readMagnetometerRawY [
	"read the raw y values from the accelerometer"

	^magnetometerY := bus registerPairSigned: MagnetometerYOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1MagnetometerSensor >> readMagnetometerRawZ [
	"read the raw z values from the accelerometer"

	^magnetometerZ := bus registerPairSigned: MagnetometerZOutputRegister.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> setCompassCtrl1 [
	"setup magnetometer compass sample rate"

	bus register: MagnetometerCtrlRegister1 value: chosenCompassSampleRate << 2.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> setCompassCtrl2 [
	"set magnetometer compass scalling factors"

	compassScale := #(0.014 0.029 0.043 0.058) at: chosenCompassFSR +1.
	bus register: MagnetometerCtrlRegister2 value: chosenCompassFSR * 16r20.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> setCompassCtrl3 [
	"make sure ctrl 3 is 0'd"

	bus register: MagnetometerCtrlRegister3 value: 0.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1MagnetometerSensor >> whoAmI [
	"what is the ID byte value for one of me"
	^16r3D "per the STI data sheet"
]
