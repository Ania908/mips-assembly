.data  # don't ask user, just show both orders
	sequence: .space 400
	comma: .asciiz ", "
	newLine: .asciiz "\n"
	message1: .asciiz "Enter the size of your sequence (max 100 integers):\n"
	message2: .asciiz "Enter all the numbers. Press 'enter' after each of them:\n"
	message3: .asciiz "Your sequence:\n"
	message4: .asciiz "\nYour sequence after sorting:\n"	
	message5: .asciiz "\nIncreasing sort - press 1, decreasing sort - press 2\n"
	
.text
	main:
	addi $v0, $zero, 4	# gets the size of sequnce
	la $a0, message1
	syscall
	addi $v0, $zero, 5
	syscall
	add $s0, $zero, $v0
	mul $s0, $s0, 4	# converts size to max index
	
	addi $v0, $zero, 4
	la $a0, message2
	syscall
	
	addi $t0, $zero, 0 #index of sequence
	while1:
		beq $t0, $s0, exit1
		addi $v0, $zero, 5 	# gets all the numbers
		syscall
		add $t1, $zero, $v0
		sw $t1, sequence($t0)
		addi $t0, $t0, 4
		j while1
	exit1:
		addi $t0, $zero,0	# cleans the registers
		addi $t1, $zero, 0
	
		addi $v0, $zero, 4
		la $a0, message3
		syscall
	
	while2:	# prints the sequence
		beq $t0, $s0, exit2
		lw $t1, sequence($t0)
		addi $v0, $zero, 1
		add $a0, $zero, $t1
		syscall
		addi $v0, $zero, 4
		la $a0, comma
		syscall
		addi $t0, $t0, 4
		j while2
	exit2:
		addi $t0, $zero, 0	# cleans registers
		addi $t1, $zero, 0
	

	
	addi $v0, $zero, 4
	la $a0, message4
	syscall
	
	#increasing:
	jal bubbleSort1

	
	while3:		# displays sorted sequence
		beq $t0, $s0, exit3
	
		lw $t1, sequence($t0)
		
		addi $v0, $zero, 1
		add $a0, $zero, $t1
		syscall
		
		addi $v0, $zero, 4
		la $a0, comma
		syscall
		
		addi $t1, $zero, 0 # cleans register
		addi $t0, $t0, 4 # index++
		j while3
			
	exit3:
	
	addi $v0, $zero, 4
	la $a0, newLine
	syscall
	
	#decreasing:
	jal bubbleSort2


	while8:		# displays sorted sequence
		beq $t0, $s0, exit8
	
		lw $t1, sequence($t0)
		
		addi $v0, $zero, 1
		add $a0, $zero, $t1
		syscall
		
		addi $v0, $zero, 4
		la $a0, comma
		syscall
		
		addi $t1, $zero, 0 # cleans register
		addi $t0, $t0, 4 # index++
		j while8
			
	exit8:

#----------------------------------FINISHES THE PROGRAM ----------------------------------------------------------
			
	addi $v0, $zero, 10
	syscall
	
############# FUNCTIONS ##########################################################################################	
# s0 = max index of the sequence
bubbleSort1:

	addi $t0, $zero, 1 # flag = 1
	addi $t1, $zero, 0 # j = 0 ( i and j are indexes so they'll be incremented by 4 )
	addi $t2, $zero, 0 # i = 0
	
	while4:
		beqz $t0, exit4
			
		addi $t0, $zero, 0
		addi $t1, $t1, 4
		sub $t3, $s0, $t1
		
		while5:
			beq $t2, $t3, exit5
		
			addi $t4, $t2, 4
			
			lw $t5, sequence($t2)
			lw $t6, sequence($t4)
			
			blt $t5, $t6, doNothing
						
			addi $sp, $sp, -4
			sw $ra, 0($sp)		
			jal swap1
			lw $ra, 0($sp)
			
			addi $t2, $t2, 4			
			
			j while5
			
			doNothing:			
			addi $t2, $t2, 4
			j while5
		exit5:
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
	
	sw $t6, sequence($t2)
	sw $t5, sequence($t4)
	
	jr $ra
	
# from big to small----------------------------------------------------------------------------------------------
bubbleSort2:

	addi $t0, $zero, 0 
	addi $t2, $zero, 0 # i = 0
	
	while6:
		beq $t0, $s0 exit6
		addi $t2, $zero, 0		
		
		while7:
			beq $t2, $s0, exit7
		
			addi $t4, $t2, 4
			
			lw $t5, sequence($t2)
			lw $t6, sequence($t4)
			
			bgt $t5, $t6, doNothing2
						
			addi $sp, $sp, -4
			sw $ra, 0($sp)		
			jal swap2
			lw $ra, 0($sp)
			
			addi $t2, $t2, 4			
			j while7
			
			doNothing2:			
			addi $t2, $t2, 4
			j while7
		exit7:
	addi $t0, $t0, 4
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
	
	sw $t6, sequence($t2)
	sw $t5, sequence($t4)
	
	jr $ra
