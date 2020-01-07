Class {
	#name : 'RaspberryGpioFunctions',
	#superclass : 'SharedPool',
	#classVars : [
		'BbI2cClose',
		'BbI2cOpen',
		'BbI2cZip',
		'BbSpiClose',
		'BbSpiOpen',
		'BbSpiXfer',
		'BscXfer',
		'EventMonitor',
		'EventSetFunc',
		'EventSetFuncEx',
		'EventTrigger',
		'FileClose',
		'FileList',
		'FileOpen',
		'FileRead',
		'FileSeek',
		'FileWrite',
		'GetBitInBytes',
		'GetRaspberryGpioVersion',
		'GpioCfgBufferSize',
		'GpioCfgClock',
		'GpioCfgDmaChannel',
		'GpioCfgDmaChannels',
		'GpioCfgGetInternals',
		'GpioCfgInterfaces',
		'GpioCfgInternals',
		'GpioCfgMemAlloc',
		'GpioCfgNetAddr',
		'GpioCfgPermissions',
		'GpioCfgSetInternals',
		'GpioCfgSocketPort',
		'GpioCustom1',
		'GpioCustom2',
		'GpioDelay',
		'GpioDeleteScript',
		'GpioGetMode',
		'GpioGetPad',
		'GpioGetPwmDutycycle',
		'GpioGetPwmFrequency',
		'GpioGetPwmRange',
		'GpioGetPwmRealRange',
		'GpioGetServoPulseWidth',
		'GpioGlitchFilter',
		'GpioHardwareClock',
		'GpioHardwarePWM',
		'GpioHardwareRevision',
		'GpioInitialise',
		'GpioNoiseFilter',
		'GpioNotifyBegin',
		'GpioNotifyClose',
		'GpioNotifyOpen',
		'GpioNotifyOpenWithSize',
		'GpioNotifyPause',
		'GpioPWM',
		'GpioRead',
		'GpioReadBits031',
		'GpioReadBits3253',
		'GpioRunScript',
		'GpioScriptStatus',
		'GpioSerialRead',
		'GpioSerialReadClose',
		'GpioSerialReadInvert',
		'GpioSerialReadOpen',
		'GpioServo',
		'GpioSetAlertFunc',
		'GpioSetAlertFuncEx',
		'GpioSetGetSamplesFunc',
		'GpioSetGetSamplesFuncEx',
		'GpioSetIsrFunc',
		'GpioSetIsrFuncEx',
		'GpioSetMode',
		'GpioSetPad',
		'GpioSetPullUpDown',
		'GpioSetPwmFrequency',
		'GpioSetPwmRange',
		'GpioSetSignalFunc',
		'GpioSetSignalFuncEx',
		'GpioSetTimerFunc',
		'GpioSetTimerFuncEx',
		'GpioSetWatchDog',
		'GpioSleep',
		'GpioStartThread',
		'GpioStopScript',
		'GpioStopThread',
		'GpioStoreScript',
		'GpioTerminate',
		'GpioTick',
		'GpioTime',
		'GpioTrigger',
		'GpioUpdateScript',
		'GpioWaveAddGeneric',
		'GpioWaveAddNew',
		'GpioWaveAddSerial',
		'GpioWaveChain',
		'GpioWaveClear',
		'GpioWaveCreate',
		'GpioWaveDelete',
		'GpioWaveGetCbs',
		'GpioWaveGetHighCbs',
		'GpioWaveGetHighMicros',
		'GpioWaveGetHighPulses',
		'GpioWaveGetMaxCbs',
		'GpioWaveGetMaxMicros',
		'GpioWaveGetMaxPulses',
		'GpioWaveGetMicros',
		'GpioWaveGetPulses',
		'GpioWaveTxAt',
		'GpioWaveTxBusy',
		'GpioWaveTxSend',
		'GpioWaveTxStop',
		'GpioWrite',
		'GpioWriteBits031Clear',
		'GpioWriteBits031Set',
		'GpioWriteBits3253Clear',
		'GpioWriteBits3253Set',
		'I2cBlockProcessCall',
		'I2cClose',
		'I2cOpen',
		'I2cProcessCall',
		'I2cReadBlockData',
		'I2cReadByte',
		'I2cReadByteData',
		'I2cReadDevice',
		'I2cReadI2cBlockData',
		'I2cReadWordData',
		'I2cSegments',
		'I2cSwitchCombined',
		'I2cWriteBlockData',
		'I2cWriteByte',
		'I2cWriteByteData',
		'I2cWriteDevice',
		'I2cWriteI2cBlockData',
		'I2cWriteQuick',
		'I2cWriteWordData',
		'I2cZip',
		'PutBitInBytes',
		'RawDumpScript',
		'RawDumpWave',
		'RawWaveAddGeneric',
		'RawWaveAddSpi',
		'RawWaveCB',
		'RawWaveCBAdr',
		'RawWaveGetIn',
		'RawWaveGetOOL',
		'RawWaveGetOut',
		'RawWaveInfo',
		'RawWaveSetIn',
		'RawWaveSetOOL',
		'RawWaveSetOut',
		'SerClose',
		'SerDataAvailable',
		'SerOpen',
		'SerRead',
		'SerReadByte',
		'SerWrite',
		'SerWriteByte',
		'Shell',
		'SpiClose',
		'SpiOpen',
		'SpiRead',
		'SpiWrite',
		'SpiXfer',
		'TimeSleep',
		'TimeTime'
	],
	#type : 'variable',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Initializing' }
