Class {
	#name : 'RaspberryGpioDaemonFunctions',
	#superclass : 'SharedPool',
	#classVars : [
		'BbI2cClose',
		'BbI2cOpen',
		'BbI2cZip',
		'BbSerialInvert',
		'BbSerialRead',
		'BbSerialReadClose',
		'BbSerialReadOpen',
		'BbSpiClose',
		'BbSpiOpen',
		'BbSpiXfer',
		'BscI2c',
		'BscXfer',
		'Callback',
		'CallbackCancel',
		'CallbackEx',
		'ClearBank1',
		'ClearBank2',
		'Custom1',
		'Custom2',
		'DeleteScript',
		'EventCallback',
		'EventCallbackCancel',
		'EventCallbackEx',
		'EventTrigger',
		'FileClose',
		'FileList',
		'FileOpen',
		'FileRead',
		'FileSeek',
		'FileWrite',
		'GetCurrentTick',
		'GetHardwareRevision',
		'GetMode',
		'GetPadStrength',
		'GetPwmDutycycle',
		'GetPwmFrequency',
		'GetPwmRange',
		'GetPwmRealRange',
		'GetRaspberryGpioVersion',
		'GetServoPulseWidth',
		'GpioRead',
		'GpioTrigger',
		'GpioWrite',
		'HardwareClock',
		'HardwarePwm',
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
		'I2cWriteBlockData',
		'I2cWriteByte',
		'I2cWriteByteData',
		'I2cWriteDevice',
		'I2cWriteI2cBlockData',
		'I2cWriteQuick',
		'I2cWriteWordData',
		'I2cZip',
		'NotifyBegin',
		'NotifyClose',
		'NotifyOpen',
		'NotifyPause',
		'RaspberryGpioDaemonStart',
		'RaspberryGpioDaemonStop',
		'RaspberryGpioDaemonVersion',
		'RaspberryGpioError',
		'ReadBank1',
		'ReadBank2',
		'RunScript',
		'ScriptStatus',
		'SerialClose',
		'SerialDataAvailable',
		'SerialOpen',
		'SerialRead',
		'SerialReadByte',
		'SerialWrite',
		'SerialWriteByte',
		'SetBank1',
		'SetBank2',
		'SetGlitchFilter',
		'SetMode',
		'SetNoiseFilter',
		'SetPadStrength',
		'SetPullUpDown',
		'SetPwmDutycycle',
		'SetPwmFrequency',
		'SetPwmRange',
		'SetServoPulseWidth',
		'SetWatchDog',
		'Shell',
		'SpiClose',
		'SpiOpen',
		'SpiRead',
		'SpiWrite',
		'SpiXfer',
		'StartThread',
		'StopScript',
		'StopThread',
		'StoreScript',
		'TimeSleep',
		'TimeTime',
		'UpdateScript',
		'WaitForEdge',
		'WaitForEvent',
		'WaveAddGeneric',
		'WaveAddNew',
		'WaveAddSerial',
		'WaveChain',
		'WaveClear',
		'WaveCreate',
		'WaveDelete',
		'WaveGetCbs',
		'WaveGetHighCbs',
		'WaveGetHighMicros',
		'WaveGetHighPulses',
		'WaveGetMaxCbs',
		'WaveGetMaxMicros',
		'WaveGetMaxPulses',
		'WaveGetMicros',
		'WaveGetPulses',
		'WaveSendOnce',
		'WaveSendRepeat',
		'WaveSendUsingMode',
		'WaveTxAt',
		'WaveTxBusy',
		'WaveTxStop'
	],
	#type : 'variable',
	#category : 'RaspberryHardwareInterfaceCoreApp'
}

