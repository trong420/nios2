#N = SW[9:2], kiển tra N nếu N chia hết cho 0x11 và
#0x18<N<0x40. Nếu thỏa 1 trong 2 thì LED[3:0] sáng, còn thỏa
#hết thì LED[7:4] sáng, nếu không thỏa 2 điều thì LED[9:0] tắt.
# Viết chương trình con kiểm tra N có chia hết 0x11 không.

.text
.equ G_LED, 0xFF200000
.equ SW, 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global _start _start:
movia r5, SW
movia r6, G_LED
movia sp, SDRAM_END - 3
movi r1, 0
movi r16, 0
movi r4, 0x40
movi r15, 0x18
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[3:0]
#andi r2, r7, 0xF
#M = SW[9:2]
srli r3, r7, 2
andi r3, r3, 0xFF
mov r10, r3
call CHIA
br LOOP
CHIA:
subi sp, sp, 12
stw r16, 8(sp)
stw r2, 4(sp)
stw r3, 0(sp)
FOR:
beq r3, r0, A
blt r3, r0, B
subi r3, r3, 0x11
br FOR
A:
ble r10, r15, C
bge r10, r4, C
movi r16, 0x00F0
br DONE
B:
ble r10, r15, D
bge r10, r4, D
movi r16, 0xF
br DONE
C:
movi r16, 0xF
br DONE
D:
movi r16, 0x0000
br DONE
DONE:
stwio r16,0(r6)
ldw r16, 8(sp)
ldw r2, 4(sp)
ldw r3, 0(sp)
addi sp, sp, 12
ret
.data
.end