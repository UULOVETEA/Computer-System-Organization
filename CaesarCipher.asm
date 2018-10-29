#################### CaesarCipher.asm ####################
#                                                        #
# Xiaomeng                                               #
# CaesarCipher.asm                                       #
# Description                                            #
#     Enter a message and a key, the program will        #
#     encrypt or decrypt the message by using the key    #
#                                                        #
# Program Logic                                          #
# 1.  Display the greeting message                       #
# 2.  Display the menu                                   #
# 3.  Enter different number go to different function    #
# 4.  If enter 1 go to encryption method                 #
# 5.  Encrypt message                                    #
# 6.  Display the message, and return to the menu        #
# 7.  If enter 2 go to decryption method                 #
# 8.  Decrypt message                                    #
# 9.  Display the message, and return to the menu        #
# 10. If enter 3 exit program                            #
#                                                        #
##########################################################

	.text
        .globl __start
__start:
	la $a0,p1		# display the greeting message
	li $v0,4
	syscall

menu:
	la $a0,p2		# display the menu
	li $v0,4
	syscall

	li $v0,5		# get the input
	syscall

	beq $v0,1,op1		# if enter 1, go to encrypt
	beq $v0,2,op2		# if enter 2, go to decrypt
	beq $v0,3,eop		# if enter 3, eop

	la $a0,endl		# if invalid enter, jump to menu
	li $v0,4
	syscall

	j menu			# jump to menu


########################################## op1 ###########################################
#                                                                                        #
# a0 - holds the message                                                                 #
# a1 - holds the key                                                                     #
#                                                                                        #
##########################################################################################

op1:	la $a0,p4		# display "Please enter a message to be encrypted: " 
	li $v0,4
	syscall

	la $a0,str		# Load address of the message area
	li $a1,80		# load number of characters available for the message
	li $v0,8		# input the message
	syscall

	la $a0,p6		# display "Please enter the integer key: "
	li $v0,4
	syscall

	li $v0,5		# get the key
	syscall

	la $a0,str		# load string address to a0
	move $a1,$v0		# load key to a1

	jal encrypt 		# jump and link to method encrypt 

	la $a0,p7		# display "The text was successfully encrypted: "
	li $v0,4
	syscall

	la $a0,str		# display the encryted message
	li $v0,4
	syscall

	j menu			# jump to menu

########################################## op2 ###########################################
#                                                                                        #
# a0 - holds the message                                                                 #
# a1 - holds the key                                                                     #
#                                                                                        #
##########################################################################################

op2:	la $a0,p5		# display "Please enter an encrypted message to be decrypted: "
	li $v0,4
	syscall

	la $a0,str		# Load address of the message area
	li $a1,80		# load number of characters available for the message
	li $v0,8		# input the message
	syscall

	la $a0,p6		# display "Please enter the integer key: "
	li $v0,4
	syscall

	li $v0,5		# get the key
	syscall

	la $a0,str		# load string address to a0
	move $a1,$v0		# load key to a1

	jal decrypt		# jump and link to method encrypt

	la $a0,p8		# display "The text was successfully decrypted: "
	li $v0,4
	syscall

	la $a0,str		# display the decryted message
	li $v0,4
	syscall

	j menu			# jump to menu

########################################## eop ###########################################
#                                                                                        #
# Display "Goodbye!" and exit the program                                                #
#                                                                                        #
##########################################################################################

eop:	la $a0,p3		# display "Goodbye!"
	li $v0,4
	syscall

	li $v0,10		# End Of Program	
	syscall			# Call to system

################################# Encryption Method ######################################
#                                                                                        #
# 1. Get a message and a key                                                             #
# 2. Increase every characters by the key                                                #
# 3. If the new characters is out of the range of 255, correct it                        #
# 4. Return and display the new message                                                  #
# 5. Return to the Menu                                                                  #
#                                                                                        #
##########################################################################################

