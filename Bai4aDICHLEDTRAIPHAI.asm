.text
.equ RED_LEDS, 0x10000000
.global _start
_start:
	movia r1,RED_LEDS
    movi r5,1
    mov r3, r5
    movia r4, 0b100000000000000000
LOOP:
	beq r3, r4, DICHPHAI
	rol r3, r3, r5
    stwio r3, (r1)
    movia r7, 500000
    call DELAY
    br LOOP
DICHPHAI:
	beq r3, r5, LOOP
	ror r3, r3, r5
    stwio r3, (r1)
    movia r7, 500000
	call DELAY
    br DICHPHAI
DELAY:
	subi r7,r7,1
    bne r7,r0,DELAY
    ret
.end
	
    
