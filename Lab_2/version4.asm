# Sum of squares example
# switch to the Text segment
        .text
        .globl  main
main:
        addiu   $sp, $sp, -32
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)

        li      $t6, 0          # i = 0
        li      $t8, 0          # sum = 0

loop:
        mul     $t7, $t6, $t6   # t7 = i * i
        addu    $t8, $t8, $t7   # sum += i * i
        addiu   $t0, $t6, 1     # i = i + 1
        move    $t6, $t0
        ble     $t6, 100, loop

        la      $a0, str1
        jal     Print_string

        move    $a0, $t8
        jal     Print_integer

        la      $a0, str2
        jal     Print_string

        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        addiu   $sp, $sp, 32

        jal     Exit0
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# switch to the Data segment
        .data
        # global data is defined here
str1:
        .asciiz "The sum from 0 .. 100 is :"
str2:
        .asciiz ":\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Wrapper functions around some of the system calls
# See P&H COD, Fig. A.9.1, for the complete list.
# switch to the Text segment
        .text
        .globl  Print_integer
Print_integer:  # print the integer in register $a0
        li      $v0, 1
        syscall
        jr      $ra
        .globl  Print_string
Print_string:   # print the string whose starting address is in register $a0
        li      $v0, 4
        syscall
        jr      $ra
        .globl  Exit
Exit:           # end the program, no explicit return status
        li      $v0, 10
        syscall
        jr      $ra     # this instruction is never executed
        .globl  Exit0
Exit0:          # end the program, default return status
        li      $a0, 0  # return status 0
        li      $v0, 17
        syscall
        jr      $ra     # this instruction is never executed
        .globl  Exit2
Exit2:          # end the program, with return status from register $a0
        li      $v0, 17
        syscall
        jr      $ra     # this instruction is never executed
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -