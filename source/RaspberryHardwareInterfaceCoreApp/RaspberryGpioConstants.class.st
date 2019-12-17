Class {
	#name : 'RaspberryGpioConstants',
	#superclass : 'SharedPool',
	#classVars : [
		'AccelerometerXOutputRegister',
		'AccelerometerYOutputRegister',
		'AccelerometerZOutputRegister',
		'ADSConfigRegister',
		'ADSConversionRegister',
		'AvConfRegister',
		'BadBufMillis',
		'BadCfgInternal',
		'BadChainCmd',
		'BadChainDelay',
		'BadChainLoop',
		'BadChannel',
		'BadClkMicros',
		'BadClkPeriph',
		'BadClkSource',
		'BadDatabits',
		'BadEdge',
		'BadEventId',
		'BadFifoCommand',
		'BadFileFlag',
		'GpioBadFileMode',
		'GpioBadFileRead',
		'GpioBadFileSeek',
		'GpioBadFileWrite',
		'BadFilter',
		'BadForever',
		'BadGpio',
		'BadHclkFreq',
		'BadHclkPass',
		'BadHpwmDuty',
		'BadHpwmFreq',
		'BadI2cAddr',
		'BadI2cBaud',
		'BadI2cBus',
		'BadI2cCmd',
		'BadI2cRlen',
		'BadI2cSeg',
		'BadI2cWLen',
		'BadIfFlags',
		'BadIsrInit',
		'BadLevel',
		'BadMallocMode',
		'BadMicros',
		'BadMicsDelay',
		'BadMilsDelay',
		'BadMode',
		'BadMs',
		'BadPad',
		'BadParam',
		'BadParamNum',
		'BadPathname',
		'BadPointer',
		'BadPrimChannel',
		'BadPud',
		'BadPulselen',
		'BadPulsewidth',
		'BadScript',
		'BadScriptCmd',
		'BadScriptId',
		'BadScriptName',
		'BadSecoChannel',
		'BadSeconds',
		'BadSerDevice',
		'BadSerialBuf',
		'BadSerialCount',
		'BadSerialStruc',
		'BadSerInvert',
		'BadSerOffset',
		'BadSerSpeed',
		'BadShellStatus',
		'BadSignum',
		'BadSmbusCmd',
		'BadSocketPort',
		'BadSpiBaud',
		'BadSpiSpeed',
		'BadStopbits',
		'BadStrength',
		'BadTag',
		'BadTimer',
		'BadTimeType',
		'BadUserGpio',
		'BadVarNum',
		'BadWaveBaud',
		'BadWaveId',
		'BadWaveMode',
		'BadWDogTimeout',
		'BadWvscCommnd',
		'BadWvsmCommnd',
		'BadWvspCommnd',
		'BbI2cMaxBaud',
		'BbI2cMinBaud',
		'BbSerInvert',
		'BbSerMaxBaud',
		'BbSerMinBaud',
		'BbSerNormal',
		'BbSpiMaxBaud',
		'BbSpiMinBaud',
		'ChainCounter',
		'ChainLoopCnt',
		'ChainNesting',
		'ChainTooBig',
		'ClockPcm',
		'ClockPwm',
		'CmdAdd',
		'CmdAnd',
		'CmdBc1',
		'CmdBc2',
		'CmdBi2Cc',
		'CmdBi2Co',
		'CmdBi2Cz',
		'CmdBr1',
		'CmdBr2',
		'CmdBs1',
		'CmdBs2',
		'CmdBscx',
		'CmdBspic',
		'CmdBspio',
		'CmdBspix',
		'CmdCall',
		'CmdCf1',
		'CmdCf2',
		'CmdCgi',
		'CmdCmdr',
		'CmdCmdw',
		'CmdCmp',
		'CmdCsi',
		'CmdDcr',
		'CmdDcra',
		'CmdDiv',
		'CmdEvm',
		'CmdEvt',
		'CmdEvtwt',
		'CmdFc',
		'CmdFg',
		'CmdFl',
		'CmdFn',
		'CmdFo',
		'CmdFr',
		'CmdFs',
		'CmdFw',
		'CmdGdc',
		'CmdGpw',
		'CmdHalt',
		'CmdHc',
		'CmdHelp',
		'CmdHp',
		'CmdHwver',
		'CmdI2cC',
		'CmdI2cO',
		'CmdI2cPc',
		'CmdI2cPk',
		'CmdI2cRb',
		'CmdI2cRd',
		'CmdI2cRi',
		'CmdI2cRk',
		'CmdI2cRs',
		'CmdI2cRw',
		'CmdI2cWb',
		'CmdI2cWd',
		'CmdI2cWi',
		'CmdI2cWk',
		'CmdI2cWq',
		'CmdI2cWs',
		'CmdI2cWw',
		'CmdI2cZ',
		'CmdInr',
		'CmdInra',
		'CmdInterrupted',
		'CmdJm',
		'CmdJmp',
		'CmdJnz',
		'CmdJp',
		'CmdJz',
		'CmdLd',
		'CmdLda',
		'CmdLdab',
		'CmdMics',
		'CmdMils',
		'CmdMlt',
		'CmdMod',
		'CmdModeg',
		'CmdModes',
		'CmdNb',
		'CmdNc',
		'CmdNo',
		'CmdNoib',
		'CmdNop',
		'CmdNp',
		'CmdOr',
		'CmdPadg',
		'CmdPads',
		'CmdParse',
		'CmdPfg',
		'CmdPfs',
		'CmdPigpv',
		'CmdPop',
		'CmdPopa',
		'CmdPrg',
		'CmdProc',
		'CmdProcd',
		'CmdProcp',
		'CmdProcr',
		'CmdProcs',
		'CmdProcu',
		'CmdPrrg',
		'CmdPrs',
		'CmdPud',
		'CmdPush',
		'CmdPusha',
		'CmdPwm',
		'CmdRead',
		'CmdRet',
		'CmdRl',
		'CmdRla',
		'CmdRr',
		'CmdRra',
		'CmdScript',
		'CmdSerc',
		'CmdSerda',
		'CmdSero',
		'CmdSerr',
		'CmdSerrb',
		'CmdServo',
		'CmdSerw',
		'CmdSerwb',
		'CmdShell',
		'CmdSlr',
		'CmdSlrc',
		'CmdSlri',
		'CmdSlro',
		'CmdSpic',
		'CmdSpio',
		'CmdSpir',
		'CmdSpiw',
		'CmdSpix',
		'CmdSta',
		'CmdStab',
		'CmdSub',
		'CmdSys',
		'CmdTag',
		'CmdTick',
		'CmdTrig',
		'CmdWait',
		'CmdWdog',
		'CmdWrite',
		'CmdWvag',
		'CmdWvas',
		'CmdWvbsy',
		'CmdWvcha',
		'CmdWvclr',
		'CmdWvcre',
		'CmdWvdel',
		'CmdWvgo',
		'CmdWvgor',
		'CmdWvhlt',
		'CmdWvnew',
		'CmdWvsc',
		'CmdWvsm',
		'CmdWvsp',
		'CmdWvtat',
		'CmdWvtx',
		'CmdWvtxm',
		'CmdWvtxr',
		'CmdX',
		'CmdXa',
		'CmdXor',
		'CtrlRegister1',
		'CtrlRegister2',
		'CtrlRegister3',
		'CustomErr0',
		'CustomErr999',
		'DefaultBufferMillis',
		'DefaultCfgInternals',
		'DefaultClkMicros',
		'DefaultClkPeripheral',
		'DefaultDmaChannel',
		'DefaultDmaPrimaryChannel',
		'DefaultDmaSecondaryChannel',
		'DefaultForeground',
		'DefaultIfFlags',
		'DefaultMemAllocMode',
		'DefaultSocketAddrStr',
		'DefaultSocketPort',
		'DefaultSocketPortStr',
		'DefaultUpdateMaskAB2',
		'DefaultUpdateMaskAplusBplus',
		'DefaultUpdateMaskB1',
		'DefaultUpdateMaskCompute',
		'DefaultUpdateMaskPi2B',
		'DefaultUpdateMaskPi3B',
		'DefaultUpdateMaskUnknown',
		'DefaultUpdateMaskZero',
		'Deprecated',
		'DisableFifoIf',
		'DisableSockIf',
		'DisableAlert',
		'DupTag',
		'EitherEdge',
		'EmptyWaveform',
		'EventBsc',
		'FallingEdge',
		'FifoCtrlRegister',
		'FileAppend',
		'FileCreate',
		'FileIsADir',
		'FileNotROpen',
		'FileNotWOpen',
		'FileRead',
		'FileRW',
		'FileTrunc',
		'FileWrite',
		'FileOpenFailed',
		'FromCurrent',
		'FromEnd',
		'FromStart',
		'GpioAlt0',
		'GpioAlt1',
		'GpioAlt2',
		'GpioAlt3',
		'GpioAlt4',
		'GpioAlt5',
		'GpioBadCallback',
		'GpioCallbackNotFound',
		'GpioBadConnect',
		'GpioBadDuplicateCallback',
		'GpioBadDutyCycle',
		'GpioBadDutyRange',
		'GpioBadFlags',
		'GpioBadGetAddrInfo',
		'GpioBadGpio',
		'GpioBadHandle',
		'GpioBadI2cAddr',
		'GpioBadI2cBus',
		'GpioBadLevel',
		'GpioBadMalloc',
		'GpioBadMode',
		'GpioBadNoib',
		'GpioBadNotifyFailed',
		'GpioBadParam',
		'GpioBadPointer',
		'GpioBadPud',
		'GpioBadPulseWidth',
		'GpioBadRecv',
		'GpioBadSend',
		'GpioBadSocket',
		'GpioBadSpiChannel',
		'GpioBadSpiCount',
		'GpioBadSPISpeed',
		'GpioBadTooManyPis',
		'GpioBadUnConnectedPi',
		'GpioBadUserGpio',
		'GpioBadWaveId',
		'GpioBadWaveMode',
		'GpioClear',
		'GpioEmptyWaveform',
		'GpioEmptyWaveformId',
		'GpioHigh',
		'GpioI2cOpenFailed',
		'GpioI2cReadFailed',
		'GpioI2cWriteFailed',
		'GpioInput',
		'GpioInUse',
		'GpioLow',
		'GpioMaxDutyRange',
		'GpioMinDutyRange',
		'GpioNoAuxSPI',
		'GpioNoHandle',
		'GpioNotPermitted',
		'GpioNotPwmGpio',
		'GpioNotServoGpio',
		'GpioNoWaveformId',
		'GpioOff',
		'GpioOn',
		'GpioOutput',
		'GpioPudDown',
		'GpioPudOff',
		'GpioPudUp',
		'GpioSet',
		'GpioSPIOpenFailed',
		'GpioSPIXferFailed',
		'GpioTooManyCBS',
		'GpioTooManyOOL',
		'GpioTooManyPulses',
		'GyroCtrlRegister1',
		'GyroCtrlRegister3',
		'GyroCtrlRegister6',
		'GyroCtrlRegister7',
		'GyroXOutputRegister',
		'GyroYOutputRegister',
		'GyroZOutputRegister',
		'H0HRegister',
		'H0T0OutRegister',
		'H1HRegister',
		'H1T0OutRegister',
		'HpwmIllegal',
		'HumidityOutRegister',
		'HwClkMaxFreq',
		'HwClkMinFreq',
		'HwPwmMaxFreq',
		'HwPwmMinFreq',
		'HwPwmRange',
		'I2cOpenFailed',
		'I2cReadFailed',
		'I2cWriteFailed',
		'InitFailed',
		'Initialised',
		'IOCON_HAEN',
		'IOCON_INIT',
		'LedControlRegister1',
		'LedControlRegister2',
		'LedControlRegister3',
		'LocalhostSockIf',
		'MagnetometerCtrlRegister1',
		'MagnetometerCtrlRegister2',
		'MagnetometerCtrlRegister3',
		'MagnetometerXOutputRegister',
		'MagnetometerYOutputRegister',
		'MagnetometerZOutputRegister',
		'MaxServoPulsewidth',
		'MaxWatchDogTimeout',
		'MaxWaveCycles',
		'MaxWaveDatabits',
		'MaxWaveDelay',
		'MaxWaveHalfstopbits',
		'MaxWaves',
		'Mcp23x17GpioA',
		'Mcp23x17GpioB',
		'Mcp23x17GpioPUA',
		'Mcp23x17GpioPUB',
		'Mcp23x17IOCON',
		'Mcp23x17IOCONB',
		'Mcp23x17IODirA',
		'Mcp23x17IODirB',
		'Mcp23x17OLatA',
		'Mcp23x17OLatB',
		'MemAllocAuto',
		'MemAllocMailbox',
		'MemAllocPagemap',
		'MinServoPulsewidth',
		'MinWatchDogTimeout',
		'MinWaveDatabits',
		'MinWaveHalfstopbits',
		'MsgToobig',
		'NoAlertFunc',
		'NoAuxSpi',
		'NoFileAccess',
		'NoFileMatch',
		'NoHandle',
		'NoMemory',
		'NoScriptRoom',
		'NotHalted',
		'NotHclkGpio',
		'NotHpwmGpio',
		'NotI2cGpio',
		'NotifySlots',
		'NotInitialised',
		'NotPermitted',
		'NotPwmGpio',
		'NotSerialGpio',
		'NotServoGpio',
		'NotSpiGpio',
		'NoTxWave',
		'NoWaveformId',
		'NtfyFlagsAlive',
		'NtfyFlagsEvent',
		'NtfyFlagsWatchDog',
		'PigifErr0',
		'PigifErr99',
		'PressureOutRegister',
		'PWMRegister',
		'RisingEdge',
		'ScriptIniting',
		'ScriptHalted',
		'ScriptFailed',
		'ScriptNotReady',
		'ScriptRunning',
		'ScriptWaiting',
		'SerOpenFailed',
		'SerReadFailed',
		'SerReadNoData',
		'ServoOff',
		'SerWriteFailed',
		'ShutdownRegister',
		'SockReadFailed',
		'SockWritFailed',
		'SomePermitted',
		'SpiCmdRead',
		'SpiCmdWrite',
		'SpiMaxBaud',
		'SpiMinBaud',
		'SpiOpenFailed',
		'SpiXferFailed',
		'StatusRegister',
		'T0degCRegister',
		'T0OutRegister',
		'T1degCRegister',
		'T1OutRegister',
		'T1T0MSBRegister',
		'TempHumidityOutRegister',
		'TempPressureOutRegister',
		'TimeAbsolute',
		'Timeout',
		'TimeRelative',
		'TimerFailed',
		'TooManyCbs',
		'TooManyChars',
		'TooManyOol',
		'TooManyParam',
		'TooManyPulses',
		'TooManySegs',
		'TooManyTags',
		'UnknownCommand',
		'UpdateRegister',
		'WaveCountPages',
		'WaveMaxBaud',
		'WaveMaxMicros',
		'WaveMinBaud',
		'WaveModeOneShot',
		'WaveModeOneShotSync',
		'WaveModeRepeat',
		'WaveModeRepeatSync',
		'WaveNotFound',
		'WhoAmIRegister'
	],
	#type : 'variable',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Initializing' }
