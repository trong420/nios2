#Dịch chuỗi bit sang trái nếu KEY[1] được nhấn dịch
#phải nếu KEY[2] được nhấn và nếu KEY[3] được nhấn xuất
#REDLED kết quả từ SW

.text
.equ KEY, 0xFF200050
.equ SW, 0xFF200040
.equ RED_LED, 0xFF200000
.equ SDRAM_END, 0x03FFFFFF #1
.global _start _start:
movia sp, SDRAM_END-3 #2
movia r6, KEY
movia r7, SW
movia r3, RED_LED
movia r20, 0
movia r21, N
LOOP:
mov r1, zero
movi r2, 0x2
movi r4, 0x4
movi r8, 0x8
stwio r20, (r3) # store RED_LED
call KEY_DECODE #3
ldw r10, (r21)
and r12, r10, r2 #KEY1
cmpeq r12, r12, r2
bne r12, r0, SHIFT_L
and r12, r10, r4 #KEY2
cmpeq r12, r12, r4
bne r12, r0, SHIFT_R
and r12, r10, r8 #KEY3
cmpeq r12, r12, r8
bne r12, r0, LOAD_SW
br LOOP
SHIFT_L:
slli r20, r20, 1
br LOOP
SHIFT_R:
srli r20, r20, 1
br LOOP
LOAD_SW:
ldwio r20, (r7)
br LOOP
KEY_DECODE:
#4
subi sp, sp, 8
stw r10, 4(sp)
stw r11, 0(sp)
#5
CHECK_KEY:
ldhio r10, 0(r6)
beq r10, zero, CHECK_KEY
WAIT:
ldhio r11, 0(r6)
bne r11, zero, WAIT
andi r10, r10, 0x000E # KEY1, 2, 3
stw r10, (r21)
#6
ldw r10, 4(sp)
ldw r11, 0(sp)
addi sp, sp, 8
#7
ret
.data
N: .word 0
.end