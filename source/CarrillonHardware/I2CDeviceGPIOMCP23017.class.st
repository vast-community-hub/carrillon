Class {
	#name : 'I2CDeviceGPIOMCP23017',
	#superclass : 'I2cDevice',
	#instVars : [
		'lastOutput'
	],
	#category : 'CarrillonHardware'
}

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> allInputs [
	^self ioDirection:16rFFFF
]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> allOutputs [
	^self ioDirection:16r0000
]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> clearOutputBit: anInteger [
	^self outputBit: anInteger put: 0

]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> configuration [
	"  8 bits:
	 | BANK | MIRROR | SEQOP | DISSLW | HAEN | ODR | INTPOL | — | "
	^bus register: 16rA
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> configuration: value [
	"  8 bits:
	 | BANK | MIRROR | SEQOP | DISSLW | HAEN | ODR | INTPOL | — | "
	^bus register: 16rA value: value
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> defaultInputValue [
	" 16r0000 is the default value"
	^bus register16: 6
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> defaultInputValue: value [
	" 16r0000 is the default value"
	^bus register16: 6 value: value
]

{ #category : 'initialization' }
I2CDeviceGPIOMCP23017 >> initializeRegisters [
	" This device has two address maps, which can be chosen changing the IOCON.BANK bit.
	   However, this bit has different addressed for the two address maps, so it's impossible? to
	   used the device without prior knowledge of the address map itself.
	   
	   We'll assume the device is in its Power On default configuration:

	   IOCON.BANK=0 (IO Port A is at 16r00, and IO Port B is at 16r01. This is the only supported addressing mode
	   
	   This implemenation uses the device as a 16 bits IO port, always performing 16 bits operations" 
	   lastOutput := 0
]

{ #category : 'I/O',
 #vaCategories : ['I/O','registers'] }
I2CDeviceGPIOMCP23017 >> input [
	^bus register16: 16r12
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> inputAtInterrupt [
	^self interruptCapture
]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> inputBit: anInteger [
	^self input >> anInteger & 1
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> inputPolarity [
	" 1 = GPIO register bit reflects the opposite logic state of the input pin.
	  0 = GPIO register bit reflects the same logic state of the input pin. (default value)"
	^bus register16: 2
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> inputPolarity: value [
	" 1 = GPIO register bit reflects the opposite logic state of the input pin.
	  0 = GPIO register bit reflects the same logic state of the input pin. (default value)"
	^bus register16: 2 value: value
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> inputPullup [
	"  when cofigured as input, 100 Kohm can be configured as pullup for each pin
	  1 = Pull-up enabled
	  0 = Pull-up disable.  (default value)"
	^bus register16: 16rC
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> inputPullup: value [
	"  when cofigured as input, 100 Kohm can be configured as pullup for each pin
	  1 = Pull-up enabled
	  0 = Pull-up disable.  (default value)"
	^bus register16: 16rC value: value
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptCapture [
	" the GPIO port value at the time the interrupt occurred."
	^bus register16: 16r10
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptFlag [
	"  1 = Pin caused interrupt.
	  0 = Interrupt not pending. (default value)"
	^bus register16: 16rE
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptOnInputChange [
	" 1 = Enables GPIO input pin for interrupt-on-change event.
	  0 = Disables GPIO input pin for interrupt-on-change event. (default value)
	  
	  see #interruptOnInputChangeControl"
	^bus register16: 4
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptOnInputChange: value [
	" 1 = Enables GPIO input pin for interrupt-on-change event.
	  0 = Disables GPIO input pin for interrupt-on-change event. (default value)
	  
	  see #interruptOnInputChangeControl"
	^bus register16: 4 value: value
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptOnInputChangeControll [
	" 1 = Pin value is compared against the associated bit in the DEFVAL register.
	  0 = Pin value is compared against the previous pin value. (default value)"
	^bus register16: 8
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> interruptOnInputChangeControll: value [
	" 1 = Pin value is compared against the associated bit in the DEFVAL register.
	  0 = Pin value is compared against the previous pin value. (default value)"
	^bus register16: 8 value: value
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> ioDirection [
	" 1 = Pin is configured as an input. (default value)
	  0 = Pin is configured as an output."
	^bus register16: 0
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> ioDirection: value [
	" 1 = Pin is configured as an input. (default value)
	  0 = Pin is configured as an output."
	^bus register16: 0 value: value
]

{ #category : 'I/O',
 #vaCategories : ['I/O','registers'] }
I2CDeviceGPIOMCP23017 >> output [
	^bus register16: 16r12
]

{ #category : 'I/O',
 #vaCategories : ['I/O','registers'] }
I2CDeviceGPIOMCP23017 >> output: value [
	lastOutput := value.
	^bus register16: 16r12value: value
]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> outputBit: anInteger put: value [
	| output |
	output := value = 1
		ifTrue: [ lastOutput | (1 << anInteger)]
		ifFalse: [ lastOutput & (1 << anInteger) bitInvert]. 
	^self output: output.
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> outputLatches [
	^bus register16: 16r14
]

{ #category : 'registers' }
I2CDeviceGPIOMCP23017 >> outputLatches: value [
	^bus register16: 16r14 value: value
]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> setOutputBit: anInteger [
	^self outputBit: anInteger put: 1

]

{ #category : 'I/O' }
I2CDeviceGPIOMCP23017 >> toggleOutputBit: anInteger [
	| value |
	value := lastOutput >> anInteger bitXor: 1.
	^self outputBit: anInteger put: value
	
]
