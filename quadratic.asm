####################### quadratic.asm ##########################
# Xiaomeng Cao                                                 #
# quadratic.asm                                                #
# Description                                                  #
#     Calculate y = Ax^2 + Bx + C and display x and y          #
# Program Logic                                                #
# 1.  Ask for the coefficients of the quadratic: A, B and C    #
# 2.  Input A and place it in t0                               #
# 3.  Input B and place it in t1                               #
# 4.  Input C and place it in t2                               #
# 5.  Ask for lower and upper bounds of the domain variable x  #
# 6.  Input the lower bound and place it in t3                 #
# 7.  Input the upper bound and place it in t4                 #
# 8.  Calculate the range variable y = (Ax + B)x + C           #
# 9.  Display the ordered pair x and y                         #
# 10. t3 = t3 + 1                                              #
# 11. If (t3 <= t4) goto step 8                                #
# 12. Continue again (y/n)?                                    #
# 13. If yes goto step 1                                       #
# 14. EOP                                                      #
################################################################

        .text
        .globl __start
__start:

#Step 1
        la $a0,p1	    # display massage
        li $v0,4
        syscall

#Step 2
        la $a0,p2	    # display massage "Enter A (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter A -> t0
	syscall
	move $t0,$v0

#Step 3
        la $a0,p3	    # display massage "Enter B (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter B -> t1
	syscall
	move $t1,$v0

#Step 4
        la $a0,p4	    # display massage "Enter C (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter C -> t2
	syscall
	move $t2,$v0

#Step 5
        la $a0,p5	    # display massage "Enter lower bounds of the domain variable x: "
        li $v0,4
        syscall

#Step 6
	li $v0,5            # enter lower x -> t3
	syscall
	move $t3,$v0

#Step 7
	la $a0,p6	    # display massage "Enter upper bounds of the domain variable x: "
        li $v0,4
        syscall

	li $v0,5            # enter upper x -> t4
	syscall
	move $t4,$v0

#Step 8

step8:  mul $t5,$t0,$t3     # t5=Ax

	add $t5,$t5,$t1     # t5=Ax+B

        mul $t5,$t5,$t3     # t5=(Ax+B)x

        add $t5,$t5,$t2     # t5=(Ax+B)x+C

#Step 9
	la $a0,p8           # display massage "x: "
	li $v0,4
	syscall

        move $a0,$t3        # display the value of x
	li $v0,1
	syscall

	la $a0,newl         # display a new line
        li $v0,4
        syscall

	la $a0,p9           # display massage "y: "
	li $v0,4
	syscall

	move $a0,$t5        # display the value of y
	li $v0,1
	syscall

        la $a0,newl         # display a new line
        li $v0,4
        syscall

	la $a0,newl         # display a new line
        li $v0,4
        syscall

#Step 10
	add $t3,$t3,1       # t3=t3+1

#Step 11
	ble $t3,$t4,step8   # if (t3 <= t4) goto step 8

#Step 12
	la $a0,p7           # ask for repeat
	li $v0,4
	syscall

#Step 13
	li $v0,5            # enter 1-yes  0-no
	syscall

	beqz $v0,eop        # compare input to 0

	j __start           # if it is 1 go back to start

#Step 14	
        li $v0,10           # EOP
        syscall

eop:	li $v0,10           # End Of Program	
	syscall             # Call to system

        .data
p1:     .asciiz             "Calculate y = Ax^2 + Bx + C, please enter the values of A,B,C\n"
p2:     .asciiz             "Enter A (interger): "
p3:     .asciiz             "Enter B (interger): "
p4:     .asciiz             "Enter C (interger): "
p5:     .asciiz             "Enter lower bounds of the domain variable x: "
p6:     .asciiz             "Enter upper bounds of the domain variable x: "
p7:     .asciiz             "Repeat? (1-yes  0-no)"
p8:     .asciiz             "x: "
p9:     .asciiz             "y: "
newl:   .asciiz             "\n"

######################### Output #################################
#                                                                #
# Console                                                        #
# =========================                                      #
# Calculate y = Ax^2 + Bx + C, please enter the values of A,B,C  #
# Enter A (interger): 1                                          #
# Enter B (interger): -1                                         #
# Enter C (interger): -6                                         #
# Enter lower bounds of the domain variable x: -5                #
# Enter upper bounds of the domain variable x: 5                 #
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