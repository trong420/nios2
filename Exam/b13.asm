#Với N là sô 8-bit được đọc từ 8 bit cuối Slider Switch – SW[7:0]. Thực hiện viết chương trình assembly kiểm tra N có
#phải là số nguyên tố hay không, nếu là số nguyên tố thì toàn
#bộ RED_LED sáng, ngược lại thì tắt. Lưu ý: Viết hàm con thực công việc kiểm tra số nguyên tố.

.text
.equ SW, 0xFF200040
.equ RED_LED, 0xFF200000
.equ SDRAM_END, 0x03FFFFFF #1
.global main
main:
movia sp, SDRAM_END-3 #2
movia r6, SW
movia r10, RED_LED
FOR:
ldwio r11, (r6)
andi r11, r11, 0xFF # r8 = N
movi r12,1
call FOR1
br FOR
FOR1:
subi sp, sp, 12
stw r13, 8(sp)
stw r12, 4(sp)
stw r11, 0(sp)
ble r11,r12,DONE
slli r12,r12,1 #r12=2 (1<<1=2)
beq r11,r12,PHAI
mov r13,r11
br CHIA
CHIA:
sub r13,r13,r12
bge r13,r12,CHIA
beq r13,r0,KHONG
br LOOP
LOOP:
addi r12,r12,1
mov r13,r11
bge r12,r13,PHAI
br CHIA
KHONG:
movi r5,0
br DONE
PHAI:
movi r5, 0x3FF
br DONE
DONE:
stwio r5,0(r10)
ldw r13, 8(sp)
ldw r12, 4(sp)
ldw r11, 0(sp)
addi sp, sp, 12
ret
.data
.end