# Program to generate an array of Fibonacci numbers with a given size.
#
# INPUT: Size of the array (n).
# OUTPUT: An array containing Fibonacci numbers.
#
# Parameter registers:
# $a0 = Used for string printing (prompts)
# $f0 = Used for floating point return values and print syscall.
#
# $f13 = Base address of the array.
# $a2 = n (size of the array).
#
# Temporary registers:
# $t0 = Temporary storage for integer values before conversion to float.
# $f2 = Temporary storage for floating point calculations.
# $t3 = Address pointer for array traversal.
# $t4 = Loop counter (i).
#
# Initialization:
# The first two numbers in the Fibonacci sequence are set as 0 and -1 respectively.
# The subsequent numbers are calculated as the sum of the previous two numbers.
#
# Note:
# The program assumes that the user enters a valid size for the Fibonacci sequence.
#
# code
#
.data
prompt:    .asciiz "Enter the size of the array: "
printElem: .asciiz "\nArray: "
space:     .asciiz "  "
newLine:   .asciiz "\n"
iString: .asciiz "\ni = "
jString: .asciiz "\nj = "
minidxString: .asciiz "\nminidx = "

.text
.globl main

main:
   # Print the prompt
   li $v0, 4
   la $a0, prompt
   syscall

   # Read the size of the array into $a2 (as an integer)
   li $v0, 5
   syscall
   move $a2, $v0

   # Allocate memory for the array
   li $v0, 9
   move $a0, $a2
   syscall
   mtc1 $v0, $f13 # Store the base address of the array in $f13
   
   jal fillArray
   jal printArray
   jal selectionSort
   jal printArray

   # Exit
   li $v0, 10
   syscall

fillArray:
   mfc1 $t3, $f13  # Set start-address of array to $t3
   li $t4, 2      # Set i to 2
   move $t5, $a2  # set n to $t5

   # hardcode the first element: arr[0] = 0
   li $t0, 0         # store 0 in $t0
   mtc1 $t0, $f2     # load integer into floating-point register
   cvt.s.w $f2, $f2  # Convert integer to float
   s.s $f2, 0($t3)   # Store float in array

   li $t0, -1        # store -1 in $t0
   mtc1 $t0, $f2     # load integer into floating-point register
   cvt.s.w $f2, $f2  # Convert integer to float
   s.s $f2, 4($t3)   # Store float in array   

   addi $t3, $t3, 8  # go third element in array arr[3]

   # Generate Fibonacci numbers using floating-point operations
   fillElement:
      bge $t4, $t5, fillElementEnd  # go to end if i >= n

      # first calculation = arr[i - 1] + arr[i - 2]
      l.s $f3, -4($t3)  # load the previous value arr[i-1]
      l.s $f1, -8($t3)  # load the value before the previous value arr[i-2]
      add.s $f1, $f3, $f1 # add the previous two values arr[i]
      
      # function to calculate y=(-1)^i, $t2=$t0^$t1
      # we cant outsource this function because we already used jal
      # input: $t4 = i
      # output: $f5 = y
      power:
         # save arguments in temporary registers
         li    $t0, -1
         move   $t1, $t4 # move from float point register to temp
         li     $t2, 1 # save 1 in $t2

         loop:
            beq     $t1, $zero, end # goto end if k >= 0
            mul     $t2, $t2, $t0 # multiply x with x
            addi    $t1, $t1, -1 # decrement i
            j       loop

         end:
            mtc1 $t2, $f5 # save the result in $f5
            cvt.s.w $f5, $f5  # Convert integer to float
      
      # second calculation = arr[i] * pow(-1, i)
      mul.s $f1, $f1, $f5 # multiply the result with (-1)^i

      # third calculation = arr[i] / 2
      li $t0, 2        # store 2 in $t0
      mtc1 $t0, $f2     # load integer into floating-point register
      cvt.s.w $f2, $f2  # Convert integer to float
      div.s $f1, $f1, $f2 # divide the result with 2

      s.s $f1, 0($t3)   # Store new Fibonacci number in the array

      addi $t3, $t3, 4 # Move to the next element in array
      addi $t4, $t4, 1 # Increment i by 1

      j fillElement

   fillElementEnd:
      # go back n*4 bytes of the array
      li $t6, 4        # Load 4 into $t6 (size of each element in bytes)
      mul $t6, $t6, $t5  # Multiply $t6 by $t5 to get the offset
      sub $t3, $t3, $t6  # Subtract the offset from $t3 to go back n*4 bytes in the array

      #addi $t3, $t3, -40

      # move $t3 back to $f13 
      mtc1 $t3, $f13

      jr $ra

