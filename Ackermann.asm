.text
	.globl main

main:
	# Print m_message
	li $v0, 4
	la $a0, m_message
	syscall
	
	# Scan terminal "m"
	li $v0, 5
	syscall
	move $s0, $v0
	
	# Print n_message
	li $v0, 4
	la $a0, n_message
	syscall
	
	# Scan terminal "n"
	li $v0, 5
	syscall
	move $s1, $v0
	
	# Save in Stack
	addi $sp, $sp, -12
	lw $ra, 0($sp) # 0 - address
	lw $s0, 4($sp) # 4 - m
	lw $s1, 8($sp) # 8 - n
	
	# Jump and Link
	jal ackermann

    # Restore from Stack
    lw $s1, 8($sp) # 8 - n
    lw $s0, 4($sp) # 4 - m
    lw $ra, 0($sp) # 0 - return adress
    addi $sp, $sp, 12

    # Result
    li $v0, 4
    la $a0, results
    syscall

    # Exit
    end:
	li $v0, 10
	syscall
	
ackermann:

	
	



.data
m_message: .asciiz "Digite o valor m: "
n_message: .asciiz "Digite o valor n: "
results: .asciiz "Resultado: "
