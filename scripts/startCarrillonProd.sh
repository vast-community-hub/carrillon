#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

echo "ROOT: $carrillonRoot"

echo "Starting midi2tcp.py"
python3 "$carrillonRoot/midi2tcp.py" &
sleep 3

echo "Start pigpiod"
sudo pigpiod

echo "connecting Keyboard"
aconnect 20:0 128:0

echo "Start VAST"
$carrillonRoot/deploy/app/startCarrillonVAST.sh
