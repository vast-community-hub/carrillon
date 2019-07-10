#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

pkill -f 'midi2tcp.py'
pkill -f 'aplaymidi'
pkill -f 'esnx'
sudo killall pigpiod
