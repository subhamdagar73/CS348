# Lab 1: Assembly Language Programming

**Name:** Subham
**Roll No.:** 230101098

This lab contains three x86 Assembly programs demonstrating fundamental concepts in low-level programming.

## Overview

Lab 1 includes three separate assembly programs, each implementing different algorithms and demonstrating various assembly language techniques.

## Programs

### 1. Binary Palindrome Checker (`230101098_setA.asm`)

**Description:** Checks if the binary representation of a decimal number is a palindrome.

**Algorithm:**
1. Prompts the user to enter a decimal number
2. Converts the number to binary representation
3. Reverses the binary representation by shifting and accumulating bits
4. Compares the original binary with the reversed binary
5. Outputs whether the binary representation is a palindrome or not

**Key Techniques:**
- Bit manipulation (AND, OR, SHL, SHR operations)
- Loop control for bit processing
- C library function calls (`printf`, `scanf`)

**Input:** A decimal integer

**Output:** Message indicating if the binary is a palindrome

---

### 2. Graph Connectivity Checker (`230101098_setB_a.asm`)

**Description:** Determines if a graph is connected using Depth-First Search (DFS).

**Algorithm:**
1. Reads the number of vertices
2. Reads the adjacency matrix representing the graph
3. Performs DFS starting from vertex 0
4. Tracks visited vertices to check connectivity
5. Outputs whether the graph is connected or not

**Key Techniques:**
- Dynamic memory usage (arrays in `.bss` section)
- Recursive-style DFS implementation
- Matrix indexing and calculations
- Graph traversal logic

**Input:**
- Number of vertices (n)
- Adjacency matrix (n × n)

**Output:** Message indicating if the graph is CONNECTED or NOT CONNECTED

---

### 3. Matrix Transpose (`230101098_setB_b.asm`)

**Description:** Computes the transpose of an N × N matrix.

**Algorithm:**
1. Prompts for matrix size (N)
2. Reads N² matrix elements
3. Computes the transpose by swapping rows and columns
4. Outputs the transposed matrix

**Key Techniques:**
- 2D array manipulation
- Index calculation for matrix access
- Nested loop structure
- I/O formatting

**Input:**
- Matrix size (N)
- N² integers representing the matrix elements

**Output:** Transposed matrix elements

---

## Compilation and Execution

To assemble and run these programs:

```bash
# Assemble the program
nasm -f elf32 <filename>.asm -o <filename>.o

# Link using gcc
gcc -m32 <filename>.o -o <filename>

# Run the program
./<filename>
```

## Notes

- All programs use 32-bit x86 assembly syntax 
- Programs rely on C library functions for I/O operations

