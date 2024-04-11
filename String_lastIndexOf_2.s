/* Subroutine String_indexOf_1: Find the index of a specified charcter or substring
 * in a given string.
 * x0: String to convert to find index
 * x1: Char to search through string
*	x2: Index to search at
 * Returns:
 * x0: Index char was found at
 * All AAPCS required registers are preserved
*/

	.global String_lastIndexOf_2

	.text
String_lastIndexOf_2:
	// Since we don't modify the char to search for,
  	// and we aren't modifying the string at all
	add		x2,x2,x0		// Add regis x2, and x0 and store into x2
	sub		x2,x2,#1		// Sub 1 to skip char given at index


loop:
	cmp		x2,x0			// Check to see if x2 and 0 are <
	blt		exit			// IF x2 is less than x0 we reached
								// the end of string(which is really
								// the bginning if you think about it)

	ldrb		w4,[x2],#-1	// Load a single char byte
	cmp		w4,w1			// IF char = searchChar
	beq		found			// Branch if the match
	b			loop			// Continue through loop

	// Chars match
found:
	add		x2,x2,#1		// Add 1 back to undo i--
	sub		x0,x2,x0		// index=string[0] - string[char address]

	RET						// Return to main

exit:
	mov		x0,#-1		// Set x0 to -1 and return back to main
	RET								// Return to main

