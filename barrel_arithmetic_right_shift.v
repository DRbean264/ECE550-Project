module barrel_arithmetic_right_shift(out, in, ctrl_shiftamt);
	input [31:0] in;
	input [4:0] ctrl_shiftamt;
	output [31:0] out;
	
	wire [31:0] out_layer1, out_layer2, out_layer3, out_layer4;
	wire sign_bit;
	
	assign sign_bit = in[31];
	
	//  First layer, shift amount is 1
	assign out_layer1[31] = ctrl_shiftamt[0] ? sign_bit : in[31];
	genvar i;
	generate
		for (i = 0; i < 31; i = i + 1) begin: mux_first_layer
			assign out_layer1[i] = ctrl_shiftamt[0] ? in[i + 1] : in[i];
		end
	endgenerate
	
	//  Second layer, shift amount is 2
	assign out_layer2[31] = ctrl_shiftamt[1] ? sign_bit : out_layer1[31];
	assign out_layer2[30] = ctrl_shiftamt[1] ? sign_bit : out_layer1[30];
	genvar j;
	generate
		for (j = 0; j < 30; j = j + 1) begin: mux_second_layer
			assign out_layer2[j] = ctrl_shiftamt[1] ? out_layer1[j + 2] : out_layer1[j];
		end
	endgenerate
	
	//  Third layer, shift amount is 4
	assign out_layer3[31] = ctrl_shiftamt[2] ? sign_bit : out_layer2[31];
	assign out_layer3[30] = ctrl_shiftamt[2] ? sign_bit : out_layer2[30];
	assign out_layer3[29] = ctrl_shiftamt[2] ? sign_bit : out_layer2[29];
	assign out_layer3[28] = ctrl_shiftamt[2] ? sign_bit : out_layer2[28];
	genvar k;
	generate
		for (k = 0; k < 28; k = k + 1) begin: mux_third_layer
			assign out_layer3[k] = ctrl_shiftamt[2] ? out_layer2[k + 4] : out_layer2[k];
		end
	endgenerate
	
	//  Fourth layer, shift amount is 8
	genvar l0;
	generate
		for (l0 = 24; l0 < 32; l0 = l0 + 1) begin: mux_fourth_layer_0
			assign out_layer4[l0] = ctrl_shiftamt[3] ? sign_bit : out_layer3[l0];
		end
	endgenerate
	genvar l1;
	generate
		for (l1 = 0; l1 < 24; l1 = l1 + 1) begin: mux_fourth_layer_1
			assign out_layer4[l1] = ctrl_shiftamt[3] ? out_layer3[l1 + 8] : out_layer3[l1];
		end
	endgenerate
	
	//  Fifth layer, shift amount is 16
	genvar m0;
	generate
		for (m0 = 16; m0 < 32; m0 = m0 + 1) begin: mux_fifth_layer_0
			assign out[m0] = ctrl_shiftamt[4] ? sign_bit : out_layer4[m0];
		end
	endgenerate
	genvar m1;
	generate
		for (m1 = 0; m1 < 16; m1 = m1 + 1) begin: mux_fifth_layer_1
			assign out[m1] = ctrl_shiftamt[4] ? out_layer4[m1 + 16] : out_layer4[m1];
		end
	endgenerate
endmodule