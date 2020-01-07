#!/bin/bash

cd /home/pi/carrillon
killall carrillon.py 2>/dev/null
killall python3 2>/dev/null
./carrillon.py &

while (true)
do
    sleep 5
    if (aconnect -l | grep Connected) >/dev/null
    then
        echo -n
    else
        SRC=`aconnect -l | grep client.*AKM320| cut -d ' ' -f 2|cut -d : -f 1`
        DST=`aconnect -l | grep client.*RtMidiIn| cut -d ' ' -f 2|cut -d : -f 1`
        echo Connecting $SRC:0 $DST:0
        aconnect $SRC:0 $DST:0
    fi
done
