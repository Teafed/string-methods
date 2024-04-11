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

.end
