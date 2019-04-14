# carrillon
This code runs in a Raspberry Pi Zero, and controlls an 18 bells pneumatic setup, using two [IO Pi Zero boards](https://www.abelectronics.co.uk/p/71/io-pi-zero) and then a driver module composed of triacs.

Most of the "system" is implemented in [carrillon.py], where Midi events are translated into GPIOs and also "menu options" to control the system to do things like recording a song, replaying a song, turning on and off the main air pressure pump, resetting the system or live playback.

The file [live.py] contains the mapping between Midi events and GPIO ports, and also a very crude live playback feature, mapping qwerty key presses to bells.

[IOPi.py] is a librarayr accompaning the IO Pi Zero boards.
