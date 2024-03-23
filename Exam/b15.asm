#a = SW[3:0], b = [7:4] viết hàm con tính a - b xuất ra
#HEX[2:0] dùng hàm con giải mã led 7 đoạn

.text
.equ SW, 0xFF200040
.equ HEX3_HEX0, 0xFF200020
.equ SDRAM_END, 0x03FFFFFF
.global _start _start:
movia r1, SEVEN_SEG_DECODE_TABLE
movia r2, SW
movia sp, SDRAM_END - 3
LOOP:
#A = [3:0]
ldwio r3, (r2)
andi r4, r3, 0xF
#B = [7:4]
srli r5, r3, 4
andi r5, r5, 0xF
movia r9, HEX_SEGMENTS
call SEVEN_SEG_DECODER
br LOOP
SEVEN_SEG_DECODER:
subi sp, sp, 24
stw r12, 20(sp)
stw r11, 16(sp)
stw r8, 12(sp)
stw r16, 8(sp)
stw r15, 4(sp)
stw r9, 0(sp)
#Tinh a - b a= r4 b= r5
ble r4, r5, F
sub r8, r4, r5
sub r12, r4, r5
#N/M N = r8; M = r7
movi r10, 0
CHUC:
movi r7, 10
movi r11, 0
mov r11, r10
blt r8, r7, DONVI
addi r10, r10, 1
sub r8, r8, r7
br CHUC
DONVI:
#M mod N N r7 M r12
movi r20, 10
beq r12, r20, E
blt r12, r20, DONE
sub r12, r12, r20
br DONVI
E:
movi r12, 0
br DONVI
F:
movi r12, 0
movi r11, 0
br DONE
DONE:
movi r23, 0
add r15, r1, r12
ldb r16, 0(r15)
stb r16, 0(r9)
addi r9, r9, 1
add r15, r1, r11
ldb r16, 0(r15)
stb r16, 0(r9)
addi r9, r9, 1
add r15, r1, r23
ldb r16, 0(r15)
stb r16, 0(r9)
movia r9, HEX_SEGMENTS
ldw r16, 0(r9)
movia r17, HEX3_HEX0
stwio r16, 0(r17)
ldw r12, 20(sp)
ldw r11, 16(sp)
ldw r8, 12(sp)
ldw r16, 8(sp)
ldw r15, 4(sp)
ldw r9, 0(sp)
addi sp, sp, 24
ret
.data
.skip 3
N: .byte 16
SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
HEX_SEGMENTS:
.fill 1, 4, 0
.end