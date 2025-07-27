/**************************************************************************
 * C S 429 Assembly Coding Lab
 *
 * functions.s - Template for all functions to be implemented.
 *
 * Copyright (c) 2022, 2023, 2024.
 * Authors: Kavya Rathod, Prithvi Jamadagni, Anoop Rachakonda
 * All rights reserved.
 * May not be used, modified, or copied without permission.
 **************************************************************************/

 
 //  Vihaan Mehta - vjm655
 
    
    .arch armv8-a
	.file	"functions.c"
	.text


    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global hamming_distance
    .type   hamming_distance, %function
hamming_distance:
    // (STUDENT TODO) Code for hamming_distance goes here.
    // Input parameter x is passed in X0; input parameter y is passed in X1.
    // Output value is returned in X0.

    eor x0, x0, x1
    
    // STAGE 1
    // Store original value of x

    mvn x2, x0
    mvn x2, x2

   movz x4, 0x5555, LSL #0
   movk x4, 0x5555, LSL #16
   movk x4, 0x5555, LSL #32
   movk x4, 0x5555, LSL #48
    
    // AND operation with mask
    ands x0, x0, x4

    // Original value of x is restored
    mvn x2, x2
    mvn x3, x2

    // Process x3
    mvn x3, x3, LSR 1
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3 




    // STAGE 2
    // Store original value of x
    mvn x2, x0
    mvn x2, x2

    movz x4, 0x3333, LSL #0
    movk x4, 0x3333, LSL #16
    movk x4, 0x3333, LSL #32
    movk x4, 0x3333, LSL #48

    // AND operation with mask
    ands x0, x0, x4

    // Original value of x is restored
    mvn x3, x2
    mvn x3, x3

    // Process x3
    mvn x3, x3, LSR 2
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3




    // STAGE 3
    // Store original value of x
    mvn x2, x0
    mvn x2, x2

    // AND operation with mask

    movz x4, 0x0F0F, LSL #0
    movk x4, 0x0F0F, LSL #16
    movk x4, 0x0F0F, LSL #32
    movk x4, 0x0F0F, LSL #48
    ands x0, x0, x4

    // Original value of x is restored
    mvn x3, x2
    mvn x3, x3

    // Process x3
    mvn x3, x3, LSR 4
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3



    // STAGE 4
    // Store original value of x
    mvn x2, x0
    mvn x2, x2

    // AND operation with mask
    movz x4, 0x00FF, LSL #0
    movk x4, 0x00FF, LSL #16
    movk x4, 0x00FF, LSL #32
    movk x4, 0x00FF, LSL #48

    ands x0, x0, x4

    // Original value of x is restored
    mvn x3, x2
    mvn x3, x3

    // Process x3
    mvn x3, x3, LSR 8
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3




    // STAGE 5
    // Store original value of x
    mvn x2, x0
    mvn x2, x2

    // AND operation with mask

    movz x4, 0xFFFF, LSL #0
    movk x4, 0x0000, LSL #16
    movk x4, 0xFFFF, LSL #32
    movk x4, 0x0000, LSL #48
    ands x0, x0, x4

    // Original value of x is restored
    mvn x3, x2
    mvn x3, x3

    // Process x3
    mvn x3, x3, LSR 16
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3




    // STAGE 6
    // Store original value of x
    mvn x2, x0
    mvn x2, x2

    // AND operation with mask

    movz x4, 0xFFFF, LSL #0
    movk x4, 0xFFFF, LSL #16
    movk x4, 0x0000, LSL #32
    movk x4, 0x0000, LSL #48
    ands x0, x0, x4

    // Original value of x is restored
    mvn x3, x2
    mvn x3, x3

    // Process x3
    mvn x3, x3, LSR 32
    mvn x3, x3
    ands x3, x3, x4

    // Finally, add x3 and x0
    adds x0, x0, x3

    


    ret
    .size   hamming_distance, .-hamming_distance
    // ... and ends with the .size above this line.


	// Every function starts from the .align below this line ...
	.align	2
	.global	transpose
	.type	transpose, %function
transpose:
    // (STUDENT TODO) Code for transpose goes here.
    // Input parameter x is passed in X0.
    // Output value is returned in X0.


