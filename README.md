# [MIPS Processor Implementation](https://github.com/SmartCheese22/CS220/blob/main/MIPS_processor.v)

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



