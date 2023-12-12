# Compute the factorial of n iteratively
#
# INPUT: n
# OUTPUT: n!
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data                              
n: .word 3

#
# code
#
.globl main
.text

main:
   # Load n into $a0
   lw $a0, n

   # Call the fact function
   jal fact

   # Print the result
   move $a0, $v0  # Move result to $a0
   li $v0, 1      # Set syscall code for printing integer
   syscall         # Print result

   # Exit the program
   li $v0, 10     # Set syscall code for exit
   syscall         # Exit program

fact:
   # Move n into $t0
   move $t0, $a0  

   # Initialize the result to 1
   li $v0, 1

   for:
      # If we've reached n+1, exit the loop
      beq $t0, $0, done

      # Multiply the result by the current number
      mul $v0, $v0, $t0

      # Increment the current number
      subi $t0, $t0, 1

      # Jump back to the beginning of the loop
      j for

   done:
      # Return the result in $v0
      jr $ra
