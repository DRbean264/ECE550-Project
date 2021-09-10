module full_adder(sum, cout, a, b, cin);
	input a, b, cin;
	output sum, cout;
	
	wire xorab_out;
	wire and1_out, and2_out;
	
	xor xor1(xorab_out, a, b);
	xor xor2(sum, xorab_out, cin);
	
	and and1(and1_out, xorab_out, cin);
	and and2(and2_out, a, b);
	or or1(cout, and1_out, and2_out);
endmodule
