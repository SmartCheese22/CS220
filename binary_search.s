# binary_search.s
#   PB   
# Always allocate the array first so that you don't get a mis-alignment error later!
# date: 4/18/2024
.data
    array: .space 48
    prompt: .asciiz "Enter a the Value of N: "
    request: .asciiz "Enter the array Values line by line: \n"
    request_k: .asciiz "Enter the value of K: "
    found_prompt: .asciiz "The value K is found at index: "
    not_found_prompt: .asciiz "The value K is not found in the array"
    newline:  .asciiz "\n"

.text
.globl main

    main:
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall

        move $t0, $v0   # $t0 = N
        la $t1, array
        li $s0, 0

        li $v0, 4
        la $a0, request
        syscall

    loop_input:
        li $v0, 5
        syscall

        sw $v0, 0($t1)
        addi $t1, $t1, 4
        addi $s0, $s0, 1
        bne $s0, $t0, loop_input

        li $s0, 0   # $s0 = 0
        la $t1, array   # $t1 = &array[0]

        li $v0, 4
        la $a0, request_k
        syscall

        li $v0, 5
        syscall
        move $t2, $v0   # $t2 = K

        xor $t3, $t3, $t3   # $t3 = 0
        addi $t4, $t0, -1  # $t4 = N - 1
    binary_search:
        bgt $t3, $t4, not_found  # if low > high, not found
        add $t5, $t3, $t4  # $t5 = low + high
        srl $t5, $t5, 1     # $t5 = (low + high) / 2

        sll $t6, $t5, 2     # $t6 = mid * 4
        add $t6, $t6, $t1   # $t6 = &array[mid]
        lw $t6, 0($t6)      # $t6 = array[mid]

        beq $t6, $t2, found # if array[mid] == K, found
        bgt $t6, $t2, decrease_high  # if array[mid] > K, high = mid - 1
        addi $t3, $t5, 1    # low = mid + 1
        j binary_search
    decrease_high:
        addi $t4, $t5, -1   # high = mid - 1
        j binary_search
    found:
        li $v0, 4
        la $a0, found_prompt
        syscall

        move $a0, $t5
        li $v0, 1
        syscall

        j exit
    not_found:
        li $v0, 4
        la $a0, not_found_prompt
        syscall

        j exit
    exit:
        li $v0, 4
        la $a0, newline
        syscall
        jr $ra






