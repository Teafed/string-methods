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
    str     x30, [sp, #-16]!        //push x30 onto stack
    mov     x1, x0                  //copy pointer to x1

loop:

    ldrb    w2, [x1], #1            //load byte from pointer into w2 and increment pointer
    cmp     w2, #0                  //check for null terminator
    beq     exit_loop               //if null terminator, exit loop
    cmp     w2, #'A'                //check if not uppercase
    blt     loop                    //if not, continue
    cmp     w2, #'Z'                //check if not uppercase
    bgt     loop                    //if not, continue
    add     w2, w2, #'a' - 'A'      //convert uppercase to lowercase
    strb    w2, [x1, #-1]           //store the uppercase character and decrement pointer
    b       loop                    //branch to loop

exit_loop:
    ldr     x30, [sp], #16          //pop x30 from stack
    ret     LR                      //return

.end

/*
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

*/
