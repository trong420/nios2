.text
.global main
.equ X, 0
main:
	movia r10, FLAG
	movi r9,X
	beq r9,r0,LOI
	ldw r11, 4(r10)
	div r12, r11, r9
	mul r12, r12, r9
	sub r12, r11, r12
	beq r12, r0, CHIAHET
	movi r12, 0
	br DONE
LOI:
	movi r12, -1
	br DONE
CHIAHET:
	movi r12, 1
	br DONE
DONE:
	stw r12, 0(r10)
.data
FLAG: .skip 4
N: .word 8
.end