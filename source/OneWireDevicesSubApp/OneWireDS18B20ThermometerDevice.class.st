"
A OneWireDS18B20ThermometerDevice is and interface to the Pi 1wire bus and a DS18B20 chip attached to it. 
We can read the temperature merely by sending #temperature.

Setup and installation:

We originally make the device connection following these links: 

http://www.circuitbasics.com/raspberry-pi-ds18b20-temperature-sensor-tutorial/
https://tutorials-raspberrypi.com/raspberry-pi-temperature-sensor-1wire-ds18b20/

In our case, we didn't plug the LCD screen and the R1 resistor was not necessary.

A summary of the steps where:

1) sudo raspi-config

1-wire enabled

2) Reboot

3) System Update / Upgrade

sudo apt-get update && sudo apt-get upgrade -y

4) sudo vim /boot/config.txt 

dtoverlay=w1-gpio     -> shall be enabled

5) Run:

sudo modprobe w1-gpio

sudo modprobe w1-therm

And then check the mods are present:

lsmod

6) 
cd /sys/bus/w1/devices/
ls
cat /sys/bus/w1/devices/28-020691770dfc/w1_slave

66 01 55 05 7f 7e 81 66 22 : crc=22 YES

66 01 55 05 7f 7e 81 66 22 t=22375

22375 / 100 = 22,375 °

"
Class {
	#name : 'OneWireDS18B20ThermometerDevice',
	#superclass : 'OneWireDevice',
	#category : 'OneWireDevicesSubApp'
}

{ #category : 'accessing' }
OneWireDS18B20ThermometerDevice class >> familyType [
	"which 1wire family type do I support"
	^16r28
]

{ #category : 'device values' }
OneWireDS18B20ThermometerDevice >> temperature [
	"Answer the current temperature value of this device. It is possible the device may not have reported a correct list of data, so return 999 as a placeholder"
	| file data pos tStr |

	file := CfsReadFileStream open: devFilePath.
	file isCfsError ifFalse: [
		data := file contents.
		((data indexOfSubCollection: 'YES') > 0) ifTrue: [
			pos := data indexOfSubCollection: 't='.
			(pos > 0) ifTrue: [
				tStr := data copyFrom: pos + 2 to: data size.
				^tStr asNumber / 1000.0.
			].
		].
	].
	^999.

]
