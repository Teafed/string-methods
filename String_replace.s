/* Subroutine String_replace: Replaces all occurences of an oldChar character
 * with newChar character.
 * x0: String
 * x1: Char to replace
 * x2: Char replaced(Deleted)
 * Returns:
 * x0: Address of new character replaced string
 * All AAPCS required registers are preserved
*/

	.global String_replace

	.text
String_replace:
	STP		LR,x0,[SP,#-16]!		// Push return address and modify string
	STP		x1,x2,[SP,#-16]!  // Push x1 and x2 (x1 - Old char)
										// 					(x2 - New Char)
loop:

	ldrb	w4, [x0]
	cbz		w4, exit
	cmp		w4, w1
	bne		continue
	strb	w2, [x0]

continue:

	add		x0, x0, #1
	b		loop
/*

	// Use string length to find length to use as lcv

	bl			String_length		// Branch and link to length

	add		x0,x0,#1				// Add numeric value of 1 to length
										// (Allocates for null termination)

	bl			malloc				// Ask for memory for newly created
										// string
	ldp		x2,x3,[SP],#16		// Pop regis x2 and x3 (Old and new chars)
	ldp		LR,x1,[SP],#16    //	Pop regis LR and x1(Return address and old char)
	stp		LR,x0,[SP,#-16]!	// Push regis LR and x0(String address)

loop:
	ldrb		w4,[x1],#1			// Load a single byte(current char and i++)
	cmp		w4,#0					// if char == \n
	beq		exit					// if \n branch to exit sequence
	cmp		w4,w2					// if char == replaceKey
	beq		replace				// branch to replace
	// If not char != continue through loop,
	strb		w4,[x0],#1			// Store a single byte(char)to new string i++
	b			loop					// Unconditional branch back to loop


replace:
	// Replace chars
	strb		w3,[x0],#1			// Store a single byte(char) to string and increment
										// pointer by 1
	b			loop					// Unconditional branch to loop

*/

exit:
	LDP		x1,x2,[SP],16		  // Push x1 and x2 (x1 - Old char)
	LDP		LR,x0,[SP],#16			// pop link regi and x0 to stack(Return address and return string address)
	RET								// Return to driver


