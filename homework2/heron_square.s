# Heron's method for computing the square root of a number
#
# INPUT: 
# OUTPUT: 
#
# AUTHOR: Tony Meißner
#
# INFO: 3 iterations are enough for the correct 4 digits after the decimal point

#
# data declarations
#
.data
a:    .float 49
two:  .float 2
iter: .word 5  # Iteration count

#
# code
#
.text
.globl main

main:
   # $f2 = a, Load value of a into $f2
   lwc1 $f2, a

   # $t0 = iter, Initialize counter $t0 to iter (iteration count)
   lw $t0, iter

   # $f3 = a/2, Initial approximation
   lwc1 $f4, two
   div.s $f3, $f2, $f4

for:
   beq $t0, $zero, end  # if counter $t0 is zero, exit loop

   # Next iteration: $f5 = 0.5 * ($f3 + a/$f3)
   div.s $f6, $f2, $f3
   add.s $f5, $f3, $f6
   div.s $f5, $f5, $f4

   mov.s $f3, $f5    # $f3 = $f5
   
   sub $t0, $t0, 1   # Decrement counter $t0
   j for

end:
   # print $f3
   li $v0, 2
   mov.s $f12, $f3
   syscall

   li $v0, 10
   syscall
