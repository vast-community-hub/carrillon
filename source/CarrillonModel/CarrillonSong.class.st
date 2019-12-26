"
CarrillonSong songs

CarrillonSong songs do: [:each | each writeJsonFile]

CarrillonSong initializeFromPath: '../../web/media/'

CarrillonSong songs at: 5

CarrillonSong fromJsonOrMidiFileNamed: 'Beatles-yesterday.mid' onPath: '../../web/media/'
"
Class {
	#name : 'CarrillonSong',
	#superclass : 'GRObject',
	#instVars : [
		'name',
		'songName',
		'number',
		'author',
		'midiFilename'
	],
	#classVars : [
		'Songs'
	],
	#category : 'CarrillonModel'
}

{ #category : 'Accessing' }
CarrillonSong class >> addSong: aSong [

	self songs add: aSong
]

{ #category : 'Examples' }
CarrillonSong class >> desired [
	"
	yesterday
	feliz cumple / payaso plimplim
	el monstruo de la laguna
	manuelita
	himno argentino
	marcha peronista
	marcha radical
	hotel california
	"
]

{ #category : 'Examples' }
CarrillonSong class >> exampleEmptyAndFillSomeSongs [
	"Got some examples from: https://bitmidi.com/
	 
	 self exampleEmptyAndFillSomeSongs
	 "

	self initializeSongs.
	self addSong: (
		CarrillonSong new
			songName: 'Yesterday';
			author: 'The Beatles';
			number: 57;
			midiFilename: 'Beatles-yesterday.mid').
	self addSong: (
		CarrillonSong new
			songName: 'Bohemian Rhapsody';
			author: 'Quuen';
			number: 51;
			midiFilename: 'Queen-Bohemian-Rhapsody.mid').
	self addSong: (
		CarrillonSong new
			songName: 'Star Wars ';
			author: 'Star Wars Theme';
			number: 52;
			midiFilename: 'Star-Wars-Theme.mid').
	self addSong: (
		CarrillonSong new
			songName: 'Moonlight Sonata';
			author: 'Beethoven';
			number: 53;
			midiFilename: 'Beethoven-Moonlight-Sonata.mid').
	self addSong: (
		CarrillonSong new
			songName: 'A Whole New World';
			author: 'Aladdin Theme';
			number: 54;
			midiFilename: 'A-Whole-New-World.mid').
	self addSong: (
		CarrillonSong new
			songName: 'Nothing Else Matters';
			author: 'Metallica';
			number: 54;
			midiFilename: 'Metallica - Nothing Else Matters.mid')



]

{ #category : 'Instance creation' }
CarrillonSong class >> forMidiFileNamed: aString [
	| answer |
	answer := self new midiFilename: aString.
	answer guessAll.
	^ answer
]

{ #category : 'Instance creation' }
CarrillonSong class >> fromJsonOrMidiFileNamed: filename onPath: aString [
	| jsonName |
	jsonName := aString, (filename copyUpTo: $.), '.json'.
	jsonName asPath exists ifFalse: [^self forMidiFileNamed: filename].
	jsonName asPath readStreamDo: [:strm |
		| reader |
		reader := NeoJSONReader on: strm.
		reader mapInstVarsFor: self.
		^ reader nextAs: self]
]

{ #category : 'Initialization' }
CarrillonSong class >> initializeFromPath: aString [
	" self initializeFromPath: '../../web/media/' "
	self initializeSongs.
	aString asPath allFilesAndDirectoriesMatching: '*.mid' do: [:each |
		| song |
		song := self fromJsonOrMidiFileNamed: each onPath: aString.
		self addSong: song]
		
]

{ #category : 'Initialization' }
CarrillonSong class >> initializeSongs [

	Songs := OrderedCollection new
]

{ #category : 'Accessing' }
CarrillonSong class >> songs [

	^Songs ifNil: [self initializeSongs]
]

{ #category : 'save & restore' }
CarrillonSong >> asJson [
	^ NeoJSONWriter toStringPretty: self
]

{ #category : 'accessing' }
CarrillonSong >> author [
	^author
]

{ #category : 'accessing' }
CarrillonSong >> author: anObject [

	author := anObject
]

{ #category : 'accessing' }
CarrillonSong >> duration [
	^ self shouldBeImplemented 
]

{ #category : 'save & restore' }
CarrillonSong >> guessAll [
	songName := self midiFilename copyUpTo: $..
	author := 'Unknown'.
	number := -1.
	

]

{ #category : 'accessing' }
CarrillonSong >> jsonFilename [

	^(self midiFilename copyUpTo: $.) , 'json'
]

{ #category : 'accessing' }
CarrillonSong >> midiFilename [
	^midiFilename
]

{ #category : 'accessing' }
CarrillonSong >> midiFilename: anObject [
	midiFilename := anObject
]

{ #category : 'save & restore' }
CarrillonSong >> neoJsonOn: neoJSONWriter [
	" NeoJSONWriter toString: Songs first "
	(neoJSONWriter objectMappingFor: self class)
		mapInstVars.
	super neoJsonOn: neoJSONWriter.

]

{ #category : 'accessing' }
CarrillonSong >> number [
	^number
]

{ #category : 'accessing' }
CarrillonSong >> number: anObject [
	number := anObject
]

{ #category : 'printing' }
CarrillonSong >> printOn: strm [
	super printOn: strm.
	strm
		space;
		nextPut: $(;
		nextPutAll: songName;
		nextPut: $)
]

{ #category : 'accessing' }
CarrillonSong >> songName [

	^songName
]

{ #category : 'accessing' }
CarrillonSong >> songName: anObject [

	songName := anObject
]

{ #category : 'accessing' }
CarrillonSong >> thumbnailFilename [

	^(self midiFilename allButLast: 3) , 'jpg'
]

{ #category : 'save & restore' }
CarrillonSong >> writeJsonFile [
	self jsonFilename asPath writeStreamDo: [:strm |
		(NeoJSONWriter on: strm) nextPut: self]
]
