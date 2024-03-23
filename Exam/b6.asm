#N = SW[5:0], M = [8:6] viết hàm con tính r16 = N/M xuất ra LEDRED

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
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[5:0]
andi r2, r7, 0x3F
#M = SW[8:6]
srli r3, r7, 6
andi r3, r3, 0x7
call CHIA
br LOOP
CHIA:
subi sp, sp, 12
stw r16, 8(sp)
stw r2, 4(sp)
stw r1, 0(sp)
FUNC:
beq r3, r0, DONE
addi r1, r1, 1
sub r2, r2, r3
mov r16, r1
blt r2, r3, DONE
br FUNC
DONE:
stwio r16,(r6)
ldw r16, 8(sp)
ldw r2, 4(sp)
ldw r1, 0(sp)
addi sp, sp, 12
ret
.data
.end