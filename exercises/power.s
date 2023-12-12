# programm to compute the power of a number
#
# INPUT: x, k
# OUTPUT: x^k
#
# AUTHOR: Tony Meißner
#
# INFO:
# highest number in 32 bit: 2 147 483 647
# every result over 2 147 483 647 will be wrong! (for example 2^31 = -2 147 483 648)

#
#	data section
#
.data
prompt:      .asciiz "This program calculates x^k."
promptX:      .asciiz "type a value for x: "
promptK:      .asciiz "type a value for k: "
resultStr:    .asciiz "x^k is: "
newline: .asciiz "\n"

#
#	code
#
.globl main
.text

main:
   # print prompt
   li      $v0, 4            
   la      $a0, prompt      
   syscall 

   la $a0, newline
   li $v0, 4
   syscall       

   # print promptX
   li      $v0, 4            
   la      $a0, promptX
   syscall                   

   # read integer x to $t0
   li      $v0, 5           
   syscall                  
   move    $t0, $v0  

   # print promptK
   li      $v0, 4            
   la      $a0, promptK    
   syscall                   

   # read integer k to $t1
   li      $v0, 5           
   syscall                  
   move    $t1, $v0 

   # move values to arguments register, to use them in the power function
   move    $a0, $t0
   move    $a1, $t1
   jal power
     
   # move returned value from argument register to temporary register
   move   $t0, $a0

   # print the resultStr
   la      $a0, resultStr
   li      $v0, 4
   syscall

   # print the result value
   move    $a0, $t0
   li      $v0, 1
   syscall

   # Exit the program
   li      $v0, 10
   syscall

# function to calculate x^k
power:
   # save arguments in temporary registers
   move    $t0, $a0
   move    $t1, $a1
   li     $t2, 1 # save 1 in $t2

   loop:
      beq     $t1, $zero, end # goto end if k >= 0
      mul     $t2, $t2, $t0 # multiply x with x
      addi    $t1, $t1, -1 # decrement k
      j       loop

   end:
      move   $a0, $t2
      jr     $ra
