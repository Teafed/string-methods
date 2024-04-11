/* Subroutine String_substring_2: Provided a pointer to a null-terminated
 * string, a pointer to another string, and an int, String_substring_2
 * will return a substring from the first index (inclusive) to the end of
 * the string.
 * x0: Must point to a null-terminated string
 * x1: Must point to the address of the substring
 * x2: Must contain the first index as an int
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: original null-terminated tring
 *	x1: null-terminated substring
 * All registers are preserved except x0 and x1. Memory must be deallocated!
 */


	.global String_substring_2

	.text

String_substring_2:
	stp		x1, x30, [sp, #-16]!		//push x1 and x30 onto stack

	mov		x1, x0						//move address to x1
	bl		String_length				//get full string length
	mov		x7, x0						//move to x7
	sub		x8, x0, x2					//x8 holds length of substring
	add		x8, x8, #1					//plus 1 for null terminator
	mov		x0, x1						//put address back into x0

	stp		x0, x2, [sp, #-16]!			//push x0 and x2 onto stack
	stp		x7, x8, [sp, #-16]!			//push x7 and x8 onto stack

	mov		x0, x8						//put amount to allocate into x0
	bl		calloc						//allocate memory

	mov		x1, x0						//store address of substring into x1
	mov		x9, x0						//store address of substring into x9 (for getting start pos)
	mov		x4, #0						//initialize counter x4 to 0

	ldp		x7, x8, [sp], #16			//pop x8 from stack
	ldp		x0, x2, [sp], #16			//pop x0 and x2 from stack
	mov		x10, x0						//store address of string into x10 (for getting start pos)

loop:

	ldrb	w5, [x0], #1				//load contents of x0 into w5
	cmp		x4, x2						//compare with start index
	blt		skip_byte					//if x4 < x1, don't copy
	cmp		x4, x7						//compare with end index
	bge		exit_loop					//if x4 >= x2, exit loop
	strb	w5, [x1], #1				//store byte into x1 and increment

skip_byte:

	add		x4, x4, #1					//increment counter
	cbz		w5, exit_loop				//if null, exit loop
	b		loop						//otherwise loop again

exit_loop:

	strb	wzr, [x1]					//store null terminator

	ldp		x1, x30, [sp], #16			//pop x1 and x30 from stack
	mov		x1, x9						//restore substring starting address
	mov		x0, x10						//restore original string starting address

	ret		LR
.end
