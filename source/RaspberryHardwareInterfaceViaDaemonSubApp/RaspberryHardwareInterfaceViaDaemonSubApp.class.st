Class {
	#name : 'RaspberryHardwareInterfaceViaDaemonSubApp',
	#superclass : 'SubApplication',
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> loaded [
	"Execute the code in the method comment to create and save the source for the method."
	"Initialize things just after being loaded."
	"Initialize parts."

	I2cDeviceADS1015ADC initializeOnLoad.
	RaspberryGpioDaemonInterface initializeOnLoad.

]

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> lookUpAndRaiseError: anErrorCode [
	"Raise a <RaspberryGpioErrorException> with the code @anErrorCode and
	 look up the error code to indicate what failed."
	| errDesc |

	errDesc := self raspberryGpioErrorText: anErrorCode.
	RaspberryGpioErrorException signalWith: anErrorCode -> errDesc.

]

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> lookUpAndRaiseError: anErrorCode with: contextDescription [
	"Raise a <RaspberryGpioErrorException> with the code @anErrorCode and
	 look up the error code and append @contextDescription to it to indicate what failed."
	| errDesc |

	errDesc := self raspberryGpioErrorText: anErrorCode.
	RaspberryGpioErrorException signalWith: anErrorCode -> (contextDescription, '  ', errDesc).

]

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> raiseError: anErrorCode with: contextDescription [
	"Raise a <RaspberryGpioErrorException> with the code @anErrorCode and
		@contextDescription to indicate what failed."
	
	RaspberryGpioErrorException signalWith: anErrorCode -> contextDescription.

]

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> raspberryGpioErrorText: anInt [
	"Answer the text description for the raspberryGpioError number."
	| errorTextPtr errorText |

	errorTextPtr := RaspberryGpioError callWith: anInt.
	errorText := (OSStringZ address: errorTextPtr) asString.
	^errorText.

]

{ #category : 'Not categorized' }
RaspberryHardwareInterfaceViaDaemonSubApp class >> shutDown [
	"Send #shutDown to the classes that want it."

	RaspberryGpioDaemonInterface shutDown.

]
