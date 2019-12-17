Class {
	#name : 'CarrillonMainComponent',
	#superclass : 'CarrillonBaseComponent',
	#instVars : [
		'innerComponent'
	],
	#category : 'CarrillonSeasideApp'
}

{ #category : 'Accessing' }
CarrillonMainComponent >> innerComponent [

	^innerComponent ifNil: [CarrillonMainPlayerComponent new]
]

{ #category : 'Rendering' }
CarrillonMainComponent >> renderContentOn: html [

	html div
		class: 'music-player';
		id: self ajaxId;
		with: [
			self renderNavbarOn: html.
			html render: self innerComponent]
]

{ #category : 'Rendering' }
CarrillonMainComponent >> renderNavbarBrandOn: html [

	html div
		with: [
			html tbsNavbarBrand with: [
				html image
				class: 'img-responsive';
					url:
						'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmyvnp2BtnsFTPAJcyr8awl6h65P66MOSWx-UXRbdCTzKMISV0Lw']]


]

{ #category : 'Rendering' }
CarrillonMainComponent >> renderNavbarButtonsOn: html [

	html tbsNav
		tbsPullRight;
		class: 'navbar-right top-nav';
		with: [
			html tbsButtonToolbar: [
				html tbsNavbarButton 
					bePush;
					style: (self carrillon isPumpRunning
						ifTrue: ['background-image: linear-gradient(to bottom, #fff 0%, #00ff00 100%);']
						ifFalse: ['background-image: linear-gradient(to bottom, #fff 0%, #ff0000 100%);']);
					onClick: (html jQuery ajax script: [:s |
						self carrillon pumpToggle.
						self scriptReplaceOn: s]);
					with: [
						html tbsGlyphIcon iconMusic
					].
				html tbsNavbarButton with: [html tbsGlyphIcon iconOff].
				html tbsNavbarButton with: [html tbsGlyphIcon iconCog]]]
]

{ #category : 'Rendering' }
CarrillonMainComponent >> renderNavbarOn: html [

	html tbsNav
		class: 'navbar navbar-inverse';
		with: [
			html div
				class: 'container-fluid';
				with: [
					self renderNavbarBrandOn: html.
					self renderNavbarButtonsOn: html]]


]
