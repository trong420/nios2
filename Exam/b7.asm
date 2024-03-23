#: a = SW[3:0], b = [7:4] viết hàm con tính r16 = a^2 + 3b + 25 xuất ra LEDRED

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
#N = SW[3:0]
andi r2, r7, 0xF
#M = SW[7:4]
srli
r3, r7, 4
andi r3, r3, 0xF
call CHIA
br LOOP
CHIA:
subi sp, sp, 12
stw
r16, 8(sp)
stw
r2, 4(sp)
stw
r1, 0(sp)
FOR:
beq r1, r2, ADD
add r16, r16, r2
addi r1, r1, 1
br FOR
ADD:
add r16, r16, r3
add r16, r16, r3
add r16, r16, r3
addi r16, r16, 25
DONE:
stwio r16,0(r6)
ldw
r16, 8(sp)
ldw
r2, 4(sp)
ldw
r1, 0(sp)
addi sp, sp, 12
ret
.data
.end