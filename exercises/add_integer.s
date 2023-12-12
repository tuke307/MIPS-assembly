# add two integers
#
# INPUT: n, v
# OUTPUT: sum
#
# AUTHOR: Tony Meißner

#
# data declarations
#
.data
n: .word 20
v: .space 80
sp: .asciiz " "
sl: .asciiz "/"

#
# code
#
.globl main
.text

main:
    li $s0, 0 # sum
    li $s1, 0 # i
    lw $s2, n # n

for: 
    bge $s1, $s2, endFor

    ### code for loop

    mul $t0, $s1, $s1 # i * i
    add $t1, $t0, $t1 # aufaddieren

    mul $t5, $s1, 4 # i * 4

    sw $t0, v($t5) # speichern von (i * i) in ram

    ###
    addi $s1, $s1, 1
    j for
endFor:

    div $s0, $t1, 20 # teilen durch 20 fuer durchschnitt

    mflo $s0  # mflo ist Ganzzahl   (Speichern in $s0) (ist technically irrelevant)
    mfhi $s1  # mfhi ist Rest       (Speichern in $s1)

    # print output
    move $a0, $s0   # Vorkommazahl
    li $v0, 1
    syscall

    la $a0, sp      # Leerzeichen
    li $v0, 4
    syscall

    move $a0, $s1   # Rest (Zähler)
    li $v0, 1
    syscall

    la $a0, sl      # Slash /
    li $v0, 4
    syscall

    move $a0, $s2   # Nenner
    li $v0, 1
    syscall
