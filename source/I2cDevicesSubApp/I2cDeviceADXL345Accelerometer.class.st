"
This class provides support for the ADXL345 accelerometer sensor over I2C protocol. 

For soldering, assemblying and connecting it to the Raspberry Pi, a few tutorials have been followed and
were ueful:

- https://pinout.xyz/pinout/i2c
- https://www.hackster.io/4360/i2c-accelerometer-564b34
- https://www.sunfounder.com/learn/Super_Kit_V2_for_RaspberryPi/lesson-14-adxl345-super-kit-for-raspberrypi.html
- https://learn.adafruit.com/adxl345-digital-accelerometer/assembly-and-wiring
- https://www.sparkfun.com/datasheets/Sensors/Accelerometer/ADXL345.pdf
- http://www.pibits.net/code/raspberry-pi-adxl345-gy-291-example.php
- https://github.com/adafruit/Adafruit_CircuitPython_ADXL34x

One doubt that raised during the assembly is that some links simply ignore CS and SD0 while others
do connect CS to 3.3v and SD0 to GND. Based on one of the links we read:

CS: Connect to 3.3V (The ADXL345 actually supports both SPI and I2C protocols. To select I2C,
 we keep this pin tied to 3.3V. The datasheet contains much more information about the pin functions)
SDO: Connect to ground (In I2C mode, this pin is used to select the device address. You can attach two
 ADXL345 to the same I2C bus if you connect this pin to 3.3V on the second device. See the datasheet 
 for more details)
 
 So... because of that, we finally decided to do connect CS to 3.3v and SD0 to GND.
 
 For more details see TestI2cDeviceADXL345Accelerometer, its tests, and the examples in the class side.
"
Class {
	#name : 'I2cDeviceADXL345Accelerometer',
	#superclass : 'I2cDevice',
	#category : 'I2cDevicesSubApp'
}

{ #category : 'Not categorized' }
I2cDeviceADXL345Accelerometer class >> defaultI2CAddress [
	"You can check this by executing this in your linux:
	 
pi@marianopi3:~ $ sudo i2cdetect -y 1
	 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- 53 -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
	 "

	^16r53
]

{ #category : 'initialize-release' }
I2cDeviceADXL345Accelerometer >> initializeRegisters [
	"The code is based from C:
	https://www.sunfounder.com/learn/Super_Kit_V2_for_RaspberryPi/lesson-14-adxl345-super-kit-for-raspberrypi.html"

	bus
		register: 16r31 value: 16rB;
		register: 16r2D value: 16r08;
		register: 16r1E value: 16r00;
		register: 16r1F value: 16r00;
		register: 16r20 value: 16r00;
		register: 16r21 value: 16r00;
		register: 16r22 value: 16r00;
		register: 16r23 value: 16r00;
		register: 16r24 value: 16r01;
		register: 16r25 value: 16r0F;
		register: 16r26 value: 16r2B;
		register: 16r27 value: 16r00;
		register: 16r28 value: 16r09;
		register: 16r29 value: 16rFF;
		register: 16r2A value: 16r80;
		register: 16r2C value: 16r0A;
		register: 16r2F value: 16r00;
		register: 16r38 value: 16r9F
]

{ #category : 'API' }
I2cDeviceADXL345Accelerometer >> readCoordinates [
	"The code is based from C:
	https://www.sunfounder.com/learn/Super_Kit_V2_for_RaspberryPi/lesson-14-adxl345-super-kit-for-raspberrypi.html"

	| acc_x acc_y acc_z |

	"On the datasheet or some links online it says:
		'Digital output data is formatted as 16-bit twoâ€™s complement'
	 That's why we use #register16signed:
	 "
	acc_x := bus register16signed: 16r32.
	acc_y := bus register16signed: 16r34.
	acc_z := bus register16signed: 16r36.

	^Array with: acc_x with: acc_y with: acc_z
]
