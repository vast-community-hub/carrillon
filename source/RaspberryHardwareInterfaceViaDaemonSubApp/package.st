Package {
	#name : 'RaspberryHardwareInterfaceViaDaemonSubApp',
	#vaParent : 'RaspberryHardwareInterfaceCoreApp',
	#vaSubApplications : [	{		#condition : 'true',		#subapps : [			'I2cDevicesSubApp'		]	}]
}
