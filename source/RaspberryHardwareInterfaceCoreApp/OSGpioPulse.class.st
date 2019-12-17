Class {
	#name : 'OSGpioPulse',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSGpioPulse class >> fromArray: anArray [
	"Create a new instance and set the values.  If there is more than one pulse, answer an array with the pulses."
	| pulseCnt pulses aCnt |

	aCnt := anArray size.
	pulseCnt := (aCnt + 2) // 3.
	pulses := Array new: pulseCnt.
	1 to: pulseCnt do: [:p | | i o d pulse off delay |
		i := ((p - 1) * 3) + 1.
		o := i + 1.
		d := i + 2.
		off := (o <= aCnt) ifTrue: [anArray at: o] ifFalse: [0].
		delay := (d <= aCnt) ifTrue: [anArray at: d] ifFalse: [0].
		pulse := self gpioOn: (anArray at: i) gpioOff: off usDelay: delay.
		pulses at: p put: pulse.
	].
	^(pulseCnt = 1) ifTrue: [pulses first] ifFalse: [pulses].

]

{ #category : 'Not categorized' }
OSGpioPulse class >> gpioOn: on gpioOff: off usDelay: delay [
	"Create a new instance and set the values."

	^self new gpioOn: on; gpioOff: off; usDelay: delay; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSGpioPulse class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(gpioOn gpioOff usDelay)
		types: #(uint32 uint32 uint32).

]

{ #category : 'Not categorized' }
OSGpioPulse >> gpioOff [
	"Answer the value of gpioOff."

	^self uint32At: #gpioOff.

]

{ #category : 'Not categorized' }
OSGpioPulse >> gpioOff: anInt [
	"Set the value of gpioOff."

	^self uint32At: #gpioOff put: anInt.

]

{ #category : 'Not categorized' }
OSGpioPulse >> gpioOn [
	"Answer the value of gpioOn."

	^self uint32At: #gpioOn.

]

{ #category : 'Not categorized' }
OSGpioPulse >> gpioOn: anInt [
	"Set the value of gpioOn."

	^self uint32At: #gpioOn put: anInt.

]

{ #category : 'Not categorized' }
OSGpioPulse >> usDelay [
	"Answer the value of usDelay."

	^self uint32At: #usDelay.

]

{ #category : 'Not categorized' }
OSGpioPulse >> usDelay: anInt [
	"Set the value of usDelay."

	^self uint32At: #usDelay put: anInt.

]
