.data
X: .word 3
Y: .word -1
.text
.align 2
.globl main
main:
	addi $sp, $sp, -4
	sw $ra,0($sp)
	

	addi $s1, $zero, 3
	addi $s2, $zero, 5
	sub $s0, $s2, $s1
	la $s3, X
	lw   $s4, 0($s3)
	sw	$s4, 4($s3)


	lw $ra,0($sp)
	addi $sp, $sp, 4
	jr $ra
.end main

	
