module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire [31:0] data_result_general_adder;
	wire [31:0] data_result_and;
	wire [31:0] data_result_or;
	wire [31:0] data_result_sll;
	wire [31:0] data_result_sra;
	wire Cout;
	wire [31:0] out_enable;
	wire adder_enable;
	wire less_than0, less_than1, less_than2;
	wire notB31;
	
	//  all modules
	general_adder_32 gadder(data_result_general_adder, Cout, overflow, data_operandA, data_operandB, ctrl_ALUopcode);
	and_32 and32(data_result_and, data_operandA, data_operandB);
	or_32 or32(data_result_or, data_operandA, data_operandB);
	barrel_logical_left_shift barrel_sll(data_result_sll, data_operandA, ctrl_shiftamt);
	barrel_arithmetic_right_shift barrel_sra(data_result_sra, data_operandA, ctrl_shiftamt);
	
	//  is not equal
	or or_not_equal(isNotEqual, data_result_general_adder[0], data_result_general_adder[1],
										 data_result_general_adder[2], data_result_general_adder[3],
										 data_result_general_adder[4], data_result_general_adder[5],
										 data_result_general_adder[6], data_result_general_adder[7],
										 data_result_general_adder[8], data_result_general_adder[9],
										 data_result_general_adder[10], data_result_general_adder[11],
										 data_result_general_adder[12], data_result_general_adder[13],
										 data_result_general_adder[14], data_result_general_adder[15],
										 data_result_general_adder[16], data_result_general_adder[17],
										 data_result_general_adder[18], data_result_general_adder[19],
										 data_result_general_adder[20], data_result_general_adder[21],
										 data_result_general_adder[22], data_result_general_adder[23],
										 data_result_general_adder[24], data_result_general_adder[25],
										 data_result_general_adder[26], data_result_general_adder[27],
										 data_result_general_adder[28], data_result_general_adder[29],
										 data_result_general_adder[30], data_result_general_adder[31]);
	
	// is less than
	and and0_less_than(less_than0, data_operandA[31], data_result_general_adder[31]);
	xor xor_less_than(less_than1, data_operandA[31], data_result_general_adder[31]);
	not not_less_than(notB31, data_operandB[31]);
	and and1_less_than(less_than2, notB31, less_than1);
	or or_less_than(isLessThan, less_than0, less_than2);
	
	
	//  decoder choose which tristate buffer to enable
	decoder_5to32 dec(out_enable, ctrl_ALUopcode, 1'b1);
	
	//  32-bit Tristate buffer to select which to output
	// general adder
	or or_general_adder(adder_enable, out_enable[0], out_enable[1]);
	tristate_buffer tb_gadder(data_result, data_result_general_adder, adder_enable);
	// bitwise and
	tristate_buffer tb_and(data_result, data_result_and, out_enable[2]);
	// bitwise or
	tristate_buffer tb_or(data_result, data_result_or, out_enable[3]);
	// barrel shift left logic
	tristate_buffer tb_sll(data_result, data_result_sll, out_enable[4]);
	// barrel shift right arithmetic
	tristate_buffer tb_sra(data_result, data_result_sra, out_enable[5]);
	
endmodule
