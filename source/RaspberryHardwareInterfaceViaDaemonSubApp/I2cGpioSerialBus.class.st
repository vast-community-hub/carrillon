"
An I2CBus connection for Raspberry Pi using the pigpio library. I keep a handle for the particular i2c interface provided by pigpiod, whihc needs to be released at times.
"
Class {
	#name : 'I2cGpioSerialBus',
	#superclass : 'GpioSerialBus',
	#instVars : [
		'slaveAddress'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
I2cGpioSerialBus class >> new [
	"#new cannot be used to create a GpioSerialBus or its sub classes.
		See RaspberryGpioDaemonInterface>createI2cBus: for I2CGpioSerialBus and
		RaspberryGpioDaemonInterface>createSpiBusChannel:speed:flags: for SPIGpioSerialBus."

	^self shouldNotImplement.

]

{ #category : 'initialize-release' }
I2cGpioSerialBus >> interface: aRaspberryGpioDaemonInterface handle: aHandle slaveAddress: anAddress [
	"Set our data.  If any of the data is set, we exit without making changes.
		This method should only be called from an instance of RaspberryGpioDaemonInterface by #createI2cBus:"

	(library isNil & handle isNil & slaveAddress isNil) ifTrue: [
		library := aRaspberryGpioDaemonInterface.
		handle := aHandle.
		slaveAddress := anAddress.
	].

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> register: regNum [

	"return the i2c byte in register regNum"

	^library i2cReadBus: self register: regNum.

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> register: regNum value: val [

	"return the i2c byte in register regNum"

	^library i2cWriteBus: self register: regNum value: val.

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> register16: regNum [

	"return the i2c 2 bytes in register regNum & regNum +1"

	^library i2cRead16Bus: self register: regNum.

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> register16: regNum value: val [

	"return the i2c byte in register regNum"

	^library i2cWrite16Bus: self register: regNum value: val.

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> register16signed: regNum [

	"return the i2c 16bit value in register regNum, converted as 16bit signed int"
	| raw |
	raw := self register16: regNum.
	raw > 16r8000 ifTrue: [raw := raw - 16r10000].
	^raw
]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> registerPairSigned: regNum [

	"return the i2c 2 bytes in register regNum & regNum +1 converted as 16bit signed int"
	| raw |

	raw := library i2cReadPairBus: self register: regNum.
	raw > 16r8000 ifTrue: [raw := raw - 16r10000].
	^raw.

]

{ #category : 'bus initialization/release' }
I2cGpioSerialBus >> release [
	"close the i2c connection and release the handle"

	library releaseI2cBus: self.
	handle := nil.

]

{ #category : 'Not categorized' }
I2cGpioSerialBus >> slaveAddress [
	"Answer the slaveAddress was are connected with."

	^slaveAddress.

]

{ #category : 'slave read/write' }
I2cGpioSerialBus >> whoAmI [
	"return the i2c whoami byte ID to check"

	^library i2cReadBus: self register: 15.				"WhoAmIRegister"

]