{ #category : 'Initializing' }
RaspberryGpioDaemonFunctions class >> initialize [
	BbI2cClose := PlatformFunction fromArray: #('C' 'bb_i2c_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	BbI2cOpen := PlatformFunction fromArray: #('C' 'bb_i2c_open' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	BbI2cZip := PlatformFunction fromArray: #('C' 'bb_i2c_zip' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32 #pointer #uint32) #int32).
	BbSerialInvert := PlatformFunction fromArray: #('C' 'bb_serial_invert' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	BbSerialRead := PlatformFunction fromArray: #('C' 'bb_serial_read' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	BbSerialReadClose := PlatformFunction fromArray: #('C' 'bb_serial_read_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	BbSerialReadOpen := PlatformFunction fromArray: #('C' 'bb_serial_read_open' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	BbSpiClose := PlatformFunction fromArray: #('C' 'bb_spi_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	BbSpiOpen := PlatformFunction fromArray: #('C' 'bb_spi_open' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32 #uint32 #uint32 #uint32) #int32).
	BbSpiXfer := PlatformFunction fromArray: #('C' 'bb_spi_xfer' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #pointer #uint32) #int32).
	BscI2c := PlatformFunction fromArray: #('C' 'bsc_i2c' nil 'RaspberryGpioDaemon' #(#int32 #int32 #pointer) #int32).
	BscXfer := PlatformFunction fromArray: #('C' 'bsc_xfer' nil 'RaspberryGpioDaemon' #(#int32 #pointer) #int32).
	Callback := PlatformFunction fromArray: #('C' 'callback' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer) #int32).
	CallbackCancel := PlatformFunction fromArray: #('C' 'callback_cancel' nil 'RaspberryGpioDaemon' #(#uint32) #int32).
	CallbackEx := PlatformFunction fromArray: #('C' 'callback_ex' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #pointer) #int32).
	ClearBank1 := PlatformFunction fromArray: #('C' 'clear_bank_1' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	ClearBank2 := PlatformFunction fromArray: #('C' 'clear_bank_2' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	Custom1 := PlatformFunction fromArray: #('C' 'custom_1' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #uint32) #int32).
	Custom2 := PlatformFunction fromArray: #('C' 'custom_2' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32 #pointer #uint32) #int32).
	DeleteScript := PlatformFunction fromArray: #('C' 'delete_script' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	EventCallback := PlatformFunction fromArray: #('C' 'event_callback' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer) #int32).
	EventCallbackCancel := PlatformFunction fromArray: #('C' 'event_callback_cancel' nil 'RaspberryGpioDaemon' #(#uint32) #int32).
	EventCallbackEx := PlatformFunction fromArray: #('C' 'event_callback_ex' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #pointer) #int32).
	EventTrigger := PlatformFunction fromArray: #('C' 'event_trigger' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	FileClose := PlatformFunction fromArray: #('C' 'file_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	FileList := PlatformFunction fromArray: #('C' 'file_list' nil 'RaspberryGpioDaemon' #(#int32 #pointer #pointer #uint32) #int32).
	FileOpen := PlatformFunction fromArray: #('C' 'file_open' nil 'RaspberryGpioDaemon' #(#int32 #pointer #uint32) #int32).
	FileRead := PlatformFunction fromArray: #('C' 'file_read' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	FileSeek := PlatformFunction fromArray: #('C' 'file_seek' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #int32 #int32) #int32).
	FileWrite := PlatformFunction fromArray: #('C' 'file_write' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	GetCurrentTick := PlatformFunction fromArray: #('C' 'get_current_tick' nil 'RaspberryGpioDaemon' #(#int32) #uint32).
	GetHardwareRevision := PlatformFunction fromArray: #('C' 'get_hardware_revision' nil 'RaspberryGpioDaemon' #(#int32) #uint32).
	GetMode := PlatformFunction fromArray: #('C' 'get_mode' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetPadStrength := PlatformFunction fromArray: #('C' 'get_pad_strength' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetPwmDutycycle := PlatformFunction fromArray: #('C' 'get_PWM_dutycycle' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetPwmFrequency := PlatformFunction fromArray: #('C' 'get_PWM_frequency' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetPwmRange := PlatformFunction fromArray: #('C' 'get_PWM_range' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetPwmRealRange := PlatformFunction fromArray: #('C' 'get_PWM_real_range' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GetRaspberryGpioVersion := PlatformFunction fromArray: #('C' 'get_pigpio_version' nil 'RaspberryGpioDaemon' #(#int32) #uint32).
	GetServoPulseWidth := PlatformFunction fromArray: #('C' 'get_servo_pulsewidth' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GpioRead := PlatformFunction fromArray: #('C' 'gpio_read' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	GpioTrigger := PlatformFunction fromArray: #('C' 'gpio_trigger' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	GpioWrite := PlatformFunction fromArray: #('C' 'gpio_write' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	HardwareClock := PlatformFunction fromArray: #('C' 'hardware_clock' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	HardwarePwm := PlatformFunction fromArray: #('C' 'hardware_PWM' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	I2cBlockProcessCall := PlatformFunction fromArray: #('C' 'i2c_block_process_call' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #uint32) #int32).
	I2cClose := PlatformFunction fromArray: #('C' 'i2c_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	I2cOpen := PlatformFunction fromArray: #('C' 'i2c_open' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	I2cProcessCall := PlatformFunction fromArray: #('C' 'i2c_process_call' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	I2cReadBlockData := PlatformFunction fromArray: #('C' 'i2c_read_block_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer) #int32).
	I2cReadByte := PlatformFunction fromArray: #('C' 'i2c_read_byte' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	I2cReadByteData := PlatformFunction fromArray: #('C' 'i2c_read_byte_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	I2cReadDevice := PlatformFunction fromArray: #('C' 'i2c_read_device' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	I2cReadI2cBlockData := PlatformFunction fromArray: #('C' 'i2c_read_i2c_block_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #uint32) #int32).
	I2cReadWordData := PlatformFunction fromArray: #('C' 'i2c_read_word_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	I2cWriteBlockData := PlatformFunction fromArray: #('C' 'i2c_write_block_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #uint32) #int32).
	I2cWriteByte := PlatformFunction fromArray: #('C' 'i2c_write_byte' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	I2cWriteByteData := PlatformFunction fromArray: #('C' 'i2c_write_byte_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	I2cWriteDevice := PlatformFunction fromArray: #('C' 'i2c_write_device' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	I2cWriteI2cBlockData := PlatformFunction fromArray: #('C' 'i2c_write_i2c_block_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer #uint32) #int32).
	I2cWriteQuick := PlatformFunction fromArray: #('C' 'i2c_write_quick' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	I2cWriteWordData := PlatformFunction fromArray: #('C' 'i2c_write_word_data' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	I2cZip := PlatformFunction fromArray: #('C' 'i2c_zip' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32 #pointer #uint32) #int32).
	NotifyBegin := PlatformFunction fromArray: #('C' 'notify_begin' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	NotifyClose := PlatformFunction fromArray: #('C' 'notify_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	NotifyOpen := PlatformFunction fromArray: #('C' 'notify_open' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	NotifyPause := PlatformFunction fromArray: #('C' 'notify_pause' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	RaspberryGpioDaemonStart := PlatformFunction fromArray: #('C' 'pigpio_start' nil 'RaspberryGpioDaemon' #(#pointer #pointer) #int32).
	RaspberryGpioDaemonStop := PlatformFunction fromArray: #('C' 'pigpio_stop' nil 'RaspberryGpioDaemon' #(#int32) #void).
	RaspberryGpioDaemonVersion := PlatformFunction fromArray: #('C' 'pigpiod_if_version' nil 'RaspberryGpioDaemon' #() #uint32).
	RaspberryGpioError := PlatformFunction fromArray: #('C' 'pigpio_error' nil 'RaspberryGpioDaemon' #(#int32) #pointer).
	ReadBank1 := PlatformFunction fromArray: #('C' 'read_bank_1' nil 'RaspberryGpioDaemon' #(#int32) #uint32).
	ReadBank2 := PlatformFunction fromArray: #('C' 'read_bank_2' nil 'RaspberryGpioDaemon' #(#int32) #uint32).
	RunScript := PlatformFunction fromArray: #('C' 'run_script' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer) #int32).
	ScriptStatus := PlatformFunction fromArray: #('C' 'script_status' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer) #int32).
	SerialClose := PlatformFunction fromArray: #('C' 'serial_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SerialDataAvailable := PlatformFunction fromArray: #('C' 'serial_data_available' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SerialOpen := PlatformFunction fromArray: #('C' 'serial_open' nil 'RaspberryGpioDaemon' #(#int32 #pointer #uint32 #uint32) #int32).
	SerialRead := PlatformFunction fromArray: #('C' 'serial_read' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	SerialReadByte := PlatformFunction fromArray: #('C' 'serial_read_byte' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SerialWrite := PlatformFunction fromArray: #('C' 'serial_write' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	SerialWriteByte := PlatformFunction fromArray: #('C' 'serial_write_byte' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetBank1 := PlatformFunction fromArray: #('C' 'set_bank_1' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SetBank2 := PlatformFunction fromArray: #('C' 'set_bank_2' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SetGlitchFilter := PlatformFunction fromArray: #('C' 'set_glitch_filter' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetMode := PlatformFunction fromArray: #('C' 'set_mode' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetNoiseFilter := PlatformFunction fromArray: #('C' 'set_noise_filter' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	SetPadStrength := PlatformFunction fromArray: #('C' 'set_pad_strength' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetPullUpDown := PlatformFunction fromArray: #('C' 'set_pull_up_down' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetPwmDutycycle := PlatformFunction fromArray: #('C' 'set_PWM_dutycycle' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetPwmFrequency := PlatformFunction fromArray: #('C' 'set_PWM_frequency' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetPwmRange := PlatformFunction fromArray: #('C' 'set_PWM_range' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetServoPulseWidth := PlatformFunction fromArray: #('C' 'set_servo_pulsewidth' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	SetWatchDog := PlatformFunction fromArray: #('C' 'set_watchdog' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	Shell := PlatformFunction fromArray: #('C' 'shell_' nil 'RaspberryGpioDaemon' #(#int32 #pointer #pointer) #int32).
	SpiClose := PlatformFunction fromArray: #('C' 'spi_close' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	SpiOpen := PlatformFunction fromArray: #('C' 'spi_open' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32) #int32).
	SpiRead := PlatformFunction fromArray: #('C' 'spi_read' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	SpiWrite := PlatformFunction fromArray: #('C' 'spi_write' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #uint32) #int32).
	SpiXfer := PlatformFunction fromArray: #('C' 'spi_xfer' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer #pointer #uint32) #int32).
	StartThread := PlatformFunction fromArray: #('C' 'start_thread' nil 'RaspberryGpioDaemon' #(#pointer #pointer) #pointer).
	StopScript := PlatformFunction fromArray: #('C' 'stop_script' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	StopThread := PlatformFunction fromArray: #('C' 'stop_thread' nil 'RaspberryGpioDaemon' #(#pointer) #void).
	StoreScript := PlatformFunction fromArray: #('C' 'store_script' nil 'RaspberryGpioDaemon' #(#int32 #pointer) #int32).
	TimeSleep := PlatformFunction fromArray: #('C' 'time_sleep' nil 'RaspberryGpioDaemon' #(#double) #void).
	TimeTime := PlatformFunction fromArray: #('C' 'time_time' nil 'RaspberryGpioDaemon' #() #double).
	UpdateScript := PlatformFunction fromArray: #('C' 'update_script' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #pointer) #int32).
	WaitForEdge := PlatformFunction fromArray: #('C' 'wait_for_edge' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #double) #int32).
	WaitForEvent := PlatformFunction fromArray: #('C' 'wait_for_event' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #double) #int32).
	WaveAddGeneric := PlatformFunction fromArray: #('C' 'wave_add_generic' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #pointer) #int32).
	WaveAddNew := PlatformFunction fromArray: #('C' 'wave_add_new' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveAddSerial := PlatformFunction fromArray: #('C' 'wave_add_serial' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32 #uint32 #uint32 #uint32 #uint32 #pointer) #int32).
	WaveChain := PlatformFunction fromArray: #('C' 'wave_chain' nil 'RaspberryGpioDaemon' #(#int32 #pointer #uint32) #int32).
	WaveClear := PlatformFunction fromArray: #('C' 'wave_clear' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveCreate := PlatformFunction fromArray: #('C' 'wave_create' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveDelete := PlatformFunction fromArray: #('C' 'wave_delete' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	WaveGetCbs := PlatformFunction fromArray: #('C' 'wave_get_cbs' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetHighCbs := PlatformFunction fromArray: #('C' 'wave_get_high_cbs' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetHighMicros := PlatformFunction fromArray: #('C' 'wave_get_high_micros' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetHighPulses := PlatformFunction fromArray: #('C' 'wave_get_high_pulses' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetMaxCbs := PlatformFunction fromArray: #('C' 'wave_get_max_cbs' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetMaxMicros := PlatformFunction fromArray: #('C' 'wave_get_max_micros' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetMaxPulses := PlatformFunction fromArray: #('C' 'wave_get_max_pulses' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetMicros := PlatformFunction fromArray: #('C' 'wave_get_micros' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveGetPulses := PlatformFunction fromArray: #('C' 'wave_get_pulses' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveSendOnce := PlatformFunction fromArray: #('C' 'wave_send_once' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	WaveSendRepeat := PlatformFunction fromArray: #('C' 'wave_send_repeat' nil 'RaspberryGpioDaemon' #(#int32 #uint32) #int32).
	WaveSendUsingMode := PlatformFunction fromArray: #('C' 'wave_send_using_mode' nil 'RaspberryGpioDaemon' #(#int32 #uint32 #uint32) #int32).
	WaveTxAt := PlatformFunction fromArray: #('C' 'wave_tx_at' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveTxBusy := PlatformFunction fromArray: #('C' 'wave_tx_busy' nil 'RaspberryGpioDaemon' #(#int32) #int32).
	WaveTxStop := PlatformFunction fromArray: #('C' 'wave_tx_stop' nil 'RaspberryGpioDaemon' #(#int32) #int32).

]
