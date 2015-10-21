	.data

prompt:	.asciiz	"Enter a Julian Date: \n"
output:	.asciiz	"The corresponding Gregorian Date is: \n"

	.text
ParseInput:
	#input: $t0
	#month: $s0
	#year: 	$s1
	#day:	$s2

	li	$v0,8
	syscall
	addi	$t0, $v0, $zero

	#put month, day, year into arg registers, call tojdn

	

ToJDN:
	#a:	$s0
	#y: 	$s1
	#m: 	$s2
	#JDN: 	$s3

	sw $s0, $4(sp)
	sw $s1, $8(sp)
	sw $s2, $12(sp)
	addi $sp, $sp, -12

	#do stuff, use your own saved registers + those under arg

	addi $a0, $s3, $zero
	
	addi $sp, $sp, 12
	lw $s2, $12(sp)
	lw $s1, $8(sp)
	lw $s0, $4(sp)

	#call togregorian, the JDN is all it needs so put that in $a0, function can then use the other registers

ToGregorian:
	#y,j,m,n,r,p,v,u:	$t0-t7
	#s,w,B,C:		$s1-$s4

	#save the registers you use!
	
	sw $s1, $4(sp)
	sw $s2, $8(sp)
	sw $s3, $12(sp)
	sw $s4, $16(sp)
	addi $sp, $sp, -16

	#Add all those constants into the registers
	#Calculate day, month, year, save them into args to print function
	#we may run out of registers here? save a register and restore between independent steps of the alg?

	addi $sp, $sp, 16
	lw $s4, $16(sp)
	lw $s3, $12(sp)
	lw $s2, $8(sp)
	lw $s1, $4(sp)

	
