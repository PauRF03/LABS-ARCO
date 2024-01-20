.data
X: .word 2,1,3,4
Y: .word -2, 0, 3, 6
Z: .space 16
.text
.globl main
main:
	la $t0, X
	la $t1, Y
	la $t2, Z
	lw $s0, 4($t0)
	lw $s1, 0($t1)
	add $s3, $s0, $s1
	sw $s3, 8($t2)
	nop
	nop
	nop
	nop
	

