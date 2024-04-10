/*
 * Subroutine String_startsWith_1: Provided two pointers to null-terminated
 *	strings and an index, String_equals will return 1 (true) to x0 if string
 *	2 is an exact match with the beginning of string 1, or 0 (false) if not
 * x0: Must point to the full null-terminated string
 * x1: Contains the index to be searched
 * x2: Must point to a null-terminated string to match with the start of string 1
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: int byte result
 * All registers are preserved except x0
 */
	.global String_startsWith_1

	.text

String_startsWith_1:

	str		x30, [sp, #-16]!		//push x30 onto stack
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack
	mov		x3, x2					//put s2 into x3 for a sec
	mov		x2, x1					//put length into x2
	bl		String_substring_2		//get substring of string1
	mov		x0, x1					//move new substring to x0
	mov		x3, x1					//also put in x3 for later
	ldp		x1, x2, [sp], #16		//pop x1 and x2 from stack
	mov		x1, x2					//move substring to x1
	bl		String_equals			//are they the same?
	str		x0, [sp, #-16]!			//push onto stack
	mov		x0, x3					//don't forget
	bl		free					//i'm shitting in the dark
	ldr		x0, [sp], #16			//pop onto stack
	ldr		x30, [sp], #16			//push x30 onto stack

	ret		LR						//return to sender
/*
	//preserve x1, x2, x3, x4 registers
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack
	stp		x3, x4, [sp, #-16]!		//push x3 and x4 onto stack
	mov		x3, x0					//x3 = string 1 pointer
	mov		x4, x2					//x4 = string 2 pointer
	mov		x0, x2					//copy string 2 pointer to x0
	bl		String_length			//get string length
	mov		x5, x0					//x5 = string 2 length
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

	mov		x0, x1					//move x1 into x0
	bl		free

	ldp		x3, x4, [sp], #16		//pop x3 and x4
	ldp		x1, x2, [sp], #16		//pop x1 and x2
	ldr		x30, [sp], #16			//push x30 onto stack

	ret 	LR						//return to caller

	.end
.end

*/
