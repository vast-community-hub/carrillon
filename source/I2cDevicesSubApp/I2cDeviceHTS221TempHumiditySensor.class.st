"
An HTS221 is an i2c chip with temperature and humidity sensing. The api is extremely simple - use #readHumidty or #readTemp for the obvious purposes.
"
Class {
	#name : 'I2cDeviceHTS221TempHumiditySensor',
	#superclass : 'I2cDevice',
	#instVars : [
		'tempM',
		'tempC',
		'humidM',
		'humidC',
		'lastTemp',
		'lastHumidity'
	],
	#category : 'I2cDevicesSubApp'
}

{ #category : 'initialize-release' }
I2cDeviceHTS221TempHumiditySensor >> calibrateSensors [
	"slightly involved calibration dance"
	| a b t0 t1 t0out t1out h0 h1 h0out h1out |

	a := bus register: T1T0MSBRegister.
	b := bus register: T0degCRegister.
	t0 := ((a bitAnd: 3) << 8 bitOr: b) / 8.0.
	b := bus register: T1degCRegister.
	t1 := ((a bitAnd: 12) << 6 bitOr: b) / 8.0.
	t0out := bus registerPairSigned: T0OutRegister.

	t1out := bus registerPairSigned: T1OutRegister.

	h0 := (bus register: H0HRegister) / 2.0.
	h1 := (bus register: H1HRegister) / 2.0.

	h0out := bus registerPairSigned: H0T0OutRegister.

	h1out := bus registerPairSigned: H1T0OutRegister.

	tempM := t1 - t0 / (t1out - t0out).
	tempC := t0 - (tempM * t0out).
	humidM := h1 - h0 / (h1out - h0out).
	humidC := h0 - (humidM * h0out)
]

{ #category : 'initialize-release' }
I2cDeviceHTS221TempHumiditySensor >> initializeRegisters [
	"check the whoAmI value"

	bus whoAmI = self whoAmI
		ifTrue: ["power up, set data rate"
			bus register: CtrlRegister1 value: 135.
			"humidity & temp resolution"
			bus register: AvConfRegister value: 27.
			self calibrateSensors]
]

{ #category : 'initialize-release' }
I2cDeviceHTS221TempHumiditySensor >> readHumidity [
	"check the status and return the latest reading"
	| t |

	^((bus register: StatusRegister) anyMask: 2)
		ifTrue: [t := bus registerPairSigned: HumidityOutRegister.
			lastHumidity := t * humidM + humidC]
		ifFalse: [lastHumidity]
]

{ #category : 'initialize-release' }
I2cDeviceHTS221TempHumiditySensor >> readTemp [
	"check the status and return the latest reading"
	| t |

	^((bus register: StatusRegister) anyMask: 1)
		ifTrue: [t := bus registerPairSigned: TempHumidityOutRegister.
			lastTemp := t * tempM + tempC]
		ifFalse: [lastTemp]
]

{ #category : 'initialize-release' }
I2cDeviceHTS221TempHumiditySensor >> whoAmI [
	"what is the ID byte value for one of me"
	^16rBC "per the STI data sheet"
]
