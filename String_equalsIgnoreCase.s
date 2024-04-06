/***********************************
 * Name:   Noëlle Abat
 * Class:  CS3B - Professor Barnett
 * Lab:    RASM-3
 * Date:   4/4/24
 **********************************/

	.global String_equalsIgnoreCase

	.text

String_equalsIgnoreCase:

	//preserve x1, x2, x3, x4 registers
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack
	stp		x3, x4, [sp, #-16]!		//push x3 and x4 onto stack
	mov		x3, x0					//copy x0 pointer to x3
	mov		x4, x1					//copy x1 pointer to x4
	mov		w0, #1					//initialize to true

loop:

	ldrb	w1, [x3], #1			//load byte from pointer into w1
	ldrb	w2, [x4], #1			//load byte from pointer into w2

	cmp		w1, w2					//check if chars are equal
	bne		not_equal				//if not, branch to not_equal
	cbz		w1, exit_loop			//if byte in w1 is null, branch to exit_loop
	b		loop					//otherwise loop again

not_equal:
	mov		w0, #0					//change to false
	b		exit_loop				//exit loop

exit_loop:

	ldp		x3, x4, [sp], #16		//pop x3 and x4
	ldp		x1, x2, [sp], #16		//pop x1 and x2

	ret 	LR						//return to caller

	.end
.end
