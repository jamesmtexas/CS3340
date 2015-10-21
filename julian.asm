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
	
	add	$s0, $v0, $zero	#Save return value from leap year checker so we can use $v0 again
	add	$s1, $a0, $zero	#Also save the julian nummber	

	li	$v0, 4
	la	$a0, NumberPrompt
	syscall
	
	li	$v0, 5
	syscall
	add	$t1, $v0, $zero
	
	subi	$t2, $t1, 366
	
	beq	$t2, $s0 ,Invalid

	#naive solution: hard code the values of each month (adding 1 after feb in leap years)
	#see if assembly lets you define constants
	#sub the month value, if less than 0 it is that month + day
	#repeat, subtracting the *cumulative* month values (oh god there will be so many conditional branches)
	#wait no fuck that, just keep a variable with the count of the month we're on and increment each time
	#so we still have a lot of cases but at least the thing we're subtracting is clear

	#Leap year or not - $s0
	#Julian number - $s1

	#use $t0 for month count
	addi	$t0, $t0, 31
	sub	$t1, $t0, $s1
	blz	$t1, January
	
	beqz	$s0, LeapTrack

NonLeapTrack:
	addi	$t0, $t0, 28
	j	AfterLeap	

LeapTrack:
	addi	$t0, $t0, 29
	j	AfterLeap	
	
AfterLeap: specific month labels will print their own output then exit	
	sub	$t1, $t0, $s1
	blz	$t1, February

	addi	$t0, $t0, 31
	sub	$t1, $t0, $s1
	blz	$t1, March

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s1
        blz     $t1, April 

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s1
        blz     $t1, May

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s1
        blz     $t1, June

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s1
        blz     $t1, July

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s1
        blz     $t1, August

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s1
        blz     $t1, September

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s1
        blz     $t1, October

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s1
        blz     $t1, November

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s1
        blz     $t1, December
	
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
