/* Subroutine String_toUpperCase: Converts the characters of a
 * string into  upper case characters.
 * x0: String to convert to upper case
 * Returns:
 * x0: Address of new upper case string
 * All AAPCS required registers are preserved
*/

	.global String_toUpperCase

	.text

String_toUpperCase:
    str     x30, [sp, #-16]!        //push x30 onto stack
    mov     x1, x0                  //copy pointer to x1

loop:

    ldrb    w2, [x1], #1            //load byte from pointer into w2 and increment pointer
    cmp     w2, #0                  //check for null terminator
    beq     exit_loop               //if null terminator, exit loop
    cmp     w2, #'a'                //check if not lowercase
    blt     loop                    //if not, continue
    cmp     w2, #'z'				//check if not lowercase
    bgt     loop					//if not, continue
    sub     w2, w2, #'a' - 'A'      //convert lowercase to uppercase
    strb    w2, [x1, #-1]           //store the uppercase character and decrement pointer
    b       loop					//branch to loop

exit_loop:
    ldr     x30, [sp], #16          //pop x30 from stack
    ret     LR                      //return

.end
