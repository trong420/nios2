.text
.equ RED_LEDS, 0x10000000
.global _start
_start:
	movia r10, RED_LEDS
	movi r11, 1
LOOP:
	stwio r11,0(r10)
	xori r11,r11,9
	movia r15, 500000
DELAY:
	subi r15,r15,1
	bne r15, r0, DELAY
	br LOOP
.end
