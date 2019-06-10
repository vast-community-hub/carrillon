

Application create: #CarrillonHardware with:
    (#( RaspberryHardwareInterfaceCoreApp SUnit)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #CarrillonHardware missing: each]])!

CarrillonHardware becomeDefault!
I2cDevice subclass: #I2CDeviceGPIOMCP23017
    classInstanceVariableNames: ''
    instanceVariableNames: 'lastOutput '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonHardware becomeDefault!
Object subclass: #GPIOPort
    classInstanceVariableNames: ''
    instanceVariableNames: 'device bit '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonHardware becomeDefault!
Object subclass: #I2cBusForTesting
    classInstanceVariableNames: ''
    instanceVariableNames: 'in out '
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonHardware becomeDefault!
Application subclass: #CarrillonHardware
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

CarrillonHardware becomeDefault!
TestCase subclass: #GPIOPortTest
    classInstanceVariableNames: ''
    instanceVariableNames: 'in out port '
    classVariableNames: ''
    poolDictionaries: ''!


CarrillonHardware becomeDefault!

!GPIOPort class publicMethods !

on: aGPIODevice bit: anInteger
	^self new device: aGPIODevice bit: anInteger! !

!GPIOPort publicMethods !

clear
	device clearOutputBit: bit!

device: aGPIODevice bit: anInteger
	device := aGPIODevice.
	bit := anInteger.!

pulseForMilliseconds: anInteger
	[self set.
	(Delay forMilliseconds: anInteger) wait.
	self clear] fork!

set
	device setOutputBit: bit!

toggle
	device toggleOutputBit:bit!

value
	^device inputBit: bit!

value: anInteger
	^device outputBit: bit put: anInteger! !

!GPIOPortTest publicMethods !

setUp
	| device |
	device := I2CDeviceGPIOMCP23017 forTesting. 
	in := device bus in.
	out := device bus out.
	port := GPIOPort on: device bit: 1.!

testClear
	port clear.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.
!

testInput
	in nextPutAll: #(0 2 2 0).
	in reset.
	self
		assert: port value equals: 0;
		assert: port value equals: 1;
		assert: port value equals: 1;
		assert: port value equals: 0.
	out reset.
	self
		assert: out next equals: 16r12;
		assert: out next equals: 16r12;
		assert: out next equals: 16r12;
		assert: out next equals: 16r12.!

testPulse
	port pulseForMilliseconds:5.
	(Delay forMilliseconds: 6) wait.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.
!

testPulseCompleted
	port pulseForMilliseconds:5.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.
	(Delay forMilliseconds: 7) wait.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.
!

testPulseIncomplete
	port pulseForMilliseconds:5.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.
!

testSet
	port set.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.
!

testSetClear
	port
		set;
		clear.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.
!

testSetToggle
	port
		set;
		toggle;
		toggle.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out atEnd.
!

testValue
	port
		value: 1;
		value: 1;
		value: 0.
	out reset.
	self
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 2;
		assert: out next equals: 16r12; 
		assert: out next equals: 0;
		assert: out atEnd.
! !

!I2cBusForTesting class publicMethods !

new
	^super new initialize! !

!I2cBusForTesting publicMethods !

in
	^in!

initialize
	in := ReadWriteStream on: OrderedCollection new.
	out := ReadWriteStream on: OrderedCollection new.
!

out
	^out!

register16: aSmallInteger 
	out nextPut: aSmallInteger.
	^in next!

register16: index value: value
	out nextPut: index; nextPut: value! !

!I2cDevice class publicMethods !

forTesting
	^self basicNew
		slaveAddress: 16r20
		i2cBus: I2cBusForTesting new! !

!I2CDeviceGPIOMCP23017 publicMethods !

allInputs
	^self ioDirection:16rFFFF!

allOutputs
	^self ioDirection:16r0000!

clearOutputBit: anInteger
	^self outputBit: anInteger put: 0
!

configuration
	"  8 bits:
	 | BANK | MIRROR | SEQOP | DISSLW | HAEN | ODR | INTPOL | — | "
	^bus register: 16rA!

configuration: value
	"  8 bits:
	 | BANK | MIRROR | SEQOP | DISSLW | HAEN | ODR | INTPOL | — | "
	^bus register: 16rA value: value!

defaultInputValue
	" 16r0000 is the default value"
	^bus register16: 6!

defaultInputValue: value
	" 16r0000 is the default value"
	^bus register16: 6 value: value!

initializeRegisters
	" This device has two address maps, which can be chosen changing the IOCON.BANK bit.
	   However, this bit has different addressed for the two address maps, so it's impossible? to
	   used the device without prior knowledge of the address map itself.
	   
	   We'll assume the device is in its Power On default configuration:

	   IOCON.BANK=0 (IO Port A is at 16r00, and IO Port B is at 16r01. This is the only supported addressing mode
	   
	   This implemenation uses the device as a 16 bits IO port, always performing 16 bits operations" 
	   lastOutput := 0!

input
	^bus register16: 16r12!

inputAtInterrupt
	^self interruptCapture!

inputBit: anInteger
	^self input >> anInteger & 1!

inputPolarity
	" 1 = GPIO register bit reflects the opposite logic state of the input pin.
	  0 = GPIO register bit reflects the same logic state of the input pin. (default value)"
	^bus register16: 2!

inputPolarity: value
	" 1 = GPIO register bit reflects the opposite logic state of the input pin.
	  0 = GPIO register bit reflects the same logic state of the input pin. (default value)"
	^bus register16: 2 value: value!

inputPullup
	"  when cofigured as input, 100 Kohm can be configured as pullup for each pin
	  1 = Pull-up enabled
	  0 = Pull-up disable.  (default value)"
	^bus register16: 16rC!

inputPullup: value
	"  when cofigured as input, 100 Kohm can be configured as pullup for each pin
	  1 = Pull-up enabled
	  0 = Pull-up disable.  (default value)"
	^bus register16: 16rC value: value!

interruptCapture
	" the GPIO port value at the time the interrupt occurred."
	^bus register16: 16r10!

interruptFlag
	"  1 = Pin caused interrupt.
	  0 = Interrupt not pending. (default value)"
	^bus register16: 16rE!

interruptOnInputChange
	" 1 = Enables GPIO input pin for interrupt-on-change event.
	  0 = Disables GPIO input pin for interrupt-on-change event. (default value)
	  
	  see #interruptOnInputChangeControl"
	^bus register16: 4!

interruptOnInputChange: value
	" 1 = Enables GPIO input pin for interrupt-on-change event.
	  0 = Disables GPIO input pin for interrupt-on-change event. (default value)
	  
	  see #interruptOnInputChangeControl"
	^bus register16: 4 value: value!

interruptOnInputChangeControll
	" 1 = Pin value is compared against the associated bit in the DEFVAL register.
	  0 = Pin value is compared against the previous pin value. (default value)"
	^bus register16: 8!

interruptOnInputChangeControll: value
	" 1 = Pin value is compared against the associated bit in the DEFVAL register.
	  0 = Pin value is compared against the previous pin value. (default value)"
	^bus register16: 8 value: value!

ioDirection
	" 1 = Pin is configured as an input. (default value)
	  0 = Pin is configured as an output."
	^bus register16: 0!

ioDirection: value
	" 1 = Pin is configured as an input. (default value)
	  0 = Pin is configured as an output."
	^bus register16: 0 value: value!

output
	^bus register16: 16r12!

output: value
	lastOutput := value.
	^bus register16: 16r12value: value!

outputBit: anInteger put: value
	| output |
	output := value = 1
		ifTrue: [ lastOutput | (1 << anInteger)]
		ifFalse: [ lastOutput & (1 << anInteger) bitInvert]. 
	^self output: output.!

outputLatches
	^bus register16: 16r14!

outputLatches: value
	^bus register16: 16r14 value: value!

setOutputBit: anInteger
	^self outputBit: anInteger put: 1
!

toggleOutputBit: anInteger
	| value |
	value := lastOutput >> anInteger bitXor: 1.
	^self outputBit: anInteger put: value
	! !

I2CDeviceGPIOMCP23017 initializeAfterLoad!
GPIOPort initializeAfterLoad!
I2cBusForTesting initializeAfterLoad!
CarrillonHardware initializeAfterLoad!
GPIOPortTest initializeAfterLoad!

CarrillonHardware loaded!