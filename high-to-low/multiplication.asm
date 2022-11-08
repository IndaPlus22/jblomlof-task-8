
 main:
 # So i dont really know how this stack push works, this is just copied from the example.
 #But i would guess adjust the stackpointer, since we are going to put in 4 bytes of memory
 #then we put the value of $s0(or $s1) in the top of the stack hence the 0($sp) but please explain this last step (0($sp))
 #Same goes for stack pop.
#addi $sp, $sp, -4
 #sw $s0, 0($sp)
 #addi $sp, $sp, -4
 #sw $s1, 0($sp)
 #addi $sp, $sp, -4
 #sw $ra, 0($sp)
 #####Not even needed smh
 
 move $s0, $a0# loop_start starting at 1 and going up to $a0
 ## but actually the variable should be  = 0 becauze i want to increment before
 ##actually this is not even true
 ## if i want to follow and be the "compiler" for the faculty function in the example
 #i should probably do from high to low.
 
 li $s1, 1# loop_stop ## multilpying by 1 is uselessso i simply dont by having = 1  intstead of = 0
##DEBUG
#li $s0, 3 #since i dont fucking know how to actually call this function i just pretend its getting called with a0 = 3
##END_DEBUG
 li $t2, 1 # the result which will be returned.
 ble $s0, 1, skip #prevent some infintylooping by making sure input is not less then or equal to 1
 
 faculty_loop:
 
 move $a0, $s0
 move $a1, $t2
 jal multiply
 move $t2, $v0
 
 addi $s0, $s0, -1 #decrementing loop
 bne $s0, $s1, faculty_loop # continue to loop while loop_start != loop_stop
 j skip
  
  
 multiply: ##multiplication function.
	#will add the value in $a1 to itself $a0 times
 li $t0, 0 #loop var. start at 0 and loop for $a0 times
 move $t1, $a0
 move $t2, $a1
 
 #check if either is negative
 or $t3, $t1, $t2
 bltz $t3, skip #Oh no its negative jump i dont care abour result 0 should be good.
 
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
 
 jr $ra
  
  
  
 skip:
 #lw $ra, 0($sp)
 #addi $sp, $sp, 4
 #lw $s1, 0($sp)
 #addi $sp, $sp, 4
 #lw $s0, 0($sp)
 #addi $sp, $sp, 4
 move $v1, $v0
 li $v0, 10 ##exit
 syscall
 
 #jr $ra ## am i not supposed to do this since faculty should be a function? i get error message for invalid program counter value
 
