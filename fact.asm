#########################################
#                                       #
# fact.asm - Factorial(n) = n!          #
# Example of a recursive program        #
#                                       #
#  // Java Version:  fact.java          #
#  public static int fact(int n)        #
#  {                                    #
#    if (n <= 1) return 1;              #
#    else return (n*fact(n-1));         #
#  }                                    #
#########################################

        .text
        .globl __start
__start:
        la $a0,prompt  # display "Enter factorial number: "
        li $v0,4
        syscall	
	
        li $v0,5       # enter the factorial number
        syscall 
	
        move $a0,$v0   # call factorial method
        jal fact	
        move $t0,$v0   # save result in t0

        la $a0,ans     # display "n! = "
        li $v0,4
        syscall	

        move $a0,$t0   # display returned result
        li $v0,1
        syscall

        la $a0,endl    # display crlf
        li $v0,4
        syscall

        li $v0,10      # EOP
        syscall

################ fact method ####################
# a0 - holds n,the parameter sent to the method #
# s0 - holds n                                  #
# v0 - holds the returned result, (n-1)!        #
#################################################

fact:   sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $s0,4($sp)
        sw $ra,8($sp)

        bgt $a0,1,notOne
        li $v0,1        # fact(0) = 1, fact(1) = 1
        j factret

notOne: move $s0,$a0    # save n
        sub $a0,$a0,1   # parameter = n-1
        jal fact        # compute fact(n-1)
        mul $v0,$s0,$v0 # save fact(n-1)

factret:	
        lw $a0,0($sp)   # restore registers from stack
        lw $s0,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12

        jr $ra          # return

        .data
prompt: .asciiz "Enter factorial number: "
ans:    .asciiz "n! = "
endl:   .asciiz "\n"

######### Sample Output##########
#                               #
# Enter factorial number: 5     #
# n! = 120                      #
#                               #
# Enter factorial number: 6     #
# n! = 720                      #
#                               #
#################################
