.text
.equ RED_LEDS, 0x10000000
.equ SWITCHES, 0x10000040
.global main
main:
	movia r1, SWITCHES
	movia r2, RED_LEDS
	ldwio r11, 0(r1)
	movi r14, 1
	movi r12, 2
	ble r11, r14, DACBIET1
	beq r11, r12,DACBIET2
	movi r15, 0
	mov r16, r11
	movi r13, 0
	mov r13, r11
	
	br GIAM
DACBIET1:
	movi r16,1
	br STOP
DACBIET2:
	movi r16,2
	br STOP
GIAM:
	subi r13, r13, 1
	beq r13, r12,CONG1
	br TRUNGGIAN1

TRUNGGIAN1:
	mov r15, r13
	blt r13, r11, GAN
	br NHAN
GAN:
	mov r11, r16
	br NHAN
NHAN: 
	add r16, r16, r11
	subi r13, r13,1
	beq r13, r14, TRUNGGIAN2
	br NHAN
TRUNGGIAN2: 
	mov r13, r15
	br GIAM	
CONG1:
	add r16, r16, r16
	br STOP

STOP:
	stwio r16, 0(r2)
	br STOP
.data
.skip 4
N: .word 7


	
