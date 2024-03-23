.text
.equ RED_LEDS, 0x10000000
.equ SWITCHES, 0x10000040 

.global main
main:
	movia	r9, RED_LEDS
	movia	r10, SWITCHES
loop:
	ldbio	r5, (r10)
	ldbio	r6, 2(r10)
	mov	r11, r5
	mov 	r12, r6
	movi	r7, 0
	bne	r12, r0, Loop2
	stwio	r7,0(r9)
	br	loop
Loop2:
	call 	TICH
	stwio	r7,0(r9)
	br	loop

TICH:	
	add 	r7, r7, r11
	subi	r12, r12, 1
	bgt	r12, r0, TICH
	
	ret
.end