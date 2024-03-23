#N = SW[3:0], M = [5:4] viết hàm con tính r16 = N^M xuất ra LEDRED

.text
.equ G_LED, 0xFF200000
.equ SW, 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global_start _start:
movia r5, SW
movia r6, G_LED
movia sp, SDRAM_END - 3
movi r1, 0
movi r4, 0
movi r10, 0
movi r8, 0
movi r16, 1
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[3:0]
srli r2, r7, 0
andi r2, r2, 0xF
#N = SW[5:4]
srli r3, r7, 4
andi r3, r3, 0b11
call CHIA
br LOOP
CHIA:
subi sp, sp, 16
stw r10, 12(sp)
stw r4, 8(sp)
stw r8, 4(sp)
stw r1, 0(sp)
FOR:
beq r0, r3, A
beq r16, r3, B
beq r1, r2, FOR1
add r4, r4, r2
addi r1, r1, 1
br FOR
FOR1:
beq r10, r3, DONE
add r8, r8, r4
addi r10, r10, 1
br FOR1
A:
movi r8, 1
br DONE
B:
mov r8, r2
DONE:
stwio r8,(r6)
ldw r10, 12(sp)
ldw r4, 8(sp)
ldw r8, 4(sp)
ldw r1, 0(sp)
addi sp, sp, 16
ret
.data
.end