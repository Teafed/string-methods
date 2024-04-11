/* Subroutine String_indexOf_1: Find the index of a specified charcter or substring
 * in a given string.
 * x0: String to convert to find index
 * x1: A phrase to earch for
 * Returns:
 * x0: Index char was found at
 * All AAPCS required registers are preserved
*/

	.global String_lastIndexOf_3

	.text
String_lastIndexOf_3:
	// Since we don't modify the char to search for,
  	// and we aren't modifying th string all we
	// to push is the return address.

	str		LR,[SP,#-16]!		// Push return address
	stp		x0,x1,[SP,#-16]!  // Push params
	bl			String_length		// Call String length for search phrase

	mov		x2,x0					// Move length to an unsued regi
	sub		x2,x2,#1				// Change lgt to last i
	ldp		x1,x0,[SP],#16		// Pop params

	add		x2,x2,x1				// Change last i to ptr ->end i
	ldr		LR,[SP],#16			// Pop return address


	// Find last char of search phrase
	stp		LR,x2,[SP,#-16]!	// Push return address and end address
	stp		x1,x0,[SP,#-16]!	// Push params

	bl			String_length		// Find length
	mov		x3,x0					// Move length into x3

	sub		x3,x3,#1				// Chang lgth to end index
	ldp		x0,x1,[SP],#16		// Pop params

	add		x3,x3,x1				// Change last index to ptr to last index
	ldp		LR,x2,[SP],#16		// Pop return address
	ldrb		w4,[x3],#-1			// Load last char to finr str and -- ptr

loop:
	cmp		x2,x0					// Check is x2 and x0 are <
	blt		exit2					// If less than, char wasn't found

	ldrb		w5,[x2],#-1			// Load current char and decrement string ptr
	cmp		w4,w5					// Check if w4 == w5 (Char == last char of search string)
	beq		found_char			// If matched, branch to found!
	b			loop					// If not start loop again

// If match is found
found_char:
	stp		x2,x3,[SP,#-16]!	// Push search indecis of the 2 strings


loop2:
	cmp		x3,x1					// If current find index < start index
	blt		found_str			// Entire string is found

	cmp		x2,x0					// Compare x2 and x0
	blt		exit1					// Branch if less than to exit1


	// Continue through loop
	ldrb		w5,[x2],#-1	   	// Load current search char and -- ptr
	ldrb		w6,[x3],#-1			// Load current find char and -- ptr
	cmp		w5,w6					// Check w5 and w6
	beq		loop2					// Continue through the loop
	// If not matched
	ldp		x2,x3,[SP],#16
	b			loop


found_str:
	// Save Stack
	add		SP,SP,#16			// Pop search index of two strings
	add		x2,x2,#1				// add1 to acount for -- ptr

	sub		x0,x2,x0				// i = string[0] - string[char address]
	RET								// Return main


// String not found
exit1:
	// Preserve SP
	add		SP,SP,#16			// Pop search index of 2 strings

	// Char wasn't found so return -1 for unsuccesful search
exit2:
	mov		x0,#-1				// Move -1 into x0
	RET								// Return to main

