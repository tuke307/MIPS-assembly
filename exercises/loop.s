# programm to show the usage of a for loop
#
# INPUT: -
# OUTPUT: -
#
# AUTHOR: Tony Meißner

#
#	data section
#
.data
n: .word 3

#
#	code
#
.globl main
.text

main:
   li $s0, 0    # i = 0
   li $s1, 0    # sum = 0
   lw $s2, n    # n = 3

for: 
   bge $s1, $s2, endFor

   # code within loop
   add $s0, $s0, $s0

   addi $s1, $s1, 1
   j for

endFor:
   # print output
   move $a0, $s0
   li $v0, 1
   syscall