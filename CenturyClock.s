.equ HIEN_THI, 1
.data 
rows:
.word 0x00000000 #row0
.word 0x00000001 #row1
.word 0x00000002 
.word 0x00000003
columns:
.word 0x00000000
.word 0x00010000
.word 0x00020000

num1:
#row0 
.word 0x00000000
.word 0x00000000
.word 0x00FF0000  # Chấm đỏ đầu tiên
#row1
.word 0x00000000
.word 0x00FF0000  # Chấm đỏ thứ hai
.word 0x00FF0000  # Chấm đỏ thứ ba
#row2
.word 0x00000000
.word 0x00000000
.word 0x00FF0000
#row3
.word 0x00000000
.word 0x00000000
.word 0x00FF0000
number:
.byte 0x01,0x02  # Offset để hiển thị số 1 ở hàng 1, cột 2
.text 
.globl main

main : 
    loop:
        li a0, 0x100

        li a3, 1
        li s0, HIEN_THI
        jal display_number
        j loop
    display_number:
        la a4, rows
        la a5, columns
        li t0,1
        beq a3,t0, equal_1
    equal_1:
        la a6,num1
        j next_1
    next_1:
        li t0, HIEN_THI
        beq s0,t0, hien_thi
    hien_thi:
        la a7, number
        j next_2
    next_2:
        li t0,0
        li t1,0
        li t2,0
loop_i: 
    slli s0, t0, 2  # s0 = t0 * 4 (since each .word is 4 bytes)
    add s0, a4, s0  # s0 = base address of rows + (i * 4)
    lw a1, 0(s0)    # Load the word at address s0 into a1
loop_j:
    slli s0, t1, 2 # s0 = t0 * 4 (since each .word is 4 bytes)
    add s0, a5, s0 # s0 = base address of columns + (i * 4)
    lw a2, 0(s0)

    lb s0, 0(a7) # y_offset
    lb s1, 1(a7) # x_offset
    slli s0, s0, 16
    add a2, a2, s0
    add a2, a2, s1

    mv s3, a1
    add a1, a2, a1 # pixel coordinates

    slli s0, t2, 2 # s0 = t2 * 4 (since each .word is 4 bytes)
    add s0, a6, s0 # s0 = base address of nums + (count * 4)
    lw a2, 0(s0) # Pixel values
    addi t2, t2, 1 # count++

    ecall
    mv a1, s3
   
    addi t1, t1, 1 # j++
    li t3, 3 # 3 columns
    blt t1, t3, loop_j

    li t1,0
    addi t0, t0, 1 # i++
    li t3, 4 # 4rows
    ble t0, t3, loop_i
    ret
li a0, 0x100
la s0, logo
li s2, 0
li s3, 10
outer:
li s1, 0
inner:
lw a2, 0(s0)
slli a1, s2, 16
or a1, a1, s1
ecall
addi s0, s0, 4
addi s1, s1, 1
bne s1, s3, inner
addi s2, s2, 1
bne s2, s3, outer
li a0, 10
li a1, 0
ecall


.data
logo:
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x00000000
.word 0x00000000
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x002A3172
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00F6B21A
.word 0x00000000
.word 0x00000000
.word 0x002A3172
.word 0x002A3172



