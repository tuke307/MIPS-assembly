# calculate 2*A + 3*B
#
# INPUT: A, B
# OUTPUT: 2*A + 3*B
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data
str1: .asciiz "Enter the First Operand: "
str2: .asciiz "Enter the Second Operand: "
str3: .asciiz "2*A + 3*B is "
str4: .asciiz " Done [0 = Yes, 1 = No]: "
newline: .asciiz "\n"
c: .word 0

#
# code
#
.globl main    # main is declared as a global marker, can be accessed from other files
.text          # marks the start of the instructions, i.e. the program

main:
   ### Get Input
   la $a0, str1   # load string address into $a0
   li $v0, 4      # load print_string code into $v0
   syscall        # print str1

   li $v0, 5      # load read_int code into $v0
   syscall
   move $t0, $v0  # place the read value into register $t0
   add $t0, $t0, $t0 # double the value

   la $a0, str2   # load address of string 2 into register $a0
   li $v0, 4      # load print_string code into $v0
   syscall        # print str2

   li $v0, 5      # load read_int code into $v0
   syscall
   move $t1, $v0  # place the read value into register $t1
   add $t1, $t1, $t1 # double the value
   add $t1, $t1, $v0 # double the value


   ### Performe calculation
   add $t2, $t1, $t0  # perform addition C = 2*A + 3*B
   sw $t2, c         # store the result in memory

   ### Print result
   la $a0, str3   # load address of string 3 into register $a0
   li $v0, 4      # load print_string code into $v0
   syscall        # print str3

   li $v0, 1      # print_int A + B to the console window
   move $a0, $t2   # move the result into register $a0
   syscall

   la $a0, newline   # print the new line character to put the screen cursor to a newline
   li $v0, 4
   syscall

   ### Restart program with different input?
   la $a0, str4   # load address of string 5 into register $a0
   li $v0, 4      # load print_string code to console
   syscall        # print str4

   li $v0, 5      # read an integer from the console
   syscall

   bne $v0, $zero, main   # if not complete (i.e., not 0 was provided) then start at the beginning

   ### Exit
   li $v0, 10      # syscall code 10 for terminating the program
   syscall