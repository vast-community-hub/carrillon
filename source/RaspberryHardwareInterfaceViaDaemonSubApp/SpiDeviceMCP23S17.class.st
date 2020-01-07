Class {
	#name : 'SpiDeviceMCP23S17',
	#superclass : 'SpiDevice',
	#instVars : [
		'spiDev',
		'spiPort'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
SpiDeviceMCP23S17 class >> defaultFlags [
	"what should my configuration be? SPI flags occupy the bottom 22 bits of a word
	(21)bbbbbb R T nnnn W A u2 u1 u0 p2 p1 p0 mm
	See the abyz.co.uk/rpi/pigpio/pdif2.html page for more detail"

	^0.				"This is a good start for the PiFace stuff at least."

]

{ #category : 'Not categorized' }
SpiDeviceMCP23S17 class >> defaultSpeed [
	"What should my communications rate be?"

	^4000000.

]

{ #category : 'pin read/write' }
SpiDeviceMCP23S17 >> pin: num write: value [
	"write value to the pin"

	| pin old bit |
	pin := num.
	bit := 1 << (num bitAnd: 7).
	
	pin < 8
		ifTrue: ["bank A"
			old := self readByteFromDev: spiDev reg: Mcp23x17OLatA port: spiPort.
			value = GpioLow
				ifTrue: [old := old bitClear: bit]
				ifFalse: [old := old bitOr: bit].
			self writeByte: old toDev: spiDev reg: Mcp23x17GpioA port: spiPort]
		ifFalse: ["bank B"
			old := self readByteFromDev: spiDev reg: Mcp23x17OLatB port: spiPort.
			value = GpioLow
				ifTrue: [old := old bitClear: bit]
				ifFalse: [old := old bitOr: bit].
			self writeByte: old toDev: spiDev reg: Mcp23x17GpioB port: spiPort].

]

{ #category : 'pin read/write' }
SpiDeviceMCP23S17 >> pinRead: num [
	"read the pin"

	| pin reg mask old |
	pin := num.
	pin < 8
		ifTrue: ["bank A"
			reg := Mcp23x17GpioA]
		ifFalse: ["bank B"
			reg := Mcp23x17GpioB.
			pin := pin bitAnd: 7].
	mask := 1 << pin.
	old := self readByteFromDev: spiDev reg: reg port: spiPort.
	^(old bitAnd: mask) = 0 ifTrue: [GpioLow] ifFalse: [GpioHigh].

]

{ #category : 'private' }
SpiDeviceMCP23S17 >> readByteFromDev: devId reg: reg port: port [
	| buff |

	buff := ByteArray new: 3.
	buff at: 1 put: (((devId bitAnd: 7)<<1 ) bitOr: SpiCmdRead).
	buff at: 2 put: reg.
	
	^(bus readBytesUsingBuffer: buff) at: 3.

]

{ #category : 'pin configuration' }
SpiDeviceMCP23S17 >> setPin: num direction: inOut [
	"set the pull up/down mode of the pin"
	| pin reg mask old |

	pin := num.
	pin < 8
		ifTrue: ["bank A"
			reg := Mcp23x17IODirA]
		ifFalse: ["bank B"
			reg := Mcp23x17IODirB.
			pin := pin bitAnd: 7].
	mask := 1 << pin.
	old := self readByteFromDev: spiDev reg: reg port: spiPort.
	inOut = GpioOutput 
		ifTrue: [old := old bitClear: mask]
		ifFalse: [old := old bitOr: mask].
	self writeByte: (old bitAnd: 16rFF)  toDev: spiDev reg: reg port: spiPort.

]

{ #category : 'pin configuration' }
SpiDeviceMCP23S17 >> setPin: num inputWithPullUp: boolean [

	"set the pin to input with pull up or not"
	self setPin: num direction: GpioInput; setPin: num pull: GpioPudUp
]

{ #category : 'pin configuration' }
SpiDeviceMCP23S17 >> setPin: num pull: pullUpDown [

	"set the pull up/down mode of the pin"

	| pin reg mask old |
	pin := num.
	pin < 8
		ifTrue: ["bank A"
			reg := Mcp23x17GpioPUA]
		ifFalse: ["bank B"
			reg := Mcp23x17GpioPUB.
			pin := pin bitAnd: 7].
	mask := 1 << pin.
	old := self readByteFromDev: spiDev reg: reg port: spiPort.
	pullUpDown = GpioPudUp 
		ifTrue: [old := old bitOr: mask]
		ifFalse: [old := old bitClear: mask].
	self writeByte: (old bitAnd: 16rFF)  toDev: spiDev reg: reg port: spiPort.

]

{ #category : 'pin configuration' }
SpiDeviceMCP23S17 >> setPinToOutput: num [
	"set the pin to output "
	self setPin: num direction: GpioOutput
]

{ #category : 'initialize-release' }
SpiDeviceMCP23S17 >> spiBus: anSpiBus [
	| buff |
	
	bus := anSpiBus.	

	"we may need a wider api to set the spiPort and spiDev numbers but for now 0 will do for both"
	spiDev := spiPort := 0.
	
	"we also need to set a couple of registers"
	buff := ByteArray new:3.
	buff at: 1 put: ((("devId" 0 bitAnd: 7)<<1 ) bitOr: SpiCmdWrite).
	buff at: 2 put: Mcp23x17IOCON.
	buff at: 3 put: (IOCON_INIT bitOr:  IOCON_HAEN).
	bus writeBytes: buff.

	buff := ByteArray new:3.
	buff at: 1 put: ((("devId" 0 bitAnd: 7)<<1 ) bitOr: SpiCmdWrite).
	buff at: 2 put: Mcp23x17IOCONB.
	buff at: 3 put: (IOCON_INIT bitOr: IOCON_HAEN).
	bus writeBytes: buff.

]

{ #category : 'private' }
SpiDeviceMCP23S17 >> writeByte: byte toDev: devId reg: reg port: port [
	| buff |

	buff := ByteArray new:3.
	buff at: 1 put: (((devId bitAnd: 7)<<1 ) bitOr: SpiCmdWrite).
	buff at: 2 put: reg.
	buff at: 3 put: byte.

	^bus writeBytes: buff.

]
