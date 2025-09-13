.data
string: .string "result is "
newline: .string "\n"

.text
main:
    # foo(3, 5)
    li a0, 3       # x = 3
    li a1, 5       # n = 5
    jal ra, foo
    mv x18, a0     # result = return

    # printf("result is %d\n", result)
    li a0, 4
    la a1, string
    ecall

    li a0, 1
    mv a1, x18
    ecall

    li a0, 4
    la a1, newline
    ecall

    # exit
    li a0, 10
    ecall


foo:
    addi sp, sp, -8
    sw ra, 4(sp)

    mv x19, a0     # x
    mv x20, a1     # n
    li x22, 0      # sum = 0
    li x21, 0      # i = 0

foo_loop:
    bge x21, x20, foo_after_loop
    add x22, x22, x19   # sum += x
    addi x21, x21, 1
    j foo_loop

foo_after_loop:
    # bar(10)
    li a0, 10
    jal ra, bar
    add x22, x22, a0

    mv a0, x22     # return sum
    
    lw ra, 4(sp)
    addi sp, sp, 8
    jr ra

bar:
    mv x23, a0     # n
    li x25, 0      # sum = 0
    li x24, 0      # i = 0

bar_loop:
    bge x24, x23, bar_end
    addi x26, x24, 1    # temp = i+1
    add x25, x25, x26   # sum += i+1
    addi x24, x24, 1
    j bar_loop

bar_end:
    mv a0, x25
    jr ra
