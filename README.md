# Bash Shell Calculator

This is a simple calculator implemented in Bash. It is a practice project created as part of the Bash course provided by the Information Technology Institute (ITI).

## Features

- Addition (+): Adds two numbers.

- Subtraction (-): Subtracts one number from another.

- Division (/): Divides one number by another.

- Multiplication (*): Multiplies two numbers.

- Exponentiation (^): Raises a number to a specified power.

- Provides number conversion between different bases

   >  **Binary <-> Decimal <-> Octal <-> Hexadecimal**

## Code Flow
```mermaid
graph LR
A((MAIN))--> B((Calculator))
A --> C(Documentation) --> E 
C --> A
A --> E(Exit)
B --> F(Standard)--> M(ADD-SUB-MUL-DIV-EXP)-->E
B --> G(Programmer)--> N(BIN-DEC-OCT-HEX)-->E
B --> H(Scientific)--> R(LShift-RShift-AND-OR-XOR-NOT)-->E

```

## Contact
**Mohand Zaid** ` < mohandzaid33@gmail.com > `