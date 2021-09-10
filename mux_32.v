module mux_2(out, select, in0, in1);
	input select;
	input [31:0] in0, in1;
	output [31:0] out;
	assign out = select ? in1 : in0;
endmodule

module mux_4(out, select, in0, in1, in2, in3);
	input [31:0] in0, in1, in2, in3;
	input [1:0] select;
	output [31:0] out;
	
	wire [31:0] w0, w1;
	
	mux_2 mux_lo0(w0, select[0], in0, in1);
	mux_2 mux_lo1(w1, select[0], in2, in3);
	mux_2 mux_hi(out, select[1], w0, w1);
endmodule

module mux_8(out, select, in0, in1, in2, in3, in4, in5, in6, in7);
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7;
	input [2:0] select;
	output [31:0] out;
	
	wire [31:0] w0, w1;
	
	mux_4 mux_lo0(w0, select[1:0], in0, in1, in2, in3);
	mux_4 mux_lo1(w1, select[1:0], in4, in5, in6, in7);
	mux_2 mux_hi(out, select[2], w0, w1);
endmodule

module mux_16(out, select, in0, in1, in2, in3, in4, in5, in6, in7,
in8, in9, in10, in11, in12, in13, in14, in15);
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15;
	input [3:0] select;
	output [31:0] out;
	
	wire [31:0] w0, w1;
	
	mux_8 mux_lo0(w0, select[2:0], in0, in1, in2, in3, in4, in5, in6, in7);
	mux_8 mux_lo1(w1, select[2:0], in8, in9, in10, in11, in12, in13, in14, in15);
	mux_2 mux_hi(out, select[3], w0, w1);
endmodule

module mux_32(out, select, in0, in1, in2, in3, in4, in5, in6, in7,
in8, in9, in10, in11, in12, in13, in14, in15,
in16, in17, in18, in19, in20, in21, in22, in23,
in24, in25, in26, in27, in28, in29, in30, in31);
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, 
	in8, in9, in10, in11, in12, in13, in14, in15,
	in16, in17, in18, in19, in20, in21, in22, in23,
	in24, in25, in26, in27, in28, in29, in30, in31;
	input [4:0] select;
	output [31:0] out;
	
	wire [31:0] w0, w1;
	
	mux_16 mux_lo0(w0, select[3:0], in0, in1, in2, in3, in4, in5, in6, in7,
	in8, in9, in10, in11, in12, in13, in14, in15);
	mux_16 mux_lo1(w1, select[3:0], in16, in17, in18, in19, in20, in21, in22, in23,
	in24, in25, in26, in27, in28, in29, in30, in31);
	mux_2 mux_hi(out, select[4], w0, w1);
endmodule
