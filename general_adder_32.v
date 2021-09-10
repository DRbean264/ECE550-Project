module csa_16(Sum, Cout, overflow, A, B, Cin);
	input [15:0] A, B;
	input Cin;
	output [15:0] Sum;
	output Cout, overflow;
	
	wire [7:0] Sum_hi0, Sum_hi1;
	wire Cout_lo, Cout_hi0, Cout_hi1;
	wire ovf_lo, ovf_hi0, ovf_hi1;
	
	rca_8 rca_lo(Sum[7:0], Cout_lo, ovf_lo, A[7:0], B[7:0], Cin);
	rca_8 rca_hi0(Sum_hi0, Cout_hi0, ovf_hi0, A[15:8], B[15:8], 1'b0);
	rca_8 rca_hi1(Sum_hi1, Cout_hi1, ovf_hi1, A[15:8], B[15:8], 1'b1);
	
	assign Sum[15:8] = Cout_lo ? Sum_hi1 : Sum_hi0;
	assign Cout = Cout_lo ? Cout_hi1 : Cout_hi0;
	assign overflow = Cout_lo ? ovf_hi1 : ovf_hi0;
endmodule

module csa_32(Sum, Cout, overflow, A, B, Cin);
	input [31:0] A, B;
	input Cin;
	output [31:0] Sum;
	output Cout, overflow;
	
	wire [15:0] Sum_hi0, Sum_hi1;
	wire Cout_lo, Cout_hi0, Cout_hi1;
	wire ovf_lo, ovf_hi0, ovf_hi1;
	
	csa_16 csa_lo(Sum[15:0], Cout_lo, ovf_lo, A[15:0], B[15:0], Cin);
	csa_16 csa_hi0(Sum_hi0, Cout_hi0, ovf_hi0, A[31:16], B[31:16], 1'b0);
	csa_16 csa_hi1(Sum_hi1, Cout_hi1, ovf_hi1, A[31:16], B[31:16], 1'b1);
	
	assign Sum[31:16] = Cout_lo ? Sum_hi1 : Sum_hi0;
	assign Cout = Cout_lo ? Cout_hi1 : Cout_hi0;
	assign overflow = Cout_lo ? ovf_hi1 : ovf_hi0;
endmodule

module general_adder_32(Sum, Cout, overflow, A, B, ctrl_ALUopcode);
	input [31:0] A, B;
	input [4:0] ctrl_ALUopcode;
	output [31:0] Sum;
	output Cout, overflow;
	
	wire [31:0] notB, B_input;
	
	assign notB = ~B;
	assign B_input = ctrl_ALUopcode[0] ? notB : B;  //  add/sub
	
	csa_32 csa(Sum, Cout, overflow, A, B_input, ctrl_ALUopcode[0]);
endmodule