// Shifting top right diagonal, mask a = (x & 0x000AA0AA00AA00AA)
    movz x1, 0x00AA, LSL #0
    movk x1, 0x00AA, LSL #16
    movk x1, 0x00AA, LSL #32
    movk x1, 0x00AA, LSL #48
    ands x1, x0, x1

    // b = (x & 0x5500550055005500)
    movz x2, 0x5500, LSL #0
    movk x2, 0x5500, LSL #16
    movk x2, 0x5500, LSL #32
    movk x2, 0x5500, LSL #48
    ands x2, x0, x2

    // Move top left and bottom right bits, c = (x & 0xAA55AA55AA55AA55) | (a << 7) | (b >> 7)
    movz x3, 0xAA55, LSL #0
    movk x3, 0xAA55, LSL #16
    movk x3, 0xAA55, LSL #32
    movk x3, 0xAA55, LSL #48
    ands x3, x0, x3
    lsl x1, x1, #7
    orr x3, x3, x1
    lsr x2, x2, #7
    orr x3, x3, x2

    // d = (c & 0x0000CCCC0000CCCC)
    movz x1, 0xCCCC, LSL #0
    movk x1, 0x0000, LSL #16
    movk x1, 0xCCCC, LSL #32
    movk x1, 0x0000, LSL #48
    ands x1, x3, x1

    // e = (c & 0x3333000033330000)
    movz x2, 0x0000, LSL #0
    movk x2, 0x3333, LSL #16
    movk x2, 0x0000, LSL #32
    movk x2, 0x3333, LSL #48
    ands x2, x3, x2

    // Calculating values above, below diagonals
    // f = (c & 0xCCCC3333CCCC3333) | (d << 14) | (e >> 14)
    movz x0, 0x3333, LSL #0
    movk x0, 0xCCCC, LSL #16
    movk x0, 0x3333, LSL #32
    movk x0, 0xCCCC, LSL #48
    ands x0, x3, x0
    lsl x1, x1, #14
    orr x0, x0, x1
    lsr x2, x2, #14
    orr x0, x0, x2

    // g = (f & 0x00000000F0F0F0F0)
    movz x1, 0xF0F0, LSL #0
    movk x1, 0xF0F0, LSL #16
    movk x1, 0x0000, LSL #32
    movk x1, 0x0000, LSL #48
    ands x1, x0, x1

    // h = (f & 0x0F0F0F0F00000000)
    movz x2, 0x0000, LSL #0
    movk x2, 0x0000, LSL #16
    movk x2, 0x0F0F, LSL #32
    movk x2, 0x0F0F, LSL #48
    ands x2, x0, x2

    // Shift values back in place
    // x = (f & 0xF0F0F0F00F0F0F0F) | (g << 28) | (h >> 28)
    movz x3, 0x0F0F, LSL #0
    movk x3, 0x0F0F, LSL #16
    movk x3, 0xF0F0, LSL #32
    movk x3, 0xF0F0, LSL #48
    ands x3, x0, x3
    lsl x1, x1, #28
    orr x3, x3, x1
    lsr x2, x2, #28
    orr x0, x3, x2

// Final result is in x0

    ret
	.size	transpose, .-transpose
	// ... and ends with the .size above this line.


// Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global compare
    .type   compare, %function
