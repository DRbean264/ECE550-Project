module rca_8(Sum, Cout, overflow, A, B, Cin);
	input [7:0] A;
	input [7:0] B;
	input Cin;
	output [7:0] Sum;
	output Cout, overflow;
	
	wire [6:0] w;
	
	full_adder FA0(Sum[0], w[0], A[0], B[0], Cin);
	full_adder FA1(Sum[1], w[1], A[1], B[1], w[0]);
	full_adder FA2(Sum[2], w[2], A[2], B[2], w[1]);
	full_adder FA3(Sum[3], w[3], A[3], B[3], w[2]);
	full_adder FA4(Sum[4], w[4], A[4], B[4], w[3]);
	full_adder FA5(Sum[5], w[5], A[5], B[5], w[4]);
	full_adder FA6(Sum[6], w[6], A[6], B[6], w[5]);
	full_adder FA7(Sum[7], Cout, A[7], B[7], w[6]);
	
	xor xor_overflow(overflow, Cout, w[6]);
endmodule
