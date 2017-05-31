.data	
	prompt: .asciiz "I'll calculate (a + b) - (c - d)\n Enter your values:\n"
	result: .asciiz "result:\n"
.text
	#displays message			#(a + b) - (c - d) 3 7 9 4
	li $v0, 4
	la $a0, prompt
	syscall
	
	#gets the user's values
	li $v0, 5
	syscall
	add $t0, $zero, $v0
	
	li $v0, 5
	syscall
	add $t1, $zero, $v0
	
	li $v0, 5
	syscall
	add $t2, $zero, $v0
	
	li $v0, 5
	syscall
	add $t3, $zero, $v0
		
	add $s0, $t0, $t1	#s0 = t0 + t1
	sub $s1, $t2, $t3	#s1 = t2 - t3
	sub $s2, $s0, $s1	#s2 = s0 - s1
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall
