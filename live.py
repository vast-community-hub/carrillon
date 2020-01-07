#!/usr/bin/python3

import sys
import tty
import time
import IOPi
import termios
import threading


TONG_DELAY = 0.50

class Nota(object):
   def __init__(self, board, pin, name = ''):
       self.board = board
       self.pin   = pin
       self.name  = name

   def write(self, value):
       self.board.write_pin(self.pin, value)

   def read(self):
       return self.board.read_pin(self.pin)

   def set(self):
       self.write(1)

   def reset(self):
       self.write(0)

   def toggle(self):
       self.write(self.read() ^ 1)

   def tong(self):
       self.set()
       threading.Timer(TONG_DELAY, self.reset).start()
       # time.sleep(TONG_DELAY)
       # self.reset()

def init():
    global Notas, Pump, Extras

    Board0 = IOPi.IOPi(0x20)
    Board1 = IOPi.IOPi(0x21)

    OUTPUT = 0
    Board0.set_port_direction(0, OUTPUT)
    Board0.set_port_direction(1, OUTPUT)
    Board1.set_port_direction(0, OUTPUT)
    Board1.set_port_direction(1, OUTPUT)

    Pump = Nota(Board1,7, 'Pump')

    Extras = [
        Nota(Board1, 8, 'extra0'),
        Nota(Board1, 9, 'extra1'),
        Nota(Board1, 10, 'extra2'),
        Nota(Board1, 11, 'extra3'),
        Nota(Board1, 12, 'extra4'),
    ]

    Notas = [
        Nota(Board0, 4, 'A3'),
        Nota(Board0, 3, 'A#3'),
        Nota(Board0, 2, 'B3'),
        Nota(Board0, 1, 'C4'),
        Nota(Board0, 16, 'C#4'),
        Nota(Board0, 15, 'D4'),
        Nota(Board0, 14, 'D#4'),
        Nota(Board0, 13, 'E4'),
        Nota(Board0, 5, 'F4'),
        Nota(Board0, 6, 'F#4'),
        Nota(Board0, 7, 'G4'),
        Nota(Board0, 8, 'G#4'),
        Nota(Board0, 9, 'A4'),
        Nota(Board0, 10, 'A#4'),
        Nota(Board0, 11, 'B4'),
        Nota(Board0, 12, 'C5'),
        Nota(Board1, 5, 'C#5'),
        Nota(Board1, 6, 'D5'),
        Extras[0],
        Extras[1],
        Extras[2],
        Extras[3],
        Extras[4],
    ]

    Pump.reset()
    for v in Notas:
        v.reset()

def get_key():
    return sys.stdin.read(1)

def _loop_keyboard():
    key_order = 'q2we4r5ty7u8i9op-['
    while 1 < 2:
        key = get_key()
        print(key),
        if key == '\x1b': break
        if key == '.': break
        if key == ' ': Pump.toggle()
        if key in key_order:
            Notas[key_order.find(key)].tong()

def loop_keyboard():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)

    try:
        tty.setraw(fd)
        _loop_keyboard()
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

def blinker(note, on_s = 0.25, off_s = 1.75):
    def _blinker():
        while True:
            note.set()
            time.sleep(on_s)
            note.reset()
            time.sleep(off_s)
    thread = threading.Thread(target = _blinker)
    thread.daemon = True
    thread.start()
    return thread

if __name__ == '__main__':
    init()
    loop_keyboard()
