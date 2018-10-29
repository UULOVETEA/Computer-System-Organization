#######################  math2.asm ##########################
# Xiaomeng Cao                                              #
# math2.asm                                                 #
# Description                                               #
#     Calculate (A+B)-(C-D)                                 #
# Program Logic                                             #
# 1.  Prompt for A,B,C and D and enter them                 #
#     A->t0                                                 #
#     B->t1                                                 #
#     C->t2                                                 #
#     D->t3                                                 #
# 2.  Calculate A+B -> t4, C-D -> t5, (A+B)-(C-D) -> t6     #
# 3.  Display the result. Example: (3 + 10) - (8 - 5) = 10  #
#############################################################

        .text
        .globl __start
__start:
        la $a0,p1	    # display massage
        li $v0,4
        syscall

        la $a0,p2	    # display "Enter A (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter A-> t0
	syscall
	move $t0,$v0

        la $a0,p3	    # display "Enter B (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter B-> t1
	syscall
	move $t1,$v0

        la $a0,p4	    # display "Enter C (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter C-> t2
	syscall
	move $t2,$v0

        la $a0,p5	    # display "Enter D (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter D-> t3
	syscall
	move $t3,$v0

        add $t4,$t0,$t1   # t4=A+B

        sub $t5,$t2,$t3   # t5=C-D

        sub $t6,$t4,$t5   # t6=(A+B)-(C-D)

	la $a0,lparen       # display "("
	li $v0,4
	syscall

	move $a0,$t0        # display "A"
	li $v0,1
	syscall
	
	la $a0,plus         # display " + "
	li $v0,4
	syscall
	
	move $a0,$t1        # display "B"
	li $v0,1
	syscall
	
	la $a0,middle       # display ") - ("
	li $v0,4
	syscall

	move $a0,$t2        # display "D"
	li $v0,1
	syscall

	la $a0,minus        # display "-"
	li $v0,4
	syscall

	move $a0,$t3        # display "D"
	li $v0,1
	syscall

	la $a0,finish       # display ") = "
	li $v0,4
	syscall

	move $a0,$t6        # display answer
	li $v0,1
	syscall

        la $a0,endl         # display cr/lf
        li $v0,4
        syscall
	
	la $a0,p6           # ask for repeat
	li $v0,4
	syscall

	li $v0,5            # enter 1-yes  0-no
	syscall

	beqz $v0,eop

	j __start
        li $v0,10           # EOP
        syscall

eop:	li $v0,10   # End Of Program	
	syscall     # Call to system

        .data
p1:     .asciiz             "Calculate (A+B)-(C-D), please enter the values of A,B,C,D\n"
p2:     .asciiz             "Enter A (interger): "
p3:     .asciiz             "Enter B (interger): "
p4:     .asciiz             "Enter C (interger): "
p5:     .asciiz             "Enter D (interger): "
p6:     .asciiz             "Repeat? (1-yes  0-no)"
lparen: .asciiz             "("
plus:   .asciiz             " + "
middle: .asciiz             ") - ("
minus:  .asciiz             " - "
finish: .asciiz             ") = "
endl:   .asciiz             "\n"

######################### Output #############################
#                                                            #
# Console                                                    #
# =========================                                  #
# Calculate (A+B)-(C-D), please enter the values of A,B,C,D  #
# Enter A (interger): 15                                     #
# Enter B (interger): 10                                     #
# Enter C (interger): -10                                    #
# Enter D (interger): 5                                      #
# (15 + 10) - (-10 - 5) = 40                                 #
# Repeat? (1-yes  0-no)1                                     #
# Calculate (A+B)-(C-D), please enter the values of A,B,C,D  #
# Enter A (interger): 3                                      #
# Enter B (interger): 10                                     #
# Enter C (interger): 8                                      #
# Enter D (interger): 5                                      #
# (3 + 10) - (8 - 5) = 10                                    #
# Repeat? (1-yes  0-no)1                                     #
# Calculate (A+B)-(C-D), please enter the values of A,B,C,D  #
# Enter A (interger): 5                                      #
# Enter B (interger): 7                                      #
# Enter C (interger): 8                                      #
# Enter D (interger): 3                                      #
# (5 + 7) - (8 - 3) = 7                                      #
# Repeat? (1-yes  0-no)0                                     #
#                                                            #
##############################################################