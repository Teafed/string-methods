/*
 * Subroutine String_charAt: Provided a pointer to a null-terminated string
 *	and an integer index, String_charAt will the character at the index of the
 *	provided string
 * x0: Must point a null-terminated string
 * x1: Must contain an integer index
 * LR: Must contain the return address
 *
 * Returned register contents:
 *	x0: char result
 * All registers are preserved except x0
 */
	.global String_charAt

	.text

String_charAt:

	str		x30, [sp, #-16]!		//push x30 onto stack

	//preserve x1, x2, x3, x4 registers
	stp		x1, x2, [sp, #-16]!		//push x1 and x2 onto stack
	stp		x3, x4, [sp, #-16]!		//push x3 and x4 onto stack
	mov		x3, x0					//put x0 in x3
	mov		x4, x1					//put x1 in x4

	add		x0, x0, x4, lsl #0		//add index to base address of string

	ldp		x3, x4, [sp], #16		//pop x3 and x4
	ldp		x1, x2, [sp], #16		//pop x1 and x2
	ldr		x30, [sp], #16			//push x30 onto stack

	ret 	LR						//return to caller

.end

