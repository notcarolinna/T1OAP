.text
	.globl main

main:
	# Print scan m
	li $v0, 4
	la $a0, m_message
	syscall
	
	# Scan terminal
	li $v0, 5
	syscall
	move $s0, $v0
	
	# Print scan n
	li $v0, 4
	la $a0, n_message
	syscall
	
	# Scan terminal
	li $v0, 5
	syscall
	move $s1, $v0
	
	# Save in Stack
	addi $sp, $sp, -12
	sw $ra, 0($sp) # 0 - address
	sw $s0, 4($sp) # 4 - m
	sw $s1, 8($sp) # 8 - n
	
	# Jump and Link
	jal ackermann
	
	# Clear the Stack
	add $sp, $sp, 12
	
	# Move ackermann result to s2
	move $s2, $v0
	
	# Print results string
	li $v0, 4
	la $a0, results
	syscall
	
	# Print int result
	li $v0, 1
	move $a0, $s2
	syscall

end:
	# Finish program
	li $v0, 10
	syscall
	
ackermann:

	# Load arguments
	lw $s0, 4($sp) # m
	lw $s1, 8($sp) # n
	
	# If m not equals 0
	bne $s0, 0, mnotzero
	addi $v0, $s1, 1
	jr $ra
	
	mnotzero:
	# If n not equals 0
	bne $s1, 0, nnotzero
	
	# Create space in Stack and set data
	addi $sp, $sp, -12
	addi $t0, $s0, -1
	li $t1, 1
	
	# Save in Stack
	sw $ra, 0($sp) # 0 - address
	sw $t0, 4($sp) # 4 - m - 1
	sw $t1, 8($sp) # 8 - n = 1
	
	# Call ackerman
	jal ackermann
	
	# Load ra and clear the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	
	# Return
	jr $ra
	
	nnotzero:
	
	addi $t0, $s1, -1 # n - 1
	
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp) # m
	sw $t0, 8($sp) # n - 1
	
	jal ackermann
	
	move $t1, $v0 # n
	lw $t0, 4($sp)
	addi $t0, $t0, -1 # m
	
	sw $t0, 4($sp) # m - 1
	sw $t1, 8($sp) # return
	
	jal ackermann
	
	lw $ra 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
	

.data

m_message: .asciiz "Digite o valor m ou -1 para abortar a execução:\n "
n_message: .asciiz "Digite o valor n: "
results: .asciiz "Resultado: "
