/*
 * Subroutine String_copy: Provided a pointer to a null-terminated
 *	string, String_copy will copy a string from the x0 to the x1 register
 * x0: Must point to a null-terminated string
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: null-terminated string (original)
 *	x1: null-terminated string (copy)
 * All registers are preserved except x1
 */

	.global String_copy

	.text

String_copy:

	str		x2, [sp, #-16]!			//push x2 onto stack
	mov		x2, #0					//initialize to x2 to 0

loop:

	ldrb	w2, [x0], #1			//load byte from pointer into w2 and increment
	strb	w2, [x1], #1			//store into x1 and increment

	cmp		w2, #0					//check if reached end of string (reached null char)
	beq		exit_loop				//if equal, branch to exit_loop
	add		x2, x2, #1				//increment x2
	b		loop					//and loop again

exit_loop:
	strb	w2, [x1]
//	mov		x0, x1					//save to x0
	ldr		x2, [sp], #16			//pop x2

	ret 	LR						//return to caller

	.end
.end
