##################################################################
#
#   Template for subassignment "Inbyggda System-mastern, här kommer jag!"
#
#   Author: Viola Söderlund <violaso@kth.se>
#
#   Created: 2020-10-25
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Documentation (https://ecs-network.serv.pacific.edu/ecpe-170/tutorials/mips-instruction-set)
#   See: Sieve of Eratosthenes (https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
#
##################################################################

### Data Declaration Section ###

.data

primes:		.space  1000            # reserves a block of 1000 bytes in application memory
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"
new_line:	.asciiz "\n"
result_msg: 	.asciiz "All primenumber up to and including your input is:\n"
### Executable Code Section ###

.text

main:
    # get input
    li      $v0,5                   # set system call code to "read integer"
    syscall                         # read integer from standard input stream to $v0

    # validate input
    li 	    $t0,1001                # $t0 = 1001
    slt     $t1,$v0,$t0		        # $t1 = input < 1001
    beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
    nop
    li	    $t0,1                   # $t0 = 1
    slt     $t1,$t0,$v0		        # $t1 = 1 < input
    beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
    nop
    
    # initialise primes array
    la	    $t0,primes              # $s1 = address of the first element in the #shoulb be $t0 no?
    move    $t1,$v0#999 ## loop_end, should not be 999, should be $
    addi $t1, $t1, 1 ## Without this it doesn include last digit
    li 	    $t2,0 ## loop counter
    li	    $t3,1 #1 indicating there is a value there/rather the value is so far prime.
    #need to save $v0
init_loop:
    sb	    $t3, ($t0)              # primes[i] = 1
    addi    $t0, $t0, 1             # increment pointer
    addi    $t2, $t2, 1             # increment counter
    bne	    $t2, $t1, init_loop     # loop if counter != $t1 = $v0 + 1
    
    #now there a list in mem. where the elemnt are 1's so lets make em 0 if it sieves.
    
    
    
 
    ### Continue implementation of Sieve of Eratosthenes ###
  li $t2 ,2 ## outer loop //cant do at 0 so start att 2 even since they are allowed to be a multiple of "1"
outer_loop:
  li $t6, 0 # i need $t6 to be pointer increment
  addi $t6, $t6, -1 #making it -1 since index 0 should be "1"
  add $t6, $t6, $t2
  add $t6, $t6, $t2
  bgt $t6, $t1 skip_inner_loop
	inner_loop:
	la $t0, primes #reset pointer 
	add $t0, $t0, $t6
	 sb $0, ($t0)
	 add $t6, $t6, $t2 ##increment
	 ble $t6, $t1, inner_loop #loop inner while $4 < $t1 = $v0
  skip_inner_loop:
  addi $t2, $t2, 1 ## increment outer
  bne $t2, 32, outer_loop #1000/2 
    
   
   
   
    ##print time
    li $v0, 4 #printing result message
    la $a0, result_msg
    syscall
    
    li $t4, 2 ##index but also print value and also loop
    la $t0, primes
    addi $t0, $t0, 1 # no point checking if "1" is prime since its not but itsnt touched by my code :(
    loop_again:
    lb $t2, ($t0)
    beqz $t2 no_print
    li $v0 1 #printing digits
    move $a0, $t4
    syscall
    li $v0, 4 # printing \n
    la $a0, new_line
    syscall
    no_print:
    addi $t4, $t4, 1
    addi $t0, $t0, 1
    bne $t4, $t1, loop_again
    
    # exit program
    j       exit_program
    nop

invalid_input:
    # print error message
    li      $v0, 4                  # set system call code "print string"
    la      $a0, err_msg            # load address of string err_msg into the system call argument registry
    syscall                         # print the message to standard output stream

exit_program:
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # exit program