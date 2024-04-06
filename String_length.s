/*
 * Subroutine String_length: Provided a pointer to a null-
 *	terminated string, String_length will return the length
 *	of the string to x0
 * x0: Must point to a null-terminated string
 * LR: Must contain the return address
 * Returned register contents:
 *	x0: int quad result
 * All registers are preserved, except x0
 */
	.global String_length

	.text

String_length:
	//aapcs registers aren't used, so no need to push them

	//preserve x1 and x2 registers
	stp		x1, x2, [sp, #-16]!			//push x1 onto stack
	mov		x2, x0					//copy string pointer to x2
	mov		x0, #0					//start at 0 for length

loop:

	ldrb	w1, [x2], #1			//load byte from pointer

	cbz		w1, exit_loop			//if byte in w1 is null, exit loop
	add		x0, x0, #1				//(increment counter)
	b		loop					//otherwise loop again

exit_loop:

	ldp		x1, x2, [sp], #16			//pop

	ret 	LR						//return to caller

	.end
.end
