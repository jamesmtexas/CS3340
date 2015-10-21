	.data
YearPrompt:	.asciiz		"Enter the year: \n"
NumberPrompt:	.asciiz		"Enter the Julian Day: \n"
IsLeap:		.asciiz		"The year entered is a leap year.\n"
NotLeap:	.asciiz		"The year entered is not a leap year.\n"
InvalidInput:	.asciiz		"The Julian Date and year combination is invalid.\n"
Result:		.asciiz		"The date in month/day format is: "
test:		.asciiz		"\n\n"

JAN:		.asciiz		"JAN"
FEB:		.asciiz		"FEB"
MAR:		.asciiz		"MAR"
APR:		.asciiz		"APR"
MAY:		.asciiz		"MAY"
JUN:		.asciiz		"JUN"
JUL:		.asciiz		"JUL"
AUG:		.asciiz		"AUG"
SEP:		.asciiz		"SEP"
OCT:		.asciiz		"OCT"
NOV:		.asciiz		"NOV"
DEC:		.asciiz		"DEC"

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
	add	$s1, $a0, $zero	#Also save the year

	li	$v0, 4
	la	$a0, NumberPrompt
	syscall
	
	li	$v0, 5
	syscall
	add	$t1, $v0, $zero #$t1 is the julian num
	add	$s2, $t1, $zero
	
	subi	$t2, $t1, 366
	
	beq	$t2, $s0 ,Invalid	#if year is 366 days and it is not a leap year (0 == 0)

	#Leap year or not - $s0
	#Year - $s1
	#Julian number - $s2

	li	$v0, 4
	la	$a0, Result
	syscall

	#use $t0 for day count
	addi	$t0, $t0, 31
	add	$t2, $zero, $zero
	sub	$t1, $t0, $s2
	bgez	$t1, January
	add	$t2, $t0, $zero
	beqz	$s0, NonLeapTrack

LeapTrack:
	addi	$t0, $t0, 29
	j	AfterLeap	

NonLeapTrack:
	addi	$t0, $t0, 28
	j	AfterLeap	

AfterLeap: #specific month labels will print their own output then exit	
	sub	$t1, $t0, $s2
	bgez	$t1, February
	
	add	$t2, $t0, $zero
	
	addi	$t0, $t0, 31
	sub	$t1, $t0, $s2
	bgez	$t1, March

	add	$t2, $t0, $zero

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s2
        bgez    $t1, April 

	add	$t2, $t0, $zero

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s2
        bgez    $t1, May

	add	$t2, $t0, $zero

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s2
        bgez    $t1, June

	add	$t2, $t0, $zero

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s2
        bgez    $t1, July

	add	$t2, $t0, $zero

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s2
        bgez    $t1, August

	add	$t2, $t0, $zero

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s2
        bgez    $t1, September

	add	$t2, $t0, $zero

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s2
        bgez    $t1, October

	add	$t2, $t0, $zero

	addi    $t0, $t0, 30
        sub     $t1, $t0, $s2
        bgez    $t1, November

	add	$t2, $t0, $zero

	addi    $t0, $t0, 31
        sub     $t1, $t0, $s2
        bgez    $t1, December
	
January:
	sub $t3, $s2, $t2	#subtract julian number from day count of previous months
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, JAN
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
February:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, FEB
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
March:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, MAR
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
April:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, APR
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
May:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, MAY
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit

June:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, JUN
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
July:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, JUL
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit

August:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, AUG
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
September:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, SEP
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
October:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, OCT
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
November:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, NOV
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
	j Exit
	
December:
	sub $t3, $s2, $t2
	
	li	$v0, 1
	add	$a0, $t3, $zero
	syscall
	
	li	$v0, 4
	la	$a0, DEC
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	
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