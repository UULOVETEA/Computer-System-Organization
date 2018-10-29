########### hello.asm on p. 26-27 #############
# Xiaomeng Cao                                #
# hello.asm                                   #
# Description                                 #
#     Program which displays a message        #
# Program Logic                               #
# 1.  Display a message from data area        #
# 2.  Return to operating system              #
###############################################

        .text
        .globl __start
__start:
        la $a0,str  # Display the message below
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string

        li $v0,10   # End Of Program	
        syscall     # Call to system

        .data
str:    .asciiz "Hello World!\nI am finally learning SOMETHING!\nAnd it does WORK!\nName: Xiaomeng Cao\nEmail: x.cao@clasnet.sunyocc.edu\nPhone: 3155605687"

############## Output ##############
# Console                          #
# =========================        #
# Hello World!                     #
# I am finally learning SOMETHING! #
# And it does WORK!                #
# Name: Xiaomeng Cao               #
# Email: x.cao@clasnet.sunyocc.edu #
# Phone: 3155605687                #
####################################