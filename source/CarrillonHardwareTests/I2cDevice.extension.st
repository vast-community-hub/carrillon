Extension {
	#name : 'I2cDevice'
}

{ #category : '*CarrillonHardwareTests',
 #vaCategories : ['instance creation'] }
I2cDevice class >> forTesting [
	^self basicNew
		slaveAddress: 16r20
		i2cBus: I2cBusForTesting new
]
