#N = SW[3:0], M = [7:4] viết hàm con tính r16 = Ước
#chung (LN M&N) xuất ra LEDRED

#if (a == 0 || b == 0){
#return a + b;
#}
#while (a != b){
#if (a > b){
#a -= b; // a = a - b
#}else{
# b-= a;
#}
#}
#return a;

.text
.equ G_LED, 0xFF200000
.equ SW, 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global_start _start:
movia r5, SW
movia r6, G_LED
movia sp, SDRAM_END - 3
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[3:0]
andi r2, r7, 0xF
#N = SW[7:4]
srli r3, r7, 4
andi r3, r3, 0xF
call CHIA
br LOOP
CHIA:
subi sp, sp, 8
stw r3, 4(sp)
stw r2, 0(sp)
beq r2, r0, ADD
beq r3, r0, ADD
FOR:
beq r2, r3, DONE
bgt r2, r3, A
bgt r3, r2, B
br FOR
A:
sub r2, r2, r3
movi r1, 1
bgt r1, r2, DONE
br FOR
B:
sub r3, r3, r2
movi r1, 1
bgt r1, r3, DONE
br FOR
ADD:
add r2, r3, r2
DONE:
stwio r3,(r6)
ldw r3, 4(sp)
ldw r2, 0(sp)
addi sp, sp, 8
ret
.data
.end