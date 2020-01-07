Class {
	#name : 'CarrillonSeasideEntryPoint',
	#superclass : 'Object',
	#category : 'CarrillonSeasideApp'
}

{ #category : 'Starting' }
CarrillonSeasideEntryPoint class >> startApplication [
	CarrillonRootComponent register.
	self startSeasideAdaptors.
]

{ #category : 'Starting' }
CarrillonSeasideEntryPoint class >> startSeasideAdaptors [

	| adaptor |

	WASstServerManager default adaptors do: [:each | 
		WASstServerManager default unregister: each
	].
	adaptor := WASstServerAdaptor port: 9999.
	adaptor codec: (GRCodec forEncoding: 'utf-8').
	adaptor start
]
