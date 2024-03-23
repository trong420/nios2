.text
.global main
main:
	movia r10, FLAG
	ldw r11, 4(r10)
	beq r11,r0,ZERO
	andi r11,r11,1
	br DONE
ZERO:
	movi r11, -1
DONE:
	stw r11, 0(r10)
.data
FLAG:
.skip 4
N:
.word 6
.end