#N = SW[9:0], M = [7:4] viết hàm con đếm số lần xuất
#hiện của dãy bit 0b1101 xuất ra REDLED.

#N = SW[9:0] -> 10-bit 0b11 1111 1111
#dem 0b1101
#int t = 0;
#int count = 0;
#for (int i = 0; i < 7; i++){
#t = N & 0xF;
#if (t == 0b1101)
#count++;
#N = N >> 1;
#}

.text
.equ SW, 0xFF200040
.equ RED_LED, 0xFF200000
.equ SDRAM_END, 0x03FFFFFF # ------------------ 1
.global _start _start:
movia r2, SW
movia r3, RED_LED
movia sp, SDRAM_END - 3 # ------------------ 2 stack pointer - sp
movi r16, 7
movi r17, 0b1101
LOOP:
ldwio r4, (r2) # r4 = SW = 32-bit
andi r4, r4, 0b1111111111 # 0x3FF
call FUNCTION_1 # ------------------ 3
br LOOP
FUNCTION_1:
# luu stack # ------------------ 4
subi sp, sp, 16
stw r5, 12(sp)
stw r6, 8(sp)
stw r7, 4(sp)
stw r8, 0(sp)
# code # ------------------ 5
movi r5, 0 # r5 = t
movi r6, 0 # r6 = count
movi r7, 0 # r7 = i = 0
FOR:
beq r7, r16, END_FOR
andi r5, r4, 0xF
cmpeq r8, r5, r17
add r6, r6, r8
srli r4, r4, 1
addi r7, r7, 1
br FOR
END_FOR:
stwio r6, (r3)
# load stack # ------------------ 6
ldw r5, 12(sp)
ldw r6, 8(sp)
ldw r7, 4(sp)
ldw r8, 0(sp)
addi sp, sp, 16
# return # ------------------ 7
ret # return
.data
.end