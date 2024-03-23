.text
.global main
main:
	movia r10,FLAG
	ldw r11,4(r10)
	ldw r12,8(r10)
	sub r12, r12, r11
	beq r12, r0, BANG
	bgt r12, r0, LON
	movi r12, -1
	br DONE
BANG:
	movi r12, 0
	br DONE
LON:
	movi r12, 1
	br DONE
DONE: 
	stw r12, 0(r10)
.data 
FLAG:
.skip 4
M:
.word 4
N:
.word 4
.end