#!/usr/bin/python3
import os
import time
import live
import rtmidi
import threading
import subprocess
from rtmidi.midiconstants import NOTE_ON, NOTE_OFF, CONTROL_CHANGE, PITCH_BEND

TURN_OFF_DELAY = 5

CTRL_MODULATION = 1
CTRL_VOLUME = 7

FILENAME_BASE = 'songs/bank-{}.mid'

class MidiInput(object):
    # http://www.electronics.dit.ie/staff/tscarff/Music_technology/midi/midi_note_numbers_for_octaves.htm
    # A3 = 45
    # A4 = 57
    # D5 = 62
    # A5 = 69

    #BASE_NOTE = 45               # A3   # This is the real start, but the keyboard needs to be shifted -1 Octave. So
    BASE_NOTE  = 57               # A4   # We use this base, and the keyboard just works fine
    INPUT_PORT = 20 #128
    OUTPUT_PORT = 128 #130

    def __init__(self):
        self._time = 0
        self.pump = False
        self.turning_off = None
        self.recorder = None
        self.player = None
        self.set_mode('Playing')

    def turn_off(self):
        print("POWEROFFFFFFFFFFFFF")
        os.system("sudo poweroff")

    def turn_off_in(self, delay):
        if self.turning_off is not None:
            return

        self.turning_off = threading.Timer(delay, function=self.turn_off)
        self.turning_off.start()
        print("Turning off in {} seconds".format(delay))

    def turn_off_cancel(self):
        if self.turning_off is None:
            return

        print("Turning off cancelled")
        self.turning_off.cancel()
        self.turning_off = None

    def spawn(self, cmds):
        print("Running: {}".format(cmds))
        return subprocess.Popen(cmds)

    def start_recording(self, bank):
        if self.recorder is not None:
            return
        port = str(self.INPUT_PORT)
        filename = FILENAME_BASE.format(bank)

        print("Start recording into {}".format(filename))

        cmds = ['arecordmidi', '--port', port, filename]
        self.recorder = self.spawn(cmds)

    def stop_recording(self):
        if self.recorder is not None:
            self.recorder.terminate()
            self.recorder.wait()
            self.recorder = None
            print("Stopped recording")

    def start_playing(self, bank):
        if self.player is not None:
            return

        port = str(self.OUTPUT_PORT)
        filename = FILENAME_BASE.format(bank)

        print("Start playing {}".format(filename))

        #cmds = ['aplaymidi', '--port', port, filename]
        cmds = ['./loopplay.sh', '--port', port, filename]
        self.player = self.spawn(cmds)

    def stop_playing(self):
        if self.player is not None:
            self.player.terminate()
            self.player.wait()
            self.player = None
            print("Stopped playing")

    def set_mode(self, mode):
        self.mode = mode
        print("Changed to mode {}".format(self.mode))

    def __call__(self, event, data):
        event, deltatime = event
        self._time += deltatime

        if event[0] < 0xF0:
            channel = (event[0] & 0xF) + 1
            status = event[0] & 0xF0
        else:
            status = event[0]
            channel = None

        if self.mode == 'Playing':
            if (status == NOTE_ON) and (event[1] >= self.BASE_NOTE):
                note = live.Notas[event[1]-self.BASE_NOTE]
                print(note.name, ' ON')
                note.tong()
            elif (status == NOTE_OFF) and (event[1] >= self.BASE_NOTE):
                note = live.Notas[event[1]-self.BASE_NOTE]
                print(note.name, ' OFF')
            elif status == CONTROL_CHANGE:
                control = event[1]
                value = event[2]
                if control == CTRL_VOLUME:
                    pump = value >= 64
                    if pump != self.pump:
                        print("Setting pump to {}".format(pump))
                        live.Pump.write(int(pump))
                        #live.Extras[0].write(int(pump))
                        #live.Extras[1].write(int(pump))
                        #live.Extras[2].write(int(pump))
                        #live.Extras[3].write(int(pump))
                        #live.Extras[4].write(int(pump))
                        self.pump = pump
                elif control == CTRL_MODULATION:
                    if value >= 126:
                        self.set_mode('Recording')
                    elif 60 <= value <= 68:
                        self.stop_recording()
                        self.stop_playing()
                    elif value <= 1:
                        self.set_mode('Replay')
                    else:
                        print("MODULATION: {}".format(event[1:]))    
                else:
                    print("CONTROL_CHANGE {}".format(event[1:]))    
            else:
                print(self._time, event)
        elif self.mode == 'Recording':
            if status == NOTE_ON:
                self.start_recording(event[1])
                self.set_mode('Playing')
            elif status == CONTROL_CHANGE:
                control = event[1]
                value = event[2]
                if (control == CTRL_MODULATION) and (value < 120):
                    self.set_mode('Playing')
        elif self.mode == 'Replay':
            if status == NOTE_ON:
                self.start_playing(event[1])
                self.set_mode('Playing')
            elif status == CONTROL_CHANGE:
                control = event[1]
                value = event[2]
                if (control == CTRL_MODULATION) and (value > 1):
                    self.set_mode('Playing')

        if status == PITCH_BEND:
            if event[2] <= 1:
                self.turn_off_in(TURN_OFF_DELAY)
            else:
                self.turn_off_cancel()

if __name__ == '__main__':
    live.init()

    midi = rtmidi.MidiIn()
    midi.set_callback(MidiInput())

    device = midi.open_virtual_port('Carrillon')

    print("Ready to play!")

    blinker = live.blinker(live.Extras[4], 0.25, 1.75)

    try:
        while 1:
            time.sleep(1)
    finally:
        device.close_port()
