.text
.global _start
_start:
	movia r2, 0x10000000
    movia r3, 0x10000040
LED:
	movi r4, 1
    stwio r4, 0(r2)
    ldwio r5,0(r3)
    movia r6, 500000
    call NHAN
    call DELAY
    movi r4, 0
    stwio r4, 0(r2)
    ldwio r5,0(r3)
    movia r6,500000
    call NHAN
    call DELAY
    br LED
DELAY:
	subi r6,r6,1
    bne r6,r0,DELAY
    ret
.global NHAN
NHAN:
	beq r5,r0,KT
    add r6,r6,r6
    subi r5,r5,1
    br NHAN
KT:
	ret
.end
