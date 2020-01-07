Class {
	#name : 'RaspberryGpioUltrasonicDaemonFunctions',
	#superclass : 'SharedPool',
	#classVars : [
		'UltrasonicClose',
		'UltrasonicDistance',
		'UltrasonicInit'
	],
	#type : 'variable',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Initializing' }
RaspberryGpioUltrasonicDaemonFunctions class >> initialize [
	UltrasonicClose := PlatformFunction fromArray: #('C' 'ultrasonicClose' nil 'RaspberryGpioUltrasonicDaemon' #(#int32 ) #void).
	UltrasonicDistance := PlatformFunction fromArray: #('C' 'ultrasonicDistance' nil 'RaspberryGpioUltrasonicDaemon' #(#int32 ) #int32).
	UltrasonicInit := PlatformFunction fromArray: #('C' 'ultrasonicInit' nil 'RaspberryGpioUltrasonicDaemon' #(#int32 #int32 #int32 ) #int32).
]
