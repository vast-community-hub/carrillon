Extension {
	#name : 'ByteArray'
}

{ #category : '*RaspberryHardwareInterfaceCoreApp',
 #vaCategories : ['Raspberry Tools'] }
ByteArray >> as2ByteArray [
	"Answer just the first two bytes."
	| bytes |

	bytes := ByteArray new: 2.
	self doWithIndex: [:b :i | bytes uint8At: (i - 1) put: b].
	^bytes.

]
