.data
my_fib: .string "my_fib = "
my_num: .string "my_num = "
newline: .string "\n"

.text
main:
    # my_num = 4
    li x23, 4

    # call fib_iter(12)
    li a0, 12
    jal ra, fib_iter
    mv x24, a0       # my_fib = return

    addi x23, x23, 1 # my_num++

    # printf("my_fib = %d\n", my_fib)
    li a0, 4
    la a1, my_fib
    ecall
    li a0, 1
    mv a1, x24
    ecall
    li a0, 4
    la a1, newline
    ecall

    # printf("my_num = %d\n", my_num)
    li a0, 4
    la a1, my_num
    ecall
    li a0, 1
    mv a1, x23
    ecall
    li a0, 4
    la a1, newline
    ecall

    # exit
    li a0, 10
    ecall

fib_iter:
    mv x18, a0          # n = argument
    li x19, 0           # curr_fib = 0
    li x20, 1           # next_fib = 1
    mv x22, x18         # i = n

fib_loop:
    blez x22, fib_end   # if i <= 0 break

    add x21, x19, x20   # new_fib = curr_fib + next_fib
    mv x19, x20         # curr_fib = next_fib
    mv x20, x21         # next_fib = new_fib
    addi x22, x22, -1   # i--

    j fib_loop

fib_end:
    mv a0, x19          # return curr_fib
    jr ra
