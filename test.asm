
		.text
        .globl __start
__start:

begin:	# 1.  Enter A, B and C
		li $v0, 4          			# enter A
		la $a0, str1
        syscall
		li $v0, 5
		syscall
		move $t0, $v0
		
		li $v0, 4          			# enter B
		la $a0, str2
        syscall
		li $v0, 5
		syscall
		move $t1, $v0

		li $v0, 4          			# enter B
		la $a0, str3
        syscall
		li $v0, 5
		syscall
		move $t2, $v0
		
step2:	# 2.  Enter x1 and x2
		li $v0, 4          			# enter x1
		la $a0, str4
        syscall
		li $v0, 5
		syscall
		move $t3, $v0
		
		li $v0, 4          			# enter x2
		la $a0, str5
        syscall
		li $v0, 5
		syscall
		move $t4, $v0
		
step3: 	# 3.  Enter ymax and ymin
		li $v0, 4          			# enter y-min
		la $a0, str6
        syscall
		li $v0, 5
		syscall
		move $t6, $v0
		
		li $v0, 4          			# enter y-max
		la $a0, str7
        syscall
		li $v0, 5
		syscall
		move $t7, $v0
		
step4:  # 4.  y = ymax
		add $t8, $t7, 0
		
step5:  # 5.  x = x1
		add $t9, $t3, 0
		
step6:	# 6.  f(x) = (Ax+B)x+C
		mul $t5, $t0, $t9
		add $t5, $t5, $t1
		mul $t5, $t5, $t9
		add $t5, $t5, $t2
		
step7:	# 7.  if (y == f(x)) display '*' and go to star
		beq $t8, $t5, star
		
step8:	# 8.  if (x == 0)  display '|' and go to bar
		beqz $t9, bar
		
step9:	# 9.  if (y == 0)  display '-' and go to dash
		beqz $t8, dash
		
step10:	# 10.  display ' '
		li $v0, 4
		la $a0, space
        syscall
		
step11:	# 11.  if (x == x2) display '\n' and go to newl
		beq $t9, $t4, newl
		
step12:	# 12.  x++ and go to step 6
		add $t9, $t9, 1
		j step6
		
step13:	# 13.  if (y == ymin) step15
		beq $t8, $t6, step15
		
step14:	# 14.  y-- and go to step 5
		sub $t8, $t8, 1
		j step5
		
step15: # 15. Ask if the user wants to go again
		la $a0, continue
		li $v0,4
		syscall
		li $v0,5
		syscall
		beqz $v0, EOP
		j begin
		
star:	li $v0, 4
		la $a0, starS
        syscall
		j step11
		
bar: 	li $v0, 4
		la $a0, barS
        syscall
		j step11
		
dash: 	li $v0, 4
		la $a0, dashS
        syscall
		j step11
		
newl:   li $v0, 4
		la $a0, newlS
        syscall
		j step13
		
		# 15.  EOP
EOP:	li $v0, 10
		syscall	
		
			.data
str1: 		.asciiz "A: "
str2:		.asciiz "B: "
str3:		.asciiz "C: "
str4:		.asciiz "x1: "
str5:		.asciiz "x2: "
str6:		.asciiz "y-min: "
str7:		.asciiz "y-max: "
space:		.asciiz " "
starS:		.asciiz "*"
barS: 		.asciiz "|"
dashS: 		.asciiz "-"
newlS:	    .asciiz "\n"
continue:	.asciiz "\n\nEnter 1 to continue, 0 to quit: "