/* Subroutine String_indexOf_2: Find the index of a specified charcter or substring
 * in a given string. This function allows for a single index to be searched for
 * x0: String to convert to find index
 * x1: Char to search through string
 * x2: Index to search at
 * Returns:
 * x0: Index char was found at
 * All AAPCS required registers are preserved
*/

	.global String_indexOf_2

	.text
String_indexOf_2:
	// Since we don't modify the char to search for,
  	// and we aren't modifying th string all we
	// to push is the return address.
	str		x0,[SP,#-16]!		// Push return address
	add		x0,x0,x2				// Store into x0 = x0 + x2
	add		x0,x0,#1				// Add 1 to x0 for null termination

loop:
	ldrb		w4,[x0],#1
	cmp		w4,#0					// Check is w4 has null for char
	beq		error					// If not null, branch to not found
	cmp		w4,w1					// Check if w4 and w1 are ==
	beq		found					// If equal branch to found
	b			loop					// If != to search char continue loop
										// Uncondtional branch back to loop

	// If char ia found
found:
	ldr		x1,[SP],#16			// Pop string address
	sub		x0,x0,x1				// Subtract x0 and x1
	sub		x0,x0,#1				// Subtract x0 by 1
	RET								// Return to main
	// If 	char isn't found in string
	//	Set return address to -1 and print
error:
	add		SP,SP,#16			// Add 16 to stack pointer
	mov		x0,#-1				// Set return value to -1
	RET								// Return to main

