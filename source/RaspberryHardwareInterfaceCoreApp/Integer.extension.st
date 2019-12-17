Extension {
	#name : 'Integer'
}

{ #category : '*RaspberryHardwareInterfaceCoreApp',
 #vaCategories : ['Raspberry Tools'] }
Integer >> as2ByteArray [
	"Answer a ByteArray of size 2."
	| bytes |

	bytes := ByteArray new: 2.
	bytes uint8At: 0 put: ((self >> 8) asUInt8).
	bytes uint8At: 1 put: (self asUInt8).
	^bytes.

]

{ #category : '*RaspberryHardwareInterfaceCoreApp',
 #vaCategories : ['Raspberry Tools'] }
Integer >> bitClear: aMask [

	"Answer an Integer equal to the receiver, except with all bits cleared that are set in aMask."

	^(self bitOr: aMask) - aMask.

]
