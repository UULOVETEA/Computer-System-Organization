########### Fah2Cel.asm on p. 41-42 ###############
# Xiaomeng Cao                                    #
# Fah2Cel.asm                                     #
# Description                                     #
#     Program to convert fahrenheit to celsius    #
# Program Logic                                   #
# 1.  prompt to enter a temperature in fahrenheit #
# 2.  enter the temperature                       #
# 3.  calculate the celsius temperature           #
# 4.  display the temperature in celsius          #
###################################################

        .text
        .globl __start
__start:
        la $a0,prompt     # display "Enter temperature (Fahrenheit):" 
        li $v0,4
        syscall

        li $v0,5          # enter temperature -> v0
        syscall

        sub $t0, $v0, 32  # temperature - 32
        mul $t0, $t0, 5   # (temperature - 32) * 5
        div $t0, $t0, 9   # (temperature - 32) * 5/9 -> t0

        la $a0, ans1      # display "The Temperature in Celsius is "
        li $v0,4
        syscall

        move $a0,$t0      # t0 -> a0 for display
        li  $v0,1         # display temperature
        syscall

        la $a0,endl       # display cr/lf
        li $v0,4
        syscall
	
        li $v0,10         # EOP
        syscall

        .data
prompt: .asciiz "Enter temperature (Fahrenheit): "
ans1:   .asciiz "The Temperature in Celsius is "
endl:   .asciiz "\n"

############## Output ###################
#                                       #
# Console                               #
# =========================             #
# Enter temperature (Fahrenheit): 32    #
# The Temperature in Celsius is 0       #
# Enter temperature (Fahrenheit): 212   #
# The Temperature in Celsius is 100     #
# Enter temperature (Fahrenheit): 185   #
# The Temperature in Celsius is 85      #
# Enter temperature (Fahrenheit): 34    #
# The Temperature in Celsius is 1       #
# Enter temperature (Fahrenheit): 165   #
# The Temperature in Celsius is 73      #
# Enter temperature (Fahrenheit): 150   #
# The Temperature in Celsius is 65      #
# Enter temperature (Fahrenheit): 175   #
# The Temperature in Celsius is 79      #
#                                       #
#########################################