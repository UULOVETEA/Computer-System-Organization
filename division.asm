#########################################
#                                       #
# division.asm - Factorial(n) = n!      #
# Example of a recursive program        #
#                                       #
#  // Java Version:  fact.java          #
#  public static int fact(int n)        #
#  {                                    #
#    if (n <= 1) return 1;              #
#    else return (n*fact(n-1));         #
#  }                                    #
#########################################

        .text
        .globl __start
__start:
        la $a0,prompt  # display "Enter 2 numbers: "
        li $v0,4
        syscall	
	
        li $v0,5       # enter the first number
        syscall 
	
        move $a0,$v0   # call factorial method

        li $v0,5       # enter the second number
        syscall 
	
        move $a1,$v0   # call factorial method

        jal divi
        move $t0,$v1   # save result in t0

        la $a0,ans     # display "a / b = "
        li $v0,4
        syscall	

        move $a0,$t0   # display returned result
        li $v0,1
        syscall

        la $a0,endl    # display crlf
        li $v0,4
        syscall

	la $a0,again   # ask for repeat
	li $v0,4
	syscall

	li $v0,5       # enter 1-yes  0-no
	syscall

	beqz $v0,eop   # compare input to 0

	j __start      # if it is 1 go back to start
	
        li $v0,10      # EOP
        syscall

eop:	li $v0,10      # End Of Program	
	syscall        # Call to system

################ fact method ####################
# a0 - holds a                                  #
# s0 - holds b                                  #
# v0 - holds the returned result, a / b         #
#################################################

divi:   sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $s0,4($sp)
        sw $ra,8($sp)

        bge $a0,$a1,gotEq
        li $v1,0        # fact(0) = 1, fact(1) = 1
        j divirt

gotEq:  sub $a0,$a0,$a1 # parameter = n-1
        jal divi        # compute fact(n-1)
        add $v1,1       # save fact(n-1)

divirt:
        lw $a0,0($sp)   # restore registers from stack
        lw $s0,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12

        jr $ra          # return

        .data
prompt: .asciiz "Enter 2 numbers a and b: "
ans:    .asciiz "a / b = "
endl:   .asciiz "\n"
again:  .asciiz "Do you want try again? (1-Yes, 0-No) "

############### Sample Output ##############
#                                          #
# Console                                  #
# =========================                #
# Enter 2 numbers a and b: 21              #
# 3                                        #
# a / b = 7                                #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 5               #
# 1                                        #
# a / b = 5                                #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 4               #
# 10                                       #
# a / b = 0                                #
# Do you want try again? (1-Yes, 0-No) 0   #
#                                          #
############################################
