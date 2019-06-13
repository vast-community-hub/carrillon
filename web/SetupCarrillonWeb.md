# Carrillon Web Interface

The very first step to get everything up and running is to clone this repository. For the sake of documentation, we will assume the path where this project was cloned is $CARRILLON_GIT_ROOT. Example:

```
git clone https://github.com/gerasdf/carrillon.git
cd carrillon
export CARRILLON_GIT_ROOT=$PWD
```

> If we refer to $CARRILLON_GIT_ROOT from within Smalltalk code, please change that to the absolute known path as we don't know if the variable will be resolved automatically

## Setup and configuration on a Linux development machine

The latest VASmalltalk development image we are using is 9.2 internal build b427. Our code is expected to load in that build. In addition, Carrillon web only runs on Linux platforms.

### Loading the code - GUI

1. Open the VAST development image
2. From the `Transcript` -> `Tools` -> `Browse Configuration Maps`
3. Right click on the left panel (where maps are listed) and select `Import` -> `All Versions...`.
4. On the opened popup, clear the text of the text input and let it empty. Then click `OK`.
5. On the file dialog look for `$CARRILLON_GIT_ROOT/src.st/Carrillon-Web-Development.dat` and select it.
6. On the same Configuration Map Browser go now to select the map `Carrillon Web - Development`.
7. On the right panel, right click on the latest version and select `Load With Required Maps`.
8. Done.

### Loading the code - Script

As an alternative to that GUI workflow, you can also evaluate the following code (from a workspace or anywhere):

```
StsConfigurationMapsBrowser new importAllConfigMapsFrom: '$CARRILLON_GIT_ROOT/src.st/Carrillon-Web-Development.dat'.
(EmConfigurationMap editionsFor: 'Carrillon Web - Development') first loadWithRequiredMaps.
```

### Installing development OS prerequisites

The libraries installed on the OS will depend on what we want to test exactly. But the following is a list of all the things you may have to install for all the possible testing:

```
# For python MIDI and sound support
sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall
sudo apt-get install -y fluidsynth vmpk libasound2-dev libjack-dev python3-pip python3-setuptools python3-dev
sudo pip3 install python-rtmidi

# For web deployment
sudo apt-get install -y nginx

# For remote GPIO support
rm pigpio.zip
sudo rm -rf PIGPIO
wget abyz.me.uk/rpi/pigpio/pigpio.zip
unzip pigpio.zip
cd PIGPIO
make
sudo make install
```


### Configuring nginx

First thing is that you need to be sure nginx is started on boot. Depending on the OS, it should be something like:

```
sudo systemctl enable nginx
```

Then you must copy the carrillon configuration file and reload nginx:

```
sudo cp $CARRILLON_GIT_ROOT/web/conf/nginxCarrillon.conf
sudo systemctl reload nginx
```

> Note that the default configuration of carrillon will start in port 6767. We can change this later for productive code. So...be sure NOT to have anything running in that port.

### Configuring and running the Seaside App

There are a few code snippets needed to configure and run the webapp.

For configuring, you probably need to run below script once or every in a while (if something changes):

```
"To fill some dummy songs (mandatory for now)"
CarrillonSong exampleEmptyAndFillSomeSongs.

"Set custom configuration object"
CarrillonSystem current configuration:  (CarrillonConfiguration defaultNewInstance
		staticFilesPath: '$CARRILLON_GIT_ROOT/web/files/';
		"midiPortName: 'Midi2TCP';"
		midiPortName: 'Midi Through';
		"midiPortName: 'Synth input port';"
		yourself).

"To register seaide"
CarrillonRootComponent register.    
```

The other useful scripts are for starting and stopping the Seaside server, which could also be done from `Transcript` -> `Tools` -> `Seaside Control Panel`:

```
"To start seaside"
CarrillonSeasideEntryPoint startSeasideAdapotors.

"To stop seaside"
WASstServerManager default adaptors do: [:each |
	WASstServerManager default unregister: each
].

```

To enter the web interface, you can do it through the webserver running in VAST under port 9999 (but that doens't support static files) or via nginx under port 6767. With the latter you should see the album thumbnails for example.

To enter from the browser without nginx: `http://localhost:9999/carrillon`. With nginx: `http://localhost:6767/carrillon`


### Preparing everything for a smooth testing experience

On development, it's nice to have sound aside from seeing the notes printed into the Transcript or powering up some leds. For that, open a terminal and run:

```
fluidsynth -a pulseaudio -m alsa_seq $CARRILLON_GIT_ROOT/resources/tubular_bells.sf2
```

On a second terminal, fire up our Python TCP MIDI scripts:

```
cd $CARRILLON_GIT_ROOT
python3 tcp2midi.py & python3 midi2tcp.py
```

On a third terminal, do a `aconnect -l` and identify the port numbers of `Midi Through`, `Midi2TCP` and `Synth input port`. In this example, we will assume they respectively are `14:0`, `128:0` and `130:0`.
