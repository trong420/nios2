.text
.global main
main:
	movia r10, FLAG
	ldw r11, 4(r10)
	ble r11, r0, CHECK
	movi r12, 1
LOOP:
	mul r13, r12, r12
	bgt r13, r11, NO
	beq r13, r11, YES
	addi r12, r12, 1
	br LOOP
CHECK: 
	beq r11, r0, YES
NO:
	movi r11, 0
	br DONE
YES:
	movi r11, 1
DONE:
	stw r11,0(r10)
.data
FLAG: .skip 4
N: .word 4
.end