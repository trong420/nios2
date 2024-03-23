#Đếm có bao nhiêu SW[9:0] được bật lên 1 xuất ra
#HEX[1:0] sử dụng ít nhất 1 chương trình con.

#dem SW[9:0]
#HEX[1:0]
#N = SW[9:0]
#for (int i = 0; i < 10; i++){
#t = N & 0x1;
#if (t != 0)
#count++;
#N = N >> 1;
#}
#if (count == 10){
#r21 = 0
#r22 = 1
#}
#else{
#r21 = count
#r22 = 0
#}

.text
.equ SW, 0xFF200040
.equ HEX3_HEX0, 0xFF200020
.equ SDRAM_END, 0x03FFFFFF #1
.global _start _start:
movia sp, SDRAM_END-3 #2
movia r6, SW
movia r7, SEVEN_SEG_DECODE_TABLE
mov r21, zero
mov r22, zero
mov r23, zero
movi r12, 10
LOOP:
movia r9, HEX_SEGMENTS
ldwio r8, (r6)
andi r8, r8, 0x3FF # r8 = N
movi r10, 0 # r10 = i
movi r11, 0 # r11 = count
FOR:
beq r10, r12, END_FOR
andi r14, r8, 0x1
add r11, r11, r14
srli r8, r8, 1
addi r10, r10, 1
br FOR
END_FOR:
beq r11, r12, A
mov r21, r11
mov r22, r0
br B
A:
mov r21, r0
movi r22, 1
B:
call SEVEN_SEG_DECODER
br LOOP
SEVEN_SEG_DECODER:
subi sp, sp, 16
stw r15, 12(sp)
stw r16, 8(sp)
stw r17, 4(sp)
stw r9, 0(sp)
add r15, r7, r21
ldb r16, 0(r15)
stb r16, 0(r9)
addi r9, r9, 1
add r15, r7, r22
ldb r16, 0(r15)
stb r16, 0(r9)
addi r9, r9, 1
movia r9, HEX_SEGMENTS
ldw r16, 0(r9)
movia r17, HEX3_HEX0
stwio r16, 0(r17)
ldw r15, 12(sp)
ldw r16, 8(sp)
ldw r17, 4(sp)
ldw r9, 0(sp)
addi sp, sp, 16
ret
.data
SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
HEX_SEGMENTS: .fill 1, 4, 0
.end