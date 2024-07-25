# fibonacci.s
#
# Print out first N Fibonacci numbers
#

        .data
prompt:   .asciiz "Please Enter the value of N: "
newline:  .asciiz "\n"
end_prompt: .asciiz "The program completed Successfully!\n"

        .text
        .globl main
main:   li $v0, 4       # syscall 4 (print_str)
        la $a0, prompt     # argument: string
        syscall         # print the string
        li $v0, 5       # syscall 5 (read_int)
        syscall         # read an integer
        move $t0, $v0      # save the integer in $t0
        li $t1, 0       # $t1 = 0
        li $t2, 1       # $t2 = 1
        li $v0, 1       # syscall 1 (print_int)
        move $a0, $t1      # argument: $t1
        syscall         # print $t1
        li $v0, 4       # syscall 4 (print_str)
        la $a0, newline    # argument: string
        syscall         # print the string
        li $v0, 1       # syscall 1 (print_int)
        move $a0, $t2      # argument: $t2
        syscall         # print $t2
        li $v0, 4       # syscall 4 (print_str)
        la $a0, newline    # argument: string
        syscall         # print the string
        addi $t0, $t0, -1  # $t0 = $t0 - 2
loop:   add $t3, $t1, $t2  # $t3 = $t1 + $t2
        li $v0, 1       # syscall 1 (print_int)
        move $a0, $t3      # argument: $t3
        syscall         # print $t3
        li $v0, 4       # syscall 4 (print_str)
        la $a0, newline    # argument: string
        syscall         # print the string
        addi $t1, $t2, 0   # $t1 = $t2
        addi $t2, $t3, 0   # $t2 = $t3
        addi $t0, $t0, -1  # $t0 = $t0 - 1
        bne $t0, $zero, loop  # if $t0 != 0, goto loop
        li $v0, 4       # syscall 4 (print_str)
        la $a0, end_prompt # argument: string
        syscall         # print the string
        li $v0, 10      # syscall 10 (exit)
        syscall         # exit
        jr $ra          # retrun to caller
