	.data
dbLength:		.quad 0
szLength:		.skip 21
szString:		.asciz "This is a string."
szStringEqual:	.asciz "This is a string."
szLOut:			.asciz "String Length = "
szWoohoo:		.asciz "woohoo!!!"
szUhOh:			.asciz "uh oh :("

chLF:			.byte 0xa

	.global 	_start

	.text

_start:

//**** String_length ****//

	//load szString and get its length
	ldr		x0, =szString			//load string address into x0
	bl		String_length			//get length of string
	ldr		x1, =dbLength			//load address of dbLength into x1
	str		x0, [x1]				//store x0 into dbLength

	//put dbLength into szLength
	ldr		x1, =szLength			//load address of szLength into x2
	bl		int64asc				//convert to ascii for printing

	//output length
	ldr		x0, =szLOut				//load szLOut into x0
	bl		putstring				//print
	ldr		x0, =szLength			//load szLength into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putstring				//print

//**** String_equals ****//

	//load szString and get its length
	ldr		x0, =szString			//load string address into x0
	ldr		x1, =szWoohoo			//load string address into x1
	bl		String_equals			//get length of string
	cbz		x0, equals_fail			//if 0, test failed
	b		exit_sequence			//if not, success

equals_fail:
	ldr		x0, =szUhOh				//load szUhOh into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putstring				//print

exit_sequence:

	//exit sequence
	mov		x0, #0					//return code is 0
	mov		x8, #93 			    //93 terminates program
	svc		0       			    //call linus to terminate the program

	.end
