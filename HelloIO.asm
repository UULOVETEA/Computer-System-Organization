########### helloIO.asm on p. 26-27 ###########
# Xiaomeng Cao                                #
# helloIO.asm                                 #
# Description                                 #
#     Program which displays a message that   #
#     you input                               #
# Program Logic                               #
# 1.  Ask for a message                       #
# 2.  Input the message                       #
# 3.  Display a message from data area        #
# 4.  Display a new line                      #
# 5.  Return to operating system              #
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

	li $v0,10   # End Of Program	
	syscall     # Call to system

        .data
str:    .space      80
p1:     .asciiz     "Please enter your message"
p2:     .asciiz     "\n"

############## Output ###################
#                                       #
# Console                               #
# =========================             #
# Please enter your messageXiaomeng Cao #
# Xiaomeng Cao                          #
#                                       #
#########################################
