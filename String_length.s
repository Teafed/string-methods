/***********************************
 * Name:   Noëlle Abat
 * Class:  CS3B - Professor Barnett
 * Lab:    RASM-3
 * Date:   3/26/24
 **********************************/

//this is a copy of lab10

	.global String_length

	.text

String_length:
	//aapcs registers aren't used, so no need to push them?

	//preserve x1 and x2 registers
	str		x1, [sp, #-16]!			//push x1 onto stack
	str		x2, [sp, #-16]!			//push x2 onto stack
	mov		x2, x0					//copy string pointer to x2
	mov		x0, #0					//start at 0 for length

loop:

	ldrb	w1, [x2], #1			//load byte from pointer

	cbz		w1, exit_loop			//if byte in w1 is null, exit loop
	add		x0, x0, #1				//(increment counter)
	b		loop					//otherwise loop again

exit_loop:

	ldr		x1, [sp], #16			//pop
	ldr		x2, [sp], #16			//pop

	ret 	LR						//return to caller

	.end
.end
