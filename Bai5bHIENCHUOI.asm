.text
.global _start
_start:
	movia r2, 0x10000020
    movia r3, 0x10000030
    movia r4, dataled7
    movi r1,0
loop:
    ldw r6,(r4)
    stwio r6,(r2)
    ldw r8,4(r4)
    stwio r8,(r3)
	
	movia r14,1
    call delay
    
    stwio r1,(r3)
    ldw r6,8(r4)
    stwio r6,(r2)
    
    movia r14,1
    call delay
    
    ldw r6,12(r4)
    stwio r6,(r2)
    ldw r7,16(r4)
    stwio r7,(r3)
    
    movia r14,1
    call delay
    br loop
.global delay
delay:
	
	subi r14,r14,1
	beq r14,r0,kt1
	br delay
kt1:
	ret
.data
dataled7:
	.byte 0b00111111, 0b00111000, 0b00111000, 0b01111001
	.byte 0b01110110, 0b00000000, 0b00000000, 0b00000000
    .byte 0b01110011, 0b00111000, 0b01111001, 0b01110110
	.byte 0b01000000, 0b00111000, 0b01111001, 0b00000111
	.byte 0b01111001, 0b01110001, 0b01000000, 0b00000000
.end