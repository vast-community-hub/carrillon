Class {
	#name : 'SpiDevice',
	#superclass : 'GpioBusDevice',
	#instVars : [
		'spiBus'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'instance creation' }
SpiDevice class >> defaultFlags [
	"what should my configuration be? SPI flags occupy the bottom 22 bits of a word
	(21)bbbbbb R T nnnn W A u2 u1 u0 p2 p1 p0 mm
	See the abyz.co.uk/rpi/pigpio/pdif2.html page for more detail"

	^0.				"This is a good start for the PiFace stuff at least."

]

{ #category : 'instance creation' }
SpiDevice class >> defaultSpeed [
	"What should my communications rate be?"

	^4000000.

]

{ #category : 'initialize-release' }
SpiDevice >> spiBus: anSpiBus [
	"Set our bus."
	
	bus := anSpiBus.

]
