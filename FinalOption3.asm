# Tim Miller
# 4-16-15
# recursediv.asm
# "Divide two numbers using recursion"
        .text
        .globl __start
__start:
restart:
input:
	la $a0,p1	#Print the prompt
	li $v0,4
	syscall

	li $v0,5	#Take in the Input such that
	syscall	#$t0 = A			
	move $a0,$v0	#$t1 = B
	li $v0,5
	syscall
	move $a1,$v0

	jal divide
	move $t0, $v0
output:
	move $a0, $t0
	li $v0, 1
	syscall

	la $a0, nl
	li $v0, 4
	syscall
goagain:
	la $a0, p2	# Print p2
	li $v0, 4
	syscall

	li $v0,5	# Move input to t0
	syscall
	move $t0,$v0

	beqz $t0, restart	# If t0 == 0, goto restart
eop:
	li $v0,10		#Exit
	syscall
############# Divide function #############
# Divide a0 by a1, and output to v0	#
# v0 = a0 / a1				#
# jal divide					#
###########################################
divide:
	beqz $a1, divide_divzero	# if a1 == 0, goto divzero

	beqz $a0, divide_outputzero	# if a0 == 0, return 0

	beq $a0, $a0, divide_outputone	# if a0==a1, return 1

	ble $a1, $a0, divide_outputzero	# if a1 < a0, return 0

	# else return 1 + divide(a - b, b)

divide_outputone:
	li $t3, 1
	j divide_output
divide_outputzero:		# Shortcut to output a zero
	move $t3, $zero
	j divide_output
divide_output:		# Output t0
	move $v0, $t3
	j $ra
divide_divzero:		# jump here if a1 == 0
	la $a0, dz 		#Print an error
	li $v0, 4
	syscall

	j eop			# Print an error
	.data
p1:	.asciiz "Please enter two numbers.  The first will be divided by the second.\n"
p2:	.asciiz "Please enter 0 to go again, or enter anything else to quit\n"
dz:	.asciiz "Error, tried to divide by zero (c'mon, you should know better)\n"
nl:	.asciiz "\n"