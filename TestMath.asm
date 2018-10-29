####################### quadratic.asm ##########################
# Xiaomeng Cao                                                 #
################################################################

        .text
        .globl __start
__start:


        la $a0,p1	    # display "Enter t1 (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter 1-> t5
	syscall
	move $t5,$v0

#Step 1
        la $a0,p2	    # display "Enter t1 (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter t1-> t0
	syscall
	move $t0,$v0

        la $a0,p3	    # display "Enter t2 (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter t2-> t1
	syscall
	move $t1,$v0

#Step 8

step2:  

	mul $t3,$t0,$t0     # the value of y 
	mul $t4,$t3,$t3
	sub $t4,$t4,1        

#Step 9
	la $a0,p8
	li $v0,4
	syscall

        move $a0,$t4        # display "x"
	li $v0,1
	syscall

	la $a0,space         # display cr/lf
        li $v0,4
        syscall

	la $a0,p9
	li $v0,4
	syscall

	move $a0,$t3        # display "y"
	li $v0,1
	syscall

        la $a0,endl         # display cr/lf
        li $v0,4
        syscall

        la $a0,endl         # display cr/lf
        li $v0,4
        syscall

#Step 10
	div $t6,$t5,2
	add $t0,$t0,$t6       

#Step 11
	ble $t0,$t1,step2   # if (t3 <= t4) goto step 8

#Step 12
	la $a0,p7           # ask for repeat
	li $v0,4
	syscall

#Step 13
	li $v0,5            # enter 1-yes  0-no
	syscall

	beqz $v0,eop

	j __start

#Step 14	
        li $v0,10           # EOP
        syscall

eop:	li $v0,10   # End Of Program	
	syscall     # Call to system

        .data
p1:     .asciiz             "Enter 1"
p2:     .asciiz             "Enter y1 (interger): "
p3:     .asciiz             "Enter y2 (interger): "
p7:     .asciiz             "Repeat? (1-yes  0-no)"
p8:     .asciiz             "x: "
p9:     .asciiz             "y: "
endl:   .asciiz             "\n"
space:  .asciiz             "  "

######################### Output #################################
#                                                                #
# Console                                                        #
# =========================                                      #
# Calculate y = Ax^2 + Bx + C, please enter the values of A,B,C  #                                                    #
# Enter A (interger): 1                                          #
# Enter B (interger): -1                                         #
# Enter C (interger): -6                                         #
# Enter lower bounds of the domain variable x: -5                #
# Enter lower bounds of the domain variable x: 5                 #
# x: -5                                                          #
# y: 24                                                          #
#                                                                #
# x: -4                                                          #
# y: 14                                                          #
#                                                                #
# x: -3                                                          #
# y: 6                                                           #
#                                                                #
# x: -2                                                          #
# y: 0                                                           #
#                                                                #
# x: -1                                                          #
# y: -4                                                          #
#                                                                #
# x: 0                                                           #
# y: -6                                                          #
#                                                                #
# x: 1                                                           #
# y: -6                                                          #
#                                                                #
# x: 2                                                           #
# y: -4                                                          #
#                                                                #
# x: 3                                                           #
# y: 0                                                           #
#                                                                #
# x: 4                                                           #
# y: 6                                                           #
#                                                                #
# x: 5                                                           #
# y: 14                                                          #
#                                                                #
# Repeat? (1-yes  0-no)0                                         #
#                                                                #
##################################################################