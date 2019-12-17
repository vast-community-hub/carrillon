"
I drive a TI ADS1015 ADC chip; an i2c device found on all sorts of boards but particularly in this case on a Pimoroni Explorer HAT Pro.

This is a rather irritating chip to use in some ways since it doesn't support the who-am-i register so we can't check if it is an ADS1015, it has 16bit signed register for the conversion result, a 16bit unsigned register for configuration and it's bloody big-endian too.

You can set the full scale reading in millivolts (#fullScaleMillivolts:) and the sampling rate (#sampleRate:) - note the only certain specific values are permitted and they can be found in the class initialize method
"
Class {
	#name : 'I2cDeviceADS1015ADC',
	#superclass : 'I2cDevice',
	#instVars : [
		'sampleRate',
		'fullScaleGain'
	],
	#classVars : [
		'ADSGainMap',
		'ADSSampleRates'
	],
	#category : 'I2cDevicesSubApp'
}

{ #category : 'class initialization' }
I2cDeviceADS1015ADC class >> initializeOnLoad [
	"self initialize"
	ADSGainMap := LookupTable new.
	ADSGainMap
		at: 6144 put: 0;
		at: 4096 put: 16r200;
		at: 2048 put: 16r400;
		at: 1024 put: 16r600;
		at: 512 put: 16r800;
		at: 256 put: 16rA00.
		
	ADSSampleRates := LookupTable new.
	ADSSampleRates
		at: 128 put: 0;
		at: 250 put: 16r20;
		at: 490 put: 16r40;
		at: 920 put: 16r60;
		at: 1600 put: 16r80;
		at: 2400 put: 16rA0;
		at: 3300 put: 16rC0.

]

{ #category : 'device read/write' }
I2cDeviceADS1015ADC >> basicConfigFlags [
	"set the basic flags that we really can't be bothered to individually configure
		use single-shot conversion (bit 15 and bit8)
		no comparator (bits 4:0 = 3"
	^16r8103
]

{ #category : 'device read/write' }
I2cDeviceADS1015ADC >> channelFlags: chan [
	"return the flags for channel"
	^#(16r4000 16r5000 16r6000 16r7000) at: chan+1 ifAbsent: [16r4000]
]

{ #category : 'device settings' }
I2cDeviceADS1015ADC >> fullScaleMillivolts [
	^fullScaleGain ifNil: [fullScaleGain := 2048]
]

{ #category : 'device settings' }
I2cDeviceADS1015ADC >> fullScaleMillivolts: fsr [
	"the full scale voltage is restricted to a few discrete values rather than any old number you happen to like. If you try a scale that isn't suported you'll get the default 2.048V"
	(ADSGainMap includesKey: fsr)
		ifTrue: [fullScaleGain := fsr]
]

{ #category : 'device read/write' }
I2cDeviceADS1015ADC >> gainMapFlags [
	"return the flag bits for the chosen gain/full scale setting"
	^ADSGainMap at: self fullScaleMillivolts ifAbsent:[16r400]
]

{ #category : 'initialize-release' }
I2cDeviceADS1015ADC >> initializeRegisters [
	"the ADS line of ADCs don't do the full i2c whoami dance, so we have to just believe this is The One. To make it even more interesting we have to effectively write the config register each time we want a conversion done- so nothing gets done here"
]

{ #category : 'device read/write' }
I2cDeviceADS1015ADC >> readChannel: chan [
	"The ADS line of ADCs are easy to use as single-shot converters, but doing that means that each read request involves writing the config, waiting a moment for the conversion to take place and then reading the result.
	Note that the channels range 0-3 and the ExplorerHAT Pro in particular maps them 4-1 i e both backwards and 1 based, just to make for fun"
	| config v |

	config := self basicConfigFlags.
	config := config bitOr: (self channelFlags: chan).
	config := config bitOr: self samplesPerSecondFlags.
	config := config bitOr: self gainMapFlags.
	"the ADS line is big-endian and uses actual 16bit registers instead of the more common paired 8bit regs. Big-endian? Really, guys?"
	bus register16: ADSConfigRegister value: ((config bitAnd: 16rFF) << 8 bitOr: (config >> 8)).
	"then we have to wait a moment"
	(Delay forMilliseconds: 1.0 / self sampleRate + 1) wait.
	"then read the signed, byte reversed, value, shift it down to 12 bits, scale and polish"
	v := bus register16: ADSConversionRegister.
	v := (v bitAnd: 16rFF) << 8 bitOr: (v >> 8).
	v > 16r8000 ifTrue:[v := v - 16r10000].
	^v >>4 * self fullScaleMillivolts / 2048000.0
]

{ #category : 'device settings' }
I2cDeviceADS1015ADC >> sampleRate [
	^sampleRate ifNil: [sampleRate := 1600]
]

{ #category : 'device settings' }
I2cDeviceADS1015ADC >> sampleRate: rate [

	"the sampling rate is restricted to a few discrete values rather than any old number you happen to like. If you try a rate that isn't suported you'll get the default 1600"
	(ADSSampleRates includesKey: rate)
		ifTrue: [sampleRate := rate]
]

{ #category : 'device read/write' }
I2cDeviceADS1015ADC >> samplesPerSecondFlags [
	"return the flag bits for the required sample rate"
	^ADSSampleRates at: self sampleRate ifAbsent:[16r80]
]
