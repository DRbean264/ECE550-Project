module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //k
	//wire [31:0] data_result_general_adder;
	wire Cout;
	
	general_adder_32 gadder(data_result, Cout, overflow, data_operandA, data_operandB, ctrl_ALUopcode);
	//general_adder_32 gadder(data_result_general_adder, Cout, overflow, data_operandA, data_operandB, ctrl_ALUopcode);

endmodule
