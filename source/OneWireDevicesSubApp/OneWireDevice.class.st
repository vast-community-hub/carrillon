"
A OneWireDevice is an interface to a device attached to the 1wire bus provided by the Pi (and maybe it can work for other platforms one day) through the GPIO and the 1wire device tree drivers. 
This is actually a rather awkward interface in many ways; we have to read and parse a text file hidden in the /sys directory tree in order to get our input. Each kind of device will need differnet parsing of that content.

Each device on the bus has its own unique (supposedly) ID derived from the bowels of the chip. Each kind of device has a family type code, a two-digit hex value. To find the device on your bus we have to enumerate all the directories in /sys/bus/w1/devices/{family code as string}-* in order to find all the relevent device Ids. They are reported as part of the directory names so we get {family type hex string}-{device id hex string}. To read the latest data (which may not be well-formed nor current) we read the file named by the devices root + the device type/id + 'w1_slave', or /sys/bus/w1/devices/{family type hex string}-{device id hex string}/w1_slave. And it's a read-only file, so remember to use 'readOnlyFileNamed:' to access it. Given the convoluted file name deriving we will keep the path around to save rebuilding it constantly.

The data returned is actually pre-processed somewhat by the kernel drivers and so we get a reasonably simple to check CRC status that let's us know if the data is deemed good, and for many devices a processed final result value. In the case of the very common DS18D20 thermometers this might look like -
54 01 55 00 7f ff 0c 10 c0 : crc=c0 YES
54 01 55 00 7f ff 0c 10 c0 t=21250
and so we can search for 'YES' and the digits following the ' t='. Other devices can be more complex and confusing.

"
Class {
	#name : 'OneWireDevice',
	#superclass : 'Object',
	#instVars : [
		'devId',
		'devFilePath'
	],
	#classVars : [
		'BaseDirectory'
	],
	#category : 'OneWireDevicesSubApp'
}

{ #category : 'queries' }
OneWireDevice class >> baseDirectory [
	"Answer the base directory for 1wire devices within the linux framework."

	^BaseDirectory.

]

{ #category : 'Not categorized' }
OneWireDevice class >> baseDirectory: aStringPath [
	"Set the base directory for 1wire devices within the linux framework."

	BaseDirectory := aStringPath.

]

{ #category : 'queries' }
OneWireDevice class >> concreteClassForFamilyType: familyTypeString [
	"see if any of my subclasses handle the family type specified"

	self withAllSubclassesDo: [:cl |
		(cl familyTypeString = familyTypeString) ifTrue: [^cl].
	].
	^nil.

]

{ #category : 'Not categorized' }
OneWireDevice class >> deviceDirectoryNamesMatching: pattern [
	"Answer a list of directory device names matching the pattern."
	| fd |

	fd := OrderedCollection new.
	self baseDirectory asPath fileAndDirectoryEntriesMatching: (pattern, '-*') do: [:e | e isDir ifTrue: [fd add: e]].
	^fd collect: [:d | d dName].

]

{ #category : 'queries' }
OneWireDevice class >> familyType [
	"I'm the abstract class, so use 0"
		^0
]

{ #category : 'queries' }
OneWireDevice class >> familyTypeString [
	"return the family type code as a hex string"

	^self familyType printStringRadix: 16 showRadix: false.

]

{ #category : 'instance creation' }
OneWireDevice class >> idString: aString [
	"Create a new device to represent aString. Normally this should be a name reported by #listDevices etc.
		Check for the family type being at the front; if it is, we pass it around subclasses to find one that supports the type."

	aString size = 15 ifTrue: [
		"extract the first two chars and see if any subclass claims that type"
		^(self concreteClassForFamilyType: (aString copyFrom: 1 to: 2)) ifNotNil: [:cl |
			cl idString: (aString copyFrom: 4 to: aString size)]].
		
	aString size = 12 ifTrue: [
		"we will assume this is a valid 12 hex digit id for now and make an instance"
		^self new idString: aString].

	"with no matching id likley, return nil"	
	^nil
]

{ #category : 'Not categorized' }
OneWireDevice class >> initializeOnLoad [
	"Initialize On Load."

	BaseDirectory := '/sys/bus/w1/devices'.

]

{ #category : 'queries' }
OneWireDevice class >> listDevices [
	"Answer a collection of discovered 1wire device directories matching my family code.
		OneWireDS18B20ThermometerDevice listDevices."

	^self deviceDirectoryNamesMatching: self familyTypeString.

]

{ #category : 'queries' }
OneWireDevice class >> listDevicesOfType: deviceFamilyCode [
	"Answer a collection of discovered 1wire device directories matching the family code."
	"OneWireDevice listDevicesOfType: 16r28."

	^self deviceDirectoryNamesMatching: (deviceFamilyCode printStringRadix: 16 showRadix: false).

]

{ #category : 'initialize-release' }
OneWireDevice >> idString: aTwelveHexDigitString [
	"Set my devId and derive my file path."

	devId := aTwelveHexDigitString.
	devFilePath := (self class baseDirectory), '/', (self class familyTypeString, '-', devId), '/w1_slave'.

]
