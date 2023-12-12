# programm to show the usage of a syscall to print a string to the console
#
# INPUT: -
# OUTPUT: -
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data                              # directive indicating the start of the data declarations
str1: .asciiz "Hello World!"       # define string variable as ascii string terminating with a zero byte (asciiz)


#
# code
#
.globl main    # define main marker as global label
.text          # directive indicating the start of the program definition

main:                # label indicating the start of the main program
      la $a0, str1   # load addresse (not content) of string into argument register $a0
      li $v0, 4      # load immidiate constant 4 into $v0 to be interpreted by syscall as code for print_string
      syscall        # reads $v0 -> print_string behind address in $a0 -> prints str1 to console