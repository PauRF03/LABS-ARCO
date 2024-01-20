.data

MemCacheDirect: 

	







X: .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
Y: .word -2 0 3 6 -2 12 -3 14 5 6 -7 8 19 -20 1 0 -3 3 32 -3 34 -5 6 -7 		
Z: .space 96


.text

.align 2
.globl main
main:
	addi $sp, $sp, -4
	sw $ra,0($sp)



lw $ra,0($sp)	
addi $sp, $sp, 4
jr $ra
.end main


callCache:

