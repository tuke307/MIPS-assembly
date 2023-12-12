# approximate e^-x
# e^-x = 1 - (x/1!) - (x^2/2!) - x^3/3!
#
# INPUT: x
# OUTPUT: e^-x
#
# AUTHOR: Tony Meißner

#
#	data section
#
.data
prompt:      .asciiz "Geben Sie einen Wert für x ein: "
resultStr:   .asciiz "Das Ergebnis ist: "


#
#	code
#
.globl main
.text
main:
    # print string prompt
    li      $v0, 4            
    la      $a0, prompt       
    syscall                   

   # read integer from input
    li      $v0, 5           
    syscall                  
    move    $t0, $v0          

    # 1 - x/1!
    li      $t1, 1            # load 1 to $t1
    sub     $t1, $t1, $t0     # $t1 = 1 - x

    # x^2/2!
    mul     $t2, $t0, $t0     # $t2 = x^2
    li      $t3, 2            # load 2 to $t3
    div     $t2, $t3          # divide x^2 by 2
    mflo    $t2               # move the quotient to $t2

    add     $t1, $t1, $t2     # add x^2/2! to the result

    # -x^3/3!
    mul     $t2, $t0, $t0     # $t2 = x^2
    mul     $t2, $t2, $t0     # $t2 = x^3
    li      $t3, 6            # load 6 to $t3 (3!)
    div     $t2, $t3          # divide x^3 by 6
    mflo    $t2               # move the quotient to $t2

    sub     $t1, $t1, $t2     # subtract x^3/3! from the result

    # print string resultStr 
    li      $v0, 4           
    la      $a0, resultStr    
    syscall                   

   # print integer result
    move    $a0, $t1          
    li      $v0, 1            
    syscall                   

    # Beende das Programm
    li      $v0, 10           # syscall code for exit
    syscall                   # terminate the program
