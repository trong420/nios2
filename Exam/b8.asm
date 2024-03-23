#N = SW[7:0] có dạng 0xab viết hàm con kiểm tra có
#mấy số chia 3 dư 1 trong các số a, b

.text
.equ G_LED, 0xFF200000
.equ SW, 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global _start
_start:
movia r5, SW
movia r6, G_LED
movia sp, SDRAM_END - 3
movi r1, 0
movi r16, 0
movi r20, 1
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[7:0]
andi r2, r7, 0xFF
mov r8, r2
call CHIA
br LOOP
CHIA:
subi sp, sp, 28
stw r23, 24(sp)
stw r22, 20(sp)
stw r21, 16(sp)
stw r8, 12(sp)
stw r16, 8(sp)
stw r2, 4(sp)
stw r1, 0(sp)
CHIA16:
movi r3, 16
beq r3, r0, F
addi r1, r1, 1
sub r2, r2, r3
mov r16, r1
blt r2, r3, F
br CHIA16
F:
MOD16:
movi r3, 16
beq r8, r3, A
blt r8, r3, G
sub r8, r8, r3
br MOD16
A:
movi r8, 0
G:
MOD31:
movi r3, 3
beq r16, r3, B
blt r16, r3, K
sub r16, r16, r3
br MOD31
B:
movi r16, 0
K:
MOD32:
movi r3, 3
beq r8, r3, C
blt r8, r3, TEST
sub r8, r8, r3
br MOD32
C:
movi r8, 0
TEST:
movi r21, 0
movi r22, 0
movi r23, 0
cmpeq r21, r16, r20
cmpeq r22, r8, r20
add r23, r22, r21
stwio r23, (r6)
ldw r23, 24(sp)
ldw r22, 20(sp)
ldw r21, 16(sp)
ldw r8, 12(sp)
ldw r16, 8(sp)
ldw r2, 4(sp)
ldw r1, 0(sp)
addi sp, sp, 28
ret
.data
.end