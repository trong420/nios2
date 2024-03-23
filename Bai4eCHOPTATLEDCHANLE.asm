.text
.global _start
_start:
	movia r2, 0x10000000
    movia r3, 0x10000040
    movia r5, 0b101010101010101010
    movia r6, 0b010101010101010101
    movia r9,1
SWI:
	ldwio r8,0(r3)
    beq r8,r9,LED_LE
   	slli r8,r8,7
LED_CHAN:
	stwio r6, 0(r2)
    movia r7, 500000
    call DELAY
    call LED_OFF
      movia r7, 500000
    call DELAY
    br SWI
LED_LE:
	stwio r5,0(r2)
    movia r7, 500000
    call DELAY
    call LED_OFF
      movia r7, 500000
    call DELAY
    br SWI
LED_OFF:
	stwio r0, 0(r2)
    ret
DELAY:
	subi r7,r7,1
    bne r7,r0,DELAY
    ret
.end