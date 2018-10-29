########## IOSortArray.asm on p. 65-66 ###########
# Xiaomeng  Cao                                  #
#                                                #
# Illustrates Base Addressing                    #
#                                                #
# Enter an array of numbers and find the         #
# minimum and maximum of the array, and then     #
# sort the numbers in an ascending order and     #
# dispaly them.                                  #
#                                                #
# t1 = count, t2 = min, t3 = max                 #
# t0 = counter, t4 = array element               #
# t5 = address of array element, t6 = temp       #
#                                                #
##################################################
#                                                #
#  Project - to add an input and output methods  #
#                                                #
#  jal input - jump and link to a subprogram     #
#              to input an array of numbers      #
#                                                #
#  input - a subprogram or method to:            #
#  1. input the number of entries in an array    #
#  2. input those numbers                        #
#                                                #
#  jal output - jump and link to a subprogram    #
#               to display an array of numbers   #
#                                                #
#  output - a subprogram or method to:           #
#  1. display the entries in an array            #
#                                                #
#  jal sort - jump and link to a subprogram      #
#               to sort an array of numbers      #
#  sort - a subprogram or method to:             #
#  1. sort the entries in an ascending order     #
#                                                #
#  jal output - jump and link to a subprogram    #
#               to display an array of numbers   #
#                                                #
#  output - a subprogram or method to:           #
#  1. display the entries in an array in         #
#     ascending order                            #
#                                                #
##################################################
#                                                #
#  Logic for sorting                             #
#                                                #
#  for (i = 0; i < n-1; i++)                     #
#       for (j = i+1; j < n; j++)                #
#           if ( a[i] > a[j])                    #
#               swap (a[i], a[j]);               # 
#                                                #
##################################################

        .text
        .globl __start
__start:

	jal input           # jump and link to method input

        jal output          # jump and link to method output

	jal sort            # jump and link to method sort

	jal output          # jump and link to method output

        la $t0,array        # t0 = address of array
        lw $t1,count        # t1 = count, exit loop when it goes to 0
        lw $t2,($t0)        # t2 = min = a[0] (initialization)
        lw $t3,($t0)        # t3 = max = a[0] (initialization)
        add $t0,$t0,4       # move pointer ahead to next array element a[1]
        add $t1,$t1,-1      # decrement counter to keep in step with array


loop:   lw $t4,($t0)        # t4 = next element in array
        bge $t4,$t2,notMin  # if array element is  >= min goto notMin

        move $t2,$t4        # min = a[i]
        j notMax

notMin: ble $t4,$t3,notMax  # if array element is <= max goto notMax

        move $t3,$t4        # max = a[i]

notMax: add $t1,$t1,-1      # t1 --  ->  counter --
        add $t0,$t0,4       # increment counter to point to next word
        bnez $t1,loop

	la $a0,crlf         # Display "cr/lf"
        li $v0,4            # a0 = address of message
        syscall 

        la $a0,p1           # Display "The minimum number is "
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string	

        move $a0,$t2        # Display the minimum number 
        li $v0,1
        syscall

        la $a0,p2           # Display "The maximum number is "
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string

        move $a0,$t3        # Display the maximum number 
        li $v0,1
        syscall

        la $a0,crlf         # Display "cr/lf"
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string

	la $a0,rp           # ask for repeat     
	li $v0,4
	syscall

	li $v0,5            # enter 1-yes  0-no
	syscall

	beqz $v0,eop        # if 0 EOP

	j __start           # if 1 go back

eop:    li $v0,10           # End Of Program
        syscall

input:  la $a0,p3           # ask for how many numbers you want to enter 
        li $v0,4 
        syscall             

        li $v0,5            # input the number of numbers and place it in count
        syscall     
        sw $v0,count                           
                            
        la $t0,array        # initialize t0 and t1  
        lw $t1,count                           

inloop: li $v0,5            # use a loop to enter the actual numbers in array
        syscall
        sw $v0,($t0)
        add $t0,$t0,4
        sub $t1,$t1,1
        beqz $t1,endInLoop
        j inloop

endInLoop:
        jr $ra              # go back to where you came from
        
                            # output method for student to create. 

output: la $t0,array        # initialize t0 and t1  
        lw $t1,count
  
outloop:                    # use a loop to display the numbers 
        lw $t6,($t0)        # load a number from array into $t6
        move $a0,$t6        # display that number
        li $v0,1 
        syscall             

	la $a0, space       # with spacing such as a new line or a space
	li $v0, 4
	syscall

        add $t0,$t0,4       # repeat this again until all the numbers have been displayed
        add $t1,$t1,-1
        bnez $t1,outloop
	
	la $a0,crlf
        li $v0,4
	syscall

	jr  $ra             # return to where you came from
        
sort:   la $t0,array        # t0 = address of a[i]
        la $t1,array        # t1 = address of a[j]
        addi $t1,$t1,4                          

        lw $t2,count        # t2 = count    (i counter)
        sub $t2,$t2,1       # t2 = count-1       
        move $t3,$t2        # t3 = t2       (j counter)

sloop:  lw $t4,($t0)        # t4 = a[i]
        lw $t5,($t1)        # t5 = a[j]

        ble $t4,$t5,noswap  # if (a[i] <= a[j]) do not swap

        sw $t5,($t0)        # swap a[i] and a[j]
	sw $t4,($t1)
            

noswap: addi $t1,$t1,4      # t1 = next address of a[j]
        sub $t3,$t3,1       # j count --

        bnez $t3,sloop      # if j count != 0 go back to sort loop

        addi $t0,$t0,4      # t0 = next address of a[i]

        sub $t2,$t2,1       # i count --

        move $t3,$t2        # j count = i count

        beqz $t2,endsort    # if i count = 0 sort is complete

        addi $t1,$t0,4      # t1 = the next address of a[i]
              
        j sloop             # jump to sort loop

endsort:
        jr $ra              # return to main procedure
 

        .data
array:  .space 100
count:  .word 0
p1:     .asciiz "The minimum number is "
p2:     .asciiz "\nThe maximum number is "
p3:     .asciiz "Enter the count of numbers to be read in: "
crlf:   .asciiz "\n"
rp:     .asciiz "Repeat (1-yes 0-no)"
space:  .asciiz " "

################### Output ####################
#                                             #
# Console                                     #
# =========================                   #
# Enter the count of numbers to be read in: 5 #
# 5                                           #
# 4                                           #
# 3                                           #
# 2                                           #
# 1                                           #
# 5 4 3 2 1                                   #
# 1 2 3 4 5                                   #
#                                             #
# The minimum number is 1                     #
# The maximum number is 5                     #
# Repeat (1-yes 0-no)1                        #
# Enter the count of numbers to be read in: 5 #
# 99                                          #
# 45                                          #
# 64                                          #
# 23                                          #
# 15                                          #
# 99 45 64 23 15                              #
# 15 23 45 64 99                              #
# The minimum number is 15                    #
# The maximum number is 99                    #
# Repeat (1-yes 0-no)0                        #
#                                             #
###############################################



















