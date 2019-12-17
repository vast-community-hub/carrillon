Class {
	#name : 'SpiBusGpio',
	#superclass : 'GpioSerialBus',
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
SpiBusGpio class >> new [
	"#new cannot be used to create a GpioSerialBus or its sub classes.
		See RaspberryGpioDaemonInterface>createI2cBus: for I2CGpioSerialBus and
		RaspberryGpioDaemonInterface>createSpiBusChannel:speed:flags: for SPIGpioSerialBus."

	^self shouldNotImplement.

]

{ #category : 'initialize-release' }
SpiBusGpio >> interface: aRaspberryGpioDaemonInterface handle: aHandle [
	"Set our data.  If any of the data is set we exit without making changes.
		This method should only be called from an instance of RaspberryGpioDaemonInterface by #createSpiBusChannel:speed:flags:"

	(library isNil & handle isNil) ifTrue: [
		library := aRaspberryGpioDaemonInterface.
		handle := aHandle.
	].

]

{ #category : 'read/write' }
SpiBusGpio >> readBytesUsingBuffer: txBuffer [
	"Read count bytes into a buffer from the spi device/channel"
	| rxBuffer |

	rxBuffer := ByteArray new: txBuffer size.
	library spiTransferBus: self txBuffer: txBuffer rxBuffer: rxBuffer count: rxBuffer size.
	^rxBuffer.

]

{ #category : 'read/write' }
SpiBusGpio >> readNumBytes: count [
	"Read count bytes into a buffer from the spi device/channel"
	| byteArrayBuffer |

	byteArrayBuffer := ByteArray new: count.
	library spiReadBus: self buffer: byteArrayBuffer count: byteArrayBuffer size.
	^byteArrayBuffer.

]

{ #category : 'initialize-release' }
SpiBusGpio >> release [
	"Close the SPI connection and release the handle"

	library releaseSpiBus: self.
	handle := nil.

]

{ #category : 'read/write' }
SpiBusGpio >> writeBytes: byteArrayBuffer [
	"Write bytes from a buffer to the spi device/channel"

	library spiWriteBus: self buffer: byteArrayBuffer count: byteArrayBuffer size.

]
