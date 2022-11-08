.globl multiply

.text
main:
multiply: ##multiplication function.
	#will add the value in $a1 to itself $a0 times
 li $t0, 0 #loop var. start at 0 and loop for $a0 times
 move $t1, $a0
 move $t2, $a1
 
 #check if either is negative
 or $t3, $t1, $t2
 bltz $t3, van_halen #Oh no its negative jump i dont care abour result 0 should be good.
 
 #i want $t1 to be less then $t2 because that would be faster
 ble $t1, $t2, no_switch
 
 move $t3, $t1
 move $t1, $t2
 move $t2, $t3
 
 no_switch: 
 li $v0, 0
 ##debug
 ##li $t1, 3
 ##li $t2, 5
 ##end debug
 
loop:
 add $v0, $v0, $t2
 addi $t0, $t0, 1
 bne $t0, $t1, loop
 
 van_halen: ##hmm Go ahead and jump
 jr $ra
