Class {
	#name : 'I2cDevice',
	#superclass : 'GpioBusDevice',
	#instVars : [
		'slaveAddress'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'instance creation' }
I2cDevice class >> new [
	"#new cannot be used to create a I2cDevice.  See RaspberryGpioDaemonInterface>createI2cDevice:slaveAddress:."

	^self shouldNotImplement.

]

{ #category : 'initialize-release' }
I2cDevice >> initializeRegisters [

]

{ #category : 'device read/write' }
I2cDevice >> readBytes: length [
	"Use the bus to read the byres."

	^bus readBytes: length.

]

{ #category : 'device read/write' }
I2cDevice >> readBytes: length register: registerAddress [
	"Use the bus to read the byres."

	^bus readBytes: length register: registerAddress.

]

{ #category : 'initialize-release' }
I2cDevice >> slaveAddress: address i2cBus: anI2cBus [

	slaveAddress := address.
	bus := anI2cBus.
	self initializeRegisters.

]

{ #category : 'device read/write' }
I2cDevice >> writeBytes: aByteArray [
	"Use the bus to write the byres."

	bus writeBytes: aByteArray.

]

{ #category : 'device read/write' }
I2cDevice >> writeBytes: aByteArray register: registerAddress [
	"Use the bus to write the byres."

	bus writeBytes: aByteArray register: registerAddress.

]
