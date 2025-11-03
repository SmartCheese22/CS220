# CS220 - Computer Architecture Projects

This repository contains coursework and projects related to CS220 (Computer Architecture), including MIPS assembly programs and a custom MIPS processor implementation in Verilog.

## Repository Contents

- **MIPS Assembly Programs**: Three MIPS assembly programs demonstrating various algorithms
  - `binary_search.s` - Binary search implementation
  - `fibonacci.s` - Iterative Fibonacci number generator
  - `fibonacci_recursive.s` - Recursive Fibonacci number generator
- **MIPS Processor**: A custom Verilog implementation of a MIPS processor
  - `MIPS_processor.v` - Complete processor design with FSM
- **Instructions.pdf**: Detailed project instructions and specifications

## MIPS Assembly Programs

### binary_search.s
Implements binary search algorithm on a user-provided sorted array. The program:
- Prompts the user to enter the size of the array (N)
- Accepts N integers as array elements
- Prompts for a search value (K)
- Uses binary search to find K in the array
- Outputs the index if found, or a not-found message

### fibonacci.s (Iterative)
Generates the first N Fibonacci numbers using an iterative approach:
- Prompts the user to enter N
- Prints the first N Fibonacci numbers
- Uses efficient iterative calculation

### fibonacci_recursive.s
Generates the first N Fibonacci numbers using a recursive approach:
- Prompts the user to enter N
- Prints the first N Fibonacci numbers
- Demonstrates recursive function calls in MIPS assembly

### Running Assembly Programs
To run these MIPS assembly programs, you can use:
1. **MARS (MIPS Assembler and Runtime Simulator)**: Open the `.s` file in MARS and run
2. **SPIM**: Load and run using SPIM simulator
3. **QtSpim**: GUI-based MIPS simulator

## [MIPS Processor Implementation](https://github.com/SmartCheese22/CS220/blob/main/MIPS_processor.v)

This repository contains a Verilog implementation of a simple MIPS processor designed to execute a subset of MIPS instructions. The processor is implemented using a finite state machine (FSM) with seven distinct states.

## Overview

The MIPS processor performs basic arithmetic and logical operations, as well as memory access and branching. It includes components for instruction fetching, decoding, execution, register file management, and memory access. The processor follows the MIPS instruction set and can handle operations such as load word (`lw`), add immediate unsigned (`addiu`), set on less than (`slt`), branch on equal (`beq`), add unsigned (`addu`), and branch on not equal (`bne`).

## Modules

- **`state_change`**: Manages the FSM state transitions based on clock edges and program counter (PC) value.
- **`fetch`**: Fetches instructions from instruction memory based on the current state and PC value.
- **`decode`**: Decodes the fetched instruction into opcode, function code, and operands.
- **`reg_file`**: Manages the 32-register file, providing read and write access based on the current state and instruction.
- **`execute`**: Executes the decoded instruction and updates the program counter (PC) and result based on the operation.
- **`memory`**: Handles data memory operations for load and store instructions.
- **`MIPS_Processor`**: Top-level module integrating all components and controlling the processor's execution flow.

## Instructions and Memory

### Instruction Memory

The instruction memory is initialized with a sequence of MIPS instructions encoded in binary. The instructions perform operations such as loading values into registers, performing arithmetic operations, and branching based on conditions.

### Data Memory

The data memory is initialized with 8-bit two’s complement values representing variables `a`, `b`, and `c`. The data memory is used for load and store operations.

### Finite State Machine (FSM)

The FSM is designed with seven states:

1. **FETCH**: Read the instruction from the instruction memory.
2. **DECODE**: Decode the instruction.
3. **REGFILE**: Access the register file to read operands.
4. **EXECUTE**: Execute the instruction and update the PC.
5. **MEMORY**: Access data memory for load operations.
6. **WRITE**: Write results back to the register file and update the state based on the PC value.
7. **FINAL**: Display the final result on LEDs.

## Dependencies

- Verilog HDL for hardware description and simulation.

## Usage

1. **Simulation**: Load the Verilog files into a simulation tool such as ModelSim or Vivado.
2. **Testing**: Run the simulation to verify the processor's functionality with various instruction sequences.
3. **Synthesis**: Synthesize the design for implementation on FPGA hardware if desired.

## Example

An example of an MIPS instruction sequence and corresponding operations is provided in the code comments. This sequence initializes registers, performs arithmetic operations, and demonstrates branching.



