#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

echo "ROOT: $carrillonRoot"

echo "Starting midi2tcp.py"
python3 "$carrillonRoot/midi2tcp.py" &

echo "Start pigpiod"
sudo pigpiod

echo "connecting Keyboard"
# aconnect -l >/tmp/aconnect
(sleep 10 && aconnect 20:0 128:0 && aconnect -l) 2>&1 >> /tmp/aconnect 
# aconnect -l >>/tmp/aconnect

echo "Start VAST"
$carrillonRoot/deploy/app/startCarrillonVAST.sh
