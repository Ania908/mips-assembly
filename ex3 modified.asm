.data #fix and show sum
	newLine: .asciiz "\n"
	comma: .asciiz ", "
	message1: .asciiz "Please enter the size of your vectors. (max 100)\n"
	message2: .asciiz "\nPlease enter all the values from your first vector (press enter after each one)\n"
	message3: .asciiz "\nThe scalar (dot) procuct of your vectors is:\n"
	message4: .asciiz "\nPlease enter all the values from your second vector (press enter after each one)\n"
	message5: .asciiz "Your first sparse vector:\n"
	message6: .asciiz "\nYour second sparse vector:\n"
	message7: .asciiz "\nFirst order vector:\n"
	message8: .asciiz "\nFirst vector of values:\n"
	message9: .asciiz "\nSecond order vector:\n"
	message10: .asciiz "\nSecond vector of values:\n"
	message11: .asciiz "\nSum:\n"
	
.text
	main:
#gets sparseVector1 ---------------------------------------------------------------------------------------
	
	addi $v0, $zero, 4
	la $a0, message1
	syscall
	
	jal usersNumber
	add $t4, $zero, $v0
	add $t7, $zero, $v0
	mul $t4, $t4, 6
	mul $t4, $t4, 4
	addi $t0, $zero, 0
	add $a0, $zero, $t4
	addi $v0, $zero, 9
	syscall
	
	addi $t4, $zero, 0
	
	add $s7, $zero $v0
	
	mul $t4, $t7, 4
	add $s6, $s7, $t4
	add $s5, $s6, $t4
	add $s4, $s5, $t4
	add $s3, $s4, $t4
	add $s2, $s3, $t4
	addi $t4, $zero, 4
	
	addi $v0, $zero, 4
	la $a0, message2
	syscall
	
	addi $t0, $zero, 0
	add $t2, $zero, $s7

	while1:
	beq $t0, $t7, exit1
	
	jal usersNumber
	add $t1, $zero, $v0
	sw $t1, ($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
		
	j while1
	
	exit1:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0

#gets sparseVector2 ---------------------------------------------------------------------------------------
		
	addi $v0, $zero, 4
	la $a0, message4
	syscall
	
	addi $t0, $zero, 0
	add $t2, $zero, $s6

	while2:
	beq $t0, $t7, exit2	# while( index < maxindex )
	
	jal usersNumber
	add $t1, $zero, $v0	# puts user's value in t1
	sw $t1, ($t2)	# puts the value to an array in index t2
	addi $t0, $t0, 1
	addi $t2, $t2, 4
		
	j while2
	
	exit2:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	
#prints sparseVector1 -----------------------------------------------------------------------------------------		
	
	addi $v0, $zero, 4
	la $a0, message5
	syscall
	
	addi $t0, $zero, 0
	add $t2, $zero, $s7
	
	while3:	# prints sparseVector1
	beq $t0, $t7, exit3
	
	lw $t1, ($t2)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	
	j while3
	exit3:
		
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0

#prints sparseVector2 -----------------------------------------------------------------------------------------		
	
	addi $v0, $zero, 4
	la $a0, message6
	syscall
	
	addi $t0, $zero, 0
	add $t2, $zero, $s6
	
	while4:	# prints sparseVector1
	beq $t0, $t7, exit4
	
	lw $t1, ($t2)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	
	j while4
	exit4:
		
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	
#converts sparseVector1 into orderVector1 and valuesVector1 ---------------------------------------------------
	
	addi $t8, $zero, 0
	
	add $t3, $zero, $s7
	add $t5, $zero, $s5
	add $t6, $zero, $s4
	
	addi $t0, $zero, 0
	addi $t1, $zero, 1	# just t1 = 1
	while5:
	beq $t0, $t7, exit5
		
	lw $t2, ($t3)
	
	beqz $t2, ifZero1
	bgtz $t2, ifNotZero1 # makes the program work only for not negative numbers
	
	ifZero1:
	sw $zero, ($t5)
	addi $t0, $t0, 1
	addi $t3, $t3, 4
	addi $t5, $t5, 4
	j while5
	
	ifNotZero1:
	sw $t1, ($t5)
	sw $t2, ($t6)
	addi $t0, $t0, 1
	addi $t3, $t3, 4
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	addi $t8, $t8, 1
	j while5
	
	exit5:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0

#converts sparseVector2 into orderVector2 and valuesVector2 ---------------------------------------------------
	
	addi $t9, $zero, 0
	
	add $t3, $zero, $s6
	add $t5, $zero, $s3
	add $t6, $zero, $s2
	
	addi $t0, $zero, 0
	addi $t1, $zero, 1	
	while6:
	beq $t0, $t7, exit6
		
	lw $t2, ($t3)
	
	beqz $t2, ifZero2
	bgtz $t2, ifNotZero2 # makes rhe program work only for not negative numbers
	
	ifZero2:
	sw $zero, ($t5)
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	addi $t3, $t3, 4
	j while6
	
	ifNotZero2:
	sw $t1, ($t5)
	sw $t2, ($t6)
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	addi $t9, $t9, 1
	addi $t3, $t3, 4
	j while6
	
	exit6:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0

#prints orderVector1 -------------------------------------------------------------------------
	
	addi $t0, $zero, 0
	add $t5, $zero, $s5
	
	addi $v0, $zero, 4
	la $a0, message7
	syscall
	
	while7:
	beq $t0, $t7, exit7
	
	lw $t1, ($t5)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	
	j while7
	exit7:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t5, $zero, 0
	
#prints valuesVector1 -------------------------------------------------------------------------------------------
		
	addi $v0, $zero, 4
	la $a0, message8
	syscall
	
	
	add $t6, $zero, $s4
	addi $t0, $zero, 0
	while8:	# prints valuesVector1
	beq $t0, $t8, exit8
	lw $t1, ($t6)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t6, $t6, 4
	
	j while8
	
	exit8:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t6, $zero, 0

#prints orderVector2 -------------------------------------------------------------------------
	
	addi $t0, $zero, 0
	
	add $t5, $zero, $s3
	
	addi $v0, $zero, 4
	la $a0, message9
	syscall
	
	while9:
	beq $t0, $t7, exit9
	
	lw $t1, ($t5)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	
	j while9
	exit9:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t5, $zero, 0
	
#prints valuesVector2 -------------------------------------------------------------------------------------------
				
	addi $v0, $zero, 4
	la $a0, message10
	syscall
	
	add $t6, $zero, $s2
	addi $t0, $zero, 0
	while10:	# prints valuesVector2
	beq $t0, $t9, exit10
	lw $t1, ($t6)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 1
	addi $t6, $t6, 4
	
	j while10
	
	exit10:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t6, $zero, 0
	
# calculates the dot (scalar) product --------------------------------------------------------------------------
	
	addi $t0, $zero, 0
	addi $t1 ,$zero, 0
	addi $t2, $zero, 0
	addi $t4, $zero, 0
	
	add $t5, $zero, $s5
	add $t6, $zero, $s3
	add $t8, $zero, $s4
	add $t9, $zero, $s2
	
	while11:
	beq $t0, $t7, exit11
	
	lw $s0 ($t5)
	lw $s1 ($t6)
	
	beqz $s0, firstIsZero
	beqz $s1, firstNotZero
	bgtz $s1, bothNotZero
		
	firstIsZero:
	beqz $s1, bothZero
	bgtz $s1, secondNotZero	
	
	firstNotZero:
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	addi $t8, $t8, 4
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	j while11
	
	secondNotZero:
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	add $t9, $t9, 4
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	j while11
	
	bothZero:
	addi $t0, $t0, 1
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	j while11
	
	bothNotZero:
	lw $t1 ($t8)
	lw $t2 ($t9)
	
	mul $t3, $t1, $t2
	
	add $t4, $t4, $t3	# the answer is in t4
	
	addi $t0, $t0, 1
	addi $t8, $t8, 4
	addi $t9, $t9, 4
	addi $5, $t5, 4
	addi $t6, $t6, 4
	
	addi $s0, $zero, 0	# cleans registers
	addi $s1, $zero, 0
	addi $t3, $zero, 0
	
	j while11
	
	exit11:

# prints the answer --------------------------------------------------------------------------------------------

	addi $v0, $zero, 4
	la $a0, message3
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t4
	syscall

# vector sum of sparse vectors----------------------------------------------------------------------------------
	
	addi $v0, $zero, 4
	la $a0, message11
	syscall
	
	add $t5, $zero, $s7
	add $t6, $zero, $s6
	addi $t0, $zero, 0
	whileSum:
	beq $t0, $t7, exitSum
	
	lw $t1, ($t5)
	lw $t2, ($t6)
	
	add $t3, $t1, $t2
	
	addi $v0, $zero, 1
	add $a0, $zero, $t3
	syscall
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t5, $t5, 4
	addi $t6, $t6, 4
	addi $t0, $t0, 1
	j whileSum
	
	exitSum:
	

#FINISHES THE PROGRAM ------------------------------------------------------------------------------------------
	
	addi $v0, $zero, 10
	syscall
	
###########################################################################
usersNumber:	# gets number from the user
addi $v0, $zero, 5
syscall
jr $ra

