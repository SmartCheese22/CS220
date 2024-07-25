# fibonacci.s
#
# Print out first N Fibonacci numbers
#

.data
    request: .asciiz "Enter the value of N: "
    comma: .asciiz ", "
    newline: .asciiz "\n"
    end_prompt: .asciiz "\nThe program has ended.\n"

.text
.globl main

    main:
        # Print out the request for the user
        li $v0, 4
        la $a0, request
        syscall

        # Read in the value of N
        li $v0, 5
        syscall

        addi $sp, $sp, -8
        sw $v0, 0($sp)
        sw $ra, 4($sp)

        #loop counter
        li $s0, 0

    loop:
        #check condition
        lw $t0, 0($sp)
        blt $t0, $s0, exit

        #calling and printing the fibonacci number
        addi $a0, $s0, 0
        jal fib
        move $a0, $v0
        li $v0, 1
        syscall

        #print comma  (except for the last number)
        lw $t0, 0($sp)
        ble $t0, $s0, exit
        li $v0, 4
        la $a0, comma
        syscall

        addi $s0, $s0, 1
        j loop
    exit:
        # Print out the end prompt
        li $v0, 4
        la $a0, end_prompt
        syscall
        lw $ra, 4($sp)
        addi $sp, $sp, 8
        jr $ra
    fib:
        addi $t0, $0, 1
        bgt	$a0, $t0, recursion	# if $a0 > $t0 then goto recursion
        move $v0, $a0
        jr $ra
    recursion:
        addi $sp, $sp, -12
        sw $ra, 8($sp)
        sw $a0, 4($sp)

        # calling f(n-1)
        addi $a0, $a0, -1
        jal fib
        sw $v0, 0($sp)

        #calling f(n-2)
        lw $a0, 4($sp)
        addi $a0, $a0, -2
        jal fib

        #adding the two results
        lw $t0, 0($sp)
        add $v0, $v0, $t0
        lw $ra, 8($sp)
        addi $sp, $sp, 12
        jr $ra
        


        


        