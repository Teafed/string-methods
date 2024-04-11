/* Subroutine String_lastIndexOf_1: USed to find out the
 * index of last occirrence of a character or a
 * substring in a given string
 * x0: String to search through
 * x1: Char to search through string
 * Returns:
 * x0: Index char was found at
 * All AAPCS required registers are preserved
*/

	.global String_lastIndexOf_1

	.text
String_lastIndexOf_1:
	// Since we don't modify the char to search for,
  	// and we aren't modifying the string all we
	// to push is the return address.
	str		LR,[SP,#-16]!			// Push return address
	stp		x0,x1,[SP,#-16]!		// Push x0 and x1
	bl			String_length			// Find string length of x0

	mov		x2,x0						// Mov x0 into x2
	ldp		x0,x1,[SP],#16			// Pop x0 and x1


	// Call lastIndex 2 to find index
	bl			String_lastIndexOf_2	// Call 2 to search though string from
											// the end
	ldr		LR,[SP],#16				// Pop return address from stack
	RET									// Return to main

