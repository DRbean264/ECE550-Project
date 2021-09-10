# Project1 - ALU Checkpoint 1 - Addsub-base
**Author: Yuzhe Ding (yd160); Aohua Zhang (az147)**
**Date: 09.10.2021**

## Description of our design implementation
> 32-bit General Adder Design
- 8-bit Ripple Carry Adder (RCA) implemented with 8 consecutive Full Adders (FA) connected by Cin and Cout
- 16-bit Carry Select Adder (CSA) implemented with 3 8-bit RCAs and 1 8-bit 2-to-1 multiplexer (Mux)
- 32-bit CSA consists of 3 16-bit CSA and 1 16-bit 2-to-1 Mux
- Calculate the overflow by implementing xor operation between the Cout and Cin of the most significant bit (namely the 31th bit of the adder)
- Extract the least significant bit (LSB) of ctrl_ALUopcode as the Cin of the entire 32-bit CSA
- Use the LSB of ctrl_ALUopcode to determine whether to invert the input data_operandB