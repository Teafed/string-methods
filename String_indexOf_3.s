/* Subroutine String_indexOf_3: Find the index of a specified charcter or substring
 * in a given string. Checks an entire section (otherwise known as the search key
 * becomes a phrase instead of it being a single char)
 * x0: String to convert to find index
 * x1: Phrase to search for
 * Returns:
 * x0: Index phrase was found at
 * All AAPCS required registers are preserved
*/

	.global String_indexOf_3

	.text
String_indexOf_3:
	// Since we don't modify the char to search for,
  	// and we aren't modifying th string all we
	// to push is the return address.
	str	x0,[SP,#-16]!		// Push string address (x0)
	ldrb	w4,[x1],#1			// Load a single byte(char) i++

loop:
	ldrb	w2,[x0],#1			// Load a single bye(char) and icrement ptr
	cmp	w2,#0					// Compare w2 to numeric value of 0
	beq	not_found2			// Search key wasn't found branch to not found2
	cmp	w2,w4					// Compare w2 and w4
	beq	found					// If equal branch to found
	b		loop					// Continue to loop trhough original string

	// Found one char
found:
	stp	x0,x1,[SP,#-16]!  // Push index and find string address

loop2:
	ldrb	w2,[x0],#1			// Load a char from pointer into w2
	ldrb	w6,[x1],#1			// Load a char from pointer into w6
	cmp	w6,#0					// Compare w6 to numeric value of 0(Null)
	beq	found_String		// If equal, branch to found string

	cmp	w2,#0
	beq	not_found

	cmp	w2,w6
	beq	loop2


	// If chars !=
	ldp	x0,x1,[SP],#16
	b		loop

found_String:
	ldp	x0,x1,[SP],#16
	ldr	x1,[SP],#16
	sub	x0,x0,x1
	sub	x0,x0,#1
	RET



not_found:
	add	SP,SP,#16			// Preserve stack pointer


not_found2:
	add	SP,SP,#16			// Pop string address (preserve stack pointer)
	mov	x0,#-1				// Initialize -1 into x0 to print
	RET							// Return back to main

