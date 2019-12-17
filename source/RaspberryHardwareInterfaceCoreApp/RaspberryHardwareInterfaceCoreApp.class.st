Class {
	#name : 'RaspberryHardwareInterfaceCoreApp',
	#superclass : 'Application',
	#pools : [
		'RaspberryGpioFunctions',
		'RaspberryGpioConstants',
		'RaspberryGpioDaemonFunctions',
		'RaspberryGpioUltrasonicDaemonFunctions'
	],
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : '-',
 #vaCategories : ['-','AbtEdit','AutoGen'],
  #vaVisibility : 'private' }
RaspberryHardwareInterfaceCoreApp class >> abtIsViewApplication [

	^false
]
