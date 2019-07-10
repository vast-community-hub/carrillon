#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

pkill -f 'fluidsynth'
pkill -f 'midi2tcp.py'
pkill -f 'aplaymidi'
ssh -fN -p 22 pi@campstpiz0.local 'sudo killall pigpiod'
pkill -9 -f 'ssh -N -YC -p 22 pi@'
