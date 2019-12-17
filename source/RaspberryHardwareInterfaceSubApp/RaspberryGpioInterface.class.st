Class {
	#name : 'RaspberryGpioInterface',
	#superclass : 'Object',
	#pools : [
		'RaspberryGpioConstants',
		'RaspberryGpioFunctions'
	],
	#category : 'RaspberryHardwareInterfaceSubApp'
}

{ #category : 'Not categorized' }
RaspberryGpioInterface class >> raspberryGpioStart [
	"Create a new instance, start and answer the instance."

	^self new raspberryGpioStart; yourself.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> bbI2cClose: sda [
	"This function stops bit banging I2C on a pair of GPIO previously opened with [*bb_i2c_open*].
		SDA: 0-31, the SDA GPIO used in a prior call to [*bb_i2c_open*]

		Returns 0 if OK, otherwise BadUserGpio or NotI2CGpio."

	^BbI2cClose callWith: sda.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> bbI2cOpen: sda scl: scl baud: baud [
	"This function selects a pair of GPIO for bit banging I2C at a specified baud rate.
		Bit banging I2C allows for certain operations which are not possible with the standard I2C driver.

		o baud rates as low as 50 
		o repeated starts 
		o clock stretching 
		o I2C on any pair of spare GPIO

		SDA: 0-31
		SCL: 0-31
		baud: 50-500000
		Returns 0 if OK, otherwise BadUserGpio, BadI2CBaud, or GpioInUse.

		NOTE:
			The GPIO used for SDA and SCL must have pull-ups to 3V3 connected.  As a guide the hardware pull-ups on pins 3 and 5 are 1k8 in value."

	^BbI2cOpen callWith: sda with: scl with: baud.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> bbI2cZip: sda inBuf: inBuf inLen: inLen outBuf: outBuf outLen: outLen [
	"This function executes a sequence of bit banged I2C operations.  The operations to be performed are specified by the contents of inBuf which contains the concatenated command codes and associated data.

		SDA: 0-31 (as used in a prior call to [*bb_i2c_open*])
		inBuf: pointer to the concatenated I2C commands, see below
		inLen: size of command buffer
		outBuf: pointer to buffer to hold returned data
		outLen: size of output buffer

		Returns >= 0 if OK (the number of bytes read), otherwise BadUserGpio, NotI2CGpio, BadPointer,
			BadI2CCmd, BadI2CRlen, BadI2CWlen, I2CReadFailed or I2CWriteFailed.

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

	^BbI2cZip callWith: sda with: inBuf with: inLen with: outBuf with: outLen.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> bbSerialRead: userGpio buf: buf bufSize: bufSize [
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

	^GpioSerialRead callWith: userGpio with: buf with: bufSize.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> bbSerialReadClose: userGpio [
	"This function closes a GPIO for bit bang reading of serial data.

		userGpio: 0-31, previously opened with [*BbSerialReadOpen*].

		Returns 0 if OK, otherwise BadUserGpio or NotSerialGpio."

	^GpioSerialReadClose callWith: userGpio.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> bbSerialReadOpen: userGpio baud: baud dataBits: dataBits [
	"This function opens a GPIO for bit bang reading of serial data.

		userGpio: 0-31.
		baud: 50-250000
		dataBits: 1-32

		Returns 0 if OK, otherwise BadUserGpio, BadWaveBaud or GpioInUse.

		The serial data is returned in a cyclic buffer and is read using gpioSerialRead.

		It is the caller's responsibility to read data from the cyclic buffer in a timely fashion."

	^GpioSerialReadOpen callWith: userGpio with: baud with: dataBits.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> bbSpiClose: cs [
	"This function stops bit banging SPI on a set of GPIO opened with [*bbSPIOpen*].

		cs: 0-31, the CS GPIO used in a prior call to [*bbSpiOpen*]

		Returns 0 if OK, otherwise BadUserGpio or NotSpiGpio."

	^BbSpiClose callWith: cs.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> bbSpiOpen: cs miso: miso mosi: mosi sclk: sclk baud: baud spiFlags: spiFlags [
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

	^BbSpiOpen callWith: cs with: miso with: mosi with: sclk with: baud with: spiFlags.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> bbSpiXfer: cs txBuf: txBuf rxBuf: rxBuf count: count [
	"This function executes a bit banged SPI transfer.

		cs: 0-31 (as used in a prior call to [*bbSpiOpen*])
		txBuf: pointer to buffer to hold data to be sent
		rxBuf: pointer to buffer to hold returned data
		count: size of data transfer

		Returns >= 0 if OK (the number of bytes read), otherwise BadUserGpio, NotSpiGpio or BadPointer."

	^BbSpiXfer callWith: cs with: txBuf with: rxBuf with: count.

]

{ #category : 'I2C',
 #vaCategories : ['I2C','SPI'] }
RaspberryGpioInterface >> bscXfer: aBscXfer [
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

	^BscXfer callWith: bscXferPtr.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureBufferSize: cfgMillis [
	"Configures pigpio to buffer cfgMillis milliseconds of GPIO samples.

		This function is only effective if called before [*gpioInitialise*].

		cfgMillis: 100-10000

		The default setting is 120 milliseconds.

		The intention is to allow for bursts of data and protection against other processes hogging cpu time.

		Author hasn't seen a process locked out for more than 100 milliseconds.

		Making the buffer bigger uses a LOT of memory at the more frequent sampling rates as shown in the following table in MBs.

		buffer milliseconds
		120 250 500 1sec 2sec 4sec 8sec

		1      16  31  55  107  ---  ---  ---
		2      10  18  31   55  107  ---  ---
		sample   4       8  12  18   31   55  107  ---
		rate    5       8  10  14   24   45   87  ---
		(us)    8       6   8  12   18   31   55  107
		10       6   8  10   14   24   45   87"

	^GpioCfgBufferSize callWith: cfgMillis.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureClock: cfgMicros peripheral: cfgPeripheral source: cfgSource [
   "Configures pigpio to use a particular sample rate timed by a specified peripheral.
		This function is only effective if called before [*gpioInitialise*].

		cfgMicros: 1, 2, 4, 5, 8, 10
		cfgPeripheral: 0 (PWM), 1 (PCM)
		cfgSource: deprecated, value is ignored

		The timings are provided by the specified peripheral (PWM or PCM).

		The default setting is 5 microseconds using the PCM peripheral.

		The approximate CPU percentage used for each sample rate is:

		sample  cpu	rate    %

		1					25
		2					16
		4					11
		5					10
		8					15
		10				14

		A sample rate of 5 microseconds seeems to be the sweet spot."

	^GpioCfgClock callWith: cfgMicros with: cfgPeripheral with: cfgSource.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureCustom2: arg1 argX: argX argC: argC retBuf: retBuf retMax: retMax [
	"This function is available for user customisation.

		It differs from gpioCustom1 in that it returns an array of bytes rather than just an integer.

		The returned value is an integer indicating the number of returned bytes.

		arg1: >=0
		argX: extra (byte) arguments
		argC: number of extra arguments
		retBuf: buffer for returned bytes
		retMax: maximum number of bytes to return

		Returns >= 0 if OK, less than 0 indicates a user defined error.

		The number of returned bytes must be retMax or less."

	^GpioCustom2 callWith: arg1 with: argX with: argC with: retBuf with: retMax.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureDmaChannels: primaryChannel secondaryChannel: secondaryChannel [
	"Configures pigpio to use the specified DMA channels.

		This function is only effective if called before [*gpioInitialise*].
		primaryChannel: 0-14
		secondaryChannel: 0-14

		The default setting is to use channel 14 for the primary channel and channel 6 for the secondary channel.

		The secondary channel is only used for the transmission of waves.

		If possible use one of channels 0 to 6 for the secondary channel (a full channel).

		A full channel only requires one DMA control block regardless of the length of a pulse delay.
		Channels 7 to 14 (lite channels) require one DMA control block for each 16383 microseconds of delay.  I.e.
		a 10 second pulse delay requires one control block on a full channel and 611 control blocks on a lite channel."

	^GpioCfgDmaChannels callWith: primaryChannel with: secondaryChannel.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureGetInternals [
	"This function returns the current library internal configuration settings."

	^GpioCfgGetInternals call.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureInterfaces: ifFlags [
	"Configures pigpio support of the fifo and socket interfaces.

		This function is only effective if called before [*gpioInitialise*].

		ifFlags: 0-7

		The default setting (0) is that both interfaces are enabled.

		Or in DisableFifoIf to disable the pipe interface.

		Or in DisableSockIf to disable the socket interface.

		Or in LocalhostSockIf to disable remote socket access (this means that the socket interface is only usable from the local Pi)."

	^GpioCfgInterfaces callWith: ifFlags.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureInternals: what value: value [
	"Used to tune internal settings.

		what: see pigpio.c source code
		value: see pigpio.c source code"

	^GpioCfgInternals callWith: what with: value.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureInternalSettings: cfgVal [
	"This function sets the current library internal configuration settings.

		cfgVal: see source code."

	^GpioCfgSetInternals callWith: cfgVal.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureMemAlloc: memAllocMode [
	"Selects the method of DMA memory allocation.

		This function is only effective if called before [*gpioInitialise*].

		memAllocMode: 0-2

		There are two methods of DMA memory allocation.  The original method uses the /proc/self/pagemap file to allocate bus memory.
		The new method uses the mailbox property interface to allocate bus memory.

		Auto will use the mailbox method unless a larger than default buffer size is requested with [*gpioCfgBufferSize*]."

	^GpioCfgMemAlloc callWith: memAllocMode.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureNetAddr: numSockAddr sockAddr: sockAddr [
	"Sets the network addresses which are allowed to talk over the socket interface.

		This function is only effective if called before [*gpioInitialise*].

		numSockAddr: 0-256 (0 means all addresses allowed)
		sockAddr: an array of permitted network addresses."

	^GpioCfgNetAddr callWith: numSockAddr with: sockAddr.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configurePermissions: updateMask [
	"Configures pigpio to restrict GPIO updates via the socket or pipe interfaces to the GPIO specified by the mask.
		Programs directly calling the pigpio library (i.e. linked with -lpigpio are not affected).
		A GPIO update is a write to a GPIO or a GPIO mode change or any function which would force such an action.

		This function is only effective if called before [*gpioInitialise*].

		updateMask: bit (1<<n) is set for each GPIO n which may be updated

		The default setting depends upon the Raspberry model.  The user GPIO are added to the mask.

		If the board revision is not recognised then GPIO 2-27 are allowed.

		Unknown board @ DefaultUpdateMaskUnknown @ 0x0FFFFFFC 
		Type 1 board  @ DefaultUpdateMaskB1 @ 0x03E6CF93 
		Type 2 board  @ DefaultUpdateMaskAB2 @ 0xFBC6CF9C
		Type 3 board  @ DefaultUpdateMaskPi3B @ 0x0FFFFFFC"

	^GpioCfgPermissions callWith: updateMask.

]

{ #category : 'Configure' }
RaspberryGpioInterface >> configureSocketPort: port [
	"Configures pigpio to use the specified socket port.

		This function is only effective if called before [*gpioInitialise*].

		port: 1024-32000

		The default setting is to use port 8888."

	^GpioCfgSocketPort callWith: port.

]

{ #category : 'Primitives' }
RaspberryGpioInterface >> custom1: arg1 arg2: arg2 argX: argX [
	"This function is available for user customisation.

		It returns a single integer value.

		arg1: >=0
		arg2: >=0
		argX: extra (byte) arguments
		argC: number of extra arguments

		Returns >= 0 if OK, less than 0 indicates a user defined error."

	^GpioCustom1 callWith: arg1 with: arg2 with: argX with: argX size.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> delay: micros [
	"Delays for at least the number of microseconds specified by micros.

		micros: the number of microseconds to sleep
		Returns the actual length of the delay in microseconds.

		Delays of 100 microseconds or less use busy waits."

	^GpioDelay callWith: micros.

]

{ #category : 'Primitives' }
RaspberryGpioInterface >> deleteScript: scriptId [
	"This function deletes a stored script.

		scriptId >=0, as returned by [*store_script*].

		The function returns 0 if OK, otherwise BadScriptId."

	^GpioDeleteScript callWith: scriptId.

]

{ #category : 'Event' }
RaspberryGpioInterface >> eventMonitor: handle bits: bits [
	"This function selects the events to be reported on a previously opened handle.

		handle: >=0, as returned by [*gpioNotifyOpen*]
		bits: a bit mask indicating the events of interest

		Returns 0 if OK, otherwise PI_BAD_HANDLE.

		A report is sent each time an event is triggered providing the corresponding bit in bits is set.

		See [*gpioNotifyBegin*] for the notification format.

		Start reporting events 3, 6, and 7.

		bit      76543210
		(0xC8 = 0b11001000)

		eventMonitor(h, 0xC8)"

	^EventMonitor callWith: handle with: bits.

]

{ #category : 'Event' }
RaspberryGpioInterface >> eventTrigger: event [
	"This function signals the occurrence of an event.

		event: 0-31.

		Returns 0 if OK, otherwise BadEventId.

		An event is a signal used to inform one or more consumers to start an action.  Each consumer which has registered an interest
		in the event (e.g. by calling [*event_callback*]) will be informed by a callback.

		One event, EventBsc (31) is predefined.  This event is auto generated on BSC slave activity.

		The meaning of other events is arbitrary.

		Note that other than its id and its tick there is no data associated with an event."

	^EventTrigger callWith: event.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileClose: handle [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function closes the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).

		Returns 0 if OK, otherwise GpioBadHandle."

	^FileClose callWith: handle.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileList: fPat buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function returns a list of files which match a pattern.

		fPat: file pattern to match.
		buf: an array to receive the matching file names.
		count: the maximum number of bytes to read.

		Returns the number of returned bytes if OK, otherwise NoFileAccess or NoFileMatch.

		The pattern must match an entry in /opt/pigpio/access.  The pattern may contain wildcards.  See [*fileOpen*].

		NOTE

		The returned value is not the number of files, it is the number of bytes in the buffer.  The file names are separated by newline characters."

	^FileList callWith: fPat with: buf with: count.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileOpen: fileName mode: mode [
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

	^FileOpen callWith: fileName with: mode.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileRead: handle buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function reads up to count bytes from the the file associated with handle and writes them to buf.

		handle: >=0 (as returned by [*fileOpen*]).
		buf: an array to receive the read data.
		count: the maximum number of bytes to read.

		Returns the number of bytes read (>0) if OK, otherwise GpioBadHandle, BadParam, FileNotRopen or BadFileWrite.

		bytes = file_read(pi, handle, buf, sizeof(buf));

		if (bytes >= 0) {
			// process read data
		}"

	^FileRead callWith: handle with: buf with: count.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileSeek: handle seekOffset: seekOffset seekFrom: seekFrom [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function seeks to a position within the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).
		seekOffset: the number of bytes to move.  Positive offsets move forward, negative offsets backwards.
		seekFrom: one of FromStart (0), FromCurrent (1), or FromEnd (2).

		Returns the new byte position within the file (>=0) if OK, otherwise GpioBadHandle or BadFileSeek.

		file_seek(pi, handle, 123, FromStart); // Start plus 123

		size = file_seek(pi, handle, 0, FromEnd); // End, return size
		pos = file_seek(pi, handle, 0, FromCurrent); // Current position"

	^FileSeek callWith: handle with: seekOffset with: seekFrom.

]

{ #category : 'FileIO' }
RaspberryGpioInterface >> fileWrite: handle buf: buf count: count [
	"This method is supplied for the sake of completeness, see Smalltalk Cfs... classes."
	"This function writes count bytes from buf to the the file associated with handle.

		handle: >=0 (as returned by [*fileOpen*]).
		buf: the array of bytes to write.
		count: the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam, FileNotWopen or BadFileWrite.

		if (file_write(pi, handle, buf, 100) == 0) {
			// file written okay
		} else {
			// error
		}"

	^FileWrite callWith: handle with: buf with: count.

]

{ #category : 'Bits' }
RaspberryGpioInterface >> getBitInBytes: bitPos buf: buf numBits: numBits [
	"Returns the value of the bit bitPos bits from the start of buf.
		Returns 0 if bitPos is greater than or equal to numBits.

		bitPos: bit index from the start of buf
		buf: array of bits
		numBits: number of valid bits in buf"

	^GetBitInBytes callWith: bitPos with: buf with: numBits.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> getCurrentTick [
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

	^GpioTick call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> getHardwareRevision [
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

	^GpioHardwareRevision call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> getPadStrength: pad [
	"This function returns the pad drive strength in mA.

		pad: 0-2, the pad to get.

		Returns the pad drive strength if OK, otherwise BadGpio.

		Pad @ GPIO
		0   @ 0-27
		1   @ 28-45
		2   @ 46-53

		strength = gpioGetPad: 0			get pad 0 strength"

	^GpioGetPad callWith: pad.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> getPinMode: pin [
	"Returns the mode of #pin if ok or BadGpio.
		#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GpioGetMode callWith: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> getPwmDutyCycleForPin: pin [
	"Get the pwm duty cycle (0-range, default 255 max) for pin.
		Returns 0-range if ok, or BadUserGpio or NotPwmGpio.
		Use #id:pinGetPwmRange: to read the pwm range setting."
	"#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GpioGetPwmDutycycle callWith: pin.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> getRaspberryGpioVersion [
	"Returns the Raspberry GPIO version."

	^GetRaspberryGpioVersion call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioReadBits031 [
	"Returns the current level of GPIO 0-31."

	^GpioReadBits031 call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioReadBits3253 [
	"Returns the current level of GPIO 32-53."

	^GpioReadBits3253 call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioSleep: timetype seconds: seconds micros: micros [
	"Sleeps for the number of seconds and microseconds specified by seconds and micros.

		timetype: 0 (relative), 1 (absolute)
		seconds: seconds to sleep
		micros: microseconds to sleep

		Returns 0 if OK, otherwise BadTimeType, BadSeconds or BadMicros.

		If timetype is TimeAbsolute the sleep ends when the number of seconds
		and microseconds since the epoch (1st January 1970) has elapsed.  System
		clock changes are taken into account.

		If timetype is TimeRelative the sleep is for the specified number
		of seconds and microseconds.  System clock changes do not effect the sleep length.

		For short delays (say, 50 microseonds or less) use [*gpioDelay*].

		gpioSleep: TimeRelative seconds: 2 micros: 500000 - sleep for 2.5 seconds
		gpioSleep: TimeRelative seconds: 0 micros: 100000 - sleep for 0.1 seconds
		gpioSleep: TimeRelative seconds: 60 micros: 0 - sleep for one minute"

	^GpioSleep callWith: timetype with: seconds with: micros.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioTime: timetype seconds: seconds micros: micros [
	"Updates the seconds and micros variables with the current time.

		There are probably better ways to do this in Smalltalk.

		timetype: 0 (relative), 1 (absolute)
		seconds: a pointer to an int to hold seconds
		micros: a pointer to an int to hold microseconds

		Returns 0 if OK, otherwise BadTimeType.

		If timetype is TimeAbsolute updates seconds and micros with the
		number of seconds and microseconds since the epoch (1st January 1970).

		If timetype is TimeRelative updates seconds and micros with the
		number of seconds and microseconds since the library was initialised."

	^GpioTime callWith: timetype with: seconds with: micros.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioTrigger: userGpio pulseLen: pulseLen level: level [
	"This function sends a trigger pulse to a GPIO.  The GPIO is set to level for pulseLen microseconds and then reset to not level.

		userGpio 0-31.
		pulseLen: 1-100.
		level: 0,1.

		Returns 0 if OK, otherwise BadUserGpio, BadLevel, BadPulselen, or NotPermitted."

	^GpioTrigger callWith: userGpio with: pulseLen with: level.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioWriteBits031Clear: bits [
	"Clears GPIO 0-31 if the corresponding bit in bits is set."

	^GpioWriteBits031Clear callWith: bits.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioWriteBits031Set: bits [
	"Set GPIO 0-31 if the corresponding bit in bits is set."

	^GpioWriteBits031Set callWith: bits.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioWriteBits3253Clear: bits [
	"Clears GPIO 32-53 if the corresponding bit (0-21) in bits is set."

	^GpioWriteBits3253Clear callWith: bits.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> gpioWriteBits3253Set: bits [
	"Set GPIO 32-53 if the corresponding bit (0-21) in bits is set."

	^GpioWriteBits3253Set callWith: bits.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> hardwareClock: pin clkfreq: clkfreq [
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

	^GpioHardwareClock callWith: pin with: clkfreq.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> hardwarePwm: pin pwmFreq: pwmFreq pwmDuty: pwmDuty [
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

	^GpioHardwarePWM callWith: pin with: pwmFreq with: pwmDuty.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cBlockProcessCall: handle register: regNum buffer: buf [
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

	^I2cBlockProcessCall callWith: handle with: regNum with: bytesPtr with: bytes size.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cClose: handle [
	"Disconnect from the i2c device, freeing the handle etc.  Returns 0 if ok, otherwise GpioBadHandle."

	^I2cClose callWith: handle.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cOpen: devId [
	"RaspberryGpioInterface instance i2CSetup: 16r54 for example for PiGlow.
	Return >= 0 if ok (the handle), or GpioBadI2CBus, GpioBadI2CAddr, GpioBadFlags GpioNoHandle or GpioI2COpenFailed"

	^I2cOpen callWith: 1 with: devId with: 0.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cOpen: bus device: devId flags: flags [
	"RaspberryGpioInterface instance id: id i2cOpen: 1 device: 16r54 flags: 0 for example for PiGlow.
	Return >= 0 if ok (the handle), or GpioBadI2CBus, GpioBadI2CAddr, GpioBadFlags, GpioNoHandle or GpioI2COpenFailed"

	^I2cOpen callWith: bus with: devId with: flags.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cProcessCall: handle register: regNum wVal: val [
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

	^I2cProcessCall callWith: handle with: regNum with: bytesPtr.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadBlockData: handle register: regNum buf: buf [
	"This reads a block of up to 32 bytes from the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		i2c_reg: 0-255, the register to read.
		buf: an array to receive the read data.

		The amount of returned data is set by the device.

		Returns the number of bytes read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Block read. SMBus 2.0 5.5.7

		S Addr Wr [A] i2c_reg [A]
		S Addr Rd [A] [Count] A [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadBlockData callWith: handle with: regNum with: buf.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadByte: handle [
	"This reads a single byte from the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].

		Returns the byte read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Read byte. SMBus 2.0 5.5.5

		S Addr Wr [A] i2c_reg [A] S Addr Rd [A] [Data] NA P"

	^I2cReadByte callWith: handle.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadByteData: handle register: regNum [
	"This reads a single byte from the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to read.

		Returns the byte read (>=0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		Read byte. SMBus 2.0 5.5.5

		S Addr Wr [A] i2c_reg [A] S Addr Rd [A] [Data] NA P"

	^I2cReadByteData callWith: handle with: regNum.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadDevice: handle buf: buf count: count [
	"This reads count bytes from the raw device into buf.

		handle: >=0, as returned by a call to [*i2c_open*].
		buf: an array to receive the read data bytes.
		count: >0, the number of bytes to read.

		Returns count (>0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		S Addr Rd [A] [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadDevice callWith: handle with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadI2cBlockData: handle register: regNum buf: buf count: count [
	"This reads count bytes from the specified register of the device associated with handle .  The count may be 1-32.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to read.
		buf: an array to receive the read data.
		count: 1-32, the number of bytes to read.

		Returns the number of bytes read (>0) if OK, otherwise GpioBadHandle, BadParam or I2CReadFailed.

		S Addr Wr [A] i2c_reg [A]
		S Addr Rd [A] [buf0] A [buf1] A ... A [bufn] NA P"

	^I2cReadI2cBlockData callWith: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cReadWordData: handle register: regNum [
	"read a 16bit i2c register.
	Returns word ( >= 0) or GpioBadHandle, GpioBadParam or GpioI2CReadFailed"

	^I2cReadWordData callWith: handle with: regNum.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cSegments: handle i2cMsgs: i2cMsgs [
	"Given an array of OSI2cMsg segments, execute them.
		The i2cMsgs is a normal Smalltalk collection of instances of OSI2cMsg.
		Returns the number of segments if OK, otherwise BadI2CSeg."
	"This function executes multiple I2C segments in one transaction by calling the I2C_RDWR ioctl.

		handle: >=0, as returned by a call to [*i2cOpen*]
		segs: an array of I2C segments
		numSegs: >0, the number of I2C segments

		Returns the number of segments if OK, otherwise BadI2CSeg."
	| osSegments segmentCnt |

	segmentCnt := i2cMsgs size.
	osSegments := OSObjectPointer new: segmentCnt itemType: OSI2cMsg.
	0 to: segmentCnt do: [:i | osSegments at: i put: (i2cMsgs at: (i + 1))].

	^I2cSegments callWith: segmentCnt with: osSegments.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cSwitchCombined: setting [
	"This sets the I2C (i2c-bcm2708) module 'use combined transactions' parameter on or off.

		setting: 0 to set the parameter off, non-zero to set it on

		NOTE: when the flag is on a write followed by a read to the same slave address will use a repeated start
			(rather than a stop/start)."

	I2cSwitchCombined callWith: setting.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteBlockData: handle register: regNum buf: buf count: count [
	"This writes up to 32 bytes to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		buf: an array with the data to send.
		count: 1-32, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Block write. SMBus 2.0 5.5.7

		S Addr Wr [A] i2c_reg [A] count [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteBlockData callWith: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteByte: handle byte: byte [
	"This sends a single byte to the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		i2c_reg: 0-255, the register to write.
		bVal: 0-0xFF, the value to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Write byte. SMBus 2.0 5.5.4

		S Addr Wr [A] i2c_reg [A] bVal [A] P"

	^I2cWriteByte callWith: handle with: byte.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteByteData: handle register: regNum byte: byte [
	"This writes a single byte to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		bVal: 0-0xFF, the value to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Write byte. SMBus 2.0 5.5.4

		S Addr Wr [A] i2c_reg [A] bVal [A] P"

	^I2cWriteByteData callWith: handle with: regNum with: byte.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteDevice: handle buf: buf count: count [
	"This writes count bytes from buf to the raw device.

		handle: >=0, as returned by a call to [*i2c_open*].
		buf: an array containing the data bytes to write.
		count: >0, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		S Addr Wr [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteDevice callWith: handle with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteI2cBlockData: handle register: regNum buf: buf count: count [
	"This writes 1 to 32 bytes to the specified register of the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		regNum: 0-255, the register to write.
		buf: the data to write.
		count: 1-32, the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		S Addr Wr [A] i2c_reg [A] buf0 [A] buf1 [A] ... [A] bufn [A] P"

	^I2cWriteI2cBlockData callWith: handle with: regNum with: buf with: count.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteQuick: handle bit: bit [
	"This sends a single bit (in the Rd/Wr bit) to the device associated with handle.

		handle: >=0, as returned by a call to [*i2c_open*].
		bit: 0-1, the value to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or I2cWriteFailed.

		Quick command. SMBus 2.0 5.5.1

		S Addr bit [A] P"

	^I2cWriteQuick callWith: handle with: bit.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cWriteWordData: handle register: regNum value: val [
	"write a 16bit i2c register.
	Returns 0 if OK, otherwise GpioBadHandle, GpioBadParam or GpioI2cWriteFailed"

	^I2cWriteWordData callWith: handle with: regNum with: val.

]

{ #category : 'I2C' }
RaspberryGpioInterface >> i2cZip: handle inBuf: inBuf inLen: inLen outBuf: outBuf outLen: outLen [
	"This function executes a sequence of I2C operations.  The operations to be performed are specified by the contents of inBuf
		which contains the concatenated command codes and associated data.

		handle: >=0, as returned by a call to [*i2cOpen*]
		inBuf: pointer to the concatenated I2C commands, see below
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
		Address	@ 4 P 					@ Set I2C address to P
		Flags		@ 5 lsb msb			@ Set I2C flags to lsb + (msb << 8)
		Read		@ 6 P					@ Read P bytes of data
		Write		@ 7 P ...				@ Write P bytes of data

		The address, read, and write commands take a parameter P.
		Normally P is one byte (0-255).  If the command is preceded by the Escape command then P is two bytes (0-65535, least significant byte first).

		The address defaults to that associated with the handle.
		The flags default to 0.  The address and flags maintain their previous value until updated.

		The returned I2C data is stored in consecutive locations of outBuf.

		Set address 0x53, write 0x32, read 6 bytes
		Set address 0x1E, write 0x03, read 6 bytes
		Set address 0x68, write 0x1B, read 8 bytes

		0x04 0x53   0x07 0x01 0x32   0x06 0x06
		0x04 0x1E   0x07 0x01 0x03   0x06 0x06
		0x04 0x68   0x07 0x01 0x1B   0x06 0x08
		0x00"

	^I2cZip callWith: handle with: inBuf with: inLen with: outBuf with: outLen.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> initialiseLibrary [
	"Initialises the library.

		Returns the pigpio version number if OK, otherwise GpioInitFailed.

		gpioInitialise must be called before using the other library functions with the following exceptions:

		[*gpioCfg**], [*gpioVersion*], [*gpioHardwareRevision*]

		if (gpioInitialise() < 0) {
			pigpio initialisation failed.
		} else {
			pigpio initialised okay.
		}"

	^GpioInitialise call.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> isPinOn: pin [
	"Read the value of a given Pin, returning HIGH (true) or LOW (false) or GpioBadGpio. 
	Note that if you connect a button via a pullDOWN it will return false when pressed, or for a button on a pullUP pin you will get true when pressed."

	^((self readPin: pin) = 1).

]

{ #category : 'Notify' }
RaspberryGpioInterface >> notifyBegin: handle bits: bits [
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

	^GpioNotifyBegin callWith: handle with: bits.

]

{ #category : 'Notify' }
RaspberryGpioInterface >> notifyClose: handle [
	"Stop notifications on a previously opened handle and release the handle for reuse.

		handle: 0-31 (as returned by [*notify_open*])

		Returns 0 if OK, otherwise GpioBadHandle."

	^GpioNotifyClose callWith: handle.

]

{ #category : 'Notify' }
RaspberryGpioInterface >> notifyOpen [
	"Get a free notification handle.

		Returns a handle greater than or equal to zero if OK, otherwise NoHandle.

		A notification is a method for being notified of GPIO state changes via a pipe.

		Pipes are only accessible from the local machine so this function serves no purpose if you are using the library from a remote machine.
		The in-built (socket) notifications provided by [*callback*] should be used instead.

		Notifications for handle x will be available at the pipe named /dev/pigpiox (where x is the handle number).
		E.g. if the function returns 15 then the notifications must be read from /dev/pigpio15."

	^GpioNotifyOpen call.

]

{ #category : 'Notify' }
RaspberryGpioInterface >> notifyOpenWithSize: bufSize [
	"This function requests a free notification handle.

		It differs from [*gpioNotifyOpen*] in that the pipe size may be specified,
		whereas [*gpioNotifyOpen*] uses the default pipe size.

		See [*gpioNotifyOpen*] for further details."

	^GpioNotifyOpenWithSize callWith: bufSize.

]

{ #category : 'Notify' }
RaspberryGpioInterface >> notifyPause: handle [
	"Pause notifications on a previously opened handle.

		handle: 0-31 (as returned by [*notify_open*])
		Returns 0 if OK, otherwise GpioBadHandle.

		Notifications for the handle are suspended until [*notify_begin*] is called again."

	^GpioNotifyPause callWith: handle.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: userGpio invert: invert [
	"This function inverts serial logic for big bang serial reads.

		userGpio: 0-31, previously opened with [*BbSerialReadOpen*].
		invert: 0-1, 1 invert, 0 normal.

		Returns 0 if OK, otherwise NotSerialGpio or BadSerInvert."

	^GpioSerialReadInvert callWith: userGpio with: invert.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: userGpio setMode: mode [
	"Sets the GPIO mode, typically input or output.

		userGpio: 0-53
		mode: 0-7

		Returns 0 if OK, otherwise BadGpio or BadMode.

		Arduino style: pinMode.

		gpioSetMode: 17 mode: GpioInput - Set GPIO17 as input.
		gpioSetMode: 18 mode: GpioOutput - Set GPIO18 as output.
		gpioSetMode: 22 mode: GpioAlt0 - Set GPIO22 to alternative mode 0.

		See [[http://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2835/BCM2835-ARM-Peripherals.pdf]] page 102 for an overview of the modes."

	^GpioSetMode callWith: userGpio with: mode.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: pin setPullUpDown: mode [
	"Sets or clears resistor pull ups or downs on the GPIO.

		pin: 0-53 - the Broadcom pin number, aka gpio and userGpio
		mode: 0-2

		Returns 0 if OK, otherwise BadGpio or BadPud.

		gpioSetPullUpDown: 17 mode: GpioPudUp - Sets a pull-up.
		gpioSetPullUpDown: 18 mode: GpioPudDown - Sets a pull-down.
		gpioSetPullUpDown: 23 mode: GpioPudOff - Clear any pull-ups/downs."

	^GpioSetPullUpDown callWith: pin with: mode.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: pin setPwmDutyCycle: dutycycle [
	"Set the PWM duty cycle (0-range, default 255 max) for pin.
		If dutycycle = 0, turn off PWM pulses for pin.
		Returns 0 if ok, or GpioBadUSerGpio, GpioBadDutyCycle or GpioNotPermitted.
		Use #id:pin:setPwmRange: to change the default range of 255.

		pin: 0-31 - the Broadcom pin number, aka gpio and userGpio
		dutycycle: 0-range"

	^GpioPWM callWith: pin with: dutycycle.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: pin setPwmRange: range [
	"This sets the range of the pwm output - PiGPIO sets a user range and scales this to the 'real' range possible for the pin.
		See also #readPwmRealRangePin: to find out what the actual range is use is.
		Minimum allowed value is 25, max is 40,000.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadDutyRange or GpioNotPermitted"
	
	^GpioSetPwmRange callWith: pin with: (range min: GpioMaxDutyRange max: GpioMinDutyRange).

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: pin setServoPulsewidth: width [
	"Set the servo pulse width (0- off, 500 - 2500) for pin. Updates at standard 50Hz.
		Updates at standard 50Hz.
		If width = 0, turn off servo pulses for pin.
		Returns 0 if ok, or GpioBadUserGpio, GpioBadPulseWidth or GpioNotPermitted.
		Use #id:pin:setPwmRange: to change the default range of 255."
	| pulseWidth |

	pulseWidth := (width = 0) ifTrue: [0] ifFalse: [width min: MaxServoPulsewidth max: MinServoPulsewidth].

	^GpioServo callWith: pin with: pulseWidth.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pin: pin write: value [
	"Write value (0 or 1) to pin. 
		Returns 0 if ok, or GpioBadGpio, GpioBadLevel or GpioNotPermitted.
		Turns off pwm or servo pulses if previously active on this pin"

	^GpioWrite callWith: pin with: value.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetMode: pin [
	"Returns the mode of #pin if ok or BadGpio.
		#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GpioGetMode callWith: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetPwmDutyCycle: pin [
	"Get the pwm duty cycle (0-range, default 255 max) for pin.
		Returns 0-range if ok, or BadUserGpio or NotPwmGpio.
		Use #id:pinGetPwmRange: to read the pwm range setting."
	"#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"

	^GpioGetPwmDutycycle callWith: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetPwmFrequency: userGpio [
	"Returns the frequency (in hertz) used for the GPIO if OK, otherwise BadUserGpio.

		userGpio: 0-31

		For normal PWM the frequency will be that defined for the GPIO by [*gpioSetPWMfrequency*].

		If a hardware clock is active on the GPIO the reported frequency will be that set by [*gpioHardwareClock*].

		If hardware PWM is active on the GPIO the reported frequency will be that set by [*gpioHardwarePWM*].

		f = gpioGetPWMfrequency(23); // Get frequency used for GPIO23."

	^GpioGetPwmFrequency callWith: userGpio.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetPwmRange: userGpio [
	"Returns the dutycycle range used for the GPIO if OK, otherwise BadUserGpio.

		userGpio: 0-31

		If a hardware clock or hardware PWM is active on the GPIO the reported range will be 1000000 (1M).

		r = gpioGetPWMrange(23)"

	^GpioGetPwmRange callWith: userGpio.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetPwmRealRange: userGpio [
	"Returns the real range used for the GPIO if OK, otherwise BadUserGpio.

		userGpio: 0-31

		If a hardware clock or hardware PWM is active on the GPIO the reported real range will be 1000000 (1M).

		If hardware PWM is active on the GPIO the reported real range will be approximately 250M divided by the set PWM frequency.

		r = gpioGetPWMrealRange(17)"

	^GpioGetPwmRealRange callWith: userGpio.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinGetServoPulsewidth: pin [
	"Get the servo puls width (0-range, default 255 max) for pin.
	Returns pulse width if ok, or BadUserGpio or NotServoGpio."
	"#pin is the Broadcom pin number, aka gpio and userGpio.
		pin: 0-53"
	"Returns the servo pulsewidth setting for the GPIO.

		userGpio: 0-31

		Returns 0 (off), 500 (most anti-clockwise) to 2500 (most clockwise) if OK, otherwise BadUserGpio or GpioNotServoGpio."

	^GpioGetServoPulseWidth callWith: pin.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinRead: gpio [
	"Read the on/off value of 'pin'- 0 or 1 or GpioBadGpio."

	^GpioRead callWith: gpio.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinSetAsInput: pin [

	"This sets the mode of a pin to INPUT"

	^GpioSetMode callWith: pin with: GpioInput.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinSetAsOutput: pin [

	"This sets the mode of a pin to OUTPUT"

	^GpioSetMode callWith: pin with: GpioOutput.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinSetAsPullDown: pin [
	"Sets or clears resistor pull ups or downs on the GPIO.

		pin: 0-53 - the Broadcom pin number, aka gpio and userGpio
		mode: 0-2

		Returns 0 if OK, otherwise BadGpio or BadPud.

		gpioSetPullUpDown: 17 mode: GpioPudUp - Sets a pull-up.
		gpioSetPullUpDown: 18 mode: GpioPudDown - Sets a pull-down.
		gpioSetPullUpDown: 23 mode: GpioPudOff - Clear any pull-ups/downs."

	^GpioSetPullUpDown callWith: pin with: GpioPudDown.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> pinSetAsPullUp: pin [
	"Sets or clears resistor pull ups or downs on the GPIO.

		pin: 0-53 - the Broadcom pin number, aka gpio and userGpio
		mode: 0-2

		Returns 0 if OK, otherwise BadGpio or BadPud.

		gpioSetPullUpDown: 17 mode: GpioPudUp - Sets a pull-up.
		gpioSetPullUpDown: 18 mode: GpioPudDown - Sets a pull-down.
		gpioSetPullUpDown: 23 mode: GpioPudOff - Clear any pull-ups/downs."

	^GpioSetPullUpDown callWith: pin with: GpioPudUp.

]

{ #category : 'Bits' }
RaspberryGpioInterface >> putBitInBytes: bitPos buf: buf bit: bit [
	"Sets the bit bitPos bits from the start of buf to bit.

		bitPos: bit index from the start of buf
		buf: array of bits
		bit: 0-1, value to set"

	PutBitInBytes callWith: bitPos with: buf with: bit.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> raspberryGpioStart [
	"Start things up."

	(System cpuArchitecture = 'arm') ifTrue: [
		UNIXProcess system: 'sudo killall pigpiod'.				"Make sure the daemon is not running."
		(Delay forSeconds: 3) wait.
	].

	self initialiseLibrary.

]

{ #category : 'Script' }
RaspberryGpioInterface >> rawDumpScript: scriptId [
	"Used to print a readable version of a script to stderr.

		scriptId: >=0, a script_id returned by [*gpioStoreScript*]

		Not intended for general use."

	RawDumpScript callWith: scriptId.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawDumpWave [
	"Used to print a readable version of the current waveform to stderr.

		Not intended for general use."

	RawDumpWave call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveAddGenericPulseQuads: arrayOfQuads [
	"Given an array of quads of int, add them to the current wave.
		The arrayOfQuads is a normal Smalltalk collection of integers, every four constitute a wave pulse.
		Returns number of total pulses in the current wave if ok or TooManyPulses.
		see rawWaveAddGenericPulses: for more info."
	| osPulses pulseCnt intCnt |

	intCnt := arrayOfQuads size.
	osPulses := OSObjectPointer new: intCnt itemType: OSInteger.
	0 to: intCnt do: [:i | osPulses at: i put: (arrayOfQuads at: (i + 1))].
	pulseCnt := intCnt // 4.

	^RawWaveAddGeneric callWith: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveAddGenericPulses: arrayOfPulses [
	"Given an array of OSRawWave, add them to the current wave.
		The arrayOfPulses is a normal Smalltalk collection of instances of OSRawWave.
		Returns number of total pulses in the current wave if ok or TooManyPulses"

	"This function adds a number of pulses to the current waveform.

		arrayOfPulses: the array containing the pulses

		Returns the new total number of pulses in the current waveform if OK, otherwise TooManyPulses.

		The advantage of this function over gpioWaveAddGeneric is that it allows the setting of the flags field.
		The pulses are interleaved in time order within the existing waveform (if any).
		Merging allows the waveform to be built in parts, that is the settings for GPIO#1 can be added, and then GPIO#2 etc.
		If the added waveform is intended to start after or within the existing waveform then the first pulse should consist of a delay.

		Not intended for general use."
	| osPulses pulseCnt |

	pulseCnt := arrayOfPulses size.
	osPulses := OSObjectPointer new: pulseCnt itemType: OSRawWave.
	0 to: pulseCnt do: [:i | osPulses at: i put: (arrayOfPulses at: (i + 1))].

	^RawWaveAddGeneric callWith: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveAddSpi: anOSRawSpi offset: offsetInt spiSS: spiSSInt buf: buf spiTxBits: spiTxBits spiBitFirst: spiBitFirst spiBitLast: spiBitLast spiBits: spiBits [
	"This function adds a waveform representing SPI data to the existing waveform (if any).

		spi: a pointer to a spi object
		offset: microseconds from the start of the waveform
		spiSS: the slave select GPIO
		buf: the bits to transmit, most significant bit first
		spiTxBits: the number of bits to write
		spiBitFirst: the first bit to read
		spiBitLast: the last bit to read
		spiBits: the number of bits to transfer

		Returns the new total number of pulses in the current waveform if OK, otherwise BadUserGpio, BadSerOffset or TooManyPulses.

		Not intended for general use."
	| anOSRawSpiPtr |

	anOSRawSpiPtr := OSObjectPointer reference: anOSRawSpi.

	^RawWaveAddSpi callWith: anOSRawSpiPtr with: offsetInt with: spiSSInt with: buf with: spiTxBits with: spiBitFirst with: spiBitLast with: spiBits.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveCB [
	"Returns the number of the cb being currently output.

		Not intended for general use."

	^RawWaveCB call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveCBAdr: cbNum [
	"Return the (Linux) address of contol block cbNum.

		cbNum: the cb of interest

		Not intended for general use."

	^OSRawCbs address: (RawWaveCBAdr callWith: cbNum).

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveGetOOL: pos [
	"Gets the OOL parameter stored at pos.

		pos: the position of interest.

		Not intended for general use."

	^RawWaveGetOOL callWith: pos.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> rawWaveSetOOL: pos lVal: lVal [
	"Sets the OOL parameter stored at pos to value.

		pos: the position of interest
		lVal: the value to write

		Not intended for general use."

	RawWaveSetOOL callWith: pos with: lVal.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> readPin: gpio [
	"Read the on/off value of 'pin'- 0 or 1 or GpioBadGpio."

	^GpioRead callWith: gpio.

]

{ #category : 'Script' }
RaspberryGpioInterface >> runScript: scriptId numPar: numPar param: param [
	"This function runs a stored script.

		scriptId: >=0, as returned by [*store_script*].
		numPar: 0-10, the number of parameters.
		param: an array of parameters.

		The function returns 0 if OK, otherwise BadScriptId or TooManyParam

		param is an array of up to 10 parameters which may be referenced in the script as p0 to p9."

	^GpioRunScript callWith: scriptId with: numPar with: param.

]

{ #category : 'Script' }
RaspberryGpioInterface >> scriptStatus: scriptId param: param [
	"This function returns the run status of a stored script as well as the current values of parameters 0 to 9.

		scriptId: >=0, as returned by [*StoreScript*].
		param: an array to hold the returned 10 parameters.

		The function returns greater than or equal to 0 if OK, otherwise BadScriptId.

		The run status may be ScriptIniting, ScriptHalted, ScriptRunning, ScriptWaiting or ScriptFailed

		The current value of script parameters 0 to 9 are returned in param."

	^GpioScriptStatus callWith: scriptId with: param.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialClose: handle [
	"This function closes the serial device associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns 0 if OK, otherwise GpioBadHandle."

	^SerClose callWith: handle.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialDataAvailable: handle [
	"Returns the number of bytes available to be read from the device associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns the number of bytes of data available (>=0) if OK, otherwise GpioBadHandle."

	^SerDataAvailable callWith: handle.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialOpen: serialTty baud: baud serFlags: serFlags [
	"This function opens a serial device at a specified baud rate with specified flags.  The device name must start with /dev/tty or /dev/serial.

		serialTty: the serial device to open.
		baud: the baud rate in bits per second, see below.
		serFlags: 0.

		Returns a handle (>=0) if OK, otherwise NoHandle or SerOpenFailed.

		The baud rate must be one of 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800, 9600, 19200, 38400, 57600, 115200, or 230400.

		No flags are currently defined.  This parameter should be set to zero."

	^SerOpen callWith: serialTty with: baud with: serFlags.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialRead: handle buf: buf count: count [
	"This function reads up to count bytes from the the serial port associated with handle and writes them to buf.

		handle: >=0, as returned by a call to [*SerialOpen*].
		buf: an array to receive the read data.
		count: the maximum number of bytes to read.

		Returns the number of bytes read (>=0) if OK, otherwise GpioBadHandle, BadParam, SerReadNoData or SerWriteFailed.

		If no data is ready zero is returned."

	^SerRead callWith: handle with: buf with: count.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialReadByte: handle [
	"This function reads a byte from the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns the read byte (>=0) if OK, otherwise GpioBadHandle, SerReadNoData or SerReadFailed.

		If no data is ready SerReadNoData is returned."

	^SerReadByte callWith: handle.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialWrite: handle buf: buf count: count [
	"This function writes count bytes from buf to the the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].
		buf: the array of bytes to write.
		count: the number of bytes to write.

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or SerWriteFailed."

	^SerWrite callWith: handle with: buf with: count.

]

{ #category : 'Serial' }
RaspberryGpioInterface >> serialWriteByte: handle bVal: bVal [
	"This function writes bVal to the serial port associated with handle.

		handle: >=0, as returned by a call to [*SerialOpen*].

		Returns 0 if OK, otherwise GpioBadHandle, BadParam or SerWriteFailed."

	^SerWriteByte callWith: handle with: bVal.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> setAsInputPin: pin [

	"This sets the mode of a pin to INPUT"

	^GpioSetMode callWith: pin with: GpioInput.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> setAsOutputPin: pin [

	"This sets the mode of a pin to OUTPUT"

	^GpioSetMode callWith: pin with: GpioOutput.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> setGlitchFilter: userGpio steady: steady [
	"Sets a glitch filter on a GPIO.

		Level changes on the GPIO are not reported unless the level has been stable for at least [*steady*] microseconds.
		The level is then reported.  Level changes of less than [*steady*] microseconds are ignored.

		userGpio: 0-31
		steady: 0-300000

		Returns 0 if OK, otherwise BadUserGpio or BadFilter.

		This filter affects the GPIO samples returned to callbacks set up with [*gpioSetAlertFunc*], [*gpioSetAlertFuncEx*],
			[*gpioSetGetSamplesFunc*] and [*gpioSetGetSamplesFuncEx*].

		It does not affect interrupts set up with [*gpioSetISRFunc*], [*gpioSetISRFuncEx*], or levels read by [*gpioRead*],
		[*gpioRead_Bits_0_31*], or [*gpioRead_Bits_32_53*].

		Each (stable) edge will be timestamped [*steady*] microseconds after it was first detected."

	^GpioGlitchFilter callWith: userGpio with: steady.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> setNoiseFilter: userGpio steady: steady active: active [
	"Sets a noise filter on a GPIO - Broadcom pin.

		Level changes on the GPIO are ignored until a level which has been stable for [*steady*] microseconds is detected.
		Level changes on the GPIO are then reported for [*active*] microseconds after which the process repeats.

		userGpio: 0-31
		steady: 0-300000
		active: 0-1000000

		Returns 0 if OK, otherwise BadUserGpio or BadFilter.

		This filter affects the GPIO samples returned to callbacks set up with [*callback*], [*callback_ex*] and [*wait_for_edge*].
		It does not affect levels read by [*gpio_read*], [*read_bank_1*], or [*read_bank_2*].

		Level changes before and after the active period may be reported.
		Your software must be designed to cope with such reports."

	^GpioNoiseFilter callWith: userGpio with: steady with: active.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> setPad: pad strength: padStrength [
	"This function sets the pad drive strength in mA.

		pad: 0-2, the pad to set.
		padStrength: 1-16 mA.

		Returns 0 if OK, otherwise BadPad or BadStrength.

		Pad @ GPIO
		0	@ 0-27
		1	@ 28-45
		2	@ 46-53"

	^GpioSetPad callWith: pad with: padStrength.

]

{ #category : 'PWM' }
RaspberryGpioInterface >> setPin: pin pwmFrequency: freq [
	"Set the pwm frequency to the nearest available value to freq for pin.
	If cycle = 0, turn off pwm pulses for pin.
	Returns actual selected frequency if ok, or GpioBadUSerGpio or GpioNotPermitted.
	Available frequencies for the default 5uS sample rate are:-
	8000, 4000, 2000, 1600, 1000, 800, 500, 400, 320, 250, 200, 160, 100, 80, 50, 40, 20, 10"
	"PigpiodInterface uniqueInstance ensureStarted; setPin: 23 pwmFrequency: 1000"

	^GpioSetPwmFrequency callWith: pin with: freq.

]

{ #category : 'Pin Handling' }
RaspberryGpioInterface >> setPin: pin value: value [
	"Set an output bit.

		pin: 0-53
		level: 0-1

		Returns 0 if ok, or GpioBadGpio, GpioBadLevel or GpioNotPermitted.
		If PWM or servo pulses are active on this pin they will be switched off"

	^GpioWrite callWith: pin with: value.

]

{ #category : 'PWM' }
RaspberryGpioInterface >> setWatchDog: userGpio timeout: timeout [
	"Sets a WatchDog for a GPIO.

		userGpio: 0-31.
		timeout: 0-60000.

		Returns 0 if OK, otherwise BadUserGpio or BadWDogTimeout.

		The WatchDog is nominally in milliseconds.

		Only one WatchDog may be registered per GPIO.

		The WatchDog may be cancelled by setting timeout to 0.

		Once a WatchDog has been started callbacks for the GPIO will be triggered every timeout interval after the last GPIO activity.

		The callback will receive the special level Timeout."

	^GpioSetWatchDog callWith: userGpio with: timeout.

]

{ #category : 'Script' }
RaspberryGpioInterface >> shell: scriptName parm: scriptString [
	"This function uses the system call to execute a shell script with the given string as its parameter.

		scriptName: the name of the script, only alphanumeric characters, '-' and '_' are allowed in the name
		scriptString: the string to pass to the script

		The exit status of the system call is returned if OK, otherwise BadShellStatus.

		scriptName must exist in /opt/pigpio/cgi and must be executable.

		The returned exit status is normally 256 times that set by the shell script exit function.
		If the script can't be found 32512 will be returned.

		The following table gives some example returned statuses.

		Script exit status @ Returned system call status
		1                  @ 256
		5                  @ 1280
		10                 @ 2560
		200                @ 51200
		script not found   @ 32512"

	^Shell callWith: scriptName with: scriptString.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> spiClose: handle [
	"This functions closes the SPI device identified by the handle.

		handle: >=0, as returned by a call to [*spiOpen*]

		Returns 0 if OK, otherwise GpioBadHandle."

	^SpiClose callWith: handle.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> spiOpen: spiChannel baud: baud spiFlags: spiFlags [
	"This function returns a handle for the SPI device on the channel.
		Data will be transferred at baud bits per second.
		The flags may be used to modify the default behaviour of 4-wire operation, mode 0, active low chip select.

		An auxiliary SPI device is available on all models but the A and B and may be selected by setting the A bit in the flags.
		The auxiliary device has 3 chip selects and a selectable word size in bits.

		spiChan: 0-1 (0-2 for the auxiliary SPI device)
		baud: 32K-125M (values above 30M are unlikely to work)
		spiFlags: see below

		Returns a handle (>=0) if OK, otherwise GpioBadSpiChannel, GpioBadSpiSpeed, GpioBadFlags, NoAuxSpi or SpiOpenFailed.

		spiFlags consists of the least significant 22 bits.

		21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
		b  b  b  b  b  b  R  T  n  n  n  n  W  A u2 u1 u0 p2 p1 p0  m  m

		mm defines the SPI mode.

		Warning: modes 1 and 3 do not appear to work on the auxiliary device.

		Mode	POL	PHA
		0			0		0
		1			0		1
		2			1		0
		3			1		1

		px is 0 if CEx is active low (default) and 1 for active high.

		ux is 0 if the CEx GPIO is reserved for SPI (default) and 1 otherwise.

		A is 0 for the standard SPI device, 1 for the auxiliary SPI.

		W is 0 if the device is not 3-wire, 1 if the device is 3-wire.  Standard SPI device only.

		nnnn defines the number of bytes (0-15) to write before switching
		the MOSI line to MISO to read data.  This field is ignored
		if W is not set.  Standard SPI device only.

		T is 1 if the least significant bit is transmitted on MOSI first, the default (0) shifts the most significant bit out first.
		Auxiliary SPI device only.

		R is 1 if the least significant bit is received on MISO first, the default (0) receives the most significant bit first.
		Auxiliary SPI device only.

		bbbbbb defines the word size in bits (0-32).  The default (0) sets 8 bits per word.  Auxiliary SPI device only.

		The [*spiRead*], [*spiWrite*], and [*spiXfer*] functions transfer data packed into 1, 2, or 4 bytes
		according to the word size in bits.

		For bits 1-8 there will be one byte per word. 
		For bits 9-16 there will be two bytes per word. 
		For bits 17-32 there will be four bytes per word.

		Multi-byte transfers are made in least significant byte first order.

		E.g. to transfer 32 11-bit words buf should contain 64 bytes and count should be 64.

		E.g. to transfer the 14 bit value 0x1ABC send the bytes 0xBC followed by 0x1A.

		The other bits in flags should be set to zero."

	^SpiOpen callWith: spiChannel with: baud with: spiFlags.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> spiRead: handle buf: buf count: count [
	"This function reads count bytes of data from buf to the SPI device associated with the handle.

		handle: >=0, as returned by a call to [*spiOpen*]
		buf: an array to receive the read data bytes
		count: the number of bytes to read

		Returns the number of bytes transferred if OK, otherwise GpioBadHandle, GpioBadSpiCount or SpiXferFailed."

	^SpiRead callWith: handle with: buf with: count.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> spiWrite: handle buf: buf count: count [
	"This function writes count bytes of data from buf to the SPI device associated with the handle.

		handle: >=0, as returned by a call to [*spiOpen*]
		buf: the data bytes to write
		count: the number of bytes to write

		Returns the number of bytes transferred if OK, otherwise GpioBadHandle, GpioBadSpiCount or SpiXferFailed."

	^SpiWrite callWith: handle with: buf with: count.

]

{ #category : 'SPI' }
RaspberryGpioInterface >> spiXfer: handle txBuf: txBuf rxBuf: rxBuf count: count [
	"This function transfers count bytes of data from txBuf to the SPI device associated with the handle.
		Simultaneously count bytes of data are read from the device and placed in rxBuf.

		handle: >=0, as returned by a call to [*spiOpen*]
		txBuf: the data bytes to write
		rxBuf: the received data bytes
		count: the number of bytes to transfer

		Returns the number of bytes transferred if OK, otherwise GpioBadHandle, GpioBadSpiCount or SpiXferFailed."

	^SpiXfer callWith: handle with: txBuf with: rxBuf with: count.

]

{ #category : 'Script' }
RaspberryGpioInterface >> stopScript: scriptId [
	"This function stops a running script.

		scriptId: >=0, as returned by [*store_script*].

		The function returns 0 if OK, otherwise BadScriptId."

	^GpioStopScript callWith: scriptId.

]

{ #category : 'Script' }
RaspberryGpioInterface >> storeScript: script [
	"This function stores a script for later execution.

		See [[http://abyz.me.uk/rpi/pigpio/pigs.html#Scripts]] for details.

		script: the text of the script.

		The function returns a script id if the script is valid, otherwise BadScript."

	^GpioStoreScript callWith: script.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> terminateLibrary [
	"Terminates the library.

		Returns nothing.
		Call before program exit.

		This function resets the used DMA channels, releases memory and terminates any running threads."

	GpioTerminate call.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> timeSleep: seconds [
	"Delay execution for a given number of seconds.

		seconds: the number of seconds to delay."

	TimeSleep callWith: seconds asFloatD.

]

{ #category : 'Hardware' }
RaspberryGpioInterface >> timeTime [
	"time_time returns the current time in seconds since the Epoch, we return a DateAndTime."
	| timeTime |

	timeTime := TimeTime call.

	^DateAndTime fromSeconds: timeTime asInteger.

]

{ #category : 'Script' }
RaspberryGpioInterface >> updateScript: scriptId numPar: numPar param: param [
	"This function sets the parameters of a script.  The script may or may not be running.
		The first numPar parameters of the script are overwritten with the new values.

		scriptId: >=0, as returned by [*StoreScript*].
		numPar: 0-10, the number of parameters.
		param: an array of parameters.

		The function returns 0 if OK, otherwise BadScriptId or TooManyParam.

		param is an array of up to 10 parameters which may be referenced in the script as p0 to p9."

	^GpioUpdateScript callWith: scriptId with: numPar with: param.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveAddNew [
	"This function starts a new empty waveform.  You wouldn't normally need to call this function as
		it is automatically called after a waveform is created with the [*wave_create*] function.

		Returns 0 if OK."

	^GpioWaveAddNew call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveAddPulses: arrayOfPulses [
	"Given an array of OSGpioPulse, add them to the current wave.
		The arrayOfPulses is a normal Smalltalk collection of instances of OSGpioPulse.
		Returns number of total pulses in the current wave if ok or GpioTooManyPulses"
	| osPulses pulseCnt |

	pulseCnt := arrayOfPulses size.
	osPulses := OSObjectPointer new: pulseCnt itemType: OSGpioPulse.
	0 to: pulseCnt do: [:i | osPulses at: i put: (arrayOfPulses at: (i + 1))].

	^GpioWaveAddGeneric callWith: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveAddPulseTriplets: arrayOfTriplets [
	"Given an array of triplets of int, add them to the current wave.
	 The arrayOfTriplets is a normal Smalltalk collection of integers, every three constitute a wave pulse.
	Returns number of total pulses in the current wave if ok or GpioTooManyPulses"
	| osPulses pulseCnt intCnt |

	intCnt := arrayOfTriplets size.
	osPulses := OSObjectPointer new: intCnt itemType: OSInteger.
	0 to: intCnt do: [:i | osPulses at: i put: (arrayOfTriplets at: (i + 1))].
	pulseCnt := intCnt // 3.

	^GpioWaveAddGeneric callWith: pulseCnt with: osPulses.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveAddSerial: userGpio baud: baud dataBits: dataBits stopBits: stopBits offset: offset str: str [
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

	^GpioWaveAddSerial callWith: userGpio with: baud with: dataBits with: stopBits with: offset with: strBytesPtr with: strBytes size.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveChain: waveIds [
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

	^GpioWaveChain callWith: waveIdBytesPtr with: waveIdBytes size.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveClear [
	"Clear all waveforms from the wave buffers.
	 This function clears all waveforms and any data added by calls to the [*wave_add_**] functions."

	^GpioWaveClear call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveCreate [
	"Create a waveform from the wave buffers.
	Return a wave id >= 0 if ok, otherwise GpioEmptyWaveform, GpioTooManyCBS, GpioTooManyOOL or GpioNoWaveformID "

	^GpioWaveCreate call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveDelete: waveId [
	"This function deletes the waveform with id waveId.

		waveId: >=0, as returned by [*wave_create*].
		Wave ids are allocated in order, 0, 1, 2, etc.

		The wave is flagged for deletion.  The resources used by the wave will only be reused when either of the following apply.
		- all waves with higher numbered wave ids have been deleted or have been flagged for deletion.
		- a new wave is created which uses exactly the same resources as the current wave (see the C source for gpioWaveCreate for details).

		Returns 0 if OK, otherwise BadWaveId."

	^GpioWaveDelete callWith: waveId.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetCbs [
	"This function returns the length in DMA control blocks of the current waveform."

	^GpioWaveGetCbs call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetHighCbs [
	"This function returns the length in DMA control blocks of the longest waveform created since gpio initialise was called."

	^GpioWaveGetHighCbs call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetHighMicros [
	"This function returns the length in microseconds of the longest waveform created since gpio initialise was called."

	^GpioWaveGetHighMicros call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetHighPulses [
	"This function returns the length in pulses of the longest waveform created since gpio initialise was called."

	^GpioWaveGetHighPulses call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetMaxCbs [
	"This function returns the maximum possible size of a waveform in DMA control blocks."

	^GpioWaveGetMaxCbs call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetMaxMicros [
	"This function returns the maximum possible size of a waveform in microseconds."

	^GpioWaveGetMaxMicros call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetMaxPulses [
	"This function returns the maximum possible size of a waveform in pulses."

	^GpioWaveGetMaxPulses call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetMicros [
	"This function returns the length in microseconds of the current waveform."

	^GpioWaveGetMicros call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveGetPulses [
	"This function returns the length in pulses of the current waveform."

	^GpioWaveGetPulses call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveTxAt [
	"This function returns the id of the waveform currently being transmitted.

		Returns the waveform id or one of the following special values:

		WaveNotFound (9998) - transmitted wave not found. 
		NoTxWave (9999) - no wave being transmitted."

	^GpioWaveTxAt call.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveTxBusy [
	"This function checks to see if a waveform is currently being transmitted.
		WaveTxBusy (wave_tx_busy) returns 1 if a waveform is currently being transmitted, otherwise 0, we return true/false."

	^(GpioWaveTxBusy call) = 1.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveTxSend: waveId mode: mode [
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

	^GpioWaveTxSend call with: waveId with: mode.

]

{ #category : 'Wave' }
RaspberryGpioInterface >> waveTxStop [
	"Aborts the current waveform."

	^GpioWaveTxStop call.

]
