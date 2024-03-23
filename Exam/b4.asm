#N = SW[4:1], M = [8:5] viết hàm con tính r16 = M mod N
#xuất ra LEDRED

#While(M>N)
#{
#M = M - N;
#If( M = N)
#M = 0;
#}

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
#N = SW[4:1]
srli r3, r7, 1
andi r3, r3, 0xF
#N = SW[8:5]
srli r2, r7, 5
andi r2, r2, 0xF
call CHIA
br LOOP
CHIA:
subi sp, sp, 8
stw r3, 4(sp)
stw r2, 0(sp)
FOR:
beq r2, r3, E
blt r2, r3, DONE
sub r2, r2, r3
br FOR
E:
movi r2, 0
br FOR
DONE:
stwio r2,(r6)
ldw r3, 4(sp)
ldw r2, 0(sp)
addi sp, sp, 8
ret
.data
.end