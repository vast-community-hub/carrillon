Class {
	#name : 'CarrillonSeasideApp',
	#superclass : 'Application',
	#category : 'CarrillonSeasideApp'
}

{ #category : 'StartUp' }
CarrillonSeasideApp class >> startUp [

	CarrillonSystem current configuration initializeFromReadIniFile
]
