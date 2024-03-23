.text
.equ SWITCHES, 0x10000040
.equ REDLEDS,  0x10000000
.global _start
_start:
   movia r6, SWITCHES
   ldwio r1, 0 (r6)
   movia r7, REDLEDS
   movi r2, 1
   movi r3, 1
   movi r4, 0
   movi r5, 0
   br TinhLuyThua
PhepNhan:
   addi r5, r5, 1
   bgt r5, r1, TinhLuyThua
   add r3, r3, r2
   br PhepNhan
TinhLuyThua:
   addi r4, r4, 1
   bgt r4, r1, KetQua
   mov r2, r3
   movi r3, 0
   mov r5, r0
   br PhepNhan
KetQua:
   stwio r3, 0(r7)
   br Stop
Stop:
   br Stop