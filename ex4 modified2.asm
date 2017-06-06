.data # to do: b, ask for order of sorting, memory alloc for array
	#sequence: .space 400
	comma: .asciiz ", "
	message1: .asciiz "Enter the size of your sequence (max 100 integers):\n"
	message2: .asciiz "Enter all the numbers. Press 'enter' after each of them:\n"
	message3: .asciiz "Your sequence:\n"
	message4: .asciiz "\nYour sequence after sorting:\n"	
	message5: .asciiz "\nIncreasing sort - press 1, decreasing sort - press 2\n"
	
	ask: .asciiz "\njust asking\n"
.text
	main:
	addi $v0, $zero, 4	# gets the size of sequnce
	la $a0, message1
	syscall
	addi $v0, $zero, 5
	syscall
	add $s0, $zero, $v0
	add $s1, $zero, $v0	# s1 = size of the array given by the user
	addi $t1, $s0, 1
	mul $s0, $s0, $t1
	mul $s0, $s0, 4
	addi $t0, $zero, 0	# s0 = the amount of memory needed
	
	addi $v0, $zero, 9	# allocates memory
	add $a0, $zero, $s0
	syscall
	add $s2, $zero, $v0 # s2 = address of allocated memory
	add $s3, $zero, $v0 # s3 = address of allocated memory BACK UP
	
	addi $v0, $zero, 4
	la $a0, message2
	syscall
	
	addi $t0, $zero, 0 # counter
	while1:
		beq $t0, $s1, exit1
		addi $v0, $zero, 5 	# gets all the numbers
		syscall
		add $t1, $zero, $v0
		sw $t1, ($s2)
		addi $t0, $t0, 1
		addi $s2, $s2, 4
		j while1
	exit1:
		addi $t0, $zero,0	# cleans the registers
		addi $t1, $zero, 0
		add $s2, $zero, $s3	# s2 back to index 0
	
		addi $v0, $zero, 4
		la $a0, message3
		syscall
	
	while2:	# prints the sequence
		beq $t0, $s1, exit2
		lw $t1, ($s2)
		addi $v0, $zero, 1
		add $a0, $zero, $t1
		syscall
		
		addi $v0, $zero, 4
		addi $s2, $s2, 4
		la $a0, comma
		syscall
		addi $t0, $t0, 1
		j while2
	exit2:
		addi $t0, $zero, 0	# cleans registers
		addi $t1, $zero, 0
		add $s2, $zero, $s3	# s2 back to index 0
	
	addi $v0, $zero, 4 # asks for the type of sorting
	la $a0, message5
	syscall
	
	addi $v0, $zero, 5
	syscall
	
	add $t8, $zero, $v0 #stores the answer in t8
	
	beq $t8, 1, increasing
	beq $t8, 2, decreasing
	
	increasing:
	jal bubbleSort1
	j continue
	
	decreasing:
	jal bubbleSort2
	j continue
	
	continue:
	
	addi $v0, $zero, 4
	la $a0, message4
	syscall
	
	add $s2, $zero, $s3	# s2 back to index 0
	while3:		# displays sorted sequence
		beq $t0, $s1, exit3
	
		lw $t1, ($s2)
		
		addi $v0, $zero, 1
		add $a0, $zero, $t1
		syscall
		
		addi $v0, $zero, 4
		la $a0, comma
		syscall
		
		addi $t1, $zero, 0 # cleans register
		addi $t0, $t0, 1
		addi $s2, $s2, 4
		j while3
			
	exit3:
		add $s2, $zero, $s3	# s2 back to index 0

#----------------------------------FINISHES THE PROGRAM ----------------------------------------------------------
			
	addi $v0, $zero, 10
	syscall
	
############# FUNCTIONS ##########################################################################################	
# s0 = max index of the sequence
bubbleSort1:

	addi $t0, $zero, 0
	addi $t2, $zero, 0 # i = 0
	
	while4:
		beq $t0, $s1 exit6
		addi $t2, $zero, 1
		
		while5:
			beq $t2, $s1, exit5
		
			addi $t4, $s2, 4
			
			lw $t5, ($s2)
			lw $t6, ($t4)
			
			bgt $t6, $t5, doNothing1
						
			addi $sp, $sp, -4
			sw $ra, 0($sp)		
			jal swap1
			lw $ra, 0($sp)
			
			addi $t2, $t2, 1
			addi $s2, $s2, 4			
			j while5
			
			doNothing1:			
			addi $t2, $t2, 1
			addi $s2, $s2, 4
			j while5
		exit5:
	addi $t0, $t0, 1
	add $s2, $zero, $s3
	j while4
	exit4:

	addi $t0, $zero, 0 #cleans registers
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	
	jr $ra

#swap-------------------------------------------------------------------------------------------------------------

swap1:
	
	sw $t6, ($s2)
	sw $t5, ($t4)
	
	jr $ra
	
# from big to small----------------------------------------------------------------------------------------------
bubbleSort2:

	addi $t0, $zero, 0 
	addi $t2, $zero, 0 # i = 0
	
	while6:
		beq $t0, $s1 exit6
		addi $t2, $zero, 0		
		
		while7:
			beq $t2, $s1, exit7
		
			addi $t4, $s2, 4
			
			lw $t5, ($s2)
			lw $t6, ($t4)
			
			bgt $t5, $t6, doNothing2
						
			addi $sp, $sp, -4
			sw $ra, 0($sp)		
			jal swap2
			lw $ra, 0($sp)
			
			addi $t2, $t2, 1
			addi $s2, $s2, 4			
			j while7
			
			doNothing2:			
			addi $t2, $t2, 1
			addi $s2, $s2, 4
			j while7
		exit7:
	addi $t0, $t0, 1
	add $s2, $zero, $s3
	j while6
	exit6:

	addi $t0, $zero, 0 #cleans registers
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	
	jr $ra

#swap-------------------------------------------------------------------------------------------------------------

swap2:
	
	sw $t6, ($s2)
	sw $t5, ($t4)
	
	jr $ra
