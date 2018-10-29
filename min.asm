## min.asm --- determine the min of two floats
##
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

        l.s     $f0,A
        l.s     $f2,B
        
        c.lt.s  $f0,$f2          # is A < B?
        bc1t    printA           # yes -- print A
        c.lt.s  $f2,$f0          # is B < A?
        bc1t    printB           # yes -- print B

        la      $a0,EQmsg        # otherwise
        li      $v0,4            # they are equal
        syscall
        mov.s   $f12,$f0         # print one of them
        b       prtnum
        
printA: la      $a0,Amsg         # message for A
        li      $v0,4
        syscall
        mov.s   $f12,$f0         # print A
        b       prtnum
        
printB: la      $a0,Bmsg         # message for B
        li      $v0,4
        syscall
        mov.s   $f12,$f2         # print B
        
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

        jr      $ra              # return to OS

eop:	li $v0,10                # End Of Program	
	syscall                  # Call to system

          .data

A:        .float  4.830
B:        .float  1.012
promptA:  .asciiz "Enter A: "
promptB:  .asciiz "Enter B: "
Amsg:     .asciiz "A is smallest: "
Bmsg:     .asciiz "B is smallest: "
EQmsg:    .asciiz "They are equal: "
newl:      .asciiz "\n"
rp:     .asciiz "Repeat (1-yes 0-no)"