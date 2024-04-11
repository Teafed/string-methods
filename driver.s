	.global 	_start

				.equ MAX, 20
				.equ BUFFER, 21

	.data
dbCounter:		.quad 0
dbTemp:			.quad 0
szTemp:			.skip BUFFER
szCounter:		.skip BUFFER
szIndex:		.skip 16
szCountPrint:	.asciz ".\n"
szTrue:			.asciz "TRUE\n"
szFalse:		.asciz "FALSE\n"
szStarts1:		.asciz "hat."
szStarts2:		.asciz "Cat"
szEnds:			.asciz "in the hat."
szEgg:			.asciz "egg"
szEggs:			.asciz "eggs"
szSpace:		.asciz " "
chFind:			.byte 0x61 //'a'
chReplace:		.byte 0x6f //'o'
chG:			.byte 0x67 //'g'
chLF:			.byte 0x0a //line feed

//test strings
s1:				.asciz "Cat in the hat."
s2:				.asciz "Green eggs and ham."
s3:				.asciz "cat in the hat."
s4:				.skip BUFFER

//test outputs
szString1a:		.asciz "   s1.length() = "
szString1b:		.asciz "   s2.length() = "
szString1c:		.asciz "   s3.length() = "
szString2:		.asciz "   String_equals(s1,s3) = "
szString3:		.asciz "   String_equals(s1,s1) = "
szString4:		.asciz "   String_equalsIgnoreCase(s1,s3) = "
szString5:		.asciz "   String_equalsIgnoreCase(s1,s2) = "
szString6a:		.asciz "   s4 = String_copy(s1)"
szString6b:		.asciz "   s1 = "
szString6c:		.asciz "   s4 = "
szString7:		.asciz "   String_substring_1(s3,4,14) = "
szString8:		.asciz "   String_substring_2(s3,7) = "
szString9:		.asciz "   String_charAt(s2,4) = "
szString10:		.asciz "   String_startsWith_1(s1,11,\"hat.\") = "
szString11:		.asciz "   String_startsWith_2(s1,\"Cat\") = "
szString12:		.asciz "   String_endsWith(s1,\"in the hat.\") = "
szString13:		.asciz "   String_indexOf_1(s2,'g') = "
szString14:		.asciz "   String_indexOf_2(s2,'g',9) = "
szString15:		.asciz "   String_indexOf_3(s2,\"eggs\") = "
szString16:		.asciz "   String_lastIndexOf_1(s2,'g') = "
szString17:		.asciz "   String_lastIndexOf_2(s2,'g',6) = "
szString18:		.asciz "   String_lastIndexOf_3(s2,\"egg\") = "
szString19:		.asciz "   String_replace(s1,'a','o') = "
szString20:		.asciz "   String_toLowerCase(s1) = "
szString21:		.asciz "   String_toUpperCase(s1) = "
szString22a:	.asciz "   String_concat(s1, \" \")\n"
szString22b:	.asciz "   String_concat(s1, s2) = "

	.text

_start:

// 1. String_length //

	bl		output_counter			//branch to output_counter

//s1

	//load s1 and get its length
	ldr		x0, =szString1a			//load szString1a address into x0
	bl		putstring				//print
	ldr		x0, =s1					//load s1 into x0
	bl		String_length			//get length of string
	ldr		x1, =dbTemp				//load address of dbTemp into x1
	str		x0, [x1]				//store x0 into dbLength

	//put dbLength into szLength
	ldr		x1, =szTemp				//load address of szTemp into x1
	bl		int64asc				//convert to ascii for printing

	//output length
	ldr		x0, =szTemp				//load szTemp into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print

