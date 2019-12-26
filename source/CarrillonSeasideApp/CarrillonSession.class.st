Class {
	#name : 'CarrillonSession',
	#superclass : 'WASession',
	#instVars : [
		'playingSong',
		'isPlaying'
	],
	#category : 'CarrillonSeasideApp'
}

{ #category : 'Accessing' }
CarrillonSession >> carrillon [

	^CarrillonSystem current
]

{ #category : 'Accessing' }
CarrillonSession >> player [

	^CarrillonSystem current player
]
