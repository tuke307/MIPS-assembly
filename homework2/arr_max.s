# This program finds the max element in an array.
#
# INPUT: array
# OUTPUT: max element
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data
strmax:  .asciiz "The max element is: "
arr:     .word 10000, 5, 667, 3, 34, 121, 1, 2, 3, 40000
arrsize: .word 10

#
# code
#
.text
.globl main

main:
   lw $a1, arrsize   # size of array
   la $a0, arr       # base address of array

   la $t1, 1         # loop counter
   lw $t3, 0($a0)    # initialize max with the first element

for:
   bgt $t1, $a1, exit  # if loop counter is greater than size of array, exit loop
   lw $t4, 4($a0)    # load next array element into $t4 (next)
   bgt $t4, $t3, max # if next > max, go to max

   # Just increment loop counter and array address
   addi $t1, $t1, 1  # increment loop counter
   addi $a0, $a0, 4  # increment array address
   j for             # jump to for

max:
   move $t3, $t4     # move next into max
   addi $t1, $t1, 1  # increment loop counter
   addi $a0, $a0, 4  # increment array address
   j for             # jump to for

exit:
   # print the string
   li $v0, 4
   la $a0, strmax
   syscall

   # print the max element
   li $v0, 1
   move $a0, $t3
   syscall

   li $v0, 10
   syscall
