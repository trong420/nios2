
.text 
.equ HEX, 0x10000020
.global _start

_start:
movia r20,HEX
movia r21,SEVEN_SEG_DECODE_TABLE
movi r9,10
movi r13,0
LAP:
movi r10,0
LOOP:
beq r10,r9,LAP
mov r11,r10
add r12,r21,r11
ldb r13,(r12)
stwio r13,(r20)
addi r10,r10,1
movia r8,5000000
DELAY:
subi r8,r8,1
bne r8,r0,DELAY
beq r10,r9,LAP
br LOOP

.data
.skip 3
.byte 16
SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
HEX_SEGMENTS:
.fill 1,4, 0
.end

