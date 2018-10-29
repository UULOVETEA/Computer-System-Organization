## float1.asm -- compute ax^2 + bx + c for user-input x 
##
## Xiaomeng Cao
##
## SPIM settings: pseudoinstructions: ON, branch delays: OFF,
##                load delays: OFF

        .text
        .globl __start

        # Register Use Chart
        # $f0 -- x
        # $f2 -- sum of terms

__start:# read input
        la      $a0,prompt          # prompt user for x
        li      $v0,4               # print string
        syscall
        
        li      $v0,6               # read single
        syscall                     # $f0 <-- x
        
        # evaluate the quadratic
        l.s     $f2,a               # sum = a
        mul.s   $f2,$f2,$f0         # sum = ax
        l.s     $f4,bb              # get b
        add.s   $f2,$f2,$f4         # sum = ax + b
        mul.s   $f2,$f2,$f0         # sum = (ax+b)x = ax^2 +bx
        l.s     $f4,c               # get c
        add.s   $f2,$f2,$f4         # sum = ax^2 + bx + c
        
        # print the result
        mov.s   $f12,$f2            # $f12 = argument
        li      $v0,2               # print single
        syscall

        la      $a0,newl            # new line
        li      $v0,4               # print string
        syscall

	la $a0,p1                   # ask for repeat     
	li $v0,4
	syscall

	li $v0,5                    # enter 1-yes  0-no
	syscall

	beqz $v0,eop                # if 0 EOP

	j __start                   # if 1 go back

eop:	li $v0,10                   # End Of Program	
	syscall                     # Call to system
        
##
##  Data Segment  
##
        .data
a:      .float  1.0
bb:     .float  1.0
c:      .float  1.0

prompt: .asciiz "Enter x: "
blank:  .asciiz " "
newl:   .asciiz "\n"
p1:     .asciiz "Repeat (1-yes 0-no)"

############ Output #############
#                               #
# Console                       #
# =========================     #
# Enter x: 1                    #
# 3.00000000                    #
# Repeat (1-yes 0-no)1          #
# Enter x: 1.5                  #
# 4.75000000                    #
# Repeat (1-yes 0-no)1          #
# Enter x: 2                    #
# 7.00000000                    #
# Repeat (1-yes 0-no)1          #
# Enter x: 2.5                  #
# 9.75000000                    #
# Repeat (1-yes 0-no)1          #
# Enter x: 3                    #
# 13.00000000                   #
# Repeat (1-yes 0-no)1          #
# Enter x: 4                    #
# 21.00000000                   #
# Repeat (1-yes 0-no)0          #
#                               #
#################################