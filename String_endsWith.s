/*
 * Subroutine String_endsWith: Provided two pointers to null-terminated
 *	strings, String_endsWith will determine if string1 ends with string2
 * x0: Must point to a null-terminated string
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: full null-terminated string
 *	x1: null-terminated string to search for
 * All registers are preserved except x1
 */

	.global String_endsWith

	.text

String_endsWith:

//x0: full string
//x1: end of string
//goal:
//1. get s1.length - s2.length into x1
//2. get substring_2(s1, x1) into x0
//3. s2 goes in x1
//4. check if they're equal, return that value

	stp		x2, x30, [sp, #-16]!	//push x2 and x30 onto stack
	stp		x0, x1, [sp, #-16]!		//push x0 and x1 onto stack
	mov		x0, x1					//put x1 into x0
	bl		String_length			//get length of s2
	mov		x3, x0					//x3 has s2 length
	ldp		x0, x1, [sp], #16		//pop s1 and s2
	str		x1, [sp, #-16]!			//push s2 onto stack
	stp		x0, x3, [sp, #-16]!		//push s1 and s2.length onto stack
	bl		String_length			//get length of s1
	ldp		x1, x2, [sp], #16		//x1 = s1, x2 = s2.length
	ldr		x3, [sp], #16			//x3 = s2
	sub		x2, x0, x2				//sub to get length to ignore
	str		x3, [sp, #-16]!			//push s2 onto stack
	mov		x0, x1					//x0 has s1
	mov		x1, x2					//x1 has length to ignore
	bl		String_substring_2		//turn it into a substring - x0 now
										//contains the concatenated string
	ldr		x3, [sp], #16			//x3 = s2

//this point should be good
//x0 = s1
//x1 = new concat string
//x2 = length ignore
//x3 = s2

	stp		x0, x1, [sp, #-16]!		//push s1 and new concat string onto stack
	stp		x2, x3, [sp, #-16]!		//push length and s2 onto stack
	mov		x0, x3					//move s2 to x0
	bl		String_equals			//compare concat and s2
	mov		x4, x0					//x4 has the answer
	ldp		x2, x3, [sp], #16		//push length and s2 onto stack
	ldp		x0, x1, [sp], #16		//push s1 and new concat string onto stack
	mov		x0, x1					//yeah okay sounds good
	str		x4, [sp, #-16]!			//keep result
	bl		free					//free memory from concat
	ldr		x0, [sp], #16			//pop result to x0

	ldp		x2, x30, [sp], #16		//pop x2 and x30 from stack

	ret		LR						//return

.end