encrypt:
	lb $t2,endl		# store \n in $t2, for easy reference

	li $t3,255		# store 255 in t3 for easy reference
	move $t4, $a0		# backup string address in t4

enLoop:	
	lb $t0,0($a0)		# load the byte from string into t0
	beq $t0,$t2,enEnd	# if the byte == nl, go to end	
	add $t0,$t0,$a1		# Increment the byte in t0 by the key in a1
	sb $t0,0($a0)		# store the byte to the string	
	bgt $t0,$t3,enCorrect	# if the byte is above 255, subtract 255

	j enIncorrect

enCorrect:	
	sub $t0,$t3,$t0		# subtract 255 from the character

enIncorrect:	
	add $a0,$a0,1		# increment the counter by 1

	j enLoop

enEnd:	
	move $a0,$t4		# Store string address in a0

	jr $ra			# return


################################# Encryption Method ######################################
#                                                                                        #
# 1. Get a message and a key                                                             #
# 2. Decrease every characters by the key                                                #
# 3. If the new characters is out of the range of 255, correct it                        #
# 4. Return and display the new message                                                  #
# 5. Return to the Menu                                                                  #
#                                                                                        #
##########################################################################################

decrypt:	
	lb $t2,endl		# store \n in $t2, for easy reference

	li $t3,255		# store 255 in t3 for easy reference
	move $t4, $a0		# backup string address in t4

deLoop:	
	lb $t0,0($a0)		# load the byte from string into t0
	beq $t0,$t2,deEnd	# If the byte == nl, go to end
	sub $t0,$t0,$a1		# decrement the byte in t0 by the key in a1
	sb $t0,0($a0)		# store the byte to the string
	bltz $t0,deCorrect	# if the byte is below 0, add 255

	j deIncorrect

deCorrect:
	sub $t0,$t3,$t0		# subtract 255 from the character

deIncorrect:
	add $a0,$a0,1		# increment the counter by 1

	j deLoop

deEnd:
	move $a0,$t4		# Store string address in a0

	jr $ra			# return


	.data
str:    .space      80
p1:	.asciiz "Welcome to the center for information encryption and decryption\n"
p2:	.asciiz "\n\nMain Menu\n 1. Encrypt a massage\n 2. Decrypt a massage\n 3. Exit \nPlease enter your chioce: "
p3:	.asciiz	"\nGoodbye!\n"
p4:	.asciiz "Please enter a message to be encrypted: "
p5:	.asciiz "Please enter an encrypted message to be decrypted: "
p6:	.asciiz "Please enter an key (integer): "
p7:	.asciiz "The text was successfully encrypted: "
p8:     .asciiz "The text was successfully decrypted: "
endl:   .asciiz "\n"

########################### Sample Output ############################
#                                                                    #
# Console                                                            #
# =========================                                          #
# Welcome to the center for information encryption and decryption    #
#                                                                    #
#                                                                    #
# Main Menu                                                          #
#  1. Encrypt a massage                                              #
#  2. Decrypt a massage                                              #
#  3. Exit                                                           #
# Please enter your chioce: 1                                        #
# Please enter a message to be encrypted: Hello World!!!             #
# Please enter an key (integer): 3                                   #
# The text was successfully encrypted: Khoor#Zruog$$$                #
#                                                                    #
#                                                                    #
# Main Menu                                                          #
#  1. Encrypt a massage                                              #
#  2. Decrypt a massage                                              #
#  3. Exit                                                           #
# Please enter your chioce: 2                                        #
# Please enter an encrypted message to be decrypted: Khoor#Zruog$$$  #
# Please enter an key (integer): 3                                   #
# The text was successfully decrypted: Hello World!!!               #
#                                                                    #
# Main Menu                                                          #
#  1. Encrypt a massage                                              #
#  2. Decrypt a massage                                              #
#  3. Exit                                                           #
# Please enter your chioce: 3                                        #
#                                                                    #
# Goodbye!                                                           #
#                                                                    #
######################################################################