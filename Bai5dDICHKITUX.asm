.text
.global _start
_start:
	movia r2, 0x10000020
    movia r4, dataled7
    movi r8,0
    addi r5, r4, 0
    ldb r6, (r5)
    stwio r6, 0(r2)
    movia r7, 5000000
    call delay
LOOP:
	addi r5, r4, 0
    ldb r6,(r5)
    addi r8,r8,8
    rol r6,r6,r8
    stwio r6, (r2)
    movia r7, 5000000
    call delay
    br LOOP
delay:
	subi r7,r7,1
    bne r7, r0, delay
    ret
.data
dataled7:
	.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
	.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
	.byte 0b01111111, 0b01101111, 0b00000000, 0b00000000
	.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
 .end
    