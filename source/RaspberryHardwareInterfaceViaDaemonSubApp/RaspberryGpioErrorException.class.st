Class {
	#name : 'RaspberryGpioErrorException',
	#superclass : 'Exception',
	#pools : [
		'RaspberryGpioConstants',
		'RaspberryGpioDaemonFunctions'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'Not categorized' }
RaspberryGpioErrorException class >> errorDescription: anErrorCode [
	"Answers a constant string with a short description of the given error code, 
		this description is intended for displaying to the end user.

		Arguments:
			anErrorCode - <Integer> error to return the name of
		Answers:
			<String>

		Note: If the error code is nil, it is likely some RaspberryGpio function returned nil and not an error code as it should have."
	| eTextPtr eText |

	eTextPtr := [RaspberryGpioError callWith: anErrorCode] on: Error do: [:sig | sig exitWith: nil].
	eText := eTextPtr notNil ifTrue: [(OSStringZ address: eTextPtr) asString] ifFalse: [''].
	^anErrorCode notNil ifTrue: [eText] ifFalse: ['Unknown error'].

]

{ #category : 'Not categorized' }
RaspberryGpioErrorException >> errorContext [
	"Answer the RaspberryGpio error context description...if present
		This allows the user to quickly understand what caused
		this exception.
	 
		Answers:
			<String> - context description...empty if none provided"

	^self tag isAssociation ifTrue: [self tag value] ifFalse: [''].

]

{ #category : 'Not categorized' }
RaspberryGpioErrorException >> errorDescription [
	"Answer the error description <String> for this error number."
	
	^self class errorDescription: self errorNumber.

]

{ #category : 'Not categorized' }
RaspberryGpioErrorException >> errorNumber [
	"Answer the RaspberryGpio error number which should be the key if the
		tag is an Association...otherwise the tag IS the errorNumber.

	 Answers:
		<Integer> - numeric error code"

	^self tag isAssociation ifTrue: [self tag key] ifFalse: [self tag].

]

{ #category : 'Not categorized' }
RaspberryGpioErrorException >> messageText [
	"Answer the human readable error description provided by RaspberryGpio
	 with the associated context in which the exception was produced.
	 
	 Answers:
		<String>"

	| stream |

	stream := String new writeStream.
	self errorContext notEmpty ifTrue: [
		stream
			nextPutAll: self errorContext;
			nextPut: $:.
	].
	stream
		space;
		nextPut: $:;
		space;
		nextPutAll: self errorDescription.
	^stream contents.

]
