#N = SW[3:0] viết hàm con tính S = 2 + 4 + 6 + … + 2N
#xuất REDLED
#S = S + 2*n ;

.text
.equ G_LED, 0xFF200000
.equ SW, 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global_start _start:
movia r5, SW
movia r6, G_LED
movia sp, SDRAM_END - 3
movi r2, 0
movi r3, 0
#N/M = r16
LOOP:
ldwio r7, (r5)
#N = SW[3:0]
andi r4, r7, 0xF
#N = SW[5:2]
#srli r4, r7, 2
#andi r4, r4, 0xF
call CHIA
br LOOP
CHIA:
subi sp, sp, 8
stw r3, 4(sp)
stw r2, 0(sp)
FOR:
add r3, r3, r2
add r3, r3, r2
addi r2, r2, 1
blt r4, r2, DONE
br FOR
DONE:
stwio r3,(r6)
ldw r3, 4(sp)
ldw r2, 0(sp)
addi sp, sp, 8
ret
.data
.end