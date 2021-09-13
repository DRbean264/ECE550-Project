module not_32(out, in);
	input [31:0] in;
	output [31:0] out;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: Not_Series
			not not_what(out[i], in[i]);
		end
	endgenerate
endmodule
