Class {
	#name : 'OSRawSpi',
	#superclass : 'OSStructure',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Not categorized' }
OSRawSpi class >> clk: clk mosi: mosi miso: miso ssPol: ssPol ssUs: ssUs clkPol: clkPol clkPha: clkPha clkUs: clkUs [
	"Create a new instance and set the values."

	^self new clk: clk; mosi: mosi; miso: miso; ssPol: ssPol; ssUs: ssUs; clkPol: clkPol; clkPha: clkPha; clkUs: clkUs; yourself.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
OSRawSpi class >> initializeAfterLoad [
	"Initialize our size and members."

	self
		members: #(clk mosi miso ssPol ssUs clkPol clkPha clkUs)
		types: #(int32 int32 int32 int32 int32 int32 int32 int32).

]

{ #category : 'Not categorized' }
OSRawSpi >> clk [
	"Answer the value of clk."

	^self int32At: #clk.

]

{ #category : 'Not categorized' }
OSRawSpi >> clk: anInt [
	"Set the value of clk."

	^self int32At: #clk put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkPha [
	"Answer the value of clkPha."

	^self int32At: #clkPha.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkPha: anInt [
	"Set the value of clkPha."

	^self int32At: #clkPha put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkPol [
	"Answer the value of clkPol."

	^self int32At: #clkPol.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkPol: anInt [
	"Set the value of clkPol."

	^self int32At: #clkPol put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkUs [
	"Answer the value of clkUs."

	^self int32At: #clkUs.

]

{ #category : 'Not categorized' }
OSRawSpi >> clkUs: anInt [
	"Set the value of clkUs."

	^self int32At: #clkUs put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> miso [
	"Answer the value of miso."

	^self int32At: #miso.

]

{ #category : 'Not categorized' }
OSRawSpi >> miso: anInt [
	"Set the value of miso."

	^self int32At: #miso put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> mosi [
	"Answer the value of mosi."

	^self int32At: #mosi.

]

{ #category : 'Not categorized' }
OSRawSpi >> mosi: anInt [
	"Set the value of mosi."

	^self int32At: #mosi put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> ssPol [
	"Answer the value of ssPol."

	^self int32At: #ssPol.

]

{ #category : 'Not categorized' }
OSRawSpi >> ssPol: anInt [
	"Set the value of ssPol."

	^self int32At: #ssPol put: anInt.

]

{ #category : 'Not categorized' }
OSRawSpi >> ssUs [
	"Answer the value of ssUs."

	^self int32At: #ssUs.

]

{ #category : 'Not categorized' }
OSRawSpi >> ssUs: anInt [
	"Set the value of ssUs."

	^self int32At: #ssUs put: anInt.

]
