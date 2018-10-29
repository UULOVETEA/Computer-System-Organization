########### helloIOCount.asm on p. 26-27 ######
# Xiaomeng                                    #
# helloIOCount.asm                            #
# Description                                 #
#     Program which displays a message that   #
#     you input                               #
# Program Logic                               #
# 1.  Ask for a message                       #
# 2.  Input the message                       #
# 3.  Display a message from data area        #
# 4.  Display a new line                      #
# 5.  Count the number of characters          #
# 6.  Display the count                       #
# 7.  Repeat (1-yes  0-no)?                   #
# 8.  If yes go to step 1                     #
# 9.  If no eturn to operating system         #
###############################################

        .text
        .globl __start
__start:
	la $a0,p1   # Display the message below "Please enter your message"
	li $v0,4    # a0 = address of string
	syscall     # v0 = 4, indicates display a string

	la $a0,str  # Load address of the message area
	li $a1,80   # Load number of characters available for the message
	li $v0,8    # Input the message
	syscall

	la $a0,str  # Display the message
	li $v0,4
	syscall	

	la $a0,p2   # Display the new line
	li $v0,4
	syscall


#	t0 = address of the message
	la $t0,str

#	t1 = counter starting at 0
	li $t1,0

#	t2 = a character in the message
loop:	lb $t2,($t0)

#	t3 = t2-10
	sub $t3,$t2,10

#	branch to endloop after loop if t3 = 0
	beqz $t3,endloop

#	t0 = t0+1
	addi $t0,$t0,1

#	t1 = t1+1
	addi $t1,$t1,1

#	jump back
	j loop

#	display the number of characters in the message
endloop:
	la $a0,p3   # Display the new line
	li $v0,4
	syscall

	move $a0,$t1
	li $v0,1
	syscall

#	display a new line
	la $a0,p2   # Display the new line
	li $v0,4
	syscall

#	Ask the user if that user wishes to repeat this program:   1-yes, 0-no
	la $a0,p4 
	li $v0,4
	syscall

#	Enter an integer (1 or 0)
	li $v0,5
	syscall

#	compare your input to 1
	beqz $v0,eop

#	if it is 1 go back to start
	j __start



eop:	li $v0,10   # End Of Program	
	syscall     # Call to system

        .data
str:    .space      80
p1:     .asciiz     "Please enter your message"
p2:     .asciiz     "\n"
p3:	.asciiz     "The number of characters in the message is "
p4:     .asciiz     "Repeat (1-yes  0-no)"

####################### Output ###########################
#                                                        #        
# Console                                                # 
# =========================                              #
# Please enter your messageXiaomeng Cao                  #
# Xiaomeng Cao                                           #
#                                                        #
# The number of characters in the message is 12          #
# Repeat (1-yes  0-no)1                                  #
# Please enter your messageThis is helloIOcount program  #
# This is helloIOcount program                           #
#                                                        #
# The number of characters in the message is 28          #
# Repeat (1-yes  0-no)1                                  #
# Please enter your messageMy program can run            #
# My program can run                                     #
#                                                        #
# The number of characters in the message is 18          #
# Repeat (1-yes  0-no)1                                  #
# Please enter your messageI am happy for it             #
# I am happy for it                                      #
#                                                        #
# The number of characters in the message is 17          #
# Repeat (1-yes  0-no)0                                  #
#                                                        #
##########################################################


