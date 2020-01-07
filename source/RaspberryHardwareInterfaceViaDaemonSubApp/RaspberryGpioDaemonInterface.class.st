"
A PigpiodInterface is an interface to the pigpiod_if2 library provided by Joan<pigpio@abyz.co.uk>, which talks via sockets or some other magic to the pigpiod deamon. This can actually run on any networked connected Pi, not just the local.
See abyz.co.uk/rpi/pigpio for much more detail
"
Class {
	#name : 'RaspberryGpioDaemonInterface',
	#superclass : 'Object',
	#instVars : [
		'id',
		'currentWaveId',
		'currentWavePin',
		'currentWaveFrequency',
		'allocatedDevices'
	],
	#classVars : [
		'DefaultPort',
		'AllocatedInterfaces',
		'RandomIntegers',
		'DefaultIP'
	],
	#pools : [
		'RaspberryGpioConstants',
		'RaspberryGpioDaemonFunctions',
		'RaspberryGpioUltrasonicDaemonFunctions'
	],
	#category : 'RaspberryHardwareInterfaceViaDaemonSubApp'
}

{ #category : 'accessing' }
RaspberryGpioDaemonInterface class >> defaultIP: anIPString andPort: portString [
	"set the default IP address to connect the interface to; a string in plain IP form, plus a port number. Either can be nil"
	
	"PigpiodInterface defaultIP: '192.168.1.108' andPort: nil" "remote Pi"
	"PigpiodInterface defaultIP: nil andPort: nil" "this local Pi"
	DefaultIP := anIPString.
	DefaultPort := portString.

]

{ #category : 'class initialization' }
RaspberryGpioDaemonInterface class >> initializeOnLoad [
	"PigpiodInterface initialize."

	AllocatedInterfaces := EsWeakIdentitySet new
		owner: self;
		finalizeAction: #shutDown:;
		yourself.

]

{ #category : 'class initialization' }
RaspberryGpioDaemonInterface class >> new [
	"#new cannot be used to create a RaspberryGpioDaemonInterface.  See #RaspberryGpioStartIp:port:."

	^self shouldNotImplement.

]

{ #category : 'Not categorized' }
RaspberryGpioDaemonInterface class >> raiseError: anErrorCode with: contextDescription [
	"Raise a <PiGpioErrorException> with the code @anErrorCode and
	 @contextDescription to indicate what failed."
	
	RaspberryHardwareInterfaceViaDaemonSubApp raiseError: anErrorCode with: contextDescription.

]

{ #category : 'Not categorized' }
RaspberryGpioDaemonInterface class >> randomInt [
	"Answer a random integer between 1 and 1,000,000,000."

	RandomIntegers isNil ifTrue: [RandomIntegers := EsRandom new].
	^RandomIntegers nextInt: 1000000000.

]

{ #category : 'class initialization' }
RaspberryGpioDaemonInterface class >> raspberryGpioStart [
	"Create a new instance, connect to the daemon with the ip address and port and answer the instance."

	^self raspberryGpioStartIp: DefaultIP port: DefaultPort.

]

{ #category : 'accessing' }
RaspberryGpioDaemonInterface class >> raspberryGpioStartIp: ipString port: portString [
	"Create a new instance, connect to the daemon with the ip address and port and answer the instance."
	| ip port interface |

	ip := ipString ifNil: [DefaultIP].
	port := portString ifNil: [DefaultPort].
	interface := self basicNew.
	interface raspberryGpioStartIp: ip port: port.
	^interface id notNil ifTrue: [
		AllocatedInterfaces add: interface.
		interface.
	] ifFalse: [nil].

]

{ #category : 'Not categorized' }
RaspberryGpioDaemonInterface class >> shutDown [
	"Ask external library to perform any necessary cleanup."

	AllocatedInterfaces do: [:ai | ai shutDown].

]

{ #category : 'Not categorized' }
RaspberryGpioDaemonInterface class >> shutDown: aPiGpiodInterface [
	"Ask external library to perform any necessary cleanup."

	aPiGpiodInterface shutDown.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> bbI2cClose: sda [
	"This function stops bit banging I2C on a pair of GPIO previously opened with [*bb_i2c_open*].
		SDA: 0-31, the SDA GPIO used in a prior call to [*bb_i2c_open*]

		Returns 0 if OK, otherwise BadUserGpio or NotI2CGpio."

	^BbI2cClose callWith: id with: sda.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> bbI2cOpen: sda scl: scl baud: baud [
	"This function selects a pair of GPIO for bit banging I2C at a specified baud rate.
		Bit banging I2C allows for certain operations which are not possible with the standard I2C driver.

		o baud rates as low as 50 
		o repeated starts 
		o clock stretching 
		o I2C on any pair of spare GPIO

		SDA: 0-31
		SCL: 0-31
		baud: 50-500000
		Returns 0 if OK, otherwise BadUserGpio, BadI2CBaud or GpioInUse.

		NOTE:
			The GPIO used for SDA and SCL must have pull-ups to 3V3 connected.  As a guide the hardware pull-ups on pins 3 and 5 are 1k8 in value."

	^BbI2cOpen callWith: id with: sda with: scl with: baud.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> bbI2cZip: sda inBuf: inBuf inLen: inLen outBuf: outBuf outLen: outLen [
	"This function executes a sequence of bit banged I2C operations.  The operations to be performed are specified by the contents of inBuf which contains the concatenated command codes and associated data.

		SDA: 0-31 (as used in a prior call to [*bb_i2c_open*])
		inBuf: pointer to the concatenated I2C commands, see below
		inLen: size of command buffer
		outBuf: pointer to buffer to hold returned data
		outLen: size of output buffer

		Returns >= 0 if OK (the number of bytes read), otherwise BadUserGpio, NotI2CGpio, BadPointer, BadI2CCmd, BadI2CRlen, BadI2CWlen,
			I2CReadFailed or I2CWriteFailed.

		The following command codes are supported:

		Name    @ Cmd & Data   @ Meaning
		End     @ 0            @ No more commands
		Escape  @ 1            @ Next P is two bytes
		Start   @ 2            @ Start condition
		Stop    @ 3            @ Stop condition
		Address @ 4 P          @ Set I2C address to P
		Flags   @ 5 lsb msb    @ Set I2C flags to lsb + (msb << 8)
		Read    @ 6 P          @ Read P bytes of data
		Write   @ 7 P ...      @ Write P bytes of data

		The address, read, and write commands take a parameter P.
		Normally P is one byte (0-255).  If the command is preceded by the Escape command then P is two bytes (0-65535, least significant byte first).

		The address and flags default to 0.  The address and flags maintain their previous value until updated.

		No flags are currently defined.

		The returned I2C data is stored in consecutive locations of outBuf.

		Set address 0x53 start, write 0x32, (re)start, read 6 bytes, stop
		Set address 0x1E
		start, write 0x03, (re)start, read 6 bytes, stop
		Set address 0x68
		start, write 0x1B, (re)start, read 8 bytes, stop
		End

		0x04 0x53 0x02 0x07 0x01 0x32   0x02 0x06 0x06 0x03

		0x04 0x1E 0x02 0x07 0x01 0x03   0x02 0x06 0x06 0x03

		0x04 0x68 0x02 0x07 0x01 0x1B   0x02 0x06 0x08 0x03

		0x00"

	^BbI2cZip callWith: id with: sda with: inBuf with: inLen with: outBuf with: outLen.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> bbSerialRead: userGpio buf: buf bufSize: bufSize [
	"This function copies up to bufSize bytes of data read from the bit bang serial cyclic buffer to the buffer starting at buf.

		userGpio: 0-31, previously opened with [*BbSerialReadOpen*].
		buf: an array to receive the read bytes.
		bufSize: >=0

		Returns the number of bytes copied if OK, otherwise BadUserGpio or NotSerialGpio.

		The bytes returned for each character depend upon the number of
		data bits [*data_bits*] specified in the [*BbSerialReadOpen*] command.

		For [*data_bits*] 1-8 there will be one byte per character. 
		For [*data_bits*] 9-16 there will be two bytes per character. 
		For [*data_bits*] 17-32 there will be four bytes per character."

	^BbSerialRead callWith: id with: userGpio with: buf with: bufSize.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> bbSerialReadClose: userGpio [
	"This function closes a GPIO for bit bang reading of serial data.

		userGpio: 0-31, previously opened with [*BbSerialReadOpen*].

		Returns 0 if OK, otherwise BadUserGpio or NotSerialGpio."

	^BbSerialReadClose callWith: id with: userGpio.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> bbSerialReadOpen: userGpio baud: baud dataBits: dataBits [
	"This function opens a GPIO for bit bang reading of serial data.

		userGpio: 0-31.
		baud: 50-250000
		dataBits: 1-32

		Returns 0 if OK, otherwise BadUserGpio, BadWaveBaud or GpioInUse.

		The serial data is returned in a cyclic buffer and is read using BbSerialRead.

		It is the caller's responsibility to read data from the cyclic buffer in a timely fashion."

	^BbSerialReadOpen callWith: id with: userGpio with: baud with: dataBits.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> bbSpiClose: cs [
	"This function stops bit banging SPI on a set of GPIO opened with [*bbSPIOpen*].

		cs: 0-31, the CS GPIO used in a prior call to [*bbSpiOpen*]

		Returns 0 if OK, otherwise BadUserGpio, or NotSpiGpio."

	^BbSpiClose callWith: id with: cs.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> bbSpiOpen: cs miso: miso mosi: mosi sclk: sclk baud: baud spiFlags: spiFlags [
	"This function selects a set of GPIO for bit banging SPI at a specified baud rate.

		cs: 0-31
		miso: 0-31
		mosi: 0-31
		sclk: 0-31
		baud: 50-250000
		spiFlags: see below

		spiFlags consists of the least significant 22 bits.

		21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0  0  0  0  0  0  0  R  T  0  0  0  0  0  0  0  0  0  0  0  p  m  m

		mm defines the SPI mode, defaults to 0

		Mode CPOL CPHA
		0    0    0
		1    0    1
		2    1    0
		3    1    1

		p is 0 if cs is active low (default) and 1 for active high.

		T is 1 if the least significant bit is transmitted on mosi first, the default (0) shifts the most significant bit out first.

		R is 1 if the least significant bit is received on miso first, the default (0) receives the most significant bit first.

		The other bits in flags should be set to zero.

		Returns 0 if OK, otherwise BadUserGpio, BadSpiBaud, or GpioInUse.

		If more than one device is connected to the SPI bus (defined by sclk, mosi, and miso) each must have its own cs."

	^BbSpiOpen callWith: id with: cs with: miso with: mosi with: sclk with: baud with: spiFlags.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> bbSpiXfer: cs txBuf: txBuf rxBuf: rxBuf count: count [
	"This function executes a bit banged SPI transfer.

		cs: 0-31 (as used in a prior call to [*bbSpiOpen*])
		txBuf: pointer to buffer to hold data to be sent
		rxBuf: pointer to buffer to hold returned data
		count: size of data transfer

		Returns >= 0 if OK (the number of bytes read), otherwise BadUserGpio, NotSpiGpio or BadPointer."

	^BbSpiXfer callWith: id with: cs with: txBuf with: rxBuf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> bscI2c: i2cAddr bscXfer: bscXfer [
	"This function allows the Raspberry to act as a slave I2C device.

		The data bytes (if any) are written to the BSC transmit FIFO and the bytes in the BSC receive FIFO are returned.

		i2cAddr: 0-0x7F.
		bscXfer: a structure defining the transfer. OSBscXfer

		Any received data will be written to rxBuf with rxCnt set.

		See [*BscXfer*] for details of the returned status value.

		If there was an error the status will be less than zero (and will contain the error code).

		Note that an i2cAddress of 0 may be used to close the BSC device and reassign the used GPIO (18/19) as inputs."

	^BscI2c callWith: id with: i2cAddr with: bscXfer.

]

{ #category : 'I2C',
 #vaCategories : ['I2C','SPI'] }
RaspberryGpioDaemonInterface >> bscXfer: aBscXfer [
	"This function provides a low-level interface to the SPI/I2C Slave peripheral.
		This peripheral allows the Raspberry to act as a slave device on an I2C or SPI bus.

		The author of pigpiod_if2.so can't get SPI to work properly.  He tried with a control word of 0x303 and swapped MISO and MOSI.

		The function sets the BSC mode, writes any data in the transmit buffer to the BSC transmit FIFO and
		copies any data in the BSC receive FIFO to the receive buffer.

		bscxfer: a structure defining the transfer.

		typedef struct {
			uint32_t control;          // Write
			int rxCnt;                 // Read only
			char rxBuf[BSC_FIFO_SIZE]; // Read only
			int txCnt;                 // Write
			char txBuf[BSC_FIFO_SIZE]; // Write
		} bsc_xfer_t;

		To start a transfer set control (see below) and copy the bytes to be sent (if any) to txBuf and set the byte count in txCnt.

		Upon return rxCnt will be set to the number of received bytes placed in rxBuf.

		The returned function value is the status of the transfer (see below).

		If there was an error the status will be less than zero (and will contain the error code).

		The most significant word of the returned status contains the number of bytes actually copied from txBuf to the BSC transmit FIFO (may be
		less than requested if the FIFO already contained untransmitted data).

		Note that the control word sets the BSC mode.  The BSC will stay in that mode until a different control word is sent.

		The BSC peripheral uses GPIO 18 (SDA) and 19 (SCL) in I2C mode and GPIO 18 (MOSI), 19 (SCLK), 20 (MISO), and 21 (CE) in SPI mode.
		You need to swap MISO/MOSI between master and slave.

		When a zero control word is received GPIO 18-21 will be reset to INPUT mode.

		control consists of the following bits.

		22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
		a  a  a  a  a  a  a  -  - IT HC TF IR RE TE BK EC ES PL PH I2 SP EN

		Bits 0-13 are copied unchanged to the BSC CR register.  See pages 163-165 of the Broadcom peripherals document for full details.

		aaaaaaa @ defines the I2C slave address (only relevant in I2C mode)
		IT		@ invert transmit status flags
		HC	@ enable host control
		TF	@ enable test FIFO
		IR	@ invert receive status flags
		RE	@ enable receive
		TE	@ enable transmit
		BK	@ abort operation and clear FIFOs
		EC	@ send control register as first I2C byte
		ES	@ send status register as first I2C byte
		PL	@ set SPI polarity high
		PH	@ set SPI phase high
		I2		@ enable I2C mode
		SP	@ enable SPI mode
		EN	@ enable BSC peripheral

		The returned status has the following format

		20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
		S  S  S  S  S  R  R  R  R  R  T  T  T  T  T RB TE RF TF RE TB

		Bits 0-15 are copied unchanged from the BSC FR register.  See pages 165-166 of the Broadcom peripherals document for full details.

		SSSSS @ number of bytes successfully copied to transmit FIFO
		RRRRR @ number of bytes in receieve FIFO
		TTTTT @ number of bytes in transmit FIFO
		RB	@ receive busy
		TE	@ transmit FIFO empty
		RF	@ receive FIFO full
		TF	@ transmit FIFO full
		RE	@ receive FIFO empty
		TB	@ transmit busy

		The following example shows how to configure the BSC peripheral as an I2C slave with address 0x13 and send four bytes.

		bsc_xfer_t xfer;

		xfer.control = (0x13<<16) | 0x305;

		memcpy(xfer.txBuf, 'ABCD', 4);
		xfer.txCnt = 4;

		status = bsc_xfer(pi, &xfer);

		if (status >= 0) {
			// process transfer
		}"
	| bscXferPtr |

	bscXferPtr := OSObjectPointer reference: aBscXfer.

	^BscXfer callWith: id with: bscXferPtr.

]

{ #category : 'Callback' }
RaspberryGpioDaemonInterface >> callbackCancel: callbackId [
	"This function cancels a callback identified by its id.

		callbackId: >=0, as returned by a call to [*callback*] or [*callback_ex*].

		The function returns 0 if OK, otherwise GpioCallbackNotFound."

	CallbackCancel callWith: callbackId.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> clearBank1: bits [
	"Clears GPIO 0-31 if the corresponding bit in bits is set.

		bits: a bit mask with 1 set if the corresponding GPIO is to be cleared.

		Returns 0 if OK, otherwise SomePermitted.

		A status of SomePermitted indicates that the user is not allowed to write to one or more of the GPIO."

	^ClearBank1 callWith: id with: bits.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> clearBank2: bits [
	"Clears GPIO 32-53 if the corresponding bit (0-21) in bits is set.

		bits: a bit mask with 1 set if the corresponding GPIO is to be cleared.

		Returns 0 if OK, otherwise SomePermitted.

		A status of SomePermitted indicates that the user is not allowed to write to one or more of the GPIO."

	^ClearBank2 callWith: id with: bits.

]

{ #category : 'Setup' }
RaspberryGpioDaemonInterface >> createGpioDeviceDRV8835MotorDrive: speedPin directionPin: directionPin [
	"Create and answer a new instance of GpioDeviceDRV8835MotorDrive."

	^GpioDeviceDRV8835MotorDrive basicNew speedPin: speedPin directionPin: directionPin gpioInterface: self; yourself.

]

{ #category : 'Setup' }
RaspberryGpioDaemonInterface >> createGpioDeviceHBridge: pinA pinB: pinB [
	"Create and answer a new instance of GpioDeviceHBridge."

	^GpioDeviceHBridge basicNew pinA: pinA pinB: pinB gpioInterface: self; yourself.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> createI2cBus: slaveAddress [
	"Create, set up and answer a new instance of I2cBusGpio."
	| handle msg bus |

	handle := self i2cOpen: slaveAddress.
	(handle >= 0) ifTrue: [
		bus := I2cGpioSerialBus basicNew interface: self handle: handle slaveAddress: slaveAddress; yourself.
	] ifFalse: [
		msg := 'Failed to create I2C serial bus interface for address : %1' bindWith: slaveAddress printString.
		self lookUpAndRaiseError: handle with: msg.
	].
	^bus.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> createI2cDevice: deviceClass slaveAddress: slaveAddress [
	"Create an instance of the I2cDevice, an I2cGpioSerialBus for it and answer the instance.
		deviceClass is a subclass of I2cDevice."
	| bus device |

	bus := self createI2cBus: slaveAddress.
	device := deviceClass basicNew slaveAddress: slaveAddress i2cBus: bus; yourself.
	allocatedDevices add: device.
	^device.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> createSpiBusChannel: channel speed: baud flags: spiFlags [
	"Create, set up and answer a new instance of SpiGpioSerialBus."
	| handle msg bus |

	handle := self spiSetup: channel speed: baud flags: spiFlags.
	(handle >= 0) ifTrue: [
		bus := SpiBusPiGpio basicNew interface: self handle: handle; yourself.
	] ifFalse: [
		msg := 'Failed to create SPI serial bus interface for channel: %1 and speed: %2' bindWith: channel printString with: baud printString.
		self lookUpAndRaiseError: handle with: msg.
	].
	^bus.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> createSpiDevice: deviceClass channel: channel speed: speed flags: flags [

	"Create an instance of the SpiDevice, a SpiGpioSerialBus for it and answer the instance.
		deviceClass is a subclass of SpiDevice."
	| bus device baud theFlags|

	baud := speed ifNil: [deviceClass defaultSpeed].
	theFlags := flags ifNil: [deviceClass defaultFlags].

	bus := self createSpiBusChannel: channel speed: baud flags: theFlags.
	device := deviceClass basicNew spiBus: bus; yourself.
	allocatedDevices add: device.
	^device.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> custom1: arg1 arg2: arg2 argX: argX [
	"This function is available for user customisation.

		It returns a single integer value.

		arg1: >= 0
		arg2: >= 0
		argx: extra (byte) arguments
		argc: number of extra arguments

		Returns >= 0 if OK, less than 0 indicates a user defined error."

	^Custom1 callWith: id with: arg1 with: arg2 with: argX with: argX size.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> custom2: arg1 arg2: arg2 argX: argX retMax: retMax [
	"This function is available for user customisation.

		It differs from custom_1 in that it returns an array of bytes rather than just an integer.

		The return value is an integer indicating the number of returned bytes.

		arg1: >= 0
		argc: extra (byte) arguments
		count: number of extra arguments
		retBuf: buffer for returned data
		retMax: maximum number of bytes to return

		Returns >= 0 if OK, less than 0 indicates a user defined error.

		Note, the number of returned bytes will be retMax or less."
	| retBuf rc |

	retBuf := ByteArray new: retMax.
	rc := Custom2 callWith: id with: arg1 with: arg2 with: argX with: argX size with: retBuf with: retMax.
	^(rc >= 0) ifTrue: [retBuf copyFrom: 1 to: rc] ifFalse: [RaspberryHardwareInterfaceViaDaemonSubApp lookUpAndRaiseError: rc with: 'Custom2 call raised an error.'].

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> deleteScript: scriptId [
	"This function deletes a stored script.

		scriptId >=0, as returned by [*store_script*].

		The function returns 0 if OK, otherwise BadScriptId."

	^DeleteScript callWith: id with: scriptId.

]

{ #category : 'Callback' }
RaspberryGpioDaemonInterface >> eventCallbackCancel: callbackId [
	"This function cancels an event callback identified by its id.

		callbackId: >=0, as returned by a call to [*event_callback*] or [*event_callback_ex*].

		The function returns 0 if OK, otherwise GpioCallbackNotFound."

	^EventCallbackCancel callWith: callbackId.

]

{ #category : 'Event' }
RaspberryGpioDaemonInterface >> eventTrigger: event [
	"This function signals the occurrence of an event.

		event: 0-31.

		Returns 0 if OK, otherwise BadEventId.

		An event is a signal used to inform one or more consumers to start an action.  Each consumer which has registered an interest
		in the event (e.g. by calling [*event_callback*]) will be informed by a callback.

		One event, EventBsc (31) is predefined.  This event is auto generated on BSC slave activity.

		The meaning of other events is arbitrary.

		Note that other than its id and its tick there is no data associated with an event."

	^EventTrigger callWith: id with: event.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileClose: handle [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function closes the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).

		Returns 0 if OK, otherwise GpioBadHandle."

	^FileClose callWith: id with: handle.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileList: fPat buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function returns a list of files which match a pattern.

		fpat: file pattern to match.
		buf: an array to receive the matching file names.
		count: the maximum number of bytes to read.

		Returns the number of returned bytes if OK, otherwise NoFileAccess or NoFileMatch.

		The pattern must match an entry in /opt/pigpio/access.  The pattern may contain wildcards.  See [*fileOpen*].

		NOTE

		The returned value is not the number of files, it is the number of bytes in the buffer.  The file names are separated by newline characters."

	^FileList callWith: id with: fPat with: buf with: count.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileOpen: fileName mode: mode [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function returns a handle to a file opened in a specified mode.

		fileName: the file to open.
		mode: the file open mode.

		Returns a handle (>=0) if OK, otherwise NoHandle, NoFileAccess, BadFileMode, FileOpenFailed or FileIsADir.

		File

		A file may only be opened if permission is granted by an entry in /opt/pigpio/access.  This is intended to allow remote access to files
		in a more or less controlled manner.

		Each entry in /opt/pigpio/access takes the form of a file path which may contain wildcards followed by a single letter permission.
		The permission may be R for read, W for write, U for read/write, and N for no access.

		Where more than one entry matches a file the most specific rule applies.  If no entry matches a file then access is denied.

		Suppose /opt/pigpio/access contains the following entries

		/home/* n
		/home/pi/shared/dir_1/* w
		/home/pi/shared/dir_2/* r
		/home/pi/shared/dir_3/* u
		/home/pi/shared/dir_1/file.txt n

		Files may be written in directory dir_1 with the exception of file.txt.

		Files may be read in directory dir_2.

		Files may be read and written in directory dir_3.

		If a directory allows read, write, or read/write access then files may be created in that directory.

		In an attempt to prevent risky permissions the following paths are ignored in /opt/pigpio/access.

		a path containing ..
		a path containing only wildcards (*?)
		a path containing less than two non-wildcard parts

		Mode

		The mode may have the following values.

		Macro         @ Value @ Meaning
		FileRead  @   1   @ open file for reading
		FileWrite @   2   @ open file for writing
		FileRW    @   3   @ open file for reading and writing

		The following values may be or'd into the mode.

		Macro          @ Value @ Meaning
		FileAppend @ 4     @ Writes append data to the end of the file
		FileCreate @ 8     @ The file is created if it doesn't exist
		FileTrunc  @ 16    @ The file is truncated

		Newly created files are owned by root with permissions owner read and write."

	^FileOpen callWith: id with: fileName with: mode.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileRead: handle buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function reads up to count bytes from the the file associated with handle and writes them to buf.

		handle: >=0 (as returned by [*fileOpen*]).
		buf: an array to receive the read data.
		count: the maximum number of bytes to read.

		Returns the number of bytes read (>0) if OK, otherwise GpioBadHandle, GpioBadParam, GpioFileNotRopen or GpioBadFileWrite.

		bytes = file_read(pi, handle, buf, sizeof(buf));

		if (bytes >= 0) {
			// process read data
		}"

	^FileRead callWith: id with: handle with: buf with: count.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileSeek: handle seekOffset: seekOffset seekFrom: seekFrom [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function seeks to a position within the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).
		seekOffset: the number of bytes to move.  Positive offsets move forward, negative offsets backwards.
		seekFrom: one of FromStart (0), FromCurrent (1), or FromEnd (2).

		Returns the new byte position within the file (>=0) if OK, otherwise GpioBadHandle or GpioBadFileSeek.

		file_seek(pi, handle, 123, FromStart); // Start plus 123

		size = file_seek(pi, handle, 0, FromEnd); // End, return size
		pos = file_seek(pi, handle, 0, FromCurrent); // Current position"

	^FileSeek callWith: id with: handle with: seekOffset with: seekFrom.

]

{ #category : 'FileIO' }
RaspberryGpioDaemonInterface >> fileWrite: handle buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function writes count bytes from buf to the the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).
		buf: the array of bytes to write.
		count: the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, GpioBadParam, GpioFileNotWOpen or GpioBadFileWrite.

		if (file_write(pi, handle, buf, 100) == 0) {
			// file written okay
		} else {
			// error
		}"

	^FileWrite callWith: id with: handle with: buf with: count.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> getCurrentTick [
	"Returns the current system tick.
		Tick is the number of microseconds since system boot.

		This is included in the interface for the sake of completeness but there are better ways in Smalltalk.
		Like Time millisecondClockValue.

		As tick is an unsigned 32 bit quantity it wraps around after
		2^32 microseconds, which is approximately 1 hour 12 minutes.

		You don't need to worry about the wrap around as long as you
		take a tick (uint32_t) from another tick, i.e. the following
		code will always provide the correct difference.

		uint32_t startTick, endTick;
		int diffTick;

		startTick := self gpioTick.
		do some processing
		endTick := self gpioTick.
		diffTick := endTick - startTick."

	^GetCurrentTick callWith: id.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> getHardwareRevision [
	"Returns the hardware revision.

		If the hardware revision can not be found or is not a valid hexadecimal number the function returns 0.

		The hardware revision is the last few characters on the Revision line of /proc/cpuinfo.

		The revision number can be used to determine the assignment of GPIO to pins (see [*gpio*]).

		There are at least three types of board.

		Type 1 boards have hardware revision numbers of 2 and 3.
		Type 2 boards have hardware revision numbers of 4, 5, 6, and 15.
		Type 3 boards have hardware revision numbers of 16 or greater.

		for Revision       : 0002 the function returns 2.
		for Revision       : 000f the function returns 15.
		for Revision       : 000g the function returns 0."

	^GetHardwareRevision callWith: id.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> getPadStrength: pad [
	"This function returns the pad drive strength in mA.

		pad: 0-2, the pad to get.

		Returns the pad drive strength if OK, otherwise BadGpio.

		Pad @ GPIO
		0   @ 0-27
		1   @ 28-45
		2   @ 46-53

		strength = getPadStrength: 0				get pad 0 strength"

	^GetPadStrength callWith: id with: pad.


]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> getPinMode: pin [
	"Returns the mode of #pin if ok or BadGpio.
		#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53
	 "

	^GetMode callWith: id with: pin.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> getPwmDutyCycleForPin: pin [
	"Get the pwm duty cycle (0-range, default 255 max) for pin.
		Returns 0-range if ok, or BadUserGpio or NotPwmGpio.
		Use #id:pinGetPwmRange: to read the pwm range setting."
	"#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GetPwmDutycycle callWith: id with: pin.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> getRaspberryGpioVersion [
	"Returns the Raspberry GPIO version."

	^GetRaspberryGpioVersion callWith: id.

]

{ #category : 'Event' }
RaspberryGpioDaemonInterface >> gpioTrigger: userGpio pulseLen: pulseLen level: level [
	"This function sends a trigger pulse to a GPIO.  The GPIO is set to level for pulseLen microseconds and then reset to not level.

		userGpio 0-31.
		pulseLen: 1-100.
		level: 0,1.

		Returns 0 if OK, otherwise BadUserGpio, BadLevel, BadPulselen, or NotPermitted."

	^GpioTrigger callWith: id with: userGpio with: pulseLen with: level.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> hardwareClock: pin clkFreq: clkFreq [
	"Starts a hardware clock on a GPIO at the specified frequency.  Frequencies above 30MHz are unlikely to work.

		pin: is the Broadcom pin number, aka gpio and userGpio - 0-53
		frequency: 0 (off) or 4689-250000000 (250M)

		Returns 0 if OK, otherwise NotPermitted, BadGpio, NotHclkGpio, BadHclkFreq or BadHclkPass.

		The same clock is available on multiple GPIO.  The latest frequency setting will be used by all GPIO which share a clock.

		The GPIO must be one of the following.

		4   clock 0  All models
		5   clock 1  All models but A and B (reserved for system use)
		6   clock 2  All models but A and B
		20  clock 0  All models but A and B
		21  clock 1  All models but A and Rev.2 B (reserved for system use)

		32  clock 0  Compute module only
		34  clock 0  Compute module only
		42  clock 1  Compute module only (reserved for system use)
		43  clock 2  Compute module only
		44  clock 1  Compute module only (reserved for system use)

		Access to clock 1 is protected by a password as its use will likely crash the Pi.  The password is given by or'ing 0x5A000000 with the GPIO number."

	^HardwareClock callWith: id with: pin with: clkFreq.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> hardwarePwm: pin pwmFreq: pwmFreq pwmDuty: pwmDuty [
	"Starts hardware PWM on a GPIO at the specified frequency and dutycycle.  Frequencies above 30MHz are unlikely to work.

		NOTE: Any waveform started by [*wave_send_**] or [*wave_chain*] will be cancelled.

		This function is only valid if the pigpio main clock is PCM.
		The main clock defaults to PCM but may be overridden when the pigpio daemon is started (option -t).

		pin: the Broadcom pin number, aka gpio and userGpio - 0-53
		pwmDuty: 0 (off) or 1-125000000 (125M)
		pwmDuty: 0 (off) to 1000000 (1M)(fully on)

		Returns 0 if OK, otherwise NotPermitted, BadGpio, NotHpwmGpio, BadHpwmDuty, BadHpwmFreq  or HpwmIllegal.

		The same PWM channel is available on multiple GPIO.  The latest frequency and dutycycle setting will be used by all GPIO which share a PWM channel.

		The GPIO must be one of the following.

		12  PWM channel 0  All models but A and B
		13  PWM channel 1  All models but A and B
		18  PWM channel 0  All models
		19  PWM channel 1  All models but A and B

		40  PWM channel 0  Compute module only
		41  PWM channel 1  Compute module only
		45  PWM channel 1  Compute module only
		52  PWM channel 0  Compute module only
		53  PWM channel 1  Compute module only

		The actual number of steps beween off and fully on is the integral part of 250 million divided by PWMfreq.

		The actual frequency set is 250 million / steps.

		There will only be a million steps for a PWMfreq of 250.
		Lower frequencies will have more steps and higher frequencies will have fewer steps.
		pwmDuty is automatically scaled to take this into account."

	^HardwarePwm callWith: id with: pin with: pwmFreq with: pwmDuty.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cBlockProcessCall: handle register: regNum buffer: buf [
	"This writes data bytes to the specified register of the device associated with handle and reads a device specified number of bytes of data in return.

		handle: >=0, as returned by a call to [*i2c_open*].
		i2c_reg: 0-255, the register to write/read.
		buf: an array with the data to send and to receive the read data.
		count: 1-32, the number of bytes to write.

		Returns the number of bytes read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		The smbus 2.0 documentation states that a minimum of 1 byte may be sent and a minimum of 1 byte may be received.
		The total number of bytes sent/received must be 32 or less.

		Block write-block read. SMBus 2.0 5.5.8

		S Addr Wr [A] i2c_reg [A] count [A] buf0 [A] ...
		S Addr Rd [A] [Count] A [Data] ... A P"
	| bytes bytesPtr |

	bytes := buf asByteArray.
	bytesPtr := OSObjectPointer reference: bytes.

	^I2cBlockProcessCall callWith: id with: handle with: regNum with: bytesPtr with: bytes size.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cCloseBus: bus [
	"Disconnect from the i2c device, freeing the handle etc.  Returns 0 if ok, otherwise GpioBadHandle."

	^I2cClose callWith: id with: bus handle.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cOpen: devId [
	"RaspberryGpioInterface instance i2CSetup: 16r54 for example for PiGlow.
	Return >= 0 if ok (the handle), or GpioBadI2CBus, GpioBadI2CAddr, GpioBadFlags GpioNoHandle or GpioI2COpenFailed"

	^I2cOpen callWith: id with: 1 with: devId with: 0.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cOpen: bus device: devId flags: flags [
	"RaspberryGpioInterface instance id: id i2cOpen: 1 device: 16r54 flags: 0 for example for PiGlow.
	Return >= 0 if ok (the handle), or GpioBadI2CBus, GpioBadI2CAddr, GpioBadFlags, GpioNoHandle or GpioI2COpenFailed"

	^I2cOpen callWith: id with: bus with: devId with: flags.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cProcessCall: handle register: regNum wVal: val [
	"This writes 16 bits of data to the specified register of the device associated with handle and and reads 16 bits of data in return.

		handle: >=0, as returned by a call to [*i2c_open*].
		i2c_reg: 0-255, the register to write/read.
		wVal: 0-0xFFFF, the value to write.

		Returns the word read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Process call. SMBus 2.0 5.5.6

		S Addr Wr [A] i2c_reg [A] wVal_Low [A] wVal_High [A]
		S Addr Rd [A] [DataLow] A [DataHigh] NA P."
	| bytes bytesPtr |

	bytes := val as2ByteArray.
	bytesPtr := OSObjectPointer reference: bytes itemType: OSChar16.

	^I2cProcessCall callWith: id with: handle with: regNum with: bytesPtr.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cRead16Bus: bus register: regNum [
	"read a 16bit i2c register.
	Returns word ( >= 0) or GpioBadHandle, GpioBadParam or GpioI2CReadFailed"

	^self i2cReadWordBus: bus register: regNum.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadBlockData: handle register: regNum buf: buf [
	"This reads a block of up to 32 bytes from the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		i2c_reg: 0-255, the register to read.
		buf: an array to receive the read data.

		The amount of returned data is set by the device.

		Returns the number of bytes read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Block read. SMBus 2.0 5.5.7

		S Addr Wr [A] i2c_reg [A]
		S Addr Rd [A] [Count] A [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadBlockData callWith: id with: handle with: regNum with: buf.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadBus: bus register: regNum [
	"read a byte i2c register.
	Returns the byte ( >= 0) or GpioBadHandle or GpioI2CReadFailed"

	^I2cReadByteData callWith: id with: bus handle with: regNum.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadByte: handle register: regNum [
	"This reads a single byte from the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to read.

		Returns the byte read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Read byte. SMBus 2.0 5.5.5

		S Addr Wr [A] i2c_reg [A] S Addr Rd [A] [Data] NA P"

	^I2cReadByte callWith: id with: handle with: regNum.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadDevice: handle buf: buf count: count [
	"This reads count bytes from the raw device into buf.

		handle: >=0, as returned by a call to [*i2c_open*].
		buf: an array to receive the read data bytes.
		count: >0, the number of bytes to read.

		Returns count (>0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		S Addr Rd [A] [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadDevice callWith: id with: handle with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadI2cBlockData: handle register: regNum buf: buf count: count [
	"This reads count bytes from the specified register of the device associated with handle .  The count may be 1-32.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to read.
		buf: an array to receive the read data.
		count: 1-32, the number of bytes to read.

		Returns the number of bytes read (>0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		S Addr Wr [A] i2c_reg [A]
		S Addr Rd [A] [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadI2cBlockData callWith: id with: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadPairBus: bus register: regNum [
	"read a 16bit value from two paired i2c registers"

	^(self i2cReadBus: bus register: regNum) bitOr: (self i2cReadBus: bus register: regNum + 1) << 8.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cReadWordBus: bus register: regNum [
	"read a 16bit i2c register.
	Returns word ( >= 0) or GpioBadHandle, GpioBadParam or GpioI2cReadFailed"

	^I2cReadWordData callWith: id with: bus handle with: regNum.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWrite16Bus: bus register: regNum value: val [
	"write a 16bit i2c register.
	Returns 0 if OK, otherwise GpioBadHandle, GpioBadParam or GpioI2CWriteFailed"

	^I2cWriteWordData callWith: id with: bus handle with: regNum with: val.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteBlockData: handle register: regNum buf: buf count: count [
	"This writes up to 32 bytes to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		buf: an array with the data to send.
		count: 1-32, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2CWriteFailed.

		Block write. SMBus 2.0 5.5.7

		S Addr Wr [A] i2c_reg [A] count [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteBlockData callWith: id with: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteBus: bus register: regNum value: val [
	"write a byte i2c register.
	Returns 0 if OK, otherwise GpioBadHandle, GpioBadParam or GpioI2cWriteFailed"

	^I2cWriteByteData callWith: id with: bus handle with: regNum with: val.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteByte: handle register: regNum byte: byte [
	"This writes a single byte to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		bVal: 0-0xFF, the value to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Write byte. SMBus 2.0 5.5.4

		S Addr Wr [A] i2c_reg [A] bVal [A] P"

	^I2cWriteByte callWith: id with: handle with: regNum with: byte.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteDevice: handle buf: buf count: count [
	"This writes count bytes from buf to the raw device.

		handle: >=0, as returned by a call to [*i2c_open*].
		buf: an array containing the data bytes to write.
		count: >0, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		S Addr Wr [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteDevice callWith: id with: handle with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteI2cBlockData: handle register: regNum buf: buf count: count [
	"This writes 1 to 32 bytes to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		buf: the data to write.
		count: 1-32, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		S Addr Wr [A] i2c_reg [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteI2cBlockData callWith: id with: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteQuick: handle bit: bit [
	"This sends a single bit (in the Rd/Wr bit) to the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		bit: 0-1, the value to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Quick command. SMBus 2.0 5.5.1

		S Addr bit [A] P"

	^I2cWriteQuick callWith: id with: handle with: bit.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cWriteWordData: handle register: regNum value: val [
	"write a 16bit i2c register.
	Returns 0 if OK, otherwise GpioBadHandle, GpioBadParam or GpioI2cWriteFailed"

	^I2cWriteWordData callWith: handle with: regNum with: val.

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> i2cZip: handle inBuf: inBuf inLen: inLen outBuf: outBuf outLen: outLen [
	"This function executes a sequence of I2c operations.  The operations to be performed are specified by the contents of inBuf
		which contains the concatenated command codes and associated data.

		handle: >=0, as returned by a call to [*i2cOpen*]
		inBuf: pointer to the concatenated I2c commands, see below
		inLen: size of command buffer
		outBuf: pointer to buffer to hold returned data
		outLen: size of output buffer

		Returns >= 0 if OK (the number of bytes read), otherwise GpioBadHandle, BadPointer, BadI2cCmd, BadI2cRlen, BadI2cWLen or BadI2cSeg.

		The following command codes are supported:

		Name		@ Cmd & Data	@ Meaning
		End 			@ 0						@ No more commands
		Escape		@ 1						@ Next P is two bytes
		On			@ 2						@ Switch combined flag on
		Off			@ 3						@ Switch combined flag off
		Address	@ 4 P 					@ Set I2c address to P
		Flags		@ 5 lsb msb			@ Set I2c flags to lsb + (msb << 8)
		Read		@ 6 P					@ Read P bytes of data
		Write		@ 7 P ...				@ Write P bytes of data

		The address, read, and write commands take a parameter P.
		Normally P is one byte (0-255).  If the command is preceded by the Escape command then P is two bytes (0-65535, least significant byte first).

		The address defaults to that associated with the handle.
		The flags default to 0.  The address and flags maintain their previous value until updated.

		The returned I2c data is stored in consecutive locations of outBuf.

		Set address 0x53, write 0x32, read 6 bytes
		Set address 0x1E, write 0x03, read 6 bytes
		Set address 0x68, write 0x1B, read 8 bytes

		0x04 0x53   0x07 0x01 0x32   0x06 0x06
		0x04 0x1E   0x07 0x01 0x03   0x06 0x06
		0x04 0x68   0x07 0x01 0x1B   0x06 0x08
		0x00"

	^I2cZip callWith: id with: handle with: inBuf with: inLen with: outBuf with: outLen.

]

{ #category : 'Setup' }
RaspberryGpioDaemonInterface >> id [
	"Answer our id."

	^id.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> isPinOn: pin [
	"Read the value of a given Pin, returning HIGH (true) or LOW (false) or GpioBadGpio. 
	Note that if you connect a button via a pullDOWN it will return false when pressed, or for a button on a pullUP pin you will get true when pressed."

	^((self readPin: pin) = 1).

]

{ #category : 'Error Handling' }
RaspberryGpioDaemonInterface >> lookUpAndRaiseError: anErrorCode [
	"Raise a <RaspberryGpioErrorException> with the code @anErrorCode and
		look up the error code to indicate what failed."

	RaspberryHardwareInterfaceViaDaemonSubApp lookUpAndRaiseError: anErrorCode.

]

{ #category : 'Error Handling' }
RaspberryGpioDaemonInterface >> lookUpAndRaiseError: anErrorCode with: contextDescription [
	"Raise a <RaspberryGpioErrorException> with the code @anErrorCode and
		look up the error code and append @contextDescription to it to indicate what failed."

	RaspberryHardwareInterfaceViaDaemonSubApp lookUpAndRaiseError: anErrorCode with: contextDescription.

]

{ #category : 'Notify' }
RaspberryGpioDaemonInterface >> notifyBegin: handle bits: bits [
	"Start notifications on a previously opened handle.

		handle: 0-31 (as returned by [*notify_open*])
		bits: a mask indicating the GPIO to be notified.

		Returns 0 if OK, otherwise GpioBadHandle.

		The notification sends state changes for each GPIO whose corresponding bit in bits is set.

		Each notification occupies 12 bytes in the fifo as follows:

		typedef struct {
			uint16_t seqno;
			uint16_t flags;
			uint32_t tick;
			uint32_t level;
		} gpioReport_t;

		seqno: starts at 0 each time the handle is opened and then increments by one for each report.

		flags: three flags are defined, NtfyFlagsWatchDog, NtfyFlagsAlive and NtfyFlagsEvent.

		If bit 5 is set (NtfyFlagsWatchDog) then bits 0-4 of the flags indicate a GPIO which has had a watchdog timeout.

		If bit 6 is set (NtfyFlagsAlive) this indicates a keep alive signal on the pipe/socket and is sent once a minute in the absence
		of other notification activity.

		If bit 7 is set (NtfyFlagsEvent) then bits 0-4 of the flags indicate an event which has been triggered.

		tick: the number of microseconds since system boot.  It wraps around after 1h12m.

		level: indicates the level of each GPIO.  If bit 1<<x is set then GPIO x is high."

	^NotifyBegin callWith: id with: handle with: bits.

]

{ #category : 'Notify' }
RaspberryGpioDaemonInterface >> notifyClose: handle [
	"Stop notifications on a previously opened handle and release the handle for reuse.

		handle: 0-31 (as returned by [*notify_open*])

		Returns 0 if OK, otherwise GpioBadHandle."

	^NotifyClose callWith: id with: handle.

]

{ #category : 'Notify' }
RaspberryGpioDaemonInterface >> notifyOpen [
	"Get a free notification handle.

		Returns a handle greater than or equal to zero if OK, otherwise NoHandle.

		A notification is a method for being notified of GPIO state changes via a pipe.

		Pipes are only accessible from the local machine so this function serves no purpose if you are using the library from a remote machine.
		The in-built (socket) notifications provided by [*callback*] should be used instead.

		Notifications for handle x will be available at the pipe named /dev/pigpiox (where x is the handle number).
		E.g. if the function returns 15 then the notifications must be read from /dev/pigpio15."

	^NotifyOpen callWith: id.

]

{ #category : 'Notify' }
RaspberryGpioDaemonInterface >> notifyPause: handle [
	"Pause notifications on a previously opened handle.

		handle: 0-31 (as returned by [*notify_open*])
		Returns 0 if OK, otherwise GpioBadHandle.

		Notifications for the handle are suspended until [*notify_begin*] is called again."

	^NotifyPause callWith: id with: handle.

]

{ #category : 'Pin Handling',
 #vaCategories : ['Pin Handling','Serial'] }
RaspberryGpioDaemonInterface >> pin: userGpio invert: invert [
	"This function inverts serial logic for big bang serial reads.

		userGpio: 0-31, previously opened with [*BbSerialReadOpen*].
		invert: 0-1, 1 invert, 0 normal.

		Returns 0 if OK, otherwise NotSerialGpio or BadSerInvert."

	^BbSerialInvert callWith: id with: userGpio with: invert.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pin: pin setMode: mode [
	"This sets the mode of a pin to either GpioInput, GpioOutput, or GpioAlt0-GpioAlt5 modes.
		Returns 0 if OK, otherwise GpioBadGpio, GpioBadMode or GpioNotPermitted"
	"RaspberryGpioDaemonInterface pin: 24 setMode: GpioInput"

	^SetMode callWith: id with: pin with: mode.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pin: pin setPullUpDown: mode [
	"Sets or clears resistor pull ups or downs on the GPIO.

		pin: 0-53 - the Broadcom pin number, aka gpio and userGpio
		mode: 0-2

		Returns 0 if OK, otherwise BadGpio or BadPud.

		gpioSetPullUpDown: 17 mode: GpioPudUp - Sets a pull-up.
		gpioSetPullUpDown: 18 mode: GpioPudDown - Sets a pull-down.
		gpioSetPullUpDown: 23 mode: GpioPudOff - Clear any pull-ups/downs."

	^SetPullUpDown callWith: id with: pin with: mode.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pin: pin setPwmDutyCycle: cycle [
	"Set the PWM duty cycle (0-range, default 255 max) for pin.
		If dutycycle = 0, turn off PWM pulses for pin.
		Returns 0 if ok, or GpioBadUSerGpio, GpioBadDutyCycle or GpioNotPermitted.
		Use #id:pin:setPwmRange: to change the default range of 255.

		pin: 0-31 - the Broadcom pin number, aka gpio and userGpio
		dutycycle: 0-range"

	^SetPwmDutycycle callWith: id with: pin with: cycle.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pin: pin setPwmRange: range [
	"This sets the range of the pwm output - PiGPIO sets a user range and scales this to the 'real' range possible for the pin.
		See also #readPwmRealRangePin: to find out what the actual range is use is.
		Minimum allowed value is 25, max is 40,000.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadDutyRange or GpioNotPermitted"

	^SetPwmRange callWith: id with: pin with: (range min: GpioMaxDutyRange max: GpioMinDutyRange).

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pin: pin setServoPulsewidth: width [
	"Set the servo pulse width (0- off, 500 - 2500) for pin. Updates at standard 50Hz.
		Updates at standard 50Hz.
		If width = 0, turn off servo pulses for pin.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadPulseWidth or GpioNotPermitted.
		Use #id:pin:setPwmRange: to change the default range of 255."
	| pulseWidth |

	pulseWidth := (width = 0) ifTrue: [0] ifFalse: [width min: MaxServoPulsewidth max: MinServoPulsewidth].

	^SetServoPulseWidth callWith: id with: pin with: pulseWidth.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pin: pin write: value [
	"Write value (0 or 1) to pin. 
		Returns 0 if ok, or GpioBadGpio, GpioBadLevel or GpioNotPermitted.
		Turns off pwm or servo pulses if previously active on this pin"

	^GpioWrite callWith: id with: pin with: value.

]

{ #category : 'Pin Handling',
 #vaCategories : ['Pin Handling','Servo Control'] }
RaspberryGpioDaemonInterface >> pin: gpioNum writeServoPercent: value [
	"try to move a servo to value % of its range"

	^self setServoPin: gpioNum value: ((value rounded * 5) + 1500).

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinGetMode: pin [
	"Returns the mode of 'pin' if ok or PI_BAD_GPIO"

	^GetMode callWith: id with: pin.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pinGetPwmDutyCycle: pin [
	"Get the pwm duty cycle (0-range, default 255 max) for pin.
		Returns 0-range if ok, or BadUserGpio or NotPwmGpio.
		Use #id:pinGetPwmRange: to read the pwm range setting."
	"#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GetPwmDutycycle callWith: id with: pin.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pinGetPwmFrequency: pin [
	"Return the pwm frequency for pin.
	Returns actual selected frequency if ok, or GpioBadUserGpio.
	Available frequencies for the default 5uS sample rate are:-
	8000, 4000, 2000, 1600, 1000, 800, 500, 400, 320, 250, 200, 160, 100, 80, 50, 40, 20, 10"

	^GetPwmFrequency callWith: id with: pin.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pinGetPwmRange: pin [
	"Get the pwm duty cycle range (25-40000) for pin.
	Returns duty cycle range if ok, or GpioBadUserGpio.
	Details seem a bit complex"

	^GetPwmRange callWith: id with: pin.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> pinGetPwmRealRange: pin [
	"Get the real pwm duty cycle range (25-40000) for pin.
		Returns duty cycle range if ok, or GpioBadUserGpio.
		Details seem a bit complex"

	^GetPwmRealRange callWith: id with: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinGetServoPulsewidth: pin [
	"Get the servo puls width (0-range, default 255 max) for pin.
		Returns pulse width if ok, or BadUserGpio or NotServoGpio.
		Returns 0 (off), 500 (most anti-clockwise) to 2500 (most clockwise) if OK, otherwise BadUserGpio or GpioNotServoGpio.
		#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GetServoPulseWidth callWith: id with: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinRead: pin [
	"Read the on/off value of 'pin'- 0 or 1 or GpioBadGpio."

	^GpioRead callWith: id with: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinSetAsInput: pin [

	"This sets the mode of a pin to INPUT"

	^SetMode callWith: id with: pin with: GpioInput.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinSetAsOutput: pin [

	"This sets the mode of a pin to OUTPUT"

	^SetMode callWith: id with: pin with: GpioOutput.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinSetAsPullDown: pin [
	"Control the internal pull-up/down resistors on a GPIO pin.
	Returns 0 if ok or GpioBadGpio, GpioBadPUD or GpioNotPermitted"

	^SetPullUpDown callWith: id with: pin with: GpioPudDown.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> pinSetAsPullUp: pin [
	"Control the internal pull-up/down resistors on a GPIO pin.
	Returns 0 if ok or GpioBadGpio, GpioBadPUD or GpioNotPermitted"

	^SetPullUpDown callWith: id with: pin with: GpioPudUp.

]

{ #category : 'Pin Handling',
 #vaCategories : ['Pin Handling','Servo Control'] }
RaspberryGpioDaemonInterface >> pinStopServo: gpioNum [
	"stop a servo process on gpioNum"

	^self setServoPin: gpioNum value: 0.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> platformRaspberryGpioStartIp: ipString port: portString [
	"Make a connection to the daemon and return an id for later use.
	ipString can be nil for 'this raspberry' or a string with an IP address. Nil may be over-ridden by the PIGPIO_ADDR environment variable.
	portString can be nil.
	Returns >=0 if ok (use as id)"

	^RaspberryGpioDaemonStart callWith: ipString with: portString.

]

{ #category : 'Error Handling' }
RaspberryGpioDaemonInterface >> raiseError: anErrorCode with: contextDescription [
	"Raise a <PiGpioErrorException> with the code @anErrorCode and
	 @contextDescription to indicate what failed."
	
	self class raiseError: anErrorCode with: contextDescription.

]

{ #category : 'Setup' }
RaspberryGpioDaemonInterface >> randomInt [
	"Answer a random integer between 1 and 1,000,000,000."

	^self class randomInt.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> raspberryGpioDaemonVersion [
	"Return the pigpiod_if2 version."

	^RaspberryGpioDaemonVersion call.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> raspberryGpioErrorText: anInt [
	"Answer the text description for the raspberryGpioError number."
	| errorTextPtr errorText |

	errorTextPtr := RaspberryGpioError callWith: anInt.
	errorText := (OSStringZ address: errorTextPtr) asString.
	^errorText.

]

{ #category : 'Primitives' }
RaspberryGpioDaemonInterface >> raspberryGpioStartIp: ipString port: portString [
	"Make a connection to the daemon and return an id for later use.
	ipString can be nil for 'this raspberry' or a string with an IP address. Nil may be over-ridden by the PIGPIO_ADDR environment variable.
	portString can be nil.
	Returns >=0 if ok (use as id)"
	| reply |

	id isNil ifTrue: [
		reply := [self platformRaspberryGpioStartIp: ipString port: portString] on: Error do: [:sig | sig exitWith: nil].
		(reply notNil and: [reply >= 0]) ifTrue: [
			id := reply.						"We have a good connection to the daemon."
			self setUpDeviceTracking.
		] ifFalse: [
			"The RaspberryGpio interface library failed to make contact with the daemon."
			"Lets try to start the daemon and try again.  But only if we are on the Raspberry and it is a local connection."

			(System cpuArchitecture = 'arm' and: [ipString isNil or: ['127.*' match: ipString]]) ifTrue: [
				UNIXProcess system: 'sudo pigpiod'.
				(Delay forSeconds: 3) wait.
			].

			reply := [self platformRaspberryGpioStartIp: ipString port: portString] on: Error do: [:sig | sig exitWith: sig exception].
			reply isInteger ifTrue: [						"An integer means the platform function call worked."
				(reply >= 0) ifTrue: [
					id := reply.								"We have a good connection to the daemon."
					self setUpDeviceTracking.
				] ifFalse: [self lookUpAndRaiseError: reply with: 'Failed trying to connect to daemon.'].	"Less than zero means the platform function call answered an error code."
			] ifFalse: [reply signal].								"Not an integer means the platform function call failed and we cought the exception."
		].
	] ifFalse: [RaspberryGpioErrorException signal: ('Already connected to pigpio daemon id: %1.' bindWith: id printString)].

]

{ #category : 'Setup' }
RaspberryGpioDaemonInterface >> raspberryGpioStop [
	"RaspberryGpioDaemonInterface stop."

	id notNil ifTrue: [
		[self waveStop; ultrasonicClose] on: Error do: [:sig | sig exitWith: nil].						"Stop sounds and the ultrasonic sub-library."
		[RaspberryGpioDaemonStop callWith: id] on: Error do: [:sig | sig exitWith: nil].			"Stop/break GPIO connection."
		id := nil.
	].

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> readBank1 [
	"Read the levels of the bank 1 GPIO (GPIO 0-31).

		The returned 32 bit integer has a bit set if the corresponding GPIO is logic 1.  GPIO n has bit value (1<<n)."

	^ReadBank1 callWith: id.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> readBank2 [
	"Read the levels of the bank 2 GPIO (GPIO 32-53).

		The returned 32 bit integer has a bit set if the corresponding GPIO is logic 1.  GPIO n has bit value (1<<(n-32))."

	^ReadBank2 callWith: id.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> readPin: pin [
	"Read the on/off value of 'pin'- 0 or 1 or GpioBadGpio "

	^GpioRead callWith: id with: pin.

]

{ #category : 'Shutdown' }
RaspberryGpioDaemonInterface >> release [
	"Ask external library to perform any necessary cleanup.
		We trap and ignore errors here because we assume the caller is done with this connection and just wants to clean things up."

	allocatedDevices do: [:device |
		[device release] on: Error do: [:e | e exitWith: nil].
	].
	[self raspberryGpioStop] on: Error do: [:e | e exitWith: nil].

]

{ #category : 'Shutdown' }
RaspberryGpioDaemonInterface >> releaseDevice: device [
	"Tell the device to release its resources."

	^(device isNil) ifFalse: [device release].

]

{ #category : 'I2C' }
RaspberryGpioDaemonInterface >> releaseI2cBus: bus [
	"Disconnect from the i2c device, freeing the handle etc.  Returns 0 if ok, otherwise GpioBadHandle."

	^(bus isNil) ifFalse: [I2cClose callWith: id with: bus handle].

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> releaseSpiBus: bus [
	"Disconnect from the SPI device, freeing the handle etc.  Returns 0 if ok, otherwise GpioBadHandle."

	^(bus isNil or: [bus isUndefined]) ifFalse: [SpiClose callWith: id with: bus handle].

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> runScript: scriptId numPar: numPar param: param [
	"This function runs a stored script.

		scriptId: >=0, as returned by [*store_script*].
		numPar: 0-10, the number of parameters.
		param: an array of parameters.

		The function returns 0 if OK, otherwise BadScriptId or TooManyParam

		param is an array of up to 10 parameters which may be referenced in the script as p0 to p9."

	^RunScript callWith: id with: scriptId with: numPar with: param.

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> scriptStatus: scriptId param: param [
	"This function returns the run status of a stored script as well as the current values of parameters 0 to 9.

		scriptId: >=0, as returned by [*StoreScript*].
		param: an array to hold the returned 10 parameters.

		The function returns greater than or equal to 0 if OK, otherwise BadScriptId.

		The run status may be ScriptIniting, ScriptHalted, ScriptRunning, ScriptWaiting or ScriptFailed

		The current value of script parameters 0 to 9 are returned in param."

	^ScriptStatus callWith: id with: scriptId with: param.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialClose: handle [
	"This function closes the serial device associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns 0 if OK, otherwise GpioBadHandle."

	^SerialClose callWith: id with: handle.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialDataAvailable: handle [
	"Returns the number of bytes available to be read from the device associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns the number of bytes of data available (>=0) if OK, otherwise GpioBadHandle."

	^SerialDataAvailable callWith: id with: handle.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialOpen: serialTty baud: baud serFlags: serFlags [
	"This function opens a serial device at a specified baud rate with specified flags.  The device name must start with /dev/tty or /dev/serial.

		serialTty: the serial device to open.
		baud: the baud rate in bits per second, see below.
		serFlags: 0.

		Returns a handle (>=0) if OK, otherwise NoHandle, or SerOpenFailed.

		The baud rate must be one of 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800, 9600, 19200, 38400, 57600, 115200, or 230400.

		No flags are currently defined.  This parameter should be set to zero."

	^SerialOpen callWith: id with: serialTty with: baud with: serFlags.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialRead: handle buf: buf count: count [
	"This function reads up to count bytes from the the serial port associated with handle and writes them to buf.

		handle: >=0, as returned by a call to [*SerialOpen*].
		buf: an array to receive the read data.
		count: the maximum number of bytes to read.

		Returns the number of bytes read (>=0) if OK, otherwise GpioBadHandle, BadParam, SerReadNoData, or SerWriteFailed.

		If no data is ready zero is returned."

	^SerialRead callWith: id with: handle with: buf with: count.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialReadByte: handle [
	"This function reads a byte from the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns the read byte (>=0) if OK, otherwise GpioBadHandle, SerReadNoData or SerReadFailed.

		If no data is ready SerReadNoData is returned."

	^SerialReadByte callWith: id with: handle.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialWrite: handle buf: buf count: count [
	"This function writes count bytes from buf to the the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].
		buf: the array of bytes to write.
		count: the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or SerWriteFailed."

	^SerialWrite callWith: id with: handle with: buf with: count.

]

{ #category : 'Serial' }
RaspberryGpioDaemonInterface >> serialWriteByte: handle bVal: bVal [
	"This function writes bVal to the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or SerWriteFailed."

	^SerialWriteByte callWith: id with: handle with: bVal.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> setAsInputPin: pin [

	"This sets the mode of a pin to INPUT"

	^SetMode callWith: id with: pin with: GpioInput.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> setAsOutputPin: pin [

	"This sets the mode of a pin to OUTPUT"

	^SetMode callWith: id with: pin with: GpioOutput.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setBank1: bits [
	"Sets GPIO 0-31 if the corresponding bit in bits is set.

		bits: a bit mask with 1 set if the corresponding GPIO is to be set.

		Returns 0 if OK, otherwise SomePermitted.

		A status of SomePermitted indicates that the user is not allowed to write to one or more of the GPIO."

	^SetBank1 callWith: id with: bits.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setBank2: bits [
	"Sets GPIO 32-53 if the corresponding bit (0-21) in bits is set.

		bits: a bit mask with 1 set if the corresponding GPIO is to be set.

		Returns 0 if OK, otherwise SomePermitted.

		A status of SomePermitted indicates that the user is not allowed to write to one or more of the GPIO."

	^SetBank2 callWith: id with: bits.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setGlitchFilter: userGpio steady: steady [
	"Sets a glitch filter on a GPIO.

		Level changes on the GPIO are not reported unless the level has been stable for at least [*steady*] microseconds.
		The level is then reported.  Level changes of less than [*steady*] microseconds are ignored.

		userGpio: 0-31
		steady: 0-300000

		Returns 0 if OK, otherwise BadUserGpio, or BadFilter.

		This filter affects the GPIO samples returned to callbacks set up with [*callback*], [*callback_ex*] and [*wait_for_edge*].

		It does not affect levels read by [*gpio_read*], [*ReadBank1*], or [*ReadBank2*].

		Each (stable) edge will be timestamped [*steady*] microseconds after it was first detected."

	^SetGlitchFilter callWith: id with: userGpio with: steady.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setNoiseFilter: userGpio steady: steady active: active [
	"Sets a noise filter on a GPIO - Broadcom pin.

		Level changes on the GPIO are ignored until a level which has been stable for [*steady*] microseconds is detected.
		Level changes on the GPIO are then reported for [*active*] microseconds after which the process repeats.

		userGpio: 0-31
		steady: 0-300000
		active: 0-1000000

		Returns 0 if OK, otherwise BadUserGpio, or BadFilter.

		This filter affects the GPIO samples returned to callbacks set up with [*callback*], [*callback_ex*] and [*wait_for_edge*].
		It does not affect levels read by [*gpio_read*], [*read_bank_1*], or [*read_bank_2*].

		Level changes before and after the active period may be reported.
		Your software must be designed to cope with such reports."

	^SetNoiseFilter callWith: id with: userGpio with: steady with: active.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setPad: pad strength: padStrength [
	"This function sets the pad drive strength in mA.

		pad: 0-2, the pad to set.
		padStrength: 1-16 mA.

		Returns 0 if OK, otherwise BadPad or BadStrength.

		Pad @ GPIO
		0	@ 0-27
		1	@ 28-45
		2	@ 46-53"

	^SetPadStrength callWith: id with: pad with: padStrength.

]

{ #category : 'Pin Handling',
 #vaCategories : ['Pin Handling','Servo Control'] }
RaspberryGpioDaemonInterface >> setPin: gpioNum direction: direction [
	"Set the direction of the given pin.  See #pin:setMode:"

	^self pin: gpioNum setMode: direction.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> setPin: pin pwmFrequency: freq [
	"Set the pwm frequency to the nearest available value to freq for pin.
	If cycle = 0, turn off pwm pulses for pin.
	Returns actual selected frequency if ok, or GpioBadUSerGpio or GpioNotPermitted.
	Available frequencies for the default 5uS sample rate are:-
	8000, 4000, 2000, 1600, 1000, 800, 500, 400, 320, 250, 200, 160, 100, 80, 50, 40, 20, 10"
	"PigpiodInterface uniqueInstance ensureStarted; setPin: 23 pwmFrequency: 1000"

	^SetPwmFrequency callWith: id with: pin with: freq.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> setPin: pin value: value [
	"Set an output bit. 

		pin: 0-53
		level: 0-1

		Returns 0 if ok, or GpioBadGpio, GpioBadLevel or GpioNotPermitted.
		If PWM or servo pulses are active on this pin they will be switched off"
	"RaspberryGpioDaemonInterface setPin: 23 value: GpioLow"

	^GpioWrite callWith: id with: pin with: value.

]

{ #category : 'Pin Handling' }
RaspberryGpioDaemonInterface >> setPinAsOutput: pin [

	"This sets the mode of a pin to OUTPUT"

	^SetMode callWith: id with: pin with: GpioOutput.

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> setPwmPin: pin range: val [
	"This sets the range of the pwm output - PiGPIO sets a user range and scales this to the 'real' range possible for the pin.
		See also #readPwmRealRangePin: to find out what the actual range is use is.
		Minimum allowed value is 25, max is 40,000.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadDutyRange or GpioNotPermitted"
	"RaspberryGpioDaemonInterface ensureStarted; setPwmRangePin: 17 value: 200"
	
	^SetPwmRange callWith: id with: pin with: (val min: GpioMaxDutyRange max: GpioMinDutyRange).

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> setPwmPin: pin value: val [
	"Set the pwm duty cycle (0-range, default 255 max) for pin.
	If cycle = 0, turn off pwm pulses for pin.
	Returns 0 if ok, or GpioBadUSerGpio, GpioBadDutyCycle or GpioNotPermitted.
	Use #id:pin:setPwmRange: to change the default range of 255.
	Check the range first and clamp to within it"
	| currentRange |

	currentRange := self pinGetPwmRange: pin.
	^SetPwmDutycycle callWith: id with: pin with: (val min: currentRange max: 0).

]

{ #category : 'PWM' }
RaspberryGpioDaemonInterface >> setPwmRangePin: pin value: val [
	"This sets the range of the pwm output - PiGPIO sets a user range and scales this to the 'real' range possible for the pin.
		See also #readPwmRealRangePin: to find out what the actual range is use is.
		Minimum allowed value is 25, max is 40,000.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadDutyRange or GpioNotPermitted"
		"RaspberryGpioDaemonInterface ensureStarted; setPwmRangePin: 17 value: 200"
	
	^SetPwmRange callWith: id with: pin with: (val min: GpioMaxDutyRange max: GpioMinDutyRange).

]

{ #category : 'Servo Control' }
RaspberryGpioDaemonInterface >> setServoPin: pin value: val [

	"send a servo attached to the pin a pulse of width val mSec - limit to 500-2500 mSec.
	Updates at standard 50Hz.
	If width = 0, turn off servo pulses for pin.
	Returns 0 if ok, or GpioBadUserGpio, GpioBadPulseWidth or GpioNotPermitted."
	"RaspberryGpioDaemonInterface ensureStarted; setServoPin: 17 value: 1500"
	| pulse |

	pulse := (val = 0) ifTrue: [0] ifFalse: [val min: MaxServoPulsewidth max: MinServoPulsewidth].

	^SetServoPulseWidth callWith: id with: pin with: pulse.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> setTonePin: pin value: freq [
	"Write the frequency value to the given  pin -  pin 18 on a PiBrella, for example.
	A really slow 'tone' to be visible on a default led of a Wombat breadboard -"
	"RaspberryGpioDaemonInterface ensureStarted; setTonePin: 23 value: 10"
	| delay pinVal |

	freq = 0 ifTrue: [
		self waveStop; waveClear.
		currentWavePin :=  currentWaveFrequency :=  currentWaveId := 0.
		^0.
	].

	(pin = currentWavePin and: [freq = currentWaveFrequency]) ifFalse: [
		currentWavePin := pin.
		currentWaveFrequency := freq.
		self waveStop; waveClear.
		pinVal := 1<<pin.
		delay := 500000 // freq.
		self waveAddPulseTriplets: (Array with: pinVal with: 0 with: delay with: 0 with: pinVal with: delay).
		currentWaveId := self waveCreate.
		self waveSendRepeat: currentWaveId.
		^currentWaveId.									"this id may be useful to other calls"
	].

]

{ #category : 'Shutdown',
  #vaVisibility : 'private' }
RaspberryGpioDaemonInterface >> setUpDeviceTracking [
	"Set Up Device Tracking."

	allocatedDevices := EsWeakIdentitySet new
		owner: self;
		finalizeAction: #releaseDevice:;
		yourself.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> setWatchDog: userGpio timeout: timeout [
	"Sets a WatchDog for a GPIO.

		userGpio: 0-31.
		timeout: 0-60000.

		Returns 0 if OK, otherwise BadUserGpio or BadWDogTimeout.

		The WatchDog is nominally in milliseconds.

		Only one WatchDog may be registered per GPIO.

		The WatchDog may be cancelled by setting timeout to 0.

		Once a WatchDog has been started callbacks for the GPIO will be triggered every timeout interval after the last GPIO activity.

		The callback will receive the special level Timeout."

	^SetWatchDog callWith: id with: userGpio with: timeout.

]

{ #category : 'Shutdown' }
RaspberryGpioDaemonInterface >> shutDown [
	"Ask external library to perform any necessary cleanup."

	self release.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> spiReadBus: bus buffer: buff count: count [
	"low level spi read; SPI is a bit odd and requires writing bytes from a buffer and reads the same number backand needs a count.
	Read 'count' bytes from the device.
	Return number of bytes actually read (in case not all were) or GpioBadHandle, GpioBadSPICount or GpioSPIXferFailed"

	^SpiRead callWith: id with: bus handle with: buff with: count.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> spiSetup: channel speed: spiSpeed flags: flags [
	"Open an SPI device - 'an instance of PiGpiodInterface spiOpen: 1 speed: 4000000 flags: 0' for example for PiFace Digital.
	Return handle >=0 if OK, otherwise GpioBadSPIChannel, GpioBadSPISpeed, GpioBadFlags, GpioNoAuxSPI or GpioSPIOpenFailed"

	^SpiOpen callWith: id with: channel with: spiSpeed with: flags.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> spiTransferBus: bus txBuffer: buffTx rxBuffer: buffRx count: count [
	"transfer 'count' bytes to/from the device.
	Return number of bytes actually transfered (in case not all were) or GpioBadHandle, GpioBadSPICount or GpioSPIXferFailed"

	^SpiXfer callWith: id with: bus handle with: buffTx with: buffRx with: count.

]

{ #category : 'SPI' }
RaspberryGpioDaemonInterface >> spiWriteBus: bus buffer: buff count: count [
	"Write 'count' bytes to the device.
	Return number of bytes actually transfered (in case not all were) or GpioBadHandle, GpioBadSPICount or GpioSPIXferFailed"

	^SpiWrite callWith: id with: bus handle with: buff with: count.

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> stopScript: scriptId [
	"This function stops a running script.

		scriptId: >=0, as returned by [*store_script*].

		The function returns 0 if OK, otherwise BadScriptId."

	^StopScript callWith: id with: scriptId.

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> storeScript: script [
	"This function stores a script for later execution.

		See [[http://abyz.me.uk/rpi/pigpio/pigs.html#Scripts]] for details.

		script: the text of the script.

		The function returns a script id if the script is valid, otherwise BadScript."

	^StoreScript callWith: id with: script.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> timeSleep: seconds [
	"Delay execution for a given number of seconds.

		seconds: the number of seconds to delay."

	TimeSleep callWith: seconds asFloatD.

]

{ #category : 'Hardware' }
RaspberryGpioDaemonInterface >> timeTime [
	"time_time returns the current time in seconds since the Epoch, we return a DateAndTime."
	| timeTime |

	timeTime := TimeTime call.

	^DateAndTime fromSeconds: timeTime asInteger.

]

{ #category : 'Ultrasonic' }
RaspberryGpioDaemonInterface >> ultrasonicClose [

	self ultrasonicCloseId: id.

]

{ #category : 'Ultrasonic' }
RaspberryGpioDaemonInterface >> ultrasonicCloseId: threadId [
	"Close the ultrasonic thread."

	UltrasonicClose callWith: threadId.

]

{ #category : 'Ultrasonic' }
RaspberryGpioDaemonInterface >> ultrasonicDistance [
	"ask the ultrasonic thread for the latest distance.
	Return -1 if no reading has been made, or the latest reading in centimeters"

	^UltrasonicDistance callWith: id.

]

{ #category : 'Ultrasonic' }
RaspberryGpioDaemonInterface >> ultrasonicDistanceId: threadId [
	"Ask the ultrasonic thread for the latest distance.
	Return -1 if no reading has been made, or the latest reading in centimeters"

	^UltrasonicDistance callWith: threadId.

]

{ #category : 'Ultrasonic' }
RaspberryGpioDaemonInterface >> ultrasonicTriggerOn: trig echoOn: echo [
	"set the ultrasonic processing thread to use trig & echo pins.
	Return 1 if Ok or 0 if failed or already in use"

	^UltrasonicInit callWith: id with: trig with: echo.

]

{ #category : 'Script' }
RaspberryGpioDaemonInterface >> updateScript: scriptId numPar: numPar param: param [
	"This function sets the parameters of a script.  The script may or may not be running.
		The first numPar parameters of the script are overwritten with the new values.

		scriptId: >=0, as returned by [*StoreScript*].
		numPar: 0-10, the number of parameters.
		param: an array of parameters.

		The function returns 0 if OK, otherwise BadScriptId or TooManyParam.

		param is an array of up to 10 parameters which may be referenced in the script as p0 to p9."

	^UpdateScript callWith: id with: scriptId with: numPar with: param.

]

{ #category : 'Event' }
RaspberryGpioDaemonInterface >> waitForEdge: userGpio edge: edge timeout: seconds [
	"This function waits for an edge on the GPIO for up to timeout seconds.

		userGpio 0-31.
		edge: RisingEdge, FallingEdge or EitherEdge.
		timeout: >=0.

		The function returns when the edge occurs or after the timeout.

		Do not use this function for precise timing purposes, the edge is only checked 20 times a second. Whenever
		you need to know the accurate time of GPIO events use a [*callback*] function.

		The function returns 1 if the edge occurred, otherwise 0."

	^WaitForEdge callWith: id with: userGpio with: edge with: seconds asFloatD.

]

{ #category : 'Event' }
RaspberryGpioDaemonInterface >> waitForEvent: event timeout: seconds [
	"This function waits for an event for up to timeout seconds.

		event: 0-31.
		timeout: >=0.

		The function returns when the event occurs or after the timeout.

		The function returns 1 if the event occurred, otherwise 0."

	^WaitForEvent callWith: id with: event with: seconds asFloatD.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveAddNew [
	"This function starts a new empty waveform.  You wouldn't normally need to call this function as
		it is automatically called after a waveform is created with the [*wave_create*] function.

		Returns 0 if OK."

	^WaveAddNew callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveAddPulses: arrayOfPulses [
	"Given an array of OSGpioPulse, add them to the current wave.
	 The arrayOfPulses is a normal Smalltalk collection of instances of OSGpioPulse.
	Returns number of total pulses in the current wave if ok or GpioTooManyPulses"
	| osPulses pulseCnt |

	pulseCnt := arrayOfPulses size.
	osPulses := OSObjectPointer new: pulseCnt itemType: OSGpioPulse.
	0 to: pulseCnt do: [:i | osPulses at: i put: (arrayOfPulses at: (i + 1))].

	^WaveAddGeneric callWith: id with: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveAddPulseTriplets: arrayOfTriplets [
	"Given an array of triplets of int, add them to the current wave.
	 The arrayOfTriplets is a normal Smalltalk collection of integers, every three constitute a wave pulse.
	Returns number of total pulses in the current wave if ok or GpioTooManyPulses"
	| osPulses pulseCnt intCnt |

	intCnt := arrayOfTriplets size.
	osPulses := OSObjectPointer new: intCnt itemType: OSInteger.
	0 to: intCnt do: [:i | osPulses at: i put: (arrayOfTriplets at: (i + 1))].
	pulseCnt := intCnt // 3.

	^WaveAddGeneric callWith: id with: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveAddSerial: userGpio baud: baud dataBits: dataBits stopBits: stopBits offset: offset str: str [
	"This function adds a waveform representing serial data to the existing waveform (if any).  The serial data starts offset
		microseconds from the start of the waveform.

		userGpio: 0-31.
		baud: 50-1000000
		data_bits: number of data bits (1-32)
		stop_bits: number of stop half bits (2-8)
		offset: >=0
		numBytes: >=1
		str: an array of chars.

		Returns the new total number of pulses in the current waveform if OK,
		otherwise BadUserGpio, BadWaveBaud, BadDatabits, BadStopbits, TooManyChars, BadSerOffset or TooManyPulses.

		NOTES:
		The serial data is formatted as one start bit, [*data_bits*] data bits, and [*stop_bits*]/2 stop bits.
		It is legal to add serial data streams with different baud rates to the same waveform.
		[*numBytes*] is the number of bytes of data in str.

		The bytes required for each character depend upon [*data_bits*].
		For [*data_bits*] 1-8 there will be one byte per character. 
		For [*data_bits*] 9-16 there will be two bytes per character. 
		For [*data_bits*] 17-32 there will be four bytes per character."
	| strBytes strBytesPtr |

	strBytes := str asByteArray.
	strBytesPtr := OSObjectPointer reference: strBytes.

	^WaveAddSerial callWith: id with: userGpio with: baud with: dataBits with: stopBits with: offset with: strBytesPtr with: strBytes size.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveChain: waveIds [
	"This function transmits a chain of waveforms.

		NOTE: Any hardware PWM started by [*hardware_PWM*] will be cancelled.

		The waves to be transmitted are specified by the contents of buf which contains an ordered list of [*wave_id*]s and
		optional command codes and related data.

		buf: pointer to the wave_ids and optional command codes
		bufSize: the number of bytes in buf

		Returns 0 if OK, otherwise ChainNesting, ChainLoopCnt, BadChainLoop, BadChainCmd, ChainCounter,
		BadChainDelay, ChainTooBig or BadWaveId.

		Each wave is transmitted in the order specified.  A wave may occur multiple times per chain.

		A blocks of waves may be transmitted multiple times by using the loop commands. The block is bracketed by loop start and
		end commands.  Loops may be nested.

		Delays between waves may be added with the delay command.

		The following command codes are supported:

		Name         @ Cmd & Data @ Meaning
		Loop Start   @ 255 0      @ Identify start of a wave block
		Loop Repeat  @ 255 1 x y  @ loop x + y*256 times
		Delay        @ 255 2 x y  @ delay x + y*256 microseconds
		Loop Forever @ 255 3      @ loop forever

		If present Loop Forever must be the last entry in the chain.

		The code is currently dimensioned to support a chain with roughly 600 entries and 20 loop counters."
	| waveIdBytes waveIdBytesPtr |

	waveIdBytes := waveIds asByteArray.
	waveIdBytesPtr := OSObjectPointer reference: waveIdBytes.

	^WaveChain callWith: id with: waveIdBytesPtr with: waveIdBytes size.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveClear [
	"Clear all waveforms from the wave buffers.
	 This function clears all waveforms and any data added by calls to the [*wave_add_**] functions."

	^WaveClear callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveCreate [
	"Create a waveform from the wave buffers.
	Return a wave id >= 0 if ok, otherwise GpioEmptyWaveform, GpioTooManyCBS, GpioTooManyOOL or GpioNoWaveformID "

	^WaveCreate callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveDelete: waveId [
	"This function deletes the waveform with id waveId.

		waveId: >=0, as returned by [*wave_create*].
		Wave ids are allocated in order, 0, 1, 2, etc.

		The wave is flagged for deletion.  The resources used by the wave will only be reused when either of the following apply.
		- all waves with higher numbered wave ids have been deleted or have been flagged for deletion.
		- a new wave is created which uses exactly the same resources as the current wave (see the C source for gpioWaveCreate for details).

		Returns 0 if OK, otherwise BadWaveId."

	^WaveDelete callWith: id with: waveId.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetCbs [
	"This function returns the length in DMA control blocks of the current waveform."

	^WaveGetCbs callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetHighCbs [
	"This function returns the length in DMA control blocks of the longest waveform created since the pigpio daemon was started."

	^WaveGetHighCbs callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetHighMicros [
	"This function returns the length in microseconds of the longest waveform created since the pigpio daemon was started."

	^WaveGetHighMicros callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetHighPulses [
	"This function returns the length in pulses of the longest waveform created since the pigpio daemon was started."

	^WaveGetHighPulses callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetMaxCbs [
	"This function returns the maximum possible size of a waveform in DMA control blocks."

	^WaveGetMaxCbs callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetMaxMicros [
	"This function returns the maximum possible size of a waveform in microseconds."

	^WaveGetMaxMicros callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetMaxPulses [
	"This function returns the maximum possible size of a waveform in pulses."

	^WaveGetMaxPulses callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetMicros [
	"This function returns the length in microseconds of the current waveform."

	^WaveGetMicros callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveGetPulses [
	"This function returns the length in pulses of the current waveform."

	^WaveGetPulses callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveSendOnce: waveId [
	"This function transmits the waveform with id waveId.  The waveform is sent once.

		NOTE: Any hardware PWM started by [*hardware_PWM*] will be cancelled.

		waveId: >=0, as returned by [*wave_create*].

		Returns the number of DMA control blocks in the waveform if OK, otherwise BadWaveId or BadWaveMode."

	^WaveSendOnce callWith: id with: waveId.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveSendRepeat: waveId [
	"play the waveId.
	Returns number of control blocks in the current wave if ok, or GpioBadWaveID or GpioBadWaveMode."

	^WaveSendRepeat callWith: id with: waveId.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveStop [
	"RaspberryGpioDaemonInterface ensureStarted; waveStop"

	WaveTxStop callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveTxAt [
	"This function returns the id of the waveform currently being transmitted.

		Returns the waveform id or one of the following special values:

		WaveNotFound (9998) - transmitted wave not found. 
		NoTxWave (9999) - no wave being transmitted."

	^WaveTxAt callWith: id.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveTxBusy [
	"This function checks to see if a waveform is currently being transmitted.
		WaveTxBusy (wave_tx_busy) returns 1 if a waveform is currently being transmitted, otherwise 0, we return true/false."

	^(WaveTxBusy callWith: id) = 1.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveTxSend: waveId mode: mode [
	"Transmits the waveform with id waveId using mode mode.

		waveId: >=0, as returned by [*wave_create*].
		mode: WaveModeOneShot, WaveModeRepeat, WaveModeOneShotSync or WaveModeRepeatSync.

		WaveModeOneShot same as [*wave_send_once*].
		WaveModeRepeat same as [*wave_send_repeat*].
		WaveModeOneShotSync same as [*wave_send_once*] but tries to sync with the previous waveform.
		WaveModeRepeatSync same as [*wave_send_repeat*] but tries to sync with the previous waveform.

		WARNING: bad things may happen if you delete the previous waveform before it has been synced to the new waveform.
		NOTE: Any hardware PWM started by [*hardware_PWM*] will be cancelled.

		Returns the number of DMA control blocks in the waveform if OK, otherwise BadWaveId or BadWaveMode."

	^WaveSendUsingMode callWith: id with: waveId with: mode.

]

{ #category : 'Wave' }
RaspberryGpioDaemonInterface >> waveTxStop [
	"Aborts the current waveform."

	^WaveTxStop callWith: id.

]
