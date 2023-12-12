# programm to calculate v[i] = i^2 for i = 0 to 19
#
# INPUT: -
# OUTPUT: v[0], v[1], ..., v[19]
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data
v: .word 0:20 # initialize v to 20 zeros
newline: .asciiz "\n" # newline string

#
# code
#
.globl main
.text

# calculate v[i] = i^2 for i = 0 to 19
main:
   li $t0, 0 # initialize i to 0

loop:
    slti $t1, $t0, 20 # check if i < 20
    beq $t1, $zero, done # if i >= 20, exit loop
    mul $t2, $t0, $t0 # calculate i^2
    sw $t2, v($t0) # store i^2 in v[i]
    addi $t0, $t0, 1 # increment i
    j loop # repeat loop

done:
    # print values of v
    li $t0, 0 # initialize i to 0

print_loop:
    slti $t1, $t0, 20 # check if i < 20
    beq $t1, $zero, exit # if i >= 20, exit loop
    lw $a0, v($t0) # load v[i] into $a0
    li $v0, 1 # set syscall code for printing integer
    syscall # print v[i]
    li $v0, 4 # set syscall code for printing string
    la $a0, newline # load address of newline string into $a0
    syscall # print newline
    addi $t0, $t0, 1 # increment i
    j print_loop # repeat loop

exit:
    # code to exit program
    li $v0, 10 # set syscall code for exit
    syscall # exit program