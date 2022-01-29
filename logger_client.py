import time

import serial

ser = serial.Serial(port='COM3',
                    baudrate=1000,
                    bytesize=8,
                    parity='N',
                    stopbits=1,
                    timeout=None,
                    xonxoff=0,
                    rtscts=0)
count = 0
while True:
    end = " "
    stuff = ser.read(1)
    value_bytes = (int.from_bytes(stuff, 'little'))
    text = ""
    if stuff == str.encode('|'):
        end = "\n"
        print(f"time: {time.localtime().tm_hour}:{time.localtime().tm_min}:{time.localtime().tm_sec}", end=end)
        count = 0
    else:
        if count == 0:
            state = "L"
            if value_bytes == 1:
                state = "F"
            elif value_bytes == 2:
                state = "N"
            text = f"out_state: {state}"
        elif count == 1:
            text = f"internal_state: {value_bytes}"
        elif count == 2:
            state = "*"
            if value_bytes == 1:
                state = "1"
            elif value_bytes == 2:
                state = "2"
            elif value_bytes == 4:
                state = "3"
            elif value_bytes == 8:
                state = "4"
            text = f"buttons: {state}"
        elif count == 3:
            text = f"buttons_stable: {value_bytes}"
        print(text, end=end)
        count += 1
