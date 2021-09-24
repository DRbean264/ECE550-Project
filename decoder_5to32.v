module decoder_5to32(out, in, en);
	input en;
	input [4:0] in;
	output [31:0] out;
	
	wire [4:0] notIn;
	wire [31:0] raw_out;
	
	not not0(notIn[0], in[0]);
	not not1(notIn[1], in[1]);
	not not2(notIn[2], in[2]);
	not not3(notIn[3], in[3]);
	not not4(notIn[4], in[4]);
	
	decoder_4to16 dec_lo(raw_out[15:0], in[3:0], notIn[4]);
	decoder_4to16 dec_hi(raw_out[31:16], in[3:0], in[4]);
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: And_Series
			and and_out(out[i], raw_out[i], en);
		end
	endgenerate
endmodule

module decoder_4to16(out, in, en);
	input en;
	input [3:0] in;
	output [15:0] out;
	
	wire [3:0] notIn;
	wire [15:0] raw_out;
	
	not not0(notIn[0], in[0]);
	not not1(notIn[1], in[1]);
	not not2(notIn[2], in[2]);
	not not3(notIn[3], in[3]);
	
	decoder_3to8 dec_lo(raw_out[7:0], in[2:0], notIn[3]);
	decoder_3to8 dec_hi(raw_out[15:8], in[2:0], in[3]);
	
	genvar i;
	generate
		for (i = 0; i < 16; i = i + 1) begin: And_Series
			and and_out(out[i], raw_out[i], en);
		end
	endgenerate
endmodule

module decoder_3to8(out, in, en);
	input en;
	input [2:0] in;
	output [7:0] out;
	
	wire [2:0] notIn;
	wire [7:0] raw_out;
	
	not not0(notIn[0], in[0]);
	not not1(notIn[1], in[1]);
	not not2(notIn[2], in[2]);
	
	decoder_2to4 dec_lo(raw_out[3:0], in[1:0], notIn[2]);
	decoder_2to4 dec_hi(raw_out[7:4], in[1:0], in[2]);
	
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin: And_Series
			and and_out(out[i], raw_out[i], en);
		end
	endgenerate
	
endmodule

module decoder_2to4(out, in, en);
	input en;
	input [1:0] in;
	output [3:0] out;
	
	wire [1:0] notIn;
	
	not not0(notIn[0], in[0]);
	not not1(notIn[1], in[1]);
	
	and and0(out[0], notIn[1], notIn[0], en);
	and and1(out[1], notIn[1], in[0], en);
	and and2(out[2], in[1], notIn[0], en);
	and and3(out[3], in[1], in[0], en);
endmodule