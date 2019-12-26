Class {
	#name : 'CarrillonRootComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'carrillonComponent'
	],
	#category : 'CarrillonSeasideApp'
}

{ #category : 'Deploying' }
CarrillonRootComponent class >> deployStaticFiles [

	self fileLibrariesForDeployment do: [:each | each deployFiles]
]

{ #category : 'File Libraries' }
CarrillonRootComponent class >> fileLibrariesForAppRegistration [
	^ self fileLibrariesForDeveloptment
]

{ #category : 'File Libraries' }
CarrillonRootComponent class >> fileLibrariesForDeployment [

	| libraries |

	libraries := OrderedCollection new.
	libraries
		add: JQDeploymentLibrary;
		add: TBSDeploymentLibrary;
		add: CarrillonFileLibrary.
	^libraries



]

{ #category : 'File Libraries' }
CarrillonRootComponent class >> fileLibrariesForDeveloptment [

	| libraries |

	libraries := OrderedCollection new.
	libraries
		add: JQDevelopmentLibrary;
		add: TBSDevelopmentLibrary;
		add: CarrillonFileLibrary.
	^libraries



]

{ #category : 'Initialization' }
CarrillonRootComponent class >> register [

	| application |

	application := WAAdmin register: self asApplicationAt: 'carrillon'.
	application preferenceAt: #sessionClass put: CarrillonSession.
	application exceptionHandler: WADebugErrorHandler.

	"Libraries"
	self fileLibrariesForAppRegistration
		do: [:aFileLibrary | aFileLibrary ifNotNil: [application addLibrary: aFileLibrary]].

	"Session timeout"
	application configuration at: #maximumRelativeAge put: 45 minutes asSeconds.
	application configuration at: #maximumAbsoluteAge put: 0.
	"When we registered the application in the first line via #register:asApplicationAt: a cache was created in WAApplication (because of #initialize). 
	As we are changing now the session timeout, we must re-create and re-set a new cache with the new configuration values.
	For more details see https://github.com/SeasideSt/Seaside/issues/937"
	application cache: application createCache.


	^application
]

{ #category : 'Initialization' }
CarrillonRootComponent class >> registerForProd [

	| application |

	application := WAAdmin register: self asApplicationAt: 'carrillon'.
	application preferenceAt: #sessionClass put: CarrillonSession.
	application exceptionHandler: WAWalkbackErrorHandler.

	"Libraries"
	self fileLibrariesForDeployment
		do: [:aFileLibrary | aFileLibrary ifNotNil: [application addLibrary: aFileLibrary]].

	"Session timeout"
	application configuration at: #maximumRelativeAge put: 45 minutes asSeconds.
	application configuration at: #maximumAbsoluteAge put: 0.
	"When we registered the application in the first line via #register:asApplicationAt: a cache was created in WAApplication (because of #initialize). 
	As we are changing now the session timeout, we must re-create and re-set a new cache with the new configuration values.
	For more details see https://github.com/SeasideSt/Seaside/issues/937"
	application cache: application createCache.


	^application
]

{ #category : 'Accessing' }
CarrillonRootComponent >> carrillonMainComponent [

	^carrillonComponent ifNil: [carrillonComponent := CarrillonMainComponent new]
]

{ #category : 'Rendering' }
CarrillonRootComponent >> renderCarrillonMainComponentOn: html [

	html render: self carrillonMainComponent
]

{ #category : 'Rendering' }
CarrillonRootComponent >> renderContentOn: html [

	html div
		class: 'wrapper';
		with: [self renderCarrillonMainComponentOn: html]
]

{ #category : 'Updating' }
CarrillonRootComponent >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.
	anHtmlRoot title: 'Carrillon'.
	anHtmlRoot link
		beStylesheet;
		url: 'https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css'.
	anHtmlRoot link
		beStylesheet;
		url: 'https://fonts.googleapis.com/css?family=Roboto:100,400'
]
