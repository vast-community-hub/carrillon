#!/usr/bin/python3
import time
import rtmidi
import socket
import select
from struct import pack,unpack

TCP_PORT  = 8384
MIDI_PORT = "TCP2Midi"

def log(msg):
    print("{}: {}".format(MIDI_PORT, msg))

if __name__ == '__main__':
    midi = rtmidi.MidiOut()
    device = midi.open_virtual_port(MIDI_PORT)

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(('', TCP_PORT))
    s.listen(10)
    client_s = None

    try:
        log("Listening at port %d" % TCP_PORT)
        while 1:
            if client_s is not None:
                r = [s, client_s]
            else:
                r = [s]

            r,w,x = select.select(r,[],[])
            if s in r:
                if client_s:
                    client_s.close()
                    log("Connection forcefully closed (%s)" % (client_addr,))
                client_s, client_addr = s.accept()
                log("Received connection from: %s" % (client_addr, ))
            if client_s in r:
                count = client_s.recv(1)
                if not count:
                    log("Connection closed (%s)" % (client_addr,))
                    client_s.close()
                    client_s = None
                else:
                    count = unpack('B', count)[0]
                    log("Received %d bytes" % count)
                    data = client_s.recv(count)
                    if count == len(data):
                        data = unpack('{}B'.format(count), data)
                        log("Received %r" % (data,))
                        device.send_message(data)
                    else:
                        log("Received malformed data %r" % (data,))
    finally:
        device.close_port()
