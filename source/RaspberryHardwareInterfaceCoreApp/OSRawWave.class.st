Class {
	#name : 'OSRawWave',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSRawWave class >> fromArray: anArray [
	"Create a new instance and set the values.  If there is more than one pulse, answer an array with the pulses."
	| pulseCnt pulses aCnt |

	aCnt := anArray size.
	pulseCnt := (aCnt + 3) // 4.
	pulses := Array new: pulseCnt.
	1 to: pulseCnt do: [:p | | i o d f pulse off delay flags |
		i := ((p - 1) * 4) + 1.
		o := i + 1.
		d := i + 2.
		f := i + 3.
		off := (o <= aCnt) ifTrue: [anArray at: o] ifFalse: [0].
		delay := (d <= aCnt) ifTrue: [anArray at: d] ifFalse: [0].
		flags := (f <= aCnt) ifTrue: [anArray at: f] ifFalse: [0].
		pulse := self gpioOn: (anArray at: i) gpioOff: off usDelay: delay flags: flags.
		pulses at: p put: pulse.
	].
	^(pulseCnt = 1) ifTrue: [pulses first] ifFalse: [pulses].

]

{ #category : 'Not categorized' }
OSRawWave class >> gpioOn: on gpioOff: off usDelay: delay flags: flags [
	"Create a new instance and set the values."

	^self new gpioOn: on; gpioOff: off; usDelay: delay; flags: flags; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSRawWave class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(gpioOn gpioOff usDelay flags)
		types: #(uint32 uint32 uint32 uint32).

]

{ #category : 'Not categorized' }
OSRawWave >> flags [
	"Answer the value of flags."

	^self uint32At: #flags.

]

{ #category : 'Not categorized' }
OSRawWave >> flags: anInt [
	"Set the value of flags."

	^self uint32At: #flags put: anInt.

]

{ #category : 'Not categorized' }
OSRawWave >> gpioOff [
	"Answer the value of gpioOff."

	^self uint32At: #gpioOff.

]

{ #category : 'Not categorized' }
OSRawWave >> gpioOff: anInt [
	"Set the value of gpioOff."

	^self uint32At: #gpioOff put: anInt.

]

{ #category : 'Not categorized' }
OSRawWave >> gpioOn [
	"Answer the value of gpioOn."

	^self uint32At: #gpioOn.

]

{ #category : 'Not categorized' }
OSRawWave >> gpioOn: anInt [
	"Set the value of gpioOn."

	^self uint32At: #gpioOn put: anInt.

]

{ #category : 'Not categorized' }
OSRawWave >> usDelay [
	"Answer the value of usDelay."

	^self uint32At: #usDelay.

]

{ #category : 'Not categorized' }
OSRawWave >> usDelay: anInt [
	"Set the value of usDelay."

	^self uint32At: #usDelay put: anInt.

]