//s2

	//load s2 and get its length
	ldr		x0, =szString1b			//load szString1b address into x0
	bl		putstring				//print
	ldr		x0, =s2					//load s2 into x0
	bl		String_length			//get length of string
	ldr		x1, =dbTemp				//load address of dbTemp into x1
	str		x0, [x1]				//store x0 into dbLength

	//put dbLength into szLength
	ldr		x1, =szTemp				//load address of szTemp into x1
	bl		int64asc				//convert to ascii for printing

	//output length
	ldr		x0, =szTemp				//load szTemp into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line


//s3

	//load s1 and get its length
	ldr		x0, =szString1c			//load szString1c address into x0
	bl		putstring				//print
	ldr		x0, =s3					//load s3 into x0
	bl		String_length			//get length of string
	ldr		x1, =dbTemp				//load address of dbTemp into x1
	str		x0, [x1]				//store x0 into dbLength

	//put dbLength into szLength
	ldr		x1, =szTemp				//load address of szTemp into x1
	bl		int64asc				//convert to ascii for printing

	//output length
	ldr		x0, =szTemp				//load szTemp into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print


// 2. String_equals(s1,s3) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString2			//load szString2 address into x0
	bl		putstring				//print
	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =s2					//load s2 address into x1
	bl		String_equals			//get length of string
	bl		true_false				//output true or false


// 3. String_equals(s1,s1) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString3			//load szString3 address into x0
	bl		putstring				//print
	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =s1					//load s1 address into x1
	bl		String_equals			//get length of string
	bl		true_false				//output true or false

// 4. String_equalsIgnoreCase(s1,s3) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString4			//load szString4 address into x0
	bl		putstring				//print
	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =s3					//load s3 address into x1
	bl		String_equalsIgnoreCase	//get length of string
	bl		true_false				//output true or false


// 5. String_equalsIgnoreCase(s1,s2) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString5			//load szString5 address into x0
	bl		putstring				//print
	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =s2					//load s2 address into x1
	bl		String_equalsIgnoreCase	//get length of string
	bl		true_false				//output true or false

// 6. String_copy(s1) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString6a			//load szString6a address into x0
	bl		putstring				//print
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line
	ldr		x0, =szString6b			//load szString6b address into x0
	bl		putstring				//print
	ldr		x0, =s1
	bl		putstring				//print original string

	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =s4					//load s4 address into x1
	bl		String_copy				//branch to String_copy

	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line
	ldr		x0, =szString6c			//load szString6c address into x0
	bl		putstring				//print
	ldr		x0, =s4					//load s4 into x0
	bl		putstring				//print original string
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line

// 7. String_substring_1(s3,4,14) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString7			//load szString7 address into x0
	bl		putstring				//print

	ldr		x0, =s3					//load s3 address into x0
	mov		x2, #4					//load value 4 into x1
	mov		x3, #14					//load value 14 into x2
	bl		String_substring_1		//branch to String_substring_1
	mov		x0, x1					//move x1 into x0
	bl		putstring				//print
	mov		x0, x1					//move x1 to x0
	bl		free					//free memory
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line

// 8. String_substring_2(s3,7) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString8			//load szString8 address into x0
	bl		putstring				//print

	ldr		x0, =s3					//load s3 address into x0
	mov		x2, #7					//load value 4 into x1
	bl		String_substring_2		//branch to String_substring_1
	mov		x0, x1					//move x1 into x0
	bl		putstring				//print
	mov		x0, x1
	bl		free					//free memory
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line


// 9. String_charAt(s2,4) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString9			//load szString9 address into x0
	bl		putstring				//print

	ldr		x0, =s2					//load s2 address into x0
	mov		x1, #4					//load value 4 into x1
	bl		String_charAt			//branch to String_charAt
	bl		putch					//print character
	ldr		x0, =chLF				//load chLF into x0
	bl		putch					//print new line


// 10. String_startsWith_1(s1,11,"hat.") //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString10			//load szString10 address into x0
	bl		putstring				//print

	ldr		x0, =s1					//load s1 address into x0
	mov		x1, #11					//put 11 in x1
	ldr		x2, =szStarts1			//load szStarts1 address into x2
	bl		String_startsWith_1		//branch to String_startsWith_1
	bl		true_false				//branch to true_false


