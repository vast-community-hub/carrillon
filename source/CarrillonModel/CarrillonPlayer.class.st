Class {
	#name : 'CarrillonPlayer',
	#superclass : 'GRObject',
	#instVars : [
		'playingSong',
		'aplaymidiProcess',
		'isPlaying'
	],
	#category : 'CarrillonModel'
}

{ #category : 'Instance Creation' }
CarrillonPlayer class >> defaultNewInstance [
	^ self new
]

{ #category : 'Accessing' }
CarrillonPlayer >> carrillon [
	^ CarrillonSystem current 
]

{ #category : 'Accessing' }
CarrillonPlayer >> defaultPlayingSong [

	^self carrillon songs first
]

{ #category : 'Accessing' }
CarrillonPlayer >> isPlayingSong [

	^(self isSongRunning) and: [isPlaying ifNil: [true]]
]

{ #category : 'Accessing' }
CarrillonPlayer >> isSongRunning [

	^self playingSong notNil and: [aplaymidiProcess notNil]
]

{ #category : 'Actions' }
CarrillonPlayer >> pausePlaying [

	aplaymidiProcess ifNotNil: [
		(UNIXProcess execute: 'kill -STOP ' , aplaymidiProcess pid asString) waitForCompletion].
	isPlaying := false
]

{ #category : 'Accessing' }
CarrillonPlayer >> playingSong [

	^playingSong ifNil: [self defaultPlayingSong]
]

{ #category : 'Accessing' }
CarrillonPlayer >> playingSong: anObject [

	playingSong := anObject
]

{ #category : 'Actions' }
CarrillonPlayer >> resumePlaying [

	aplaymidiProcess ifNotNil: [
		(UNIXProcess execute: 'kill -CONT ' , aplaymidiProcess pid asString) waitForCompletion].
	isPlaying := true
]

{ #category : 'Actions' }
CarrillonPlayer >> startPlaying [

	| line port midiFilename aplaymidiCmd midiPortName |
	midiFilename := self carrillon configuration staticFilesPath , self playingSong midiFilename.
	midiPortName := self carrillon configuration midiPortName.
	line :=
		(UNIXProcess shell: 'aplaymidi -l') lines
			detect: [:each | each includesSubstring: midiPortName]
			ifNone: [nil].
	line ifNil: [self error: midiPortName, ' not detected'].
	port := line trimBoth copyUpTo: Character space.
	aplaymidiCmd := 'aplaymidi --port ' , port , ' "' , midiFilename, '"'.
	aplaymidiProcess := UNIXProcess execute: aplaymidiCmd.
	isPlaying := true.
	aplaymidiProcess


]

{ #category : 'Actions' }
CarrillonPlayer >> startPlayingSong: aSong [

	(self playingSong notNil and: [aplaymidiProcess notNil]) ifTrue: [self stopPlaying].
	self playingSong: aSong.
	self startPlaying
]

{ #category : 'Actions' }
CarrillonPlayer >> stopPlaying [
	aplaymidiProcess ifNotNil: [
	aplaymidiProcess
		kill;
		waitForCompletion.
		].
	aplaymidiProcess := nil.
	isPlaying := false
]
