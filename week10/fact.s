.data
string: .string "result is "
newline: .string "\n"

.text
main:
    # call fact(10)
    li a0, 10
    jal ra, fact
    mv x18, a0     # result = return value

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


# -------------------------
fact:
    mv x19, a0       # n = argument

    beq x19, x0, fact_base  # if (n == 0) return 1

    # save ra and n before recursion
    addi sp, sp, -8
    sw ra, 4(sp)
    sw x19, 0(sp)

    # recursive call fact(n-1)
    addi a0, x19, -1
    jal ra, fact

    # load n back
    lw x19, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8

    # result = return * n
    mul x20, a0, x19
    mv a0, x20
    jr ra

fact_base:
    li a0, 1
    jr ra
