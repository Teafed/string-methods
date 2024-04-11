/*
 * Subroutine String_equalsIgnoreCase: Provided two pointers to null-
 *	terminated strings, String_equals will return 1 (true) to x0 if
 *	they are a match (ignoreing case), or 0 if they are not
 * x0: Must point to a null-terminated string
 * x1: Must point to a null-terminated string
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: int byte result
 * All registers are preserved except x0
 */
	.global String_equalsIgnoreCase

	.text

String_equalsIgnoreCase:

	//preserve x1, x2, x3, x4 registers
	str		x30, [sp, #-16]!		//push x30 onto stack
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack

	mov		x3, x0					//copy x0 pointer to x3
	mov		x4, x1					//copy x1 pointer to x4
	mov		w0, #1					//initialize to true

	str		x4, [sp, #-16]!			//push x4 into stack
	mov		x0, x3					//move x3 to x0
	bl		String_toLowerCase		//to lower
	mov		x3, x0					//move to x3
	ldr		x4, [sp], #16			//pop x4
	str		x3, [sp, #-16]!			//push x3 into stack
	mov		x0, x4					//move x4 to x0
	bl		String_toLowerCase		//to lower
	ldr		x3, [sp], #16			//pop x4
	mov		x4, x0					//move to x4

	mov		x0, #1					//initialize to true

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

	ldp		x1, x2, [sp], #16		//pop x1 and x2
	ldr		x30, [sp], #16			//pop x30 from stack

	ret 	LR						//return to caller

	.end
.end