RaspberryGpioConstants class >> initialize [
	AccelerometerXOutputRegister := 16r28.
	AccelerometerYOutputRegister := 16r2A.
	AccelerometerZOutputRegister := 16r2C.
	ADSConfigRegister := 1.
	ADSConversionRegister := 0.
	AvConfRegister := 16.
	BadBufMillis := -20.
	BadCfgInternal := -34.
	BadChainCmd := -116.
	BadChainDelay := -117.
	BadChainLoop := -114.
	BadChannel := -27.
	BadClkMicros := -19.
	BadClkPeriph := -17.
	BadClkSource := -18.
	BadDatabits := -101.
	BadEdge := -122.
	BadEventId := -143.
	BadFifoCommand := -29.
	BadFileFlag := -130.
	GpioBadFileMode := -129.
	GpioBadFileRead := -131.
	GpioBadFileSeek := -135.
	GpioBadFileWrite := -132.
	BadFilter := -125.
	BadForever := -124.
	BadGpio := -3.
	BadHclkFreq := -98.
	BadHclkPass := -99.
	BadHpwmDuty := -97.
	BadHpwmFreq := -96.
	BadI2cAddr := -75.
	BadI2cBaud := -112.
	BadI2cBus := -74.
	BadI2cCmd := -111.
	BadI2cRlen := -110.
	BadI2cSeg := -106.
	BadI2cWLen := -109.
	BadIfFlags := -26.
	BadIsrInit := -123.
	BadLevel := -5.
	BadMallocMode := -104.
	BadMicros := -13.
	BadMicsDelay := -64.
	BadMilsDelay := -65.
	BadMode := -4.
	BadMs := -10.
	BadPad := -126.
	BadParam := -81.
	BadParamNum := -52.
	BadPathname := -23.
	BadPointer := -90.
	BadPrimChannel := -27.
	BadPud := -6.
	BadPulselen := -46.
	BadPulsewidth := -7.
	BadScript := -47.
	BadScriptCmd := -55.
	BadScriptId := -48.
	BadScriptName := -140.
	BadSecoChannel := -30.
	BadSeconds := -12.
	BadSerDevice := -79.
	BadSerialBuf := -40.
	BadSerialCount := -51.
	BadSerialStruc := -39.
	BadSerInvert := -121.
	BadSerOffset := -49.
	BadSerSpeed := -80.
	BadShellStatus := -139.
	BadSignum := -22.
	BadSmbusCmd := -107.
	BadSocketPort := -28.
	BadSpiBaud := -141.
	BadSpiSpeed := -78.
	BadStopbits := -102.
	BadStrength := -127.
	BadTag := -63.
	BadTimer := -9.
	BadTimeType := -11.
	BadUserGpio := -2.
	BadVarNum := -56.
	BadWaveBaud := -35.
	BadWaveId := -66.
	BadWaveMode := -33.
	BadWDogTimeout := -15.
	BadWvscCommnd := -43.
	BadWvsmCommnd := -44.
	BadWvspCommnd := -45.
	BbI2cMaxBaud := 500000.
	BbI2cMinBaud := 50.
	BbSerInvert := 1.
	BbSerMaxBaud := 250000.
	BbSerMinBaud := 50.
	BbSerNormal := 0.
	BbSpiMaxBaud := 250000.
	BbSpiMinBaud := 50.
	ChainCounter := -115.
	ChainLoopCnt := -113.
	ChainNesting := -118.
	ChainTooBig := -119.
	ClockPcm := 1.
	ClockPwm := 0.
	CmdAdd := 800.
	CmdAnd := 801.
	CmdBc1 := 12.
	CmdBc2 := 13.
	CmdBi2Cc := 89.
	CmdBi2Co := 90.
	CmdBi2Cz := 91.
	CmdBr1 := 10.
	CmdBr2 := 11.
	CmdBs1 := 14.
	CmdBs2 := 15.
	CmdBscx := 114.
	CmdBspic := 111.
	CmdBspio := 112.
	CmdBspix := 113.
	CmdCall := 802.
	CmdCf1 := 87.
	CmdCf2 := 88.
	CmdCgi := 95.
	CmdCmdr := 803.
	CmdCmdw := 804.
	CmdCmp := 805.
	CmdCsi := 96.
	CmdDcr := 806.
	CmdDcra := 807.
	CmdDiv := 808.
	CmdEvm := 115.
	CmdEvt := 116.
	CmdEvtwt := 842.
	CmdFc := 105.
	CmdFg := 97.
	CmdFl := 109.
	CmdFn := 98.
	CmdFo := 104.
	CmdFr := 106.
	CmdFs := 108.
	CmdFw := 107.
	CmdGdc := 83.
	CmdGpw := 84.
	CmdHalt := 809.
	CmdHc := 85.
	CmdHelp := 25.
	CmdHp := 86.
	CmdHwver := 17.
	CmdI2cC := 55.
	CmdI2cO := 54.
	CmdI2cPc := 69.
	CmdI2cPk := 70.
	CmdI2cRb := 61.
	CmdI2cRd := 56.
	CmdI2cRi := 67.
	CmdI2cRk := 65.
	CmdI2cRs := 59.
	CmdI2cRw := 63.
	CmdI2cWb := 62.
	CmdI2cWd := 57.
	CmdI2cWi := 68.
	CmdI2cWk := 66.
	CmdI2cWq := 58.
	CmdI2cWs := 60.
	CmdI2cWw := 64.
	CmdI2cZ := 92.
	CmdInr := 810.
	CmdInra := 811.
	CmdInterrupted := -144.
	CmdJm := 812.
	CmdJmp := 813.
	CmdJnz := 814.
	CmdJp := 815.
	CmdJz := 816.
	CmdLd := 818.
	CmdLda := 819.
	CmdLdab := 820.
	CmdMics := 46.
	CmdMils := 47.
	CmdMlt := 821.
	CmdMod := 822.
	CmdModeg := 1.
	CmdModes := 0.
	CmdNb := 19.
	CmdNc := 21.
	CmdNo := 18.
	CmdNoib := 99.
	CmdNop := 823.
	CmdNp := 20.
	CmdOr := 824.
	CmdPadg := 103.
	CmdPads := 102.
	CmdParse := 48.
	CmdPfg := 23.
	CmdPfs := 7.
	CmdPigpv := 26.
	CmdPop := 825.
	CmdPopa := 826.
	CmdPrg := 22.
	CmdProc := 38.
	CmdProcd := 39.
	CmdProcp := 45.
	CmdProcr := 40.
	CmdProcs := 41.
	CmdProcu := 117.
	CmdPrrg := 24.
	CmdPrs := 6.
	CmdPud := 2.
	CmdPush := 827.
	CmdPusha := 828.
	CmdPwm := 5.
	CmdRead := 3.
	CmdRet := 829.
	CmdRl := 830.
	CmdRla := 831.
	CmdRr := 832.
	CmdRra := 833.
	CmdScript := 800.
	CmdSerc := 77.
	CmdSerda := 82.
	CmdSero := 76.
	CmdSerr := 80.
	CmdSerrb := 78.
	CmdServo := 8.
	CmdSerw := 81.
	CmdSerwb := 79.
	CmdShell := 110.
	CmdSlr := 43.
	CmdSlrc := 44.
	CmdSlri := 94.
	CmdSlro := 42.
	CmdSpic := 72.
	CmdSpio := 71.
	CmdSpir := 73.
	CmdSpiw := 74.
	CmdSpix := 75.
	CmdSta := 834.
	CmdStab := 835.
	CmdSub := 836.
	CmdSys := 837.
	CmdTag := 817.
	CmdTick := 16.
	CmdTrig := 37.
	CmdWait := 838.
	CmdWdog := 9.
	CmdWrite := 4.
	CmdWvag := 28.
	CmdWvas := 29.
	CmdWvbsy := 32.
	CmdWvcha := 93.
	CmdWvclr := 27.
	CmdWvcre := 49.
	CmdWvdel := 50.
	CmdWvgo := 30.
	CmdWvgor := 31.
	CmdWvhlt := 33.
	CmdWvnew := 53.
	CmdWvsc := 36.
	CmdWvsm := 34.
	CmdWvsp := 35.
	CmdWvtat := 101.
	CmdWvtx := 51.
	CmdWvtxm := 100.
	CmdWvtxr := 52.
	CmdX := 839.
	CmdXa := 840.
	CmdXor := 841.
	CtrlRegister1 := 32.
	CtrlRegister2 := 33.
	CtrlRegister3 := 34.
	CustomErr0 := -3000.
	CustomErr999 := -3999.
	DefaultBufferMillis := 120.
	DefaultCfgInternals := 0.
	DefaultClkMicros := 5.
	DefaultClkPeripheral := 1.
	DefaultDmaChannel := 14.
	DefaultDmaPrimaryChannel := 14.
	DefaultDmaSecondaryChannel := 6.
	DefaultForeground := 0.
	DefaultIfFlags := 0.
	DefaultMemAllocMode := 0.
	DefaultSocketAddrStr := '127.0.0.1'.
	DefaultSocketPort := 8888.
	DefaultSocketPortStr := '8888'.
	DefaultUpdateMaskAB2 := 16rFBC7CF9C.
	DefaultUpdateMaskAplusBplus := 16r0080480FFFFFFC.
	DefaultUpdateMaskB1 := 16r03E7CF93.
	DefaultUpdateMaskCompute := 16r00FFFFFFFFFFFF.
	DefaultUpdateMaskPi2B := 16r0080480FFFFFFC.
	DefaultUpdateMaskPi3B := 16r0000000FFFFFFC.
	DefaultUpdateMaskUnknown := 16r0000000FFFFFFC.
	DefaultUpdateMaskZero := 16r0080000FFFFFFC.
	Deprecated := -120.
	DisableFifoIf := 1.
	DisableSockIf := 2.
	DisableAlert := 8.
	DupTag := -53.
	EitherEdge := 2.
	EmptyWaveform := -69.
	EventBsc := 31.
	FallingEdge := 1.
	FifoCtrlRegister := 46.
	FileAppend := 4.
	FileCreate := 8.
	FileIsADir := -138.
	FileNotROpen := -133.
	FileNotWOpen := -134.
	FileRead := 1.
	FileRW := 3.
	FileTrunc := 16.
	FileWrite := 2.
	FileOpenFailed := -128.
	FromCurrent := 1.
	FromEnd := 2.
	FromStart := 0.
	GpioAlt0 := 4.
	GpioAlt1 := 5.
	GpioAlt2 := 6.
	GpioAlt3 := 7.
	GpioAlt4 := 3.
	GpioAlt5 := 2.
	GpioBadCallback := -2008.
	GpioCallbackNotFound := -2010.
	GpioBadConnect := -2003.
	GpioBadDuplicateCallback := -2006.
	GpioBadDutyCycle := -8.
	GpioBadDutyRange := -21.
	GpioBadFlags := -77.
	GpioBadGetAddrInfo := -2002.
	GpioBadGpio := -3.
	GpioBadHandle := -25.
	GpioBadI2cAddr := -75.
	GpioBadI2cBus := -74.
	GpioBadLevel := -5.
	GpioBadMalloc := -2007.
	GpioBadMode := -4.
	GpioBadNoib := -2005.
	GpioBadNotifyFailed := -2009.
	GpioBadParam := -79.
	GpioBadPointer := -90.
	GpioBadPud := -6.
	GpioBadPulseWidth := -7.
	GpioBadRecv := -2001.
	GpioBadSend := -2000.
	GpioBadSocket := -2004.
	GpioBadSpiChannel := -76.
	GpioBadSpiCount := -84.
	GpioBadSPISpeed := -78.
	GpioBadTooManyPis := -2012.
	GpioBadUnConnectedPi := -2011.
	GpioBadUserGpio := -2.
	GpioBadWaveId := -66.
	GpioBadWaveMode := -33.
	GpioClear := 0.
	GpioEmptyWaveform := -69.
	GpioEmptyWaveformId := -70.
	GpioHigh := 1.
	GpioI2cOpenFailed := -71.
	GpioI2cReadFailed := -83.
	GpioI2cWriteFailed := -82.
	GpioInput := 0.
	GpioInUse := -50.
	GpioLow := 0.
	GpioMaxDutyRange := 40000.
	GpioMinDutyRange := 25.
	GpioNoAuxSPI := -91.
	GpioNoHandle := -24.
	GpioNotPermitted := -41.
	GpioNotPwmGpio := -92.
	GpioNotServoGpio := -93.
	GpioNoWaveformId := -70.
	GpioOff := 0.
	GpioOn := 1.
	GpioOutput := 1.
	GpioPudDown := 1.
	GpioPudOff := 0.
	GpioPudUp := 2.
	GpioSet := 1.
	GpioSPIOpenFailed := -71.
	GpioSPIXferFailed := -89.
	GpioTooManyCBS := -67.
	GpioTooManyOOL := -68.
	GpioTooManyPulses := -36.
	GyroCtrlRegister1 := 16r10.
	GyroCtrlRegister3 := 16r12.
	GyroCtrlRegister6 := 16r20.
	GyroCtrlRegister7 := 16r21.
	GyroXOutputRegister := 16r18.
	GyroYOutputRegister := 16r1A.
	GyroZOutputRegister := 16r1C.
	H0HRegister := 48.
	H0T0OutRegister := 54.
	H1HRegister := 49.
	H1T0OutRegister := 58.
	HpwmIllegal := -100.
	HumidityOutRegister := 40.
	HwClkMaxFreq := 250000000.
	HwClkMinFreq := 4689.
	HwPwmMaxFreq := 125000000.
	HwPwmMinFreq := 1.
	HwPwmRange := 1000000.
	I2cOpenFailed := -71.
	I2cReadFailed := -83.
	I2cWriteFailed := -82.
	InitFailed := -1.
	Initialised := -32.
	IOCON_HAEN := 8.
	IOCON_INIT := 16r20.
	LedControlRegister1 := 16r13.
	LedControlRegister2 := 16r14.
	LedControlRegister3 := 16r15.
	LocalhostSockIf := 4.
	MagnetometerCtrlRegister1 := 32.
	MagnetometerCtrlRegister2 := 33.
	MagnetometerCtrlRegister3 := 34.
	MagnetometerXOutputRegister := 16r28.
	MagnetometerYOutputRegister := 16r2A.
	MagnetometerZOutputRegister := 16r2C.
	MaxServoPulsewidth := 2500.
	MaxWatchDogTimeout := 60000.
	MaxWaveCycles := 65535.
	MaxWaveDatabits := 32.
	MaxWaveDelay := 65535.
	MaxWaveHalfstopbits := 8.
	MaxWaves := 250.
	Mcp23x17GpioA := 16r12.
	Mcp23x17GpioB := 16r13.
	Mcp23x17GpioPUA := 16r0C.
	Mcp23x17GpioPUB := 16r0D.
	Mcp23x17IOCON := 16r0A.
	Mcp23x17IOCONB := 16r0B.
	Mcp23x17IODirA := 0.
	Mcp23x17IODirB := 1.
	Mcp23x17OLatA := 16r14.
	Mcp23x17OLatB := 16r15.
	MemAllocAuto := 0.
	MemAllocMailbox := 2.
	MemAllocPagemap := 1.
	MinServoPulsewidth := 500.
	MinWatchDogTimeout := 0.
	MinWaveDatabits := 1.
	MinWaveHalfstopbits := 2.
	MsgToobig := -103.
	NoAlertFunc := -16.
	NoAuxSpi := -91.
	NoFileAccess := -137.
	NoFileMatch := -136.
	NoHandle := -24.
	NoMemory := -58.
	NoScriptRoom := -57.
	NotHalted := -62.
	NotHclkGpio := -94.
	NotHpwmGpio := -95.
	NotI2cGpio := -108.
	NotifySlots := 32.
	NotInitialised := -31.
	NotPermitted := -41.
	NotPwmGpio := -92.
	NotSerialGpio := -38.
	NotServoGpio := -93.
	NotSpiGpio := -142.
	NoTxWave := 9999.
	NoWaveformId := -70.
	NtfyFlagsAlive := 2r01000000.
	NtfyFlagsEvent := 2r10000000.
	NtfyFlagsWatchDog := 2r00100000.
	PigifErr0 := -2000.
	PigifErr99 := -2099.
	PressureOutRegister := 40.
	PWMRegister := 0.
	RisingEdge := 0.
	ScriptIniting := 0.
	ScriptHalted := 1.
	ScriptFailed := 4.
	ScriptNotReady := -62.
	ScriptRunning := 2.
	ScriptWaiting := 3.
	SerOpenFailed := -72.
	SerReadFailed := -86.
	SerReadNoData := -87.
	ServoOff := 0.
	SerWriteFailed := -85.
	ShutdownRegister := 0.
	SockReadFailed := -59.
	SockWritFailed := -60.
	SomePermitted := -42.
	SpiCmdRead := 16r41.
	SpiCmdWrite := 16r40.
	SpiMaxBaud := 125000000.
	SpiMinBaud := 32000.
	SpiOpenFailed := -73.
	SpiXferFailed := -89.
	StatusRegister := 39.
	T0degCRegister := 50.
	T0OutRegister := 60.
	T1degCRegister := 51.
	T1OutRegister := 62.
	T1T0MSBRegister := 53.
	TempHumidityOutRegister := 42.
	TempPressureOutRegister := 43.
	TimeAbsolute := 1.
	Timeout := 2.
	TimeRelative := 0.
	TimerFailed := -14.
	TooManyCbs := -67.
	TooManyChars := -37.
	TooManyOol := -68.
	TooManyParam := -61.
	TooManyPulses := -36.
	TooManySegs := -105.
	TooManyTags := -54.
	UnknownCommand := -88.
	UpdateRegister := 16r16.
	WaveCountPages := 10.
	WaveMaxBaud := 1000000.
	WaveMaxMicros := 1800000000.
	WaveMinBaud := 50.
	WaveModeOneShot := 0.
	WaveModeOneShotSync := 2.
	WaveModeRepeat := 1.
	WaveModeRepeatSync := 3.
	WaveNotFound := 9998.
	WhoAmIRegister := 15.

]