// 11. String_startsWith_2(s1,"Cat") //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString11			//load szString11 address into x0
	bl		putstring				//print

	ldr		x0, =s1					//load s1 address into x0
	ldr		x1, =szStarts2			//load szStarts2 address into x1
	bl		String_startsWith_2		//branch to String_startsWith_2
	bl		true_false				//branch to true_false


// 12. String_endsWith(s1,"in the hat.") //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString12			//load szString12 address into x0
	bl		putstring				//print

	ldr		x0, =s1					//load s1 into x0
	ldr		x1, =szEnds				//load szEnds address into x1
	bl		String_endsWith			//branch to String_endsWith
	bl		true_false				//branch to true_false


// 13. String_indexOf_1(s2,'g') //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString13			//load szString13 address into x0
	bl		putstring				//print

	ldr		x0,=s2					// Load x0 with address of sz2
//	mov		x1,#'g'					// Move char value into x1
	ldr		x1, =chG
	ldrb	w1, [x1]
	bl		String_indexOf_1		// Branch and link to find index
	bl		print_index

// 14. String_indexOf_2(s2,'g',9) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString14			//load szString14 address into x0
	bl		putstring				//print

	ldr		x0,=s2
//	mov		x1,#'g'
	ldr		x1, =chG
	ldrb	w1, [x1]
	mov		x2,#9
	bl		String_indexOf_2
	bl		print_index

// 15. String_indexOf_3(s2,"eggs") //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString15			//load szString15 address into x0
	bl		putstring				//print

	ldr		x0,=s2
	ldr		x1,=szEgg
	bl		String_indexOf_3
	bl		print_index

// 16. String_lastIndexOf_1(s2,'g') //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString16			//load szString16 address into x0
	bl		putstring				//print

	ldr		x0, =s2					//load address of s2 into x0
	ldr		x1, =chG				//load chG address into x1
	ldrb	w1, [x1]				//load char
	bl		String_lastIndexOf_1	//branch to lastIndexOf_1
	bl		print_index				//print index

// 17. String_lastIndexOf_2(s2,'g',6) //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString17			//load szString17 address into x0
	bl		putstring				//print

	ldr		x0, =s2					//load address of s2 into x0
	ldr		x1, =chG				//load chG address into x1
	ldrb	w1, [x1]				//load char
	mov		x2, #6					//move value 6 into x2
	bl		String_lastIndexOf_2	//branch to lastIndexOf_2
	bl		print_index				//print index


// 18. String_lastIndexOf_3(s2,"eggs") //

	bl		output_counter			//branch to output_counter

	ldr		x0, =szString18			//load szString18 address into x0
	bl		putstring				//print

	ldr		x0, =s2					//load address of s2 into x0
	ldr		x1, =szEgg				//load szEgg address into x1
	bl		String_lastIndexOf_3	//branch to lastIndexOf_3
	bl		print_index				//print index

// 19. String_replace(s1,'a','o') //
	bl		output_counter		//branch to output_counter

	ldr		x0, =szString19		//load szString19 address into x0
	bl		putstring			//print

	ldr		x0,=s1				// Load string into x0
//	mov		x1,#'a'				// Load x1 numeric a char
//	mov		x2,#'o'				// Load x2 with numeric char
	ldr		x1, =chFind
	ldrb	w1, [x1]
	ldr		x2, =chReplace
	ldrb	w2, [x2]

	// Now we call replace string function
	bl		String_replace		// Branch and link to function
//	str		x0,[SP,#-16]!		// Str function address
	bl		putstring			// Output address
//	ldr		x0,[SP],#16			// Increment stack by 16
//	bl		free				// Free malloc with free
	ldr		x0, =chLF				//load address of chLF into x0
	bl		putch					//print new line



