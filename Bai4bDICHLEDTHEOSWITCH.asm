.text
.equ RED_LEDS, 0x10000000
.equ SWITCHES, 0x10000040
.global _start
_start:
	movia r1,RED_LEDS
    	movia r2,SWITCHES
    	movi r5,1
    	movi r6,0
    	mov r3, r5
    	movia r4, 0b100000000000000000
LOOP:
	stwio r3, (r1)
    	ldwio r6, (r2)
    	beq r6, r5, DOI
    	rol r3, r3, r5
    	stwio r3, (r1)
    	movia r7, 500000
    	call DELAY
    	br LOOP
DOI:
	ror r3, r3, r5
    	stwio r3, (r1)
    	movia r7, 500000
	call DELAY
    	ldwio r6, (r2)
    	beq r6, r0, LOOP
    	br DOI
DELAY:
	subi r7,r7,1
    	bne r7,r0,DELAY
    	ret
.end
	
    
