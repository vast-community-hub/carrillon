Class {
	#name : 'OneWireDevicesSubApp',
	#superclass : 'SubApplication',
	#category : 'OneWireDevicesSubApp'
}

{ #category : 'Not categorized' }
OneWireDevicesSubApp class >> loaded [
	"Execute the code in the method comment to create and save the source for the method."
	"Initialize things just after being loaded."
	"Initialize parts."

	OneWireDevice initializeOnLoad.

]
