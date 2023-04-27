.globl main
.text

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
	sw $ra, 0($sp) # 0 - return address
	sw $s0, 4($sp) # 4 - m
	sw $s1, 8($sp) # 8 - n

	# Jump and Link
	jal ackermann

	# Restore from Stack	
	lw $s1, 8($sp) # 8 - n
	lw $s0, 4($sp) # 4 - m
	lw $ra, 0($sp) # 0 - return address
	addi $sp, $sp, 12

	# Result
	move $s0, $v0 # armazena o resultado em $s0
	li $v0, 4
	la $a0, results
	syscall

	li $v0, 1
	move $a0, $s0 # carrega o resultado para $a0
	syscall

	li $v0, 10 # Encerra o programa
	syscall
	
ackermann:
	# Save registers
	addi $sp, $sp, -12
	sw $ra, 0($sp) # 0 - return address
	sw $s0, 4($sp) # 4 - m
	sw $s1, 8($sp) # 8 - n

	# Check base cases
	bne $s0, $zero, elseif
	addi $v0, $s1, 1 # if m == 0, return n+1
	j done

	elseif:
	bne $s1, $zero, else 
	addi $s0, $s0, -1 # if n==0, m!=0, return m-1
	li $s1, 1
	jal ackermann # return ackermann(m=1,1)
	j done

	else:
	addi $s1, $s1, -1 # n - 1
	move $s2, $s0
	jal ackermann # v0 = ackermann(m, n-1)
	move $a0, $v0
	move $a1, $s2
	addi $s0, $s0, -1 # m - 1
	jal ackermann # return ackermann(m-1, ackermann(m, n-1))

	# Restore registers
	done:
	lw $ra, 8($sp) # 8 - return address
	lw $s1, 4($sp) # 4 - n
	lw $s0, 0($sp) # 0 - m
	addi $sp, $sp, 12
	jr $ra

.data
m_message: .asciiz "Digite o valor m: "
n_message: .asciiz "Digite o valor n: "
results: .asciiz "Resultado: "
