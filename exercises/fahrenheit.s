
# Program to convert Fahrenheit to Celsius and handle absolute zero point
#
# INPUT: Fahrenheit temperature
# OUTPUT: Celsius temperature or -273.15 if below absolute zero
#
# equivalent C program:
# float f2c (float fahr)
# {
#	return cel= (5.0/9.0) * (fahr - 32.0);
# }

#
#	data section
#
.data
const5: .float 5.0
const9: .float 9.0
const32: .float 32.0

input: .float 33.0

#
#	code
#
.globl main
.text

main:
	# load input and call function
	lwc1 $f12, input
   jal f2c

   # print result
   mov.s $f12, $f0
   li $v0, 2
   syscall

   # exit
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
	