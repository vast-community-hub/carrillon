# carrillon
This code runs in a Raspberry Pi Zero, and controlls an 18 bells pneumatic setup, using two [IO Pi Zero boards](https://www.abelectronics.co.uk/p/71/io-pi-zero) and then a driver module composed of triacs.

Most of the "system" is implemented in [carrillon.py](carrillon.py), where Midi events are translated into GPIOs and also "menu options" to control the system to do things like recording a song, replaying a song, turning on and off the main air pressure pump, resetting the system or live playback.

The file [live.py](live.py) contains the mapping between Midi events and GPIO ports, and also a very crude live playback feature, mapping qwerty key presses to bells.

[IOPi.py](IOPi.py) is a librarayr accompaning the IO Pi Zero boards, it requires `python-smbus` to access the I2C bus.

[midi2tcp.py](midi2tcp.py) is a proxy that will create a virtual Midi port called "Carrillon" and 
then will listen on port 8383 for incoming TCP connections. When a client is connected, all incoming
Midi messages will be forwarded to the TCP connection. It can handle only 1 TCP conneciton at a time,
if a second connection is received while another client is connected, the second connection will be
honored, and the first will be closed.

The project also depends on `python-rtmidi` and uses external `aconnect`, `aplaymidi` and `arecordmidi` from package `alsa-utils` to play and record songs.
