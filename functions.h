/**************************************************************************
 * C S 429 Assembly Coding Lab
 *
 * testbench.c - Testbench for all the assembly functions.
 *
 * Copyright (c) 2022, 2023, 2024.
 * Authors: Anoop Rachakonda, Kavya Rathod, Prithvi Jamadagni
 * All rights reserved.
 * May not be used, modified, or copied without permission.
 **************************************************************************/

#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>


/**
 * A struct representing a student. The various fields
 * will be compared in the compare() function.
 */
typedef struct concert_ticket {
  unsigned long unique_id;      // 1
  char seat_code[3];            // 2
  double price;                 // 3
  bool special_admission;       // 4
  struct concert_ticket *recommendations;          // 5
  bool refundable;              // 6
} concert_ticket_t;

/**
 * A struct that represents a node of a binary tree.
 * It contains pointers to its 2 children and 1 piece of data.
 */
typedef struct tree_node {
  struct tree_node *left, *right;
  uint64_t data;
} node_t;

// Week 1:

/**
 * hamming_distace function
 *
 * Given two 64-bit bit vectors stored in uint64_ts, return
 * the number of bit positions in which the bits are different.
 * 
 * @param x the first bit vector
 * @param y the second bit vector
 * @return The number of bit positions that differ between x and y.
 */
 uint64_t hamming_distance(uint64_t x, uint64_t y);


/**
 * transpose function
 *
 * Given a uint64 that represents an 8x8 bit matrix, perform a transpose of
 * this matrix and return the resultant matrix. You can realize this function
 * using 3 applications of an Outer Perfect Shuffle.
 * 
 * @param input the bit-string representing an 8x8 bit matrix
 * @return the transposed matrix, also in bit-string form.
 */
uint64_t transpose(uint64_t input);

/**
 * compare function
 * 
 * Given two pointers to concert_ticket_t structs, perform a field-by-field
 * comparison and return 0 if the two structs have the same field values.
 *
 * Compare characters, ints via numerical comparison.
 * Compare floats as raw binary strings, disregarding their numerical value.
 * Compare pointers by seeing if they point to the same memory location.
 * 
 * @param a a pointer to the first struct to compare
 * @param b a pointer to the second struct to compare
 * @return a uint64_t representing the ordinal position of the first field
 *          that the two structs differ. For example if the structs first
 *          differ in the "gpa" field, return 3.
 */
uint64_t compare(concert_ticket_t *a, concert_ticket_t *b);

// Week 2:

/**
 * change_case function
 *
 * Given a pointer to a string, modify the case of the string according
 * to the flag. If the flag is true, make the string uppercase. If it
 * is false, make the string lowercase. Ignore non-alphabetical characters
 * in the string (that is, keep them the same).
 * 
 * This function modifies the string in-place. It does NOT create a new
 * string or copy it to a different location.
 *
 * @param str a pointer to the string to modify.
 * @param flag the flag to specify uppercase or lowercase operation.
 * This function does not return any value.
 */
void change_case(char *str, bool flag);

/**
 * tree_depth function
 * 
 * Given a pointer to the root of a binary tree, return the depth of the tree.
 * The tree is not necessarily complete or balanced.
 * A tree with only 1 node (the root) has depth 1.
 * This function must use recursion.
 *
 * @param root a pointer to the root node of the tree.
 * @return the depth of the tree.
 */
uint64_t tree_depth(node_t *root);

/**
 * hamming_decode function
 * 
 * Given a uint64_t code, where the 7-bit code is stored in the
 * least significant bits and an array of chars where each entry's
 * 7 least significant bits is the hamming code that maps to that
 * specific index as the message, return the message given a 
 * hamming code that may have some bit flips. If the code cannot
 * be corrected because of too many errors, return -1.
 *
 * @param root a pointer to the root node of the tree.
 * @return the depth of the tree.
 */
uint64_t hamming_decode(uint64_t code, char *hamming_codes);

#endif
