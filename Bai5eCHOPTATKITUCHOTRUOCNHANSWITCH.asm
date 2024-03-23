.text
.equ HEX3_HEX0, 0x10000020
.equ SWITCHES, 0x10000040

.global _start
_start:
	movia r19, TABLE
    movia r17, HEX3_HEX0
    movia r3, SWITCHES
LOOP:
	addi r20, r19, 0
    ldb r21, (r20)
    stwio r21, (r17)
    ldwio r5,(r3)
    movia r6, 500000
    call NHAN
    call DELAY
    stwio r0, (r17)
    ldwio r5,(r3)
    movia r6, 500000
    call NHAN
    call DELAY
    br LOOP
DELAY:
	subi r6,r6,1
    bne r6, r0, DELAY
    ret
.global NHAN
NHAN: 
	beq r5, r0, kt
    add r6,r6,r6
    subi r5,r5,1
    br NHAN
kt:
ret
.data
#luu ma hinh cua led 7 doan
TABLE:
	.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
	.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
	.byte 0b01111111, 0b01101111, 0b00000000, 0b00000000
	.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
# dat truoc 4 byte luu ma hinh led 7 doan HEX3_HEX0

.end
  
   