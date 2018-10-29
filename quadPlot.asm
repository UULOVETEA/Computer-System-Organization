##################### quadPlot.asm #############################
# Xiaomeng Cao                                                 #
# quadPlot.asm                                                 #
# Description                                                  #
#     Calculate y = Ax^2 + Bx + C and display the plot         #
# Program Logic                                                #
# 1.  Enter A, B and C                                         #
# 2.  Enter x1 and x2                                          #
# 3.  Enter ymax and ymin                                      #
# 4.  y = ymax                                                 #
# 5.  x = x1                                                   #
# 6.  f(x) = (Ax+B)x+C                                         #
# 7.  If (y == f(x)) display "*" and go to step 11             #
# 8.  If (x == 0)  display "|" and go to step 11               #
# 9.  If (y == 0)  display "-" and go to step 11               #
# 10. Display " "                                              #
# 11. If (x == x2) display "\n" and go to step 13              #
# 12. x++ and go to step 6                                     #
# 13. If (y == ymin) end of program                            #
# 14. y-- and go to step 5                                     #
# 15. ask user for repeat                                      #
################################################################

        .text
        .globl __start
__start:

#Step 1 
        la $a0,p1	    # display massage
        li $v0,4
        syscall

        la $a0,p2	    # display massage "Enter A (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter A -> t0
	syscall
	move $t0,$v0

        la $a0,p3	    # display massage "Enter B (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter B -> t1
	syscall
	move $t1,$v0

        la $a0,p4	    # display massage "Enter C (interger): "
        li $v0,4
        syscall

	li $v0,5            # enter C -> t2
	syscall
	move $t2,$v0


#Step 2 
        la $a0,p5	    # display massage "Enter lower bounds of the domain variable x1: "
        li $v0,4
        syscall

	li $v0,5            # enter lower x1 -> t3
	syscall
	move $t3,$v0

	la $a0,p6	    # display massage "Enter upper bounds of the domain variable x2: "
        li $v0,4
        syscall

	li $v0,5            # enter upper x2 -> t4
	syscall
	move $t4,$v0


#Step 3 
        la $a0,p7	    # display massage "Enter Y-Min: "
        li $v0,4
        syscall

	li $v0,5            # enter Y-Min -> t6
	syscall
	move $t6,$v0

	la $a0,p8	    # display massage "Enter Y-Max: "
        li $v0,4
        syscall

	li $v0,5            # enter Y-Max -> t7
	syscall
	move $t7,$v0


#Step 4 
	add $t8,$t7,0       # y = ymax


#Step 5 
step5:	add $t9,$t3,0       # x = x1


#Step 6
step6:  mul $t5,$t0,$t9     # t5=Ax

	add $t5,$t5,$t1     # t5=Ax+B

        mul $t5,$t5,$t9     # t5=(Ax+B)x

        add $t5,$t5,$t2     # t5=(Ax+B)x+C


#Step 7 
	beq $t8,$t5,star    # if (y == f(x)) display "*" and go to step 11


#Step 8 
	beqz $t9,bar        # if (x == 0)  display "|" and go to step 11


#Step 9 
	beqz $t8,dash       # if (y == 0)  display "-" and go to step 11


#Step 10
	la $a0,p9           # display " "
	li $v0,4
	syscall


#Step 11
step11:	beq $t9,$t4,line    # if (x == x2) display "\n" and go to step 13


#Step 12
	add $t9,$t9,1       # x++	
	j step6             # jump to step 6


#Step 13
step13:	beq $t8,$t6,repeat  # if (y == ymin) end of program


#Step 14
	sub $t8,$t8,1       # y-- and go to step 5
	j step5


repeat:	la $a0,p13          # ask for repeat     
	li $v0,4
	syscall

	li $v0,5            # enter 1-yes  0-no
	syscall

	beqz $v0,eop        # if 0 EOP

	j __start           # if 1 go back


star:   la $a0,p10          # display message "*"
	li $v0,4
	syscall
	j step11            # jump to step 11


bar:    la $a0,p11          # display message "|"
	li $v0,4
	syscall
	j step11            # jump to step 11


dash:   la $a0,p12          # display message "-"
	li $v0,4
	syscall
	j step11            # jump to step 11


line:   la $a0,newl         # display a new line
	li $v0,4
	syscall
	j step13            # jump to step 13


eop:	li $v0,10           # End Of Program	
	syscall             # Call to system

        .data
p1:     .asciiz             "Calculate y = Ax^2 + Bx + C, please enter the values of A,B,C\n"
p2:     .asciiz             "Enter A (interger): "
p3:     .asciiz             "Enter B (interger): "
p4:     .asciiz             "Enter C (interger): "
p5:     .asciiz             "Enter lower bounds of the domain variable x1: "
p6:     .asciiz             "Enter upper bounds of the domain variable x2: "
p7:     .asciiz             "Enter Y-Min: "
p8:     .asciiz             "Enter Y-Max: "
p9:     .asciiz             " "
p10:    .asciiz             "*"
p11:    .asciiz             "|"
p12:    .asciiz             "-"
p13:    .asciiz             "Repeat (1-yes 0-no)"
newl:   .asciiz             "\n"

######################### Output #################################
#                                                                #
# Console                                                        #
# =========================                                      #
# Calculate y = Ax^2 + Bx + C, please enter the values of A,B,C  #
# Enter A (interger): 1                                          #
# Enter B (interger): -1                                         #
# Enter C (interger): -6                                         #
# Enter lower bounds of the domain variable x1: -10              #
# Enter upper bounds of the domain variable x2: 10               #
# Enter Y-Min: -10                                               #
# Enter Y-Max: 10                                                #
#           |                                                    #     
#           |                                                    #
#           |                                                    #
#           |                                                    #
#        *  |   *                                                #
#           |                                                    #
#           |                                                    #
#           |                                                    #
#           |                                                    #
#           |                                                    #
# --------*-|--*-------                                          #
#           |                                                    #
#           |                                                    #
#           |                                                    #
#          *| *                                                  #
#           |                                                    #
#           **                                                   #
#           |                                                    #
#           |                                                    #
#           |                                                    #
#           |                                                    #
# Repeat (1-yes 0-no)0                                           #
#                                                                #
##################################################################