Class {
	#name : 'CarrillonConfiguration',
	#superclass : 'GRObject',
	#instVars : [
		'staticFilesPath',
		'midiPortName',
		'mediaUrlPreffix',
		'raspberryPiIp',
		'raspberryPiPigpiodPort'
	],
	#category : 'CarrillonModel'
}

{ #category : 'Instance Creation' }
CarrillonConfiguration class >> defaultNewInstance [

	^self new
		yourself
]

{ #category : 'Initialization' }
CarrillonConfiguration >> initializeFromReadIniFile [

	| iniContent |

	iniContent := System iniFileGetContentsArray: 'Carrillon'.
	iniContent
		at: 'mediaUrlPreffix' ifPresent: [:value | self mediaUrlPreffix: value];
		at: 'midiPortName' ifPresent: [:value | self midiPortName: value];
		at: 'staticFilesPath' ifPresent: [:value | self staticFilesPath: value];
		at: 'raspberryPiIp'
			ifPresent: [:value |
				value isEmpty ifTrue: [self raspberryPiIp: nil] ifFalse: [self raspberryPiIp: value]];
		at: 'raspberryPiPigpiodPort'
			ifPresent: [:value |
				value isEmpty
					ifTrue: [self raspberryPiPigpiodPort: nil]
					ifFalse: [self raspberryPiPigpiodPort: value]]
]

{ #category : 'accessing' }
CarrillonConfiguration >> mediaUrlPreffix [

	^ mediaUrlPreffix 
]

{ #category : 'accessing' }
CarrillonConfiguration >> mediaUrlPreffix: aString [

	mediaUrlPreffix := aString
]

{ #category : 'accessing' }
CarrillonConfiguration >> midiPortName [
	^midiPortName
]

{ #category : 'accessing' }
CarrillonConfiguration >> midiPortName: anObject [
	midiPortName := anObject
]

{ #category : 'accessing' }
CarrillonConfiguration >> raspberryPiIp [
	^raspberryPiIp
]

{ #category : 'accessing' }
CarrillonConfiguration >> raspberryPiIp: anObject [
	raspberryPiIp := anObject
]

{ #category : 'accessing' }
CarrillonConfiguration >> raspberryPiPigpiodPort [
	^raspberryPiPigpiodPort
]

{ #category : 'accessing' }
CarrillonConfiguration >> raspberryPiPigpiodPort: anObject [
	raspberryPiPigpiodPort := anObject
]

{ #category : 'accessing' }
CarrillonConfiguration >> staticFilesPath [
	^staticFilesPath
]

{ #category : 'accessing' }
CarrillonConfiguration >> staticFilesPath: anObject [
	staticFilesPath := anObject
]
