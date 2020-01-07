Class {
	#name : 'CarrillonBaseComponent',
	#superclass : 'WAComponent',
	#category : 'CarrillonSeasideApp'
}

{ #category : 'AJAX - Support' }
CarrillonBaseComponent >> ajaxId [

	^self ajaxId: String new
]

{ #category : 'AJAX - Support' }
CarrillonBaseComponent >> ajaxId: aString [

	^String streamContents: [:stream |
		stream
			nextPutAll: 'id';
			nextPutAll: (
				(GRPlatform current secureHashFor: self class name) asByteArray hex asLowercase
					first: 8);
			nextPut: $-;
			print: self hash;
			nextPutAll: aString]
]

{ #category : 'Accessing' }
CarrillonBaseComponent >> carrillon [

	^self session carrillon
]

{ #category : 'Accessing' }
CarrillonBaseComponent >> player [

	^CarrillonSystem current player
]

{ #category : 'AJAX - Support' }
CarrillonBaseComponent >> scriptReplaceOn: script [

	script << ( ( script jQuery id: self ajaxId )
				replaceWith: [ :h | self renderContentOn: h ] )
]
