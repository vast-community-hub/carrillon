Package {
	#name : 'RaspberryHardwareInterfaceCoreApp',
	#vaPrerequisites : ['UNIXProcesses'],
	#vaSubApplications : [	{		#condition : 'true',		#subapps : [			'OneWireDevicesSubApp',			'RaspberryHardwareInterfaceSubApp',			'RaspberryHardwareInterfaceViaDaemonSubApp'		]	}]
}
