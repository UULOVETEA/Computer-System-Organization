############### RecursiveMulDiv.asm ###############
# Xiaomeng Cao                                    #
# RecursiveMulDiv.asm                             #
# Description                                     #
# 	Program will use recursive multiolication #
#	 and division to display the result       #
# Program Logic                                   #
# 1. Ask for 2 numbers, a and b                   #
# 2. Input the 2 numbers                          #
# 3. jal mp                                       #
# 4. jal dv                                       #
# 5. Display the result of a x b                  #
# 6. Display the result of a / b                  #
# 7. Ask for repeat                               #
###################################################

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

	jal dv
        move $t1,$v0   # save result in t0

        la $a0,ansMul  # display "a x b = "
        li $v0,4
        syscall	

        move $a0,$t0   # display returned result
        li $v0,1
        syscall

        la $a0,endl    # display crlf
        li $v0,4
        syscall	

        la $a0,ansDiv  # display "a / b = "
        li $v0,4
        syscall	

        move $a0,$t1   # display returned result
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
# v0 - holds the returned result, a x b and a/b #
#################################################

mp:     sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $a1,4($sp)
        sw $ra,8($sp)

        bgt $a1,1,notOne
        move $v0,$a0    # fact(0) = 1, fact(1) = 1
        j mprt

notOne: sub $a1,$a1,1   # parameter = n-1
        jal mp          # compute fact(n-1)
        add $v0,$a0,$v0 # save fact(n-1)

mprt:	lw $a0,0($sp)   # restore registers from stack
        lw $a1,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12

        jr $ra          # return

dv:     sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $s0,4($sp)
        sw $ra,8($sp)

### beqz $a1,dvzero # if a1 = 0, go to dvzero
	bge $a0,$a1,gotEq
        li $v0,0        # fact(0) = 1, fact(1) = 1
        j dvrt

gotEq:  sub $a0,$a0,$a1 # parameter = n-1
        jal dv          # compute fact(n-1)
        add $v0,1       # save fact(n-1)

dvzero:
	la $a0,error	# display error message
	li $v0,4
	syscall
dvrt:   lw $a0,0($sp)   # restore registers from stack
        lw $s0,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12
#dvzero:
#	la $a0,error	# display error message
#	li $v0,4
#	syscall

        jr $ra          # return

        .data
prompt: .asciiz "Enter 2 numbers a and b: "
ansMul: .asciiz "a x b = "
ansDiv: .asciiz "a / b = "
endl:   .asciiz "\n"
again:  .asciiz "Do you want try again? (1-Yes, 0-No) "
error:  .asciiz "No allowance of division by 0."


############### Sample Output ##############
#                                          #
# Console                                  #
# =========================                #
# Enter 2 numbers a and b: 4               #
# 2                                        #
# a x b = 8                                #
# a / b = 2                                #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 3               #
# 2                                        #
# a x b = 6                                #
# a / b = 1                                #
# Do you want try again? (1-Yes, 0-No) 1   #
# Enter 2 numbers a and b: 8               #
# 4                                        #
# a x b = 32                               #
# a / b = 2                                #
# Do you want try again? (1-Yes, 0-No) 0   #
#                                          #
############################################
