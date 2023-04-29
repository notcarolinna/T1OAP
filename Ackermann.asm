.text
	.globl main

main:
	# Print scan 
	li $v0, 4
	la $a0, message
	syscall
	
	# Scan m
	li $v0, 5
	syscall
	move $t3, $v0
	move $s0, $v0
	bltz $s0, end
	
	# Scan n
	li $v0, 5
	syscall
	move $s1, $v0
	move $t4, $v0
	bltz $s1, end
	
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
	#li $v0, 4
	#la $a0, results
	#syscall
	
	# Print Result
	la $a0, A
	li $v0, 4		# Print " A( "
	syscall 

	li $v0, 1		# Print m
	move $a0, $t3
	syscall 

	la $a0, p2
	li $v0, 4		# Print " ,  "
	syscall 

	li $v0, 1		# Print n
	move $a0, $t4
	syscall 

	la $a0, p3
	li $v0, 4		# Print " ) =  "
	syscall 

	li $v0, 1
	move $a0, $s2 # Resultado
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

message: .asciiz "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução \n"
A:	.asciiz "A("
p2:	.asciiz ", "
p3:	.asciiz ") = "
results: .asciiz " "
