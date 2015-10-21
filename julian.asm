	.data
YearPrompt:	.asciiz		"Enter the year: \n"
NumberPrompt:	.asciiz		"Enter the Julian Day: \n"
IsLeap:		.asciiz		"The year entered is a leap year.\n"
NotLeap:	.asciiz		"The year entered is not a leap year.\n"
InvalidInput:	.asciiz		"The Julian Date and year combination is invalid.\n"

	.text

main:
	li	$v0, 4	#Print asciiz string
	la	$a0, YearPrompt
	syscall

	li	$v0, 5	#Read integer
	syscall
	add	$a0, $v0, $zero	#Save in argument register to pass to leap year checker
	
	#At this point we can run $t0 through the leap year test
	#The julian day should not be 366 unless it is a leap year
	
	jal	S1
	
	#1 in $v0 if leap year, else 0
	
	add	$t0, $v0, $zero	#Save return value from leap year checker so we can use $v0 again
	
	li	$v0, 4
	la	$a0, NumberPrompt
	syscall
	
	li	$v0, 5
	syscall
	add	$t1, $v0, $zero
	
	subi	$t2, $t1, 366
	
	beq	$t2, $t0 ,Invalid

	j Exit
	


#Following subprogram determines whether a given year is a leap year
S1:
	addi	$t1, $zero, 4	#Number to be divided by
	div	$a0, $t1
	mfhi	$t2		#Get remainder
	bnez	$t2, S5		#If not divisible by 0, not a leap year

S2:	#Leap year
	addi	$t1, $zero, 100
	div	$a0, $t1
	mfhi	$t2
	bnez	$t2, S4

S3:	#Not a leap year
	addi	$t1, $zero, 400
	div	$a0, $t1
	mfhi	$t2
	bnez	$t2, S5
	
S4:
	addi	$v0, $zero, 1
	jr	$ra
	
S5:
	addi	$v0, $zero, 0
	jr	$ra

Invalid:
	li	$v0, 4	#Print asciiz string
	la	$a0, InvalidInput
	syscall

Exit:
	li	$v0, 10	#Exit
	syscall
