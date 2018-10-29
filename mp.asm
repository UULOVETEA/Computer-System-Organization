#########################################
#                                       #
# Xiaomeng Cao                          #
# mp.asm - mp()a,b                      #
# Example of a recursive program        #
#                                       #
#  // Java Version:  mp.java            #
#  public static int fact(int a,b)      #
#  {                                    #
#    if (b = 1) return 1;               #
#    else return (a+mp(a,b-1));         #
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

        jal mp
        move $t0,$v0   # save result in t0

        la $a0,ans     # display "a x b = "
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
# a1 - holds b                                  #
# v0 - holds the returned result, a x b         #
#################################################

mp:     sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $a1,4($sp)
        sw $ra,8($sp)

        bgt $a1,1,notOne
        move $v0,$a0    # fact(0) = 1, fact(1) = 1
        j mprt

notOne: #move $s0,$a0   # save n
        sub $a1,$a1,1   # parameter = n-1
        jal mp          # compute fact(n-1)
        add $v0,$a0,$v0 # save fact(n-1)

mprt:	
        lw $a0,0($sp)   # restore registers from stack
        lw $a1,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12

        jr $ra          # return

        .data
prompt: .asciiz "Enter 2 numbers a and b: "
ans:    .asciiz "a x b = "
endl:   .asciiz "\n"
again:  .asciiz "Do you want try again? (1-Yes, 0-No) "

############### Sample Output ##############
#                                          #
# Console                                  #
# =========================                #
# Enter 2 numbers a and b: 2               #
# 3                                        #
# a x b = 6                                #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 3               #
# 6                                        #
# a x b = 18                               #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 4               #
# 5                                        #
# a x b = 20                               #
# Do you want try again? (1-Yes, 0-No) 0   #
#                                          #
############################################
