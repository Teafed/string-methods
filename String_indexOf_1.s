/* Subroutine String_indexOf_1: Find the index of a specified charcter or substring
 * in a given string.
 * x0: String to convert to find index
 * x1: Char to search through string
 * Returns:
 * x0: Index char was found at
 * All AAPCS required registers are preserved
*/

	.global String_indexOf_1

	.text
String_indexOf_1:
	// Since we don't modify the char to search for,
  	// and we aren't modifying th string all we
	// to push is the return address.
	str		LR,[SP,#-16]!		// Push return address
	mov		x2,#-1				// Initialize x2 to -1
	bl			String_indexOf_2	// Call 2 to search though string
	ldr		LR,[SP],#16			// Pop return address
	RET								// Return to main

