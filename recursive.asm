	.data
	
max:	.asciiz "Enter the max for the range sum\n"
min:	.asciiz "Enter the min for the range sum\n"

	.text
	
main:
	li	$v0, 4
	la	$a0, max
	syscall

	li	$v0, 5
	syscall
	move	$s0, $v0	#max

	li	$v0, 4
	la	$a0, min
	syscall

	li	$v0, 5
	syscall
	move 	$s1, $v0	#min
	
	move	$a0, $s0
	move	$a1, $s1
	
	jal	RangeSum
	
	move	$t0, $v0
	
	li	$v0, 1
	move	$a0, $t0
	syscall
	
	li	$v0, 10
	syscall
	
RangeSum:
	addi	$sp, $sp, -12
	sw	$a0, 8($sp)
	sw	$a1, 4($sp)
	sw	$ra, 0($sp)

	jal	RangeSumR
	
	lw	$ra, 0($sp)
	lw	$a1, 4($sp)
	lw	$a0, 8($sp)
	addi	$sp, $sp, 12
	
	move	$t0, $v0	#max
	
	addi	$sp, $sp, -12
	sw	$a0, 8($sp)
	sw	$a1, 4($sp)
	sw	$ra, 0($sp)

	move	$a0, $a1	

	jal	RangeSumR
	
	lw	$ra, 0($sp)
	lw	$a1, 4($sp)
	lw	$a0, 8($sp)
	addi	$sp, $sp, 12
	
	move	$t1, $v0	#min
	
	sub	$v0, $t0, $t1
	add	$v0, $v0, $a1
	
	jr	$ra

RangeSumR:
	addi	$t2, $a0, 1
	div	$t3, $a0, 2
	mul	$v0, $t2, $t3
	
	jr	$ra