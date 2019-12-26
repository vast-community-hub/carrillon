Class {
	#name : 'CarrillonMainPlayerComponent',
	#superclass : 'CarrillonBaseComponent',
	#category : 'CarrillonSeasideApp'
}

{ #category : 'Actions' }
CarrillonMainPlayerComponent >> pausePlayingSong [

	self player pausePlaying
]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderContentOn: html [

	html div
		id: self ajaxId;
		with: [
			self renderPlayerOn: html.
			self renderPlayerListOn: html]
]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderPlayerControlsOn: html [

	html div
		class: 'main-control';
		with: [
			html tbsButtonGroup: [
				html tbsButton
					bePush;
					onClick: (
						html jQuery ajax script: [:s |
							self player isPlayingSong
								ifTrue: [self pausePlayingSong]
								ifFalse: [
									self player isSongRunning
										ifTrue: [
											self
												resumePlayingSong]
										ifFalse: [
											self
												startPlaying

											]].
							self scriptReplaceOn: s]);
					with: [
						self player isPlayingSong
							ifTrue: [html tbsGlyphIcon iconPause]
							ifFalse: [html tbsGlyphIcon iconPlay]].
				html tbsButton with: [html tbsGlyphIcon iconRepeat].
				html tbsButton with: [html tbsGlyphIcon iconRandom].
				html tbsButton
					bePush;
					onClick: (
						html jQuery ajax script: [:s |
							self stopPlayingSong.
							self scriptReplaceOn: s]);
					with: [html tbsGlyphIcon iconStop].
				html tbsButton with: [html tbsGlyphIcon iconRecord]]]


]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderPlayerCurrentOn: html [

	| playingSong |

	playingSong := self player playingSong.
	playingSong ifNotNil: [
		html div
			class: 'main-current';
			with: [
				html div
					class: 'current-keyvisual';
					with: [html image url: self carrillon configuration mediaUrlPreffix , playingSong thumbnailFilename].
				html div
					class: 'current-info';
					with: [
						html heading
							level: 1;
							with: playingSong songName.
						html paragraph: playingSong author]]]
]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderPlayerListOn: html [

	html unorderedList
		class: 'player-list';
		with: [
			self carrillon songs do: [:each |
				html listItem: [
					self renderSongButtonsOf: each on: html.
					html space. 
					html image
						class: 'list-cover';
						url: self carrillon configuration mediaUrlPreffix, each thumbnailFilename.
					html div
						class: 'list-info';
						with: [
							html div
								class: 'info-title';
								with: [html text: each songName].
							html div
								class: 'info-artist';
								with: [html text: each author]].
					html div
						tbsPullRight;
						class: 'info-duration';
						with: [html text: '0:42']]]]


]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderPlayerOn: html [

	html div
		class: 'player-main';
		with: [
			self renderPlayerCurrentOn: html.
			self renderPlayerControlsOn: html]
]

{ #category : 'Rendering' }
CarrillonMainPlayerComponent >> renderSongButtonsOf: aSong on: html [

	html tbsButtonToolbar
		style: 'display: inline-block';
		with: [
			html tbsButton
				beSmall;
				bePush;
				onClick: (
					html jQuery ajax script: [:s |
						self startPlayingSong: aSong.
						self scriptReplaceOn: s]);
				with: [html tbsGlyphIcon iconPlay].
			html tbsButton
				beSmall;
				with: [html tbsGlyphIcon iconPencil]]
]

{ #category : 'Actions' }
CarrillonMainPlayerComponent >> resumePlayingSong [

	self player resumePlaying
]

{ #category : 'Actions' }
CarrillonMainPlayerComponent >> startPlaying [

	self player startPlaying
]

{ #category : 'Actions' }
CarrillonMainPlayerComponent >> startPlayingSong: aSong [

	self player startPlayingSong: aSong
]

{ #category : 'Actions' }
CarrillonMainPlayerComponent >> stopPlayingSong [

	self player stopPlaying
]