compare:
    // (STUDENT TODO) Code for compare goes here.
    // Input parameter a is passed in X0; input parameter b is passed in X1.
    // Output value is returned in X0.
 
    ldur x2, [x0]
    ldur x3, [x1]

    // Compare long
    cmp x2, x3
    b.ne .not_equal

    // Compare char array, without padding
    add x0, x0, #8
    add x1, x1, #8

    ldur x2, [x0]
    ldur x3, [x1]

    movz x4, 0xFFFF, LSL #0
    movk x4, 0x00FF, LSL #16
    movk x4, 0x0000, LSL #32
    movk x4, 0x0000, LSL #48
    
    ands x2, x2, x4
    ands x3, x3, x4

    cmp x2, x3
    b.ne .not_equal

    // Compare double
    add x0, x0, #8
    add x1, x1, #8

    ldur x2, [x0]
    ldur x3, [x1]

    cmp x2, x3
    b.ne .not_equal    

    // Compare bool, ignoring padding
    add x0, x0, #8
    add x1, x1, #8

    ldur x2, [x0]
    ldur x3, [x1]

    movz x4, 0x00FF, LSL #0
    movk x4, 0x0000, LSL #16
    movk x4, 0x0000, LSL #32
    movk x4, 0x0000, LSL #48

    ands x2, x2, x4
    ands x3, x3, x4

    cmp x2, x3
    b.ne .not_equal 

    // Compare pointer
    add x0, x0, #8
    add x1, x1, #8

    ldur x2, [x0]
    ldur x3, [x1]

    cmp x2, x3
    b.ne .not_equal 

    // Compare bool, ignoring padding
    add x0, x0, #8
    add x1, x1, #8

    ldur x2, [x0]
    ldur x3, [x1]

    movz x4, 0x00FF, LSL #0
    movk x4, 0x0000, LSL #16
    movk x4, 0x0000, LSL #32
    movk x4, 0x0000, LSL #48

    ands x2, x2, x4
    ands x3, x3, x4

    cmp x2, x3
    b.ne .not_equal 

    b .equal

  
    .not_equal:
    movz x0, #0x1
    ret

    .equal:
    movz x0, #0x0
    ret

    .size   compare, .-compare
    // ... and ends with the .size above this line.
 

	// Every function starts from the .align below this line ...
	.align	2
	.global	change_case
	.type	change_case, %function
change_case:
    // (STUDENT TODO) Code for change_case goes here.
    // Input parameter str is passed in X0; input parameter flag is passed in X1.
    // There is no output value. Parameter str will be mutated.

    // x3 is what we will use for the mask, which will be shifted.
    movz x3, #0x00FF, LSL #0
    

    // x4 to keep track of how many bytes are parsed.
    movz x4, #0x0000, LSL #0

    movz x7, #0x0000, LSL #0
    sub x7, x7, #8

    // Start by loading 8 bytes into x2
    ldur x2, [x0]

    movz x8, 0x005A, LSL #0
    movz x9, 0x0041, LSL #0

    movz x10, 0x0061, LSL #0
    movz x11, 0x007A, LSL #0

    movz x12, 0x0020, LSL #0

    .start:
    
    cmp x4, #8
    b.eq .resetParsedBytes
    b .noResetNeeded

    .resetParsedBytes:
        movz x4, #0x0000, LSL #0
        movz x3, #0x00FF, LSL #0

        add x0, x0, #8
        ldur x2, [x0]

        movz x7, #0x0000, LSL #0
        sub x7, x7, #8

        movz x8, 0x005A, LSL #0
        movz x9, 0x0041, LSL #0
        movz x10, 0x0061, LSL #0
        movz x11, 0x007A, LSL #0
        movz x12, 0x0020, LSL #0

    .noResetNeeded:

    // We only want 1 byte from x2, so mask out 7 bytes. 
    ands x5, x2, x3

    // Shift mask left by 8 bits to get next character
    LSL x3, x3, #8
    add x7, x7, #8
   

    cmp x4, #0
    b.gt .setValues
    b .skipSet

    .setValues:
        LSL x8, x8, #8
        LSL x9, x9, #8
        LSL x10, x10, #8
        LSL x11, x11, #8
        LSL x12, x12, #8

    .skipSet:

    // Increment x4 for parsed bytes
    add x4, x4, #1

    // If the value in x5 is 0, we have reached the end.
    cmp x5, #0
    b.eq .nullTermination

    

    // If x1 is 0, then shift to lower, else shift to upper.
    cmp x1, #0

    // Check if we want to do toLowerCase or toUppercase
    b.eq .toLowerCaseCheck
    b .toUppercaseCheck

    // First check if the value is already lowercase, in this case skip to next value
    .toLowerCaseCheck:

        // If the value is <= 90 (Z, = 0x5A) then it is valid, proceed.

        cmp x5, x8
        b.ls .UpperBound

        // If higher, then branch to start
        b.hi .start

        .UpperBound:
            cmp x5, x9
            b.hs .toLowerCase

        b .start

    .toLowerCase:

        // We are given an uppercase character. Need to add 32 (= 0x20)
        adds x2, x2, x12
        stur x2, [x0]
        b .start


    .toUppercaseCheck:
        // If the value is >= 97 (a, = 0x61) then it is valid, proceed.
        cmp x5, x10
        b.hs .UpperBound2
        b .start

        .UpperBound2:
            // 0x7A = 122
            cmp x5, x11
            b.ls .toUpperCase
        
        // If lower, then branch to start
        b .start

    .toUpperCase:
        
        // We are given a lowercase character. Need to subtract 32 (= 0x20)
        subs x2, x2, x12
        stur x2, [x0]
        b .start


    .nullTermination:

