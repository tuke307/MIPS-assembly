# convert Fahrenheit to Celsius and handle absolute zero point
#
# INPUT: Fahrenheit temperature
# OUTPUT: Celsius temperature or -273.15 if below absolute zero
#
# AUTHOR: Tony Meißner

#
# Data section
#
.data
const5: .float 5.0
const9: .float 9.0
const32: .float 32.0

prompt: .asciiz "Enter the Fahrenheit temperature: "
below_absolute_zero_value: .float -273.15


#
#	code
#
.globl main
.text

main:
   # Print a prompt for user input
   li $v0, 4
   la $a0, prompt
   syscall

   # Read input from the user into $f0
   li $v0, 6
   syscall

   # Store the user input ($f0) into $f12
   mov.s $f12, $f0

   # Call the f2c function
   jal f2c

   # Check if the result is below absolute zero (-273.15)
   lwc1 $f25, below_absolute_zero_value  # Load -273.15 into $f25
   c.lt.s $f0, $f25  # if $f0 < -273.15 then code = 1 else code = 0
   bc1t below_absolute_zero  # if code == 1 then jump to below_absolute_zero 
   
   # Load the result into $f12 and print it
   mov.s $f12, $f0
   li $v0, 2
   syscall
   j exit

below_absolute_zero:
   # Load the result into $f12 and print it
   mov.s $f12, $f25
   li $v0, 2
   syscall
   j exit
   

exit:
   # Exit the program
   li $v0, 10
   syscall

f2c:
   # load constants
   lwc1 $f18, const5
   lwc1 $f20, const9
   lwc1 $f24, const32

   # compute result
   div.s $f22, $f18, $f20  # $f24 = 5.0/9.0
   sub.s $f0, $f12, $f24 # $f0 = fahr - 32.0
   mul.s $f0, $f22, $f0 # $f0 = (5.0/9.0) * (fahr - 32.0)
  
   jr $ra
