.data
	sparseVector1: .space 400
	sparseVector2: .space 400	# t4 sparseVectors size
	orderVector1: .space 400	# t5 valuesVector1 index
	orderVector2: .space 400	# t6 valuesVector2 index
	valuesVector1: .space 400	# s4 = the answer
	valuesVector2: .space 400
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
.text
	main:
#gets sparseVector1 ---------------------------------------------------------------------------------------
	
	addi $v0, $zero, 4
	la $a0, message1
	syscall
	
	jal usersNumber
	add $t4, $zero, $v0 # sparseVector1 size = t4
	mul $t4, $t4, 4	# t4 = max index of sparseVector1
	
	addi $v0, $zero, 4
	la $a0, message2
	syscall
	
	addi $t0, $zero, 0	# index of sparseVector1 array
	while1:
	beq $t0, $t4, exit1	# while( index < maxindex )
	
	jal usersNumber
	add $t1, $zero, $v0	# puts user's value in t1
	sw $t1, sparseVector1($t0)	# puts the value to an array in index t2
	addi $t0, $t0, 4	# increases the index by 4 ( one position )
		
	j while1
	
	exit1:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0

#gets sparseVector2 ---------------------------------------------------------------------------------------
		
	addi $v0, $zero, 4
	la $a0, message4
	syscall
	
	addi $t0, $zero, 0	# index of sparseVector2 array
	while2:
	beq $t0, $t4, exit2	# while( index < maxindex )
	
	jal usersNumber
	add $t1, $zero, $v0	# puts user's value in t1
	sw $t1, sparseVector2($t0)	# puts the value to an array in index t2
	addi $t0, $t0, 4	# increases the index by 4 ( one position )
		
	j while2
	
	exit2:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0

