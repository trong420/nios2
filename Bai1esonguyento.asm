.text
.global main
main:
	movia r10,FLAG
	ldw r11, 4(r10)
	movi r12, 1
	ble r11, r12, NO
	slli r12, r12, 1
	beq r11, r12, YES
LOOP:
	div r13, r11, r12
	mul r13, r13, r12
	sub r13, r11, r13
	beq r13, r0, NO
	mul r13, r12, r12
	bgt r13, r11, YES
	addi r12, r12,1
	br LOOP
NO: 
	movi r11, 0
	br DONE
YES:
	movi r11,1
DONE: 
	stw r11, 0(r10)
.data
FLAG: .skip 4
N: .word 3
.end
	
	