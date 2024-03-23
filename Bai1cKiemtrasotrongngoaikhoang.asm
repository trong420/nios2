.text
.global main
main:
	movia r10, FLAG
	ldw r11, 4(r10)
	ldw r12, 8(r10)
	sub r12, r11, r12
	ble r12, r0,NGOAI
	ldw r12, 12(r10)
	sub r12, r12,r11
	ble r12, r0,NGOAI
	movi r12, 1
	br DONE
NGOAI:
	movi r12, 0
DONE:
	stw r12, 0(r10)
.data
FLAG: 
.skip 4
N: .word 3
M1: .word 1
M2: .word 3
.end
	