// 20. String_toLowerCase(s1) //

	bl		output_counter		//branch to output_counter

	ldr		x0, =szString20		//load szString20 address into x0
	bl		putstring			//print

	ldr		x0,=s1				// Load x0 with address of string1
	bl		String_toLowerCase
	bl		putstring			// Call function putstring

//	str		x0,[SP,#-16]!		// Store string address of x0
//	bl		putstring			// Call function putstring

//	ldr		x0,[SP],#16			// Push address
//	bl		free				// Freee memory

	ldr		x0, =chLF				//load address of chLF into x0
	bl		putch					//print new line


// 21. String_toUpperCase(s1) //

	bl		output_counter		//branch to output_counter

	ldr		x0, =szString21		//load szString21 address into x0
	bl		putstring			//print

	ldr		x0,=s1				// Load x0 with address of string1
	bl		String_toUpperCase
	bl		putstring
//	str		x0,[SP,#-16]!		// Store string address of x0
//	bl		putstring			// Call function putstring

//	ldr		x0,[SP],#16			// Push address
//	bl		free				// free emem

	ldr		x0, =chLF				//load address of chLF into x0
	bl		putch					//print new line

// 22. String_concat(s1," ") //

	bl		output_counter		//branch to output_counter

	ldr		x0, =szString22a	//load szString22a address into x0
	bl		putstring			//print

	ldr		x0, =s1
	ldr		x1, =szSpace
	ldr		x2, =szTemp
	bl		String_concat

	//String_concat(s1, s2)

	ldr		x0, =szString22b		//load szString22b address into x0
	bl		putstring				//print

	ldr		x0, =szTemp
	ldr		x1, =s2
	ldr		x2, =szCounter
	bl		String_concat
	mov		x0, x2
	bl		putstring

	b		exit_sequence


output_counter:

	str		x30, [sp, #-16]!		//push x30 to stack
	ldr		x0, =chLF				//load address of chLF into x0
	bl		putch					//print new line

	ldr		x1, =dbCounter			//load address of dbCounter into x0
	ldr		x0, [x1]				//load value of dbCounter into x0
	add		x0, x0, #1				//increase counter by 1
	str		x0, [x1]				//store new value into dbCounter
	ldr		x1, =szCounter			//load szCounter into x1
	bl		int64asc				//convert int64 to ascii

	ldr		x0, =szCounter			//load szCounter into x0
	bl		putstring				//print
	ldr		x0, =szCountPrint		//load szCounterPrint into x0
	bl		putstring				//print
	ldr		x30, [sp], #16			//pop x30 from stack

	ret		LR						//return from whence we came


true_false:

	str		x30, [sp, #-16]!		//push x30 to stack
	cmp		x0, #0					//compare x0 to 0
	beq		false					//branch to false if false

	ldr		x0, =szTrue				//load address of szTrue into x0
	bl		putstring				//print

	ldr		x30, [sp], #16			//pop x30 from stack
	ret		LR						//return

false:

	ldr		x0, =szFalse			//load address of szTrue into x0
	bl		putstring				//print

	ldr		x30, [sp], #16			//pop x30 from stack
	ret		LR						//return

print_index:

	str		LR, [sp, #-16]!			//push x30 onto stack
	ldr		x1, =szIndex			//load x1 with address of szIndex
	bl		int64asc				//convert to ascii
	ldr		x0, =szIndex			//load address of szIndex
	bl		putstring				//print string
	ldr		x0, =chLF				//load x0 with address chLF
	bl		putch					//print a new line
	ldr		LR, [sp], #16			//pop x30 from stack
	ret		LR						//return

exit_sequence:

	ldr		x0, =chLF				//load address of chLF into x0
	bl		putch					//print new line

	//exit sequence
	mov		x0, #0					//return code is 0
	mov		x8, #93 			    //93 terminates program
	svc		0       			    //call linus to terminate the program

	.end

