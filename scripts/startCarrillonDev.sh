#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

echo "ROOT: $carrillonRoot"

echo "Starting fluidsynth"
echo "$carrillonRoot/tubular_bells.sf2"
fluidsynth -i -s -a pulseaudio -m alsa_seq "$carrillonRoot/tubular_bells.sf2" &

echo "Starting midi2tcp.py"
python3 "$carrillonRoot/midi2tcp.py" &

echo "Starting aconnect "
sleep 5s #Give some time for fluidsynth and midi2tcp.py to start
aconnect 14:0 128:0
aconnect 14:0 129:0

echo "Starting SSH tunnel"
ssh -fN -p 22 pi@campstpiz0.local -L 8888:127.0.0.1:8888

echo "Start pigpiod in remote Pi"
ssh -fN -p 22 pi@campstpiz0.local 'sudo pigpiod 8888'