printArray:
   mfc1 $t3, $f13  # Store start-address of array in $t3
   li $t4, 0      # Initialize i to 0
   move $t5, $a2  # set n to $t5

   # Print array title
   li $v0, 4
   la $a0, printElem
   syscall

   printElement:
      beq $t4, $t5, printElementEnd  # Go to end if i == n

      # Print float from array
      l.s $f12, 0($t3)
      li $v0, 2
      syscall

      # Print space
      li $v0, 4
      la $a0, space
      syscall

      addi $t3, $t3, 4  # Move to the next element in array
      addi $t4, $t4, 1  # Increment i

      j printElement

   printElementEnd:
      # Print new line
      li $v0, 4
      la $a0, newLine
      syscall

      # go back n*4 bytes of the array
      li $t6, 4        # Load 4 into $t6 (size of each element in bytes)
      mul $t6, $t6, $t5  # Multiply $t6 by $t5 to get the offset
      sub $t3, $t3, $t6  # Subtract the offset from $t3 to go back n*4 bytes in the array

      #addi $t3, $t3, -40

      # move $t3 back to $f13 
      mtc1 $t3, $f13

      jr $ra

# selection sort of array
selectionSort:
   mfc1 $t3, $f13   # Set start-address of array to $t3
   move $t5, $a2    # n (size of the array)

   # prepare outer loop
   li $t4, 0        # i = 0
   addi $t6, $t5, -1  # n - 2

   # i loop (outer)
   selectionLoop:
      bge $t4, $t6, selectionSortEnd  # Exit the loop if i >= n - 2

      li $v0, 4
      la $a0, iString 
      syscall

      # print i
      li $v0, 1
      move $a0, $t4
      syscall

      # Find the minimum element in the unsorted subarray
      # min_idx = i
      move $t7, $t4

      # prepare inner loop
      addi $t8, $t4, 1  # j = i + 1

      # j loop (inner)
      findMinElement:
         bge $t8, $t5, minElementFound  # Exit the inner loop if j >= n - 1

         li $v0, 4
         la $a0, jString 
         syscall

         # print j
         li $v0, 1
         move $a0, $t8
         syscall

         # Load arr[j] into $f1
         l.s $f1, 0($t3)

         # get arr[min_idx]
         addi $t9, $t7, 1
         mul $t9, $t9, 4
         add $t9, $t9, $t3

         # Load arr[min_idx] into $f2
         l.s $f2, 0($t9)

         # if (arr[j] < arr[min_idx]), swap the elements
         c.lt.s $f1, $f2
         bc1t updateMinIdx

         updateMinIdx:
            move $t7, $t8  # min_idx = j

            li $v0, 4
            la $a0, minidxString 
            syscall

            # print minidx
            li $v0, 1
            move $a0, $t7
            syscall
            

         # continue with next j iteration
         addi $t8, $t8, 1  # Increment j
         j findMinElement

      # Swap the found minimum element
      minElementFound:
         # Skip swap if (min_idx == i)
         beq $t7, $t4, skipSwap

         # Swap arr[i] and arr[min_idx]
         #move $t8, $t4  # i
         #move $t9, $t7  # min_idx

         # Load arr[i] into $f1
         #l.s $f1, 0($t3)

         # Load arr[min_idx] into $f3
         #l.s $f3, -4($t3)

         # Swap arr[i] and arr[min_idx] using temporary registers
         #s.s $f3, 0($t3)
         #s.s $f1, -4($t3)

      skipSwap:
         #addi $t3, $t3, 4  # Move to the next element in array
         addi $t4, $t4, 1  # Increment i

         j selectionLoop

   selectionSortEnd:
      # go back n*4 bytes of the array
      li $t6, 4        # Load 4 into $t6 (size of each element in bytes)
      mul $t6, $t6, $t5  # Multiply $t6 by $t5 to get the offset
      sub $t3, $t3, $t6  # Subtract the offset from $t3 to go back n*4 bytes in the array

      #addi $t3, $t3, -32

      # move $t3 back to $f13
      #mtc1 $t3, $f13

      jr $ra
