.data
	A: .word 2
	B: .word 5
.text
.align 2
.globl main
main:
	la $a0, A
	la $a1, B
	lw $a0, 0($a0)
	lw $a1, 0($a1)
do:	jal compara
	move $a0, $v0
while:
	sle $t0, $a1, $a0
	bnez $t0, exit
	b do
exit:
	.end main 
compara:
	sgt $t0, $a0, $a1
	sub $v0, $a0, $a1
	bnez $t0, return

	seq $t0, $a0, $a1
	sub $v0, $a0, $a0
	bnez $t0, return

	move $v0, $a0

return:	
	jr $ra