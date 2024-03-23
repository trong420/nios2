.text
.equ HEX3_HEX0, 0x10000020
.equ HEX7_HEX4, 0x10000030
.global _start
_start:
    movia r15, HEX_SEGMENTS
    movia r1, HEX3_HEX0
    movia r2, HEX7_HEX4
    movi r10, 0b01111111
    movi r11, 0b01101111
    movi r12, 0b01101111
    movi r13, 0b00000110
    stb r10, 0(r15)
    stb r11, 1(r15)
    stb r12, 2(r15)
    stb r13, 3(r15)
    ldw r16, 0(r15)
    stwio r16, 0(r1)
    
    movi r10, 0b01101101
    movi r11, 0b00111111
    movi r12, 0b01001111
    movi r13, 0b00111111
    stb r10, 0(r15)
    stb r11, 1(r15)
    stb r12, 2(r15)
    stb r13, 3(r15)
    ldw r16, 0(r15)
    stwio r16, 0(r2)
STOP:
	br STOP
HEX_SEGMENTS:
.fill 1,4,0
.end