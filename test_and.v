module test_and(out, in);
	input [15:0] in;
	output out;
	
	wire [13:0] inter;
	
	and and0(inter[0], in[0], in[1]);
	
	genvar i;
	generate
		for (i = 1; i < 14; i = i + 1) begin : test
			and and_inter(inter[i], inter[i - 1], in[i + 1]);
		end
	endgenerate
	
	and and_final(out, inter[13], in[15]);
endmodule