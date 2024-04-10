/* Subroutine String_toLowerCase: Converts the characters of a
 * string into  lower case characters.
 * x0: String to convert to lower case
 * Returns:
 * x0: Address of new lower case string
 * All AAPCS required registers are preserved
*/

	.global String_toLowerCase

	.text
String_toLowerCase:
	STP		LR,x0,[SP,#-16]!	// Push return address
										// (x0 -String to lower case)

	// Use string length to find length to use as lcv

	bl			String_length		// Branch and link to length

	add		x0,x0,#1				// Add numeric value of 1 to length
										// (Allocates for null termination)

	bl			malloc				// Ask for memory for newly created
										// string
										// Since we have mallo we need to preserve the
										// link regi
	ldp		LR,x1,[SP],#16		// Pop regis x1 and link
	stp		LR,x0,[SP,#-16]!	// Push regis LR and x0(String address)

loop:
	ldrb		w4,[x1],#1			// Load a single byte(current char and i++)
	cmp		w4,#'Z'				// Check if there is Z in w4
	bgt		lower					// If w4 is greater than Z branch to lower
	cmp		w4,'A'				// Check if there is 'A' in w4
	blt		lower					// branch to lower  if lower than 'A'
	// Else if letter is not within the A-Z range
	// it means it's already lowercase
	add		w4,w4,#('a'-'A')	// Replace upper with lower case
lower:
	strb		w4,[x0],#1			// Store byte(char) to output string
	cmp		w4,#0					// Compare/check w5 for 0
	bne		loop					// Unconditional branch to loop back to loop

exit:
	ldp		LR,x0,[SP],#16		// pop link regi and x0 to stack( return string address)
	RET								// Return to driver.s
