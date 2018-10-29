## min.asm --- determine the min and max of two floats
## Xiaomeng Cao

        .text
        .globl __start

__start:
	# get the values into registers
	la      $a0,promptA      # prompt user for A
	li      $v0,4
	syscall

	li      $v0,6
	syscall
	mov.s   $f4,$f0

	la      $a0,promptB      # prompt user for B
	li      $v0,4
	syscall

	li      $v0,6
	syscall
	mov.s   $f6,$f0

        #l.s     $f0,A
        #l.s     $f2,B
        
        c.lt.s  $f4,$f6          # is A < B?
        bc1t    printA           # yes -- print A
	c.lt.s  $f6,$f4          # is A > B?
        bc1t    printB           # yes -- print B
        
        la      $a0,EQmsg        # otherwise
        li      $v0,4            # they are equal
        syscall
	mov.s   $f12,$f0         # print one of them
        b       prtnum
        

printA: la      $a0,Amsg         # message for A
        li      $v0,4
	syscall
	mov.s   $f12,$f4         # print A
        li      $v0,2
	syscall

	la      $a0,newl
        li      $v0,4            # print new line
        syscall	

	la      $a0,Blag         # message for B
	li      $v0,4
	syscall
	mov.s   $f12,$f6         # print B

	b       prtnum
        
printB: la      $a0,Bmsg         # message for B
        li      $v0,4
        syscall
	mov.s   $f12,$f6	 # print B
        li      $v0,2
	syscall

	la      $a0,newl
        li      $v0,4            # print new line
        syscall

	la      $a0,Alag         # message for A
	li      $v0,4
	syscall
	mov.s   $f12,$f4         # print A
	
        
prtnum: li      $v0,2            # print single precision
                                 # value in $f12
        syscall
        la      $a0,newl
        li      $v0,4            # print new line
        syscall


	la $a0,rp                # ask for repeat     
	li $v0,4
	syscall

	li $v0,5                 # enter 1-yes  0-no
	syscall

	beqz $v0,eop             # if 0 EOP

	j __start                # if 1 go back

        # jr      $ra            # return to OS

eop:	li $v0,10                # End Of Program	
	syscall                  # Call to system

          .data

#A:        .float  4.830
#B:        .float  1.012
promptA:  .asciiz "Enter A: "
promptB:  .asciiz "Enter B: "
Amsg:     .asciiz "A is smallest: "
Bmsg:     .asciiz "B is smallest: "
Alag:     .asciiz "A is largest: "
Blag:     .asciiz "B is largest: "
EQmsg:    .asciiz "They are equal: "
newl:     .asciiz "\n"
rp:       .asciiz "Repeat (1-yes 0-no)"


############## Output ################
#                                    #
# Console                            #
# =========================          #
# Enter A: 2.1                       #
# Enter B: 2.6                       #
# A is smallest: 2.09999990          #
# B is largest: 2.59999990           #
# Repeat (1-yes 0-no)1               #
# Enter A: 2.8                       #
# Enter B: 2.3                       #
# B is smallest: 2.29999995          #
# A is largest: 2.79999995           #
# Repeat (1-yes 0-no)1               #
# Enter A: 2.5                       #
# Enter B: 2.5                       #
# They are equal: 2.50000000         #
# Repeat (1-yes 0-no)0               #
#                                    #
######################################
