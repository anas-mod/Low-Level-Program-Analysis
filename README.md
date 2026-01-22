
   **Project Overview**

This project demonstrates a classic Buffer Overflow (Smashing the Stack) vulnerability. The objective was to manipulate a local variable's value by overflowing an adjacent character buffer in a 64-bit Linux environment.


***Vulnerability Analysis***

The target application (keycard.c) utilizes the unsafe scanf("%s") function. Because %s does not enforce boundary limits, input exceeding the allocated 32 bytes spills into neighboring memory locations on the stack.


***The Target***

To trigger the gadget() function (which prints the flag), the variable key must be modified from its initial value (0x12345678) to the "magic" value: 0xdeadbeef.


   **Technical Workflow**

*1. Static Analysis (The Source)*

Reading the C source code allowed for the identification of the logic gate.

![ C Code ](Projects/LLP-analysis/img/code_keycard.png)

*2. Reverse Engineering (The Assembly)*

Using objdump -d, I analyzed the authorize function to determine the exact memory offsets.

    -> Buffer (name) starts at rbp-0x30.

    -> Variable (key) sits at rbp-0x4.

    -> Calculation: 0x30−0x4=0x2C (44 bytes).

![ objdump ](Projects/LLP-analysis/img/objdump-d.png)

*3. Exploit Development (The C Loader)*

Instead of using high-level scripts, I developed a custom exploit in C (exploit.c). This tool:

    1. Constructs a 44-byte padding of "A" characters.

    2. Appends the Little-Endian representation of 0xdeadbeef.

    3. Pipes the raw bytes into the target process using popen().


***Execution & Proof of Concept***

By running the exploit loader, the stack was successfully corrupted, overwriting the key variable and bypassing the security check.
Bash

    # Compiling the exploit
    gcc scripts/exploit.c -o scripts/exploit

    # Running the attack
    ./scripts/exploit

![access granted](Projects/LLP-analysis/img/success.png)


*Key Learnings*

Memory Alignment: Learned how the compiler pads the stack to maintain 16-byte boundaries.

Endianness: Verified that x86_64 architecture stores multi-byte integers in Little-Endian format.

Secure Coding: Demonstrated why scanf("%s") and gets() should be replaced with safer alternatives like fgets().


## Build Instructions

This project includes a `Makefile` to automate the environment setup and compilation process.

### Quick Start
To compile both the vulnerable binary and the exploit loader, run:
```bash
make
