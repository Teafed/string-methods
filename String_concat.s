	.global String_concat

	.text

String_concat:

	stp		x30, x0, [sp, #-16]!	//push x30 and x0 onto stack
	stp		x1, x2, [sp, #-16]!		//push x30 and x0 onto stack
	str		x2, [sp, #-16]!			//keep pointer to result string in stack
	mov		x2, x0					//keep s1 pointer in x2
	bl		String_length			//x0 = string length
	mov		x3, x0					//put length in x3
	mov		x0, x1					//move second pointer to x0
	mov		x4, x1					//and to x4
	bl		String_length			//x0 = string length
	mov		x5, x0					//move to x5

	add		x0, x5, x3				//add s1 and s2 lengths
	stp		x1, x2, [sp, #-16]!		//push x30 and x0 onto stack
	stp		x3, x4, [sp, #-16]!		//push x30 and x0 onto stack
	bl		calloc					//add that many bytes of memory to heap
	ldp		x3, x4, [sp], #16		//push x30 and x0 onto stack
	ldp		x1, x2, [sp], #16		//push x30 and x0 onto stack
	mov		x6, x0					//heap ptr in x6

	mov		x1, x2					//load address of s1 into x1

copy_x:

	ldrb	w2, [x1], #1			//load first byte into w2, increment
	cbz		w2, load_y				//if null, begin y copy loop
	strb	w2, [x6], #1			//store into x0 (allocated memory)
	b		copy_x					//otherwise continue copying

load_y:

	mov		x1, x4					//load address of s2 into x1

copy_y:

	ldrb	w2, [x1], #1			//load first byte into w2, increment
	cbz		w2, exit_loop			//if null, exit loop
	strb	w2, [x6], #1			//store into x0 (allocated memory)
	b		copy_y					//otherwise continue copying

exit_loop:

	mov		w2, #0					//put null terminator into w2
	strb	w2, [x6], #1			//store null terminator to end of string

	ldr		x2, [sp], #16			//bring back pointer to holder string
	stp		x0, x30, [sp, #-16]!	//x30 onto stack

copy_string:

	ldrb	w3, [x0], #1
	strb	w3, [x2], #1
	cbz		w3, exit
	b		copy_string

exit:

	ldp		x0, x30, [sp], #16

	str		x30, [sp, #-16]!
	bl		free
	ldr		x30, [sp], #16

	ldp		x1, x2, [sp], #16		//pup x1 and x2 from stack
	ldp		x30, x3, [sp], #16		//pop x30 and x0 from stack
	ret		LR