RaspberryGpioFunctions class >> initialize [
	BbI2cClose := PlatformFunction fromArray: #('C' 'bbI2CClose' nil 'RaspberryGpio' #(#uint32) #int32).
	BbI2cOpen := PlatformFunction fromArray: #('C' 'bbI2COpen' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	BbI2cZip := PlatformFunction fromArray: #('C' 'bbI2CZip' nil 'RaspberryGpio' #(#uint32 #pointer #uint32 #pointer #uint32) #int32).
	BbSpiClose := PlatformFunction fromArray: #('C' 'bbSPIClose' nil 'RaspberryGpio' #(#uint32) #int32).
	BbSpiOpen := PlatformFunction fromArray: #('C' 'bbSPIOpen' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32 #uint32 #uint32 #uint32) #int32).
	BbSpiXfer := PlatformFunction fromArray: #('C' 'bbSPIXfer' nil 'RaspberryGpio' #(#uint32 #pointer #pointer #uint32) #int32).
	BscXfer := PlatformFunction fromArray: #('C' 'bscXfer' nil 'RaspberryGpio' #(#pointer) #int32).
	EventMonitor := PlatformFunction fromArray: #('C' 'eventMonitor' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	EventSetFunc := PlatformFunction fromArray: #('C' 'eventSetFunc' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	EventSetFuncEx := PlatformFunction fromArray: #('C' 'eventSetFuncEx' nil 'RaspberryGpio' #(#uint32 #pointer #pointer) #int32).
	EventTrigger := PlatformFunction fromArray: #('C' 'eventTrigger' nil 'RaspberryGpio' #(#uint32) #int32).
	FileClose := PlatformFunction fromArray: #('C' 'fileClose' nil 'RaspberryGpio' #(#uint32) #int32).
	FileList := PlatformFunction fromArray: #('C' 'fileList' nil 'RaspberryGpio' #(#pointer #pointer #uint32) #int32).
	FileOpen := PlatformFunction fromArray: #('C' 'fileOpen' nil 'RaspberryGpio' #(#pointer #uint32) #int32).
	FileRead := PlatformFunction fromArray: #('C' 'fileRead' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	FileSeek := PlatformFunction fromArray: #('C' 'fileSeek' nil 'RaspberryGpio' #(#uint32 #int32 #int32) #int32).
	FileWrite := PlatformFunction fromArray: #('C' 'fileWrite' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	GetBitInBytes := PlatformFunction fromArray: #('C' 'getBitInBytes' nil 'RaspberryGpio' #(#int32 #pointer #int32) #int32).
	GetRaspberryGpioVersion := PlatformFunction fromArray: #('C' 'gpioVersion' nil 'RaspberryGpio' #() #uint32).
	GpioCfgBufferSize := PlatformFunction fromArray: #('C' 'gpioCfgBufferSize' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCfgClock := PlatformFunction fromArray: #('C' 'gpioCfgClock' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	GpioCfgDmaChannel := PlatformFunction fromArray: #('C' 'gpioCfgDMAchannel' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCfgDmaChannels := PlatformFunction fromArray: #('C' 'gpioCfgDMAchannels' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioCfgGetInternals := PlatformFunction fromArray: #('C' 'gpioCfgGetInternals' nil 'RaspberryGpio' #() #uint32).
	GpioCfgInterfaces := PlatformFunction fromArray: #('C' 'gpioCfgInterfaces' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCfgInternals := PlatformFunction fromArray: #('C' 'gpioCfgInternals' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioCfgMemAlloc := PlatformFunction fromArray: #('C' 'gpioCfgMemAlloc' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCfgNetAddr := PlatformFunction fromArray: #('C' 'gpioCfgNetAddr' nil 'RaspberryGpio' #(#int32 #pointer) #int32).
	GpioCfgPermissions := PlatformFunction fromArray: #('C' 'gpioCfgPermissions' nil 'RaspberryGpio' #(#uint64) #int32).
	GpioCfgSetInternals := PlatformFunction fromArray: #('C' 'gpioCfgSetInternals' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCfgSocketPort := PlatformFunction fromArray: #('C' 'gpioCfgSocketPort' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioCustom1 := PlatformFunction fromArray: #('C' 'gpioCustom1' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #uint32) #int32).
	GpioCustom2 := PlatformFunction fromArray: #('C' 'gpioCustom2' nil 'RaspberryGpio' #(#uint32 #pointer #uint32 #pointer #uint32) #int32).
	GpioDelay := PlatformFunction fromArray: #('C' 'gpioDelay' nil 'RaspberryGpio' #(#uint32) #uint32).
	GpioDeleteScript := PlatformFunction fromArray: #('C' 'gpioDeleteScript' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetMode := PlatformFunction fromArray: #('C' 'gpioGetMode' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetPad := PlatformFunction fromArray: #('C' 'gpioGetPad' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetPwmDutycycle := PlatformFunction fromArray: #('C' 'gpioGetPWMdutycycle' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetPwmFrequency := PlatformFunction fromArray: #('C' 'gpioGetPWMfrequency' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetPwmRange := PlatformFunction fromArray: #('C' 'gpioGetPWMrange' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetPwmRealRange := PlatformFunction fromArray: #('C' 'gpioGetPWMrealRange' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGetServoPulseWidth := PlatformFunction fromArray: #('C' 'gpioGetServoPulsewidth' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioGlitchFilter := PlatformFunction fromArray: #('C' 'gpioGlitchFilter' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioHardwareClock := PlatformFunction fromArray: #('C' 'gpioHardwareClock' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioHardwarePWM := PlatformFunction fromArray: #('C' 'gpioHardwarePWM' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	GpioHardwareRevision := PlatformFunction fromArray: #('C' 'gpioHardwareRevision' nil 'RaspberryGpio' #() #uint32).
	GpioInitialise := PlatformFunction fromArray: #('C' 'gpioInitialise' nil 'RaspberryGpio' #() #int32).
	GpioNoiseFilter := PlatformFunction fromArray: #('C' 'gpioNoiseFilter' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	GpioNotifyBegin := PlatformFunction fromArray: #('C' 'gpioNotifyBegin' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioNotifyClose := PlatformFunction fromArray: #('C' 'gpioNotifyClose' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioNotifyOpen := PlatformFunction fromArray: #('C' 'gpioNotifyOpen' nil 'RaspberryGpio' #() #int32).
	GpioNotifyOpenWithSize := PlatformFunction fromArray: #('C' 'gpioNotifyOpenWithSize' nil 'RaspberryGpio' #(#int32) #int32).
	GpioNotifyPause := PlatformFunction fromArray: #('C' 'gpioNotifyPause' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioPWM := PlatformFunction fromArray: #('C' 'gpioPWM' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioRead := PlatformFunction fromArray: #('C' 'gpioRead' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioReadBits031 := PlatformFunction fromArray: #('C' 'gpioRead_Bits_0_31' nil 'RaspberryGpio' #() #uint32).
	GpioReadBits3253 := PlatformFunction fromArray: #('C' 'gpioRead_Bits_32_53' nil 'RaspberryGpio' #() #uint32).
	GpioRunScript := PlatformFunction fromArray: #('C' 'gpioRunScript' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer) #int32).
	GpioScriptStatus := PlatformFunction fromArray: #('C' 'gpioScriptStatus' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	GpioSerialRead := PlatformFunction fromArray: #('C' 'gpioSerialRead' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	GpioSerialReadClose := PlatformFunction fromArray: #('C' 'gpioSerialReadClose' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioSerialReadInvert := PlatformFunction fromArray: #('C' 'gpioSerialReadInvert' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSerialReadOpen := PlatformFunction fromArray: #('C' 'gpioSerialReadOpen' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	GpioServo := PlatformFunction fromArray: #('C' 'gpioServo' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetAlertFunc := PlatformFunction fromArray: #('C' 'gpioSetAlertFunc' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	GpioSetAlertFuncEx := PlatformFunction fromArray: #('C' 'gpioSetAlertFuncEx' nil 'RaspberryGpio' #(#uint32 #pointer #pointer) #int32).
	GpioSetGetSamplesFunc := PlatformFunction fromArray: #('C' 'gpioSetGetSamplesFunc' nil 'RaspberryGpio' #(#pointer #uint32) #int32).
	GpioSetGetSamplesFuncEx := PlatformFunction fromArray: #('C' 'gpioSetGetSamplesFuncEx' nil 'RaspberryGpio' #(#pointer #uint32 #pointer) #int32).
	GpioSetIsrFunc := PlatformFunction fromArray: #('C' 'gpioSetISRFunc' nil 'RaspberryGpio' #(#uint32 #uint32 #int32 #pointer) #int32).
	GpioSetIsrFuncEx := PlatformFunction fromArray: #('C' 'gpioSetISRFuncEx' nil 'RaspberryGpio' #(#uint32 #uint32 #int32 #pointer #pointer) #int32).
	GpioSetMode := PlatformFunction fromArray: #('C' 'gpioSetMode' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetPad := PlatformFunction fromArray: #('C' 'gpioSetPad' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetPullUpDown := PlatformFunction fromArray: #('C' 'gpioSetPullUpDown' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetPwmFrequency := PlatformFunction fromArray: #('C' 'gpioSetPWMfrequency' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetPwmRange := PlatformFunction fromArray: #('C' 'gpioSetPWMrange' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSetSignalFunc := PlatformFunction fromArray: #('C' 'gpioSetSignalFunc' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	GpioSetSignalFuncEx := PlatformFunction fromArray: #('C' 'gpioSetSignalFuncEx' nil 'RaspberryGpio' #(#uint32 #pointer #pointer) #int32).
	GpioSetTimerFunc := PlatformFunction fromArray: #('C' 'gpioSetTimerFunc' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer) #int32).
	GpioSetTimerFuncEx := PlatformFunction fromArray: #('C' 'gpioSetTimerFuncEx' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #pointer) #int32).
	GpioSetWatchDog := PlatformFunction fromArray: #('C' 'gpioSetWatchdog' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioSleep := PlatformFunction fromArray: #('C' 'gpioSleep' nil 'RaspberryGpio' #(#uint32 #int32 #int32) #int32).
	GpioStartThread := PlatformFunction fromArray: #('C' 'gpioStartThread' nil 'RaspberryGpio' #(#pointer #pointer) #pointer).
	GpioStopScript := PlatformFunction fromArray: #('C' 'gpioStopScript' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioStopThread := PlatformFunction fromArray: #('C' 'gpioStopThread' nil 'RaspberryGpio' #(#pointer) #void).
	GpioStoreScript := PlatformFunction fromArray: #('C' 'gpioStoreScript' nil 'RaspberryGpio' #(#pointer) #int32).
	GpioTerminate := PlatformFunction fromArray: #('C' 'gpioTerminate' nil 'RaspberryGpio' #() #void).
	GpioTick := PlatformFunction fromArray: #('C' 'gpioTick' nil 'RaspberryGpio' #() #uint32).
	GpioTime := PlatformFunction fromArray: #('C' 'gpioTime' nil 'RaspberryGpio' #(#uint32 #pointer #pointer) #int32).
	GpioTrigger := PlatformFunction fromArray: #('C' 'gpioTrigger' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	GpioUpdateScript := PlatformFunction fromArray: #('C' 'gpioUpdateScript' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer) #int32).
	GpioWaveAddGeneric := PlatformFunction fromArray: #('C' 'gpioWaveAddGeneric' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	GpioWaveAddNew := PlatformFunction fromArray: #('C' 'gpioWaveAddNew' nil 'RaspberryGpio' #() #int32).
	GpioWaveAddSerial := PlatformFunction fromArray: #('C' 'gpioWaveAddSerial' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32 #uint32 #uint32 #uint32 #pointer) #int32).
	GpioWaveChain := PlatformFunction fromArray: #('C' 'gpioWaveChain' nil 'RaspberryGpio' #(#pointer #uint32) #int32).
	GpioWaveClear := PlatformFunction fromArray: #('C' 'gpioWaveClear' nil 'RaspberryGpio' #() #int32).
	GpioWaveCreate := PlatformFunction fromArray: #('C' 'gpioWaveCreate' nil 'RaspberryGpio' #() #int32).
	GpioWaveDelete := PlatformFunction fromArray: #('C' 'gpioWaveDelete' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioWaveGetCbs := PlatformFunction fromArray: #('C' 'gpioWaveGetCbs' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetHighCbs := PlatformFunction fromArray: #('C' 'gpioWaveGetHighCbs' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetHighMicros := PlatformFunction fromArray: #('C' 'gpioWaveGetHighMicros' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetHighPulses := PlatformFunction fromArray: #('C' 'gpioWaveGetHighPulses' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetMaxCbs := PlatformFunction fromArray: #('C' 'gpioWaveGetMaxCbs' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetMaxMicros := PlatformFunction fromArray: #('C' 'gpioWaveGetMaxMicros' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetMaxPulses := PlatformFunction fromArray: #('C' 'gpioWaveGetMaxPulses' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetMicros := PlatformFunction fromArray: #('C' 'gpioWaveGetMicros' nil 'RaspberryGpio' #() #int32).
	GpioWaveGetPulses := PlatformFunction fromArray: #('C' 'gpioWaveGetPulses' nil 'RaspberryGpio' #() #int32).
	GpioWaveTxAt := PlatformFunction fromArray: #('C' 'gpioWaveTxAt' nil 'RaspberryGpio' #() #int32).
	GpioWaveTxBusy := PlatformFunction fromArray: #('C' 'gpioWaveTxBusy' nil 'RaspberryGpio' #() #int32).
	GpioWaveTxSend := PlatformFunction fromArray: #('C' 'gpioWaveTxSend' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioWaveTxStop := PlatformFunction fromArray: #('C' 'gpioWaveTxStop' nil 'RaspberryGpio' #() #int32).
	GpioWrite := PlatformFunction fromArray: #('C' 'gpioWrite' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	GpioWriteBits031Clear := PlatformFunction fromArray: #('C' 'gpioWrite_Bits_0_31_Clear' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioWriteBits031Set := PlatformFunction fromArray: #('C' 'gpioWrite_Bits_0_31_Set' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioWriteBits3253Clear := PlatformFunction fromArray: #('C' 'gpioWrite_Bits_32_53_Clear' nil 'RaspberryGpio' #(#uint32) #int32).
	GpioWriteBits3253Set := PlatformFunction fromArray: #('C' 'gpioWrite_Bits_32_53_Set' nil 'RaspberryGpio' #(#uint32) #int32).
	I2cBlockProcessCall := PlatformFunction fromArray: #('C' 'i2cBlockProcessCall' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #uint32) #int32).
	I2cClose := PlatformFunction fromArray: #('C' 'i2cClose' nil 'RaspberryGpio' #(#uint32) #int32).
	I2cOpen := PlatformFunction fromArray: #('C' 'i2cOpen' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	I2cProcessCall := PlatformFunction fromArray: #('C' 'i2cProcessCall' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	I2cReadBlockData := PlatformFunction fromArray: #('C' 'i2cReadBlockData' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer) #int32).
	I2cReadByte := PlatformFunction fromArray: #('C' 'i2cReadByte' nil 'RaspberryGpio' #(#uint32) #int32).
	I2cReadByteData := PlatformFunction fromArray: #('C' 'i2cReadByteData' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	I2cReadDevice := PlatformFunction fromArray: #('C' 'i2cReadDevice' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	I2cReadI2cBlockData := PlatformFunction fromArray: #('C' 'i2cReadI2CBlockData' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #uint32) #int32).
	I2cReadWordData := PlatformFunction fromArray: #('C' 'i2cReadWordData' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	I2cSegments := PlatformFunction fromArray: #('C' 'i2cSegments' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	I2cSwitchCombined := PlatformFunction fromArray: #('C' 'i2cSwitchCombined' nil 'RaspberryGpio' #(#int32) #void).
	I2cWriteBlockData := PlatformFunction fromArray: #('C' 'i2cWriteBlockData' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #uint32) #int32).
	I2cWriteByte := PlatformFunction fromArray: #('C' 'i2cWriteByte' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	I2cWriteByteData := PlatformFunction fromArray: #('C' 'i2cWriteByteData' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	I2cWriteDevice := PlatformFunction fromArray: #('C' 'i2cWriteDevice' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	I2cWriteI2cBlockData := PlatformFunction fromArray: #('C' 'i2cWriteI2CBlockData' nil 'RaspberryGpio' #(#uint32 #uint32 #pointer #uint32) #int32).
	I2cWriteQuick := PlatformFunction fromArray: #('C' 'i2cWriteQuick' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	I2cWriteWordData := PlatformFunction fromArray: #('C' 'i2cWriteWordData' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	I2cZip := PlatformFunction fromArray: #('C' 'i2cZip' nil 'RaspberryGpio' #(#uint32 #pointer #uint32 #pointer #uint32) #int32).
	PutBitInBytes := PlatformFunction fromArray: #('C' 'putBitInBytes' nil 'RaspberryGpio' #(#int32 #pointer #int32) #void).
	RawDumpScript := PlatformFunction fromArray: #('C' 'rawDumpScript' nil 'RaspberryGpio' #(#uint32) #void).
	RawDumpWave := PlatformFunction fromArray: #('C' 'rawDumpWave' nil 'RaspberryGpio' #() #void).
	RawWaveAddGeneric := PlatformFunction fromArray: #('C' 'rawWaveAddGeneric' nil 'RaspberryGpio' #(#uint32 #pointer) #int32).
	RawWaveAddSpi := PlatformFunction fromArray: #('C' 'rawWaveAddSPI' nil 'RaspberryGpio' #(#pointer #uint32 #uint32 #pointer #uint32 #uint32 #uint32 #uint32) #int32).
	RawWaveCB := PlatformFunction fromArray: #('C' 'rawWaveCB' nil 'RaspberryGpio' #() #uint32).
	RawWaveCBAdr := PlatformFunction fromArray: #('C' 'rawWaveCBAdr' nil 'RaspberryGpio' #(#int32) #pointer).
	RawWaveGetIn := PlatformFunction fromArray: #('C' 'rawWaveGetIn' nil 'RaspberryGpio' #(#int32) #uint32).
	RawWaveGetOOL := PlatformFunction fromArray: #('C' 'rawWaveGetOOL' nil 'RaspberryGpio' #(#int32) #uint32).
	RawWaveGetOut := PlatformFunction fromArray: #('C' 'rawWaveGetOut' nil 'RaspberryGpio' #(#int32) #uint32).
	RawWaveInfo := PlatformFunction fromArray: #('C' 'rawWaveInfo' nil 'RaspberryGpio' #(#int32) #pointer).
	RawWaveSetIn := PlatformFunction fromArray: #('C' 'rawWaveSetIn' nil 'RaspberryGpio' #(#int32 #uint32) #void).
	RawWaveSetOOL := PlatformFunction fromArray: #('C' 'rawWaveSetOOL' nil 'RaspberryGpio' #(#int32 #uint32) #void).
	RawWaveSetOut := PlatformFunction fromArray: #('C' 'rawWaveSetOut' nil 'RaspberryGpio' #(#int32 #uint32) #void).
	SerClose := PlatformFunction fromArray: #('C' 'serClose' nil 'RaspberryGpio' #(#uint32) #int32).
	SerDataAvailable := PlatformFunction fromArray: #('C' 'serDataAvailable' nil 'RaspberryGpio' #(#uint32) #int32).
	SerOpen := PlatformFunction fromArray: #('C' 'serOpen' nil 'RaspberryGpio' #(#pointer #uint32 #uint32) #int32).
	SerRead := PlatformFunction fromArray: #('C' 'serRead' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	SerReadByte := PlatformFunction fromArray: #('C' 'serReadByte' nil 'RaspberryGpio' #(#uint32) #int32).
	SerWrite := PlatformFunction fromArray: #('C' 'serWrite' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	SerWriteByte := PlatformFunction fromArray: #('C' 'serWriteByte' nil 'RaspberryGpio' #(#uint32 #uint32) #int32).
	Shell := PlatformFunction fromArray: #('C' 'shell' nil 'RaspberryGpio' #(#pointer #pointer) #int32).
	SpiClose := PlatformFunction fromArray: #('C' 'spiClose' nil 'RaspberryGpio' #(#uint32) #int32).
	SpiOpen := PlatformFunction fromArray: #('C' 'spiOpen' nil 'RaspberryGpio' #(#uint32 #uint32 #uint32) #int32).
	SpiRead := PlatformFunction fromArray: #('C' 'spiRead' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	SpiWrite := PlatformFunction fromArray: #('C' 'spiWrite' nil 'RaspberryGpio' #(#uint32 #pointer #uint32) #int32).
	SpiXfer := PlatformFunction fromArray: #('C' 'spiXfer' nil 'RaspberryGpio' #(#uint32 #pointer #pointer #uint32) #int32).
	TimeSleep := PlatformFunction fromArray: #('C' 'time_sleep' nil 'RaspberryGpio' #(#double) #void).
	TimeTime := PlatformFunction fromArray: #('C' 'time_time' nil 'RaspberryGpio' #() #double).
]