ret

	.size	change_case, .-change_case
	// ... and ends with the .size above this line.

	// Every function starts from the .align below this line ...
	.align	2
	.global	tree_depth
	.type	tree_depth, %function


tree_depth:
    // (STUDENT TODO) Code for tree_depth goes here.
    // Input parameter root is passed in X0.
    // Output value is returned in X0.

    movz x3, #0x0000
    movz x4, #0x0000
    movz x5, #0x0000
    
    // Branch if null
    cmp x0, #0
    b.eq .nullNode

    // Left node
    ldur x1, [x0]

    // Right node
    ldur x2, [x0, #8]

    // Stack grows
    sub sp, sp, #32

    stur x29, [sp]
    stur x30, [sp, #8]

    // Save left and right pointers
    stur x1, [sp, #16]
    stur x2, [sp, #24]
    sub x29, sp, #0
    //


   // x3 stores sum of left subtree, x4 stores sum of right subtree
   add x3, x3, #1

   add x6, x3, #1
   movz x0, #0x0000
   adds x0, x0, x1
   bl tree_depth

   cmp x6, x5
   b.hi .setLeftTemp
   b .skip
   
   .setLeftTemp:
   add x5, x6, #0
   .skip:

   // Checking right subtree
   add x4, x4, #1
   add x7, x4, #1

   movz x0, #0x0000
   adds x0, x0, x2
   bl tree_depth

   cmp x7, x5
   b.hi .setRightTemp
   b .skipR
   
   .setRightTemp:
   add x5, x7, #0
   .skipR:
    
    .nullNode:
    add x0, x5, #0 
    ldur x29, [sp]
    ldur x30, [sp, #8]
    ldur x1, [sp, #16]
    ldur x2, [sp, #24]
    add sp, sp, #32
    ret

	.size	tree_depth, .-tree_depth
	// ... and ends with the .size above this line.


    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global hamming_decode
    .type   hamming_decode, %function

hamming_decode:
    // (STUDENT TODO) Code for hamming_decode goes here.
    // Input parameter code is passed in X0; input parameter hamming_codes is passed in X1.
    // Output value is returned in X0.

    movz x4, #0x0000
    movz x7, #0x0000
    movz x9, #0x0000

    // x2 stores input, x3 stores hamming codes
    add x2, x0, #0
    add x3, x1, #0

    // x4 stores current bytes of hamming_codes
    ldur x4, [x3]
    movz x6, #0x007F
    add x9, x4, #0

    // x6 stores mask, x7 stores index
    .loopStart:
    
    cmp x7, #8 
    b.eq .updateArray
    b .staticArray

    .updateArray:
    ldur x4, [x3, #8]
    add x0, x2, #0
    add x9, x4, #0
    .staticArray:   
    
    ands x1, x9, x6 
    
    // Need to save x0, x2, x3, x4, x6, x7

    // Stack grows
    sub sp, sp, #64
    stur x29, [sp]
    stur x30, [sp, #8]

    stur x0, [sp, #16]
    stur x2, [sp, #24]
    stur x3, [sp, #32]
    stur x4, [sp, #40]
    stur x6, [sp, #48]
    stur x7, [sp, #56]

    bl hamming_distance
    
    // Stack is restored
    ldur x29, [sp]
    ldur x30, [sp, #8]
    ldur x8, [sp, #16]
    ldur x2, [sp, #24]
    ldur x3, [sp, #32]
    ldur x4, [sp, #40]
    ldur x6, [sp, #48]
    ldur x7, [sp, #56]
    add sp, sp, #64 
    
    cmp x0, #1
    b.le .foundCode
    add x0, x8, #0

    lsr x9, x9, #8
    add x7, x7, #1
    add x10, x10, #1
    cmp x7, #16
    b.lt .loopStart

    b .badCode

    .foundCode:
    add x0, x7, #0
    b .finish

    .badCode:
    movz x0, #0x0000

    .finish:
    
    ret

    .size   hamming_decode, .-hamming_decode
