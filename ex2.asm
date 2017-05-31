.data
	prompt: .asciiz "Enter a positive integer:\n"
	message: .asciiz "Factorial = "
	space: .asciiz ", "
.text
	main:
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5	# takes input from user
	syscall
	add $t1, $zero, $v0	# t1 = n -> n! = ?
	
	addi $t2, $zero, 1	#factorial
	
	addi $t0, $zero, 1	# i = 1
	while:
	bgt $t0, $t1, exit	# while(i < t1)
	
	mul $t2, $t2, $t0
	jal printNumber
	addi $t0, $t0, 1	# i++
	
	j while
	
	exit:
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 1	#prints the answer
	move $a0, $t2
	syscall
		
	li $v0, 10
	syscall
	
	printNumber:
	li $v0, 1
	add $a0, $zero $t2
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	jr $ra
