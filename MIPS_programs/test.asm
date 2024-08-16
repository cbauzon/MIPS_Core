.data
mybytes: .byte 0x12, 0x34, 0x56

.text
la a1, mybytes
lb a2, 0(a1)
lb a3, 1(a1)