#prints sparseVector1 -----------------------------------------------------------------------------------------		
	
	addi $v0, $zero, 4
	la $a0, message5
	syscall
	
	addi $t0, $zero, 0	# index of sparseVector1 array ( increases by 4 )
	
	while3:	# prints sparseVector1
	beq $t0, $t4, exit3
	
	lw $t1, sparseVector1($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while3
	exit3:
		
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0

#prints sparseVector2 -----------------------------------------------------------------------------------------		
	
	addi $v0, $zero, 4
	la $a0, message6
	syscall
	
	addi $t0, $zero, 0	# index of sparseVector1 array ( increases by 4 )
	
	while4:	# prints sparseVector1
	beq $t0, $t4, exit4
	
	lw $t1, sparseVector2($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while4
	exit4:
		
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0	
	
#converts sparseVector1 into orderVector1 and valuesVector1 ---------------------------------------------------
	
	addi $t0, $zero, 0	# index of sparseVector1 array ( increases by 4 )
	addi $t5, $zero, 0	# t5 = index of valuesVector1 = 0
	addi $t1, $zero, 1	# just t1 = 1
	while5:
	beq $t0, $t4, exit5
		
	lw $t2, sparseVector1($t0) # t2 = sparseVector1[index]
	
	beqz $t2, ifZero1
	bgtz $t2, ifNotZero1 # makes rhe program work only for not negative numbers
	
	ifZero1:
	sw $zero, orderVector1($t0)
	addi $t0, $t0, 4
	j while5
	
	ifNotZero1:
	sw $t1, orderVector1($t0) # t3 = 1
	sw $t2, valuesVector1($t5) # t2 = sparseVector1[currentIndex]
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j while5
	
	exit5:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0

#converts sparseVector2 into orderVector2 and valuesVector2 ---------------------------------------------------
	
	addi $t0, $zero, 0	# index of sparseVector2 array ( increases by 4 )
	addi $t6, $zero, 0	# t6 = index of valuesVector2 = 0
	addi $t1, $zero, 1	# just t3 = 1
	while6:
	beq $t0, $t4, exit6
		
	lw $t2, sparseVector2($t0) # t2 = sparseVector1[index]
	
	beqz $t2, ifZero2
	bgtz $t2, ifNotZero2 # makes rhe program work only for not negative numbers
	
	ifZero2:
	sw $zero, orderVector2($t0)
	addi $t0, $t0, 4
	j while6
	
	ifNotZero2:
	sw $t1, orderVector2($t0) # t3 = 1
	sw $t2, valuesVector2($t6) # t2 = sparseVector1[currentIndex]
	addi $t0, $t0, 4
	addi $t6, $t6, 4
	j while6
	
	exit6:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0

#prints orderVector1 -------------------------------------------------------------------------
	
	addi $t0, $zero, 0	# index of orderVector1 array ( increases by 4 )
	
	addi $v0, $zero, 4
	la $a0, message7
	syscall
	
	while7:
	beq $t0, $t4, exit7
	
	lw $t1, orderVector1($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while7
	exit7:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	
#prints valuesVector1 -------------------------------------------------------------------------------------------
		
	addi $v0, $zero, 4
	la $a0, message8
	syscall
	
	addi $t0, $zero, 0	# index of valuesVector1 array ( increases by 4 )
	while8:	# prints valuesVector1
	beq $t0, $t5, exit8
	lw $t1, valuesVector1($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while8
	
	exit8:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0

#prints orderVector2 -------------------------------------------------------------------------
	
	addi $t0, $zero, 0	# index of orderVector1 array ( increases by 4 )
	
	addi $v0, $zero, 4
	la $a0, message9
	syscall
	
	while9:
	beq $t0, $t4, exit9
	
	lw $t1, orderVector2($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while9
	exit9:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	
#prints valuesVector2 -------------------------------------------------------------------------------------------
		
	addi $v0, $zero, 4
	la $a0, message10
	syscall
	
	addi $t0, $zero, 0	# index of valuesVector2 array ( increases by 4 )
	while10:	# prints valuesVector2
	beq $t0, $t6, exit10
	lw $t1, valuesVector2($t0)
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, comma
	syscall
	
	addi $t0, $t0, 4
	
	j while10
	
	exit10:
	# cleans registers:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	
# calculates the dot (scalar) product --------------------------------------------------------------------------
	# t5 = size of valuesVector1, t5 = size of sparseVectors, t6 = size of valuesVector2
	
	addi $t0, $zero, 0
	addi $t1 ,$zero, 0
	addi $t2, $zero, 0
	
	while11:
	beq $t0, $t4, exit11
	
	lw $s0 orderVector1($t0)
	lw $s1 orderVector2($t0)
	
	beqz $s0, firstIsZero
	beqz $s1, firstNotZero
	bgtz $s1, bothNotZero
		
	firstIsZero:
	beqz $s1, bothZero
	bgtz $s1, secondNotZero	
	
	firstNotZero:
	addi $t1, $t1, 4
	addi $t0, $t0, 4
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	j while11
	
	secondNotZero:
	addi $t2, $t2, 4
	addi $t0, $t0, 4
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	j while11
	
	bothZero:
	addi $t0, $t0, 4
	j while11
	
	bothNotZero:
	lw $s2 valuesVector1($t1)
	lw $s3 valuesVector2($t2)
	
	mul $t3, $s2, $s3
	
	add $s4, $zero, $t3	# the answer is in s4
	
	addi $t0, $t0, 4	# increments indexes
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	
	addi $s0, $zero, 0	# cleans registers
	addi $s1, $zero, 0
	addi $s2, $zero, 0
	addi $s3, $zero, 0
	addi $t3, $zero, 0
	
	j while11
	
	exit11:

# prints the answer --------------------------------------------------------------------------------------------

	addi $v0, $zero, 4
	la $a0, message3
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $s4
	syscall

#FINISHES THE PROGRAM ------------------------------------------------------------------------------------------
	
	addi $v0, $zero, 10
	syscall
	
###########################################################################
usersNumber:	# gets number from the user
addi $v0, $zero, 5
syscall
jr $ra

