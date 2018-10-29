.data   # Data declaration section
prompt: .asciiz "Enter a message: "    #prompt to enter message
key_prompt: .asciiz "Enter a key for this message: " # enter number to shift letters
enc_dec: .asciiz "(e)ncrypt or (d)ecrypt? " # encrypt or decrypt prompt
encode_bytes: .byte 1 #bytes for encoding
key: .word 0 # the variable for encoding key
String: .space 255 # the string to be encrypted/decrypted
encode: .space 1   #the character (e) or (d) to ask encrypt or decrypt
e: .ascii "e"
d:  .ascii "d"

.text
        .globl __start
__start: 

    li $v0, 4 #print string
    la $a0, prompt # print the first prompt
    syscall

    li $v0, 8 # read in string to be encrpyted
    la $a0, String # stores string in variable
    li $a1, 255 # the string allocates room for up to 255 chars
    syscall

    li $v0, 4 #print string
    la $a0, key_prompt
    syscall

    li $v0, 5 #code to read in int
    syscall # reading in the integer
    move $t5, $v0 #moving key to $t5

    li $v0, 4 #print string
    la $a0, enc_dec #print the encode string
    syscall

    li $v0, 12 #read character code
    #la $a0, encode #load address of encode to register $a0
    #li $a1, 2 #limit input to 1 char
    syscall

    li $s7, 101
    li $s6, 100

    beq $v0, $s7, __encrypt_Loop

    beq $v0, $s6, __decrypt_Loop

__encrypt_Loop:

    la $t0, String  #holding address of String

__encode_Loop:

    lb $t2, ($t0) #loading the byte to be manipulated into $t2      
    beqz $t2, __print_String # if string is equal to zero, jump to print new string

__continue:

    add $t2, $t2, $t5 #adding the key to the string (manipulating chars)    
    li $t3, 'z' #loading the value of z, for checking purposes         
    bgt $t2, $t3, __encrypt_Check #if the char is "bigger" than z jump to fix       
    sb $t2, ($t0) #store the value
    addi $t0, 1 #incrementing to next char
    j __encode_Loop        

__encrypt_Check:

    li $s4, 25
    sub $t2, $t2, $s4       
    sb $t2, ($t0) #store char in string     
    addi $t0, 1 #incrementing to next char
    j __continue

__decrypt_Loop:

    la $t0, String  #holding address of String      
    #   la $t5, key #loading the key into $t5

__decode_Loop:

    lb $t2, ($t0) #making $t2 the address of the string     
    beqz $t2, __print_String # if string is equal to zero, jump to print new string

___continue:

    sub $t2, $t2, $t5 #subtracting the key to the string (manipulating chars)       
    li $t3, 'a' #loading the value of z, for checking purposes         
    blt $t2, $t3, __decode_Check #if the char is "smaller" than a jump to fix       
    sb $t2, ($t0) #store the value      
    addi $t0, 1 #incfementing to next char
    j __decode_Loop        

__decode_Check:

    li $s4, 25      
    add $t2, $t2, $s4       
    sb $t2, ($t0) #store char in string     
    addi $t0, 1 #incrementing to next char
    j __continue

__print_String:

    li $v0, 4
    #move $a0, $t0
    la $a0, String
    syscall

__end_program:

    li $v0, 10
    syscall