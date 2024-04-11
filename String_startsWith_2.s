/*
 * Subroutine String_startsWith_2: Provided two pointers to null-terminated
 *	strings, String_equals will return 1 (true) to x0 if string 2 is an exact
 *	match with the beginning of string 1, or 0 (false) if not
 * x0: Must point to the full null-terminated string
 * x1: Must point to a null-terminated string to match with the start of string 1
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: int byte result
 * All registers are preserved except x0
 */
	.global String_startsWith_2

	.text

String_startsWith_2:

	str		x30, [sp, #-16]!		//push x30 onto stack

	//preserve x1, x2, x3, x4 registers
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack
	stp		x3, x4, [sp, #-16]!		//push x3 and x4 onto stack
	mov		x3, x0					//copy x0 pointer to x3
	mov		x4, x1					//copy x1 pointer to x4
	mov		x0, x1					//copy x1 pointer to x0
	bl		String_length			//get string length
	mov		x5, x0					//store in x5
	mov		x6, #0					//initialize counter to 0

	mov		w0, #1					//initialize to true

loop:

	ldrb	w1, [x3], #1			//load byte from pointer into w1
	ldrb	w2, [x4], #1			//load byte from pointer into w2

	cmp		x5, x6					//compare x5 and x6
	beq		exit_loop				//exit loop if x5 == x6
	cmp		w1, w2					//check if chars are equal
	bne		not_equal				//if not, branch to not_equal

	add		x6, x6, #1				//increment counter
	cbz		w1, exit_loop			//if byte in w1 is null, branch to exit_loop
	b		loop					//otherwise loop again

not_equal:
	mov		w0, #0					//change to false
	b		exit_loop				//exit loop

exit_loop:

	ldp		x3, x4, [sp], #16		//pop x3 and x4
	ldp		x1, x2, [sp], #16		//pop x1 and x2
	ldr		x30, [sp], #16			//push x30 onto stack

	ret 	LR						//return to caller

	.end
.end

