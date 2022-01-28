import serial

ser = serial.Serial(port='COM3',
                    baudrate=1000,
                    bytesize=8,
                    parity='N',
                    stopbits=1,
                    timeout=None,
                    xonxoff=0,
                    rtscts=0)
while(True):
    end = " "
    stuff = ser.read(1)
    if stuff == str.encode('|'):
        end = "\n"
    print((bin(int.from_bytes(stuff, 'little'))), end=end)
