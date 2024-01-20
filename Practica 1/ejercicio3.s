.text
.align 2
.globl main
main:
	addi $sp, $sp, -4
	sw $ra,0($sp)

	li $a0, 1
	jal leaf_function

	lw $ra,0($sp)
	addi $sp, $sp, 4
	jr $ra
.end main


leaf_function:
	addi $a0, $a0, 1
	slti $t0, $a0, 5
	bnez $t0, else
	jr $ra
else:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal leaf_function
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	jr $ra