# programm to find the first position where the average of two consecutive
#
# INPUT: array a
# OUTPUT: first position where average > 5
#
# AUTHOR: Tony Meißner

#
# Data section
#
.data
.align 2
a:      .word 1, 7, 20, 1, 2, 2, 4, 3, 9, 1
msg:    .asciiz "Erster Mittelwert > 5 ist "
msg2:   .asciiz " an Position "


#
#	code
#
.globl main
.text


main:
    # initialize variables
    li     $t0, 0         # tmp = 0
    li     $t1, 0         # i = 0
    la     $t2, a         # save base adress from a in $t2

loop:
    # check the while condition
    bgt    $t0, 5, exit   # if tmp > 5 exit the loop
    bge    $t1, 9, exit   # if i >= 9 exit the loop

    # tmp = (a[i] + a[i+1]) / 2
    lw     $t3, 0($t2)   # a[i] in $t3 laden
    lw     $t4, 4($t2)   # a[i+1] in $t4 laden
    add    $t3, $t3, $t4 # a[i] + a[i+1]
    li     $t4, 2        # 2 in $t4 laden
    div    $t3, $t4      # (a[i] + a[i+1]) / 2
    mflo   $t0           # Quotient nach $t0 bewegen (tmp)

    # i = i + 1
    addi   $t1, $t1, 1   # $t1 (i) um 1 erhöhen
    addi   $t2, $t2, 4   # Nächsten Index im Array a erreichen
    j      loop

exit:
    # printf
    li     $v0, 4        # syscall code for print string
    la     $a0, msg      # Basisadresse der Nachricht laden
    syscall

    move   $a0, $t0      # tmp-Wert für %d setzen
    li     $v0, 1        # syscall code for print int
    syscall

    li     $v0, 4        # syscall code for print string
    la     $a0, msg2     # Basisadresse von " an Position "
    syscall

    move   $a0, $t1      # i-Wert für %d setzen
    li     $v0, 1        # syscall code for print int
    syscall

    # Programmende
    li     $v0, 10       # syscall code for exit
    syscall
