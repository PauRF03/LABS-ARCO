.data
MemCacheDirect: .word 0 
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0 
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
				.word 0
				.space 4
					
X: .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
Y: .word -2 0 3 6 -2 12 -3 14 5 6 -7 8 19 -20 1 0 -3 3 32 -3 34 -5 6 -7 		
Z: .space 96

.text
.align 2
.globl main
	main:
		addi $sp, $sp, -4
		sw $ra,0($sp)
		addi $s0, $zero, 0 #i
		addi $s1, $zero, 0 #comptador_hit
		addi $s2, $zero, 0 #comptador_miss
	for:
		sll $t0, $s0, 2
		la $t1, X
		la $t2, Y
		la $t6, Z
		add $t1, $t1, $t0 #@X[i]
		add $t2, $t2, $t0 #@Y[i]
		add $t6, $t6, $t0 #@Z[i]
		lw $t3, 0($t1) #X[i]
		lw $t4, 0($t2) #Y[i]
		add $t5, $t3, $t4
		sw $t5, 0($t6) #Z[i] = X[i] + Y[i]
		add $a0, $zero, $t1
		addi $sp, $sp, -20
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $t2, 12($sp)
		sw $t6, 16($sp)
	if1:
		jal callCache
		beqz $v0, else1
		lw $s1, 4($sp)
		addi $s1, $s1, 1 #hit++
		sw $s1, 4($sp)
		b if2
	else1:
		lw $s2, 8($sp)
		addi $s2, $s2, 1 #miss++
		sw $s2, 8($sp)
	if2:
		lw $a0, 12($sp)
		jal callCache
		beqz $v0, else2
		lw $s1, 4($sp)
		addi $s1, $s1, 1 #hit++
		sw $s1, 4($sp)
		b if3
	else2:
		lw $s2, 8($sp)
		addi $s2, $s2, 1 #miss++
		sw $s2, 8($sp)
	if3:
		lw $a0, 16($sp)
		jal callCache
		beqz $v0, else3
		lw $s1, 4($sp)
		addi $s1, $s1, 1 #hit++
		sw $s1, 4($sp)
		b fielse3
	else3:
		lw $s2, 8($sp)
		addi $s2, $s2, 1 #miss++
		sw $s2, 8($sp)
	fielse3:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $t2, 12($sp)
		lw $t6, 16($sp)
		addi $sp, $sp, 20
		addi $s0, $s0, 1 #i++
		addi $t5, $zero, 24
		bne $t5, $s0, for #i > 23 ?
	fibucle:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	.end main

callCache:
	srl $t0, $a0, 4 #line
	andi $t0, $t0, 0x000F #cache_line
	sll $t0, $t0, 3
	srl $t1, $a0, 8 #tag
if: 
	la $s0, MemCacheDirect
	add $s0, $s0, $t0
	lw $s1, 0($s0)
	lw $s2, 4($s0)
	addi $t2, $zero, 1
	bne $s1, $t2, else
	bne $s2, $t1, else
	addi $v0, $zero, 1
	jr $ra
else: 
	sw $t2, 0($s0)
	sw $t1, 4($s0)
	addi $v0, $zero, 0
	jr $ra