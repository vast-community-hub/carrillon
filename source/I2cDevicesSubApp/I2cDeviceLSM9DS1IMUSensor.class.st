"
An LSM9DS1 IMU sensor is an i2c chip with 6 DoF acceleration sensing - linear and rotational. It also includes a slave i2c magnetometer, handled by the I2CDeviceLSM9DS1MagnetometerSensor class.

This is a pretty complex chip to handle, requiring an external calibraion program to derive purportedly sensible config values, which ought to be read from a file. We're just hard-coding them for now because tedium set in. There is also some complex maths (as in multi-dimensional) to futz around with the raw output that needs to be written.

Read the unprocessed gyro and accelerometer values with #readAccelerometerRAw & #readGyroRaw.
"
Class {
	#name : 'I2cDeviceLSM9DS1IMUSensor',
	#superclass : 'I2cDevice',
	#instVars : [
		'chosenGyroSampleRate',
		'sampleRate',
		'sampleInterval',
		'chosenGyroBandWidth',
		'chosenGyroFSR',
		'gyroScale',
		'chosenGyroHPF',
		'accelerometerScale',
		'chosenAccelerometerFSR',
		'chosenAccelerometerSampleRate',
		'chosenAccelerometerLPF',
		'gyroLearningAlpha',
		'gyroContinuousAlpha',
		'gyroSampleCount',
		'gyroX',
		'gyroY',
		'gyroZ',
		'accelerometerX',
		'accelerometerY',
		'accelerometerZ'
	],
	#category : 'I2cDevicesSubApp'
}

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> accelerometerX [
	"read the raw x values from the accelerometer"
	^self readAccelerometerRawX * accelerometerScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> accelerometerY [
	"read the raw x values from the accelerometer"
	^self readAccelerometerRawY * accelerometerScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> accelerometerZ [
	"read the raw x values from the accelerometer"
	^self readAccelerometerRawZ * accelerometerScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> gyroX [
	"return the floating point value of the gyro current reading"
	^ self readGyroRawX * gyroScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> gyroY [
	"return the floating point value of the gyro current reading"
	^ self readGyroRawY * gyroScale
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> gyroZ [
	"return the floating point value of the gyro current reading"
	^ self readGyroRawZ * gyroScale
]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> initialize [
	"set some values that should really be derived from a config file; later, young Padawan"
	chosenGyroSampleRate := 2.
	chosenGyroBandWidth := 1.
	chosenGyroFSR := 1.
	chosenGyroHPF := 4.
	chosenAccelerometerSampleRate := 3.
	chosenAccelerometerFSR := 3.
	chosenAccelerometerLPF := 3
]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> initializeRegisters [
	"check the whoAmI value"

	bus whoAmI = self whoAmI
		ifTrue: ["power up, set data rate"
			self
				setGyroCtrl1;
				setGyroCtrl3;
				setAccelCtrl6;
				setAccelCtrl7;
				setGyroBias]
]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readAccelerometerRaw [
	"read the raw x,y,z values from the accelerometer"

	accelerometerX := bus registerPairSigned: AccelerometerXOutputRegister.
	accelerometerY := bus registerPairSigned: AccelerometerYOutputRegister.
	accelerometerZ := bus registerPairSigned: AccelerometerZOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readAccelerometerRawX [
	"read the raw x values from the accelerometer"

	^accelerometerX := bus registerPairSigned: AccelerometerXOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readAccelerometerRawY [
	"read the raw y values from the accelerometer"

	^accelerometerY := bus registerPairSigned: AccelerometerYOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readAccelerometerRawZ [
	"read the raw z values from the accelerometer"

	^accelerometerZ := bus registerPairSigned: AccelerometerZOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readGyroRaw [
	"read the raw x,y,z values from the gyro"

	gyroX := bus registerPairSigned: GyroXOutputRegister.
	gyroY := bus registerPairSigned: GyroYOutputRegister.
	gyroZ := bus registerPairSigned: GyroZOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readGyroRawX [
	"read the raw x values from the gyro"

	^gyroX := bus registerPairSigned: GyroXOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readGyroRawY [
	"read the raw y values from the gyro"

	^gyroY := bus registerPairSigned: GyroYOutputRegister.

]

{ #category : 'device read/write' }
I2cDeviceLSM9DS1IMUSensor >> readGyroRawZ [
	"read the raw z values from the gyro"

	^gyroZ := bus registerPairSigned: GyroZOutputRegister.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> setAccelCtrl6 [
	"set the accelerometer sample rate etc"

	accelerometerScale := #( 0.000061 0.000122 0.000244 0.000732) at: chosenAccelerometerFSR.
	bus register: GyroCtrlRegister6 value: (chosenAccelerometerSampleRate << 5 bitOr: (chosenAccelerometerFSR << 3 bitOr: (chosenAccelerometerLPF))).

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> setAccelCtrl7 [
	"set the ctrl7 reg to 0"

	bus register: GyroCtrlRegister7 value: 0.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> setGyroBias [
	"set upsome gyro calculation values"
	gyroLearningAlpha := 2.0 /sampleRate.
	gyroContinuousAlpha := 0.01 / sampleRate.
	gyroSampleCount := 0
]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> setGyroCtrl1 [
	"power up the gyro and set the sampling rate"
	| value |
	value := 16r20 * chosenGyroSampleRate.
	sampleRate := #(15 60 119 238 476 952) at: chosenGyroSampleRate.
	sampleInterval := 1000000.0 / sampleRate.
	value := value bitOr: chosenGyroBandWidth.
	value := value bitOr: ( #(0 8 nil 16r18) at: chosenGyroFSR). "NB '3' is invalid, test for this somewhere"
	gyroScale := ( #(0.00875 0.0175 0.07) at: chosenGyroFSR) degreesToRadians.
	bus register: GyroCtrlRegister1 value: value.

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> setGyroCtrl3 [
	"set the high pass filter"

	bus register: GyroCtrlRegister3 value: (16r40 bitOr: chosenGyroHPF).

]

{ #category : 'initialize-release' }
I2cDeviceLSM9DS1IMUSensor >> whoAmI [
	"what is the ID byte value for one of me"
	^16r68 "per the STI data sheet"
]
