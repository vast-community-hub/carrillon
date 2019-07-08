#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonRoot="$(dirname "$carrillonScript")"

echo "ROOT: $carrillonRoot"

echo "Starting midi2tcp.py"
python3 "$carrillonRoot/midi2tcp.py" &

echo "Start pigpiod"
sudo pigpiod 8888
