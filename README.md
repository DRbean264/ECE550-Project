# Project1 - ALU Checkpoint 1 - Addsub-base
**Author: Yuzhe Ding (yd160); Aohua Zhang (az147)**
**Date: 09.23.2021**

## Description of our design implementation
> 32-bit General Adder Design
- 8-bit Ripple Carry Adder (RCA) implemented with 8 consecutive Full Adders (FA) connected by Cin and Cout
- 16-bit Carry Select Adder (CSA) implemented with 3 8-bit RCAs and 1 8-bit 2-to-1 multiplexer (Mux)
- 32-bit CSA consists of 3 16-bit CSA and 1 16-bit 2-to-1 Mux
- Calculate the overflow by implementing xor operation between the Cout and Cin of the most significant bit (namely the 31th bit of the adder)
- Extract the least significant bit (LSB) of ctrl_ALUopcode as the Cin of the entire 32-bit CSA
- Use the LSB of ctrl_ALUopcode to determine whether to invert the input data_operandB

> 32 bitwise And/Or
- Put 32 1-bit And/Or in parallel

> Barrel Shift left (logic)
- Use five level mux stacks, which shift 1, 2, 4, 8, 16 bits respectively

> Barrel Shift right (arithmetic)
- Use five level mux stacks, which shift 1, 2, 4, 8, 16 bits respectively

> 5-to-32 Decoder
- First implement a 2-to-4 decoder with an Enable input
- Then use 2 2-to-4 decoders to construct 3-to-8 decoder with the Enable input connected to the MSB of the input
- It's the same for 4-to-16 and 5-to-32 decoder

> Tristate Buffer
- I use the constant 1'bz to implement the tristate buffer
- Use the output of the decoder to enable the tristate buffer to select which data appears on the final output