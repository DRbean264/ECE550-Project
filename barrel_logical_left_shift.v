module barrel_logical_left_shift(out, in, ctrl_shiftamt);
	input [31:0] in;
	input [4:0] ctrl_shiftamt;
	output [31:0] out;
	
	wire [31:0] out_layer1, out_layer2, out_layer3, out_layer4;
	
	//  First layer, shift amount is 1
	assign out_layer1[0] = ctrl_shiftamt[0] ? 1'b0 : in[0];
	genvar i;
	generate
		for (i = 1; i < 32; i = i + 1) begin: mux_first_layer
			assign out_layer1[i] = ctrl_shiftamt[0] ? in[i - 1] : in[i];
		end
	endgenerate
	
	//  Second layer, shift amount is 2
	assign out_layer2[0] = ctrl_shiftamt[1] ? 1'b0 : out_layer1[0];
	assign out_layer2[1] = ctrl_shiftamt[1] ? 1'b0 : out_layer1[1];
	genvar j;
	generate
		for (j = 2; j < 32; j = j + 1) begin: mux_second_layer
			assign out_layer2[j] = ctrl_shiftamt[1] ? out_layer1[j - 2] : out_layer1[j];
		end
	endgenerate
	
	//  Third layer, shift amount is 4
	assign out_layer3[0] = ctrl_shiftamt[2] ? 1'b0 : out_layer2[0];
	assign out_layer3[1] = ctrl_shiftamt[2] ? 1'b0 : out_layer2[1];
	assign out_layer3[2] = ctrl_shiftamt[2] ? 1'b0 : out_layer2[2];
	assign out_layer3[3] = ctrl_shiftamt[2] ? 1'b0 : out_layer2[3];
	genvar k;
	generate
		for (k = 4; k < 32; k = k + 1) begin: mux_third_layer
			assign out_layer3[k] = ctrl_shiftamt[2] ? out_layer2[k - 4] : out_layer2[k];
		end
	endgenerate
	
	//  Fourth layer, shift amount is 8
	genvar l0;
	generate
		for (l0 = 0; l0 < 8; l0 = l0 + 1) begin: mux_fourth_layer_0
			assign out_layer4[l0] = ctrl_shiftamt[3] ? 1'b0 : out_layer3[l0];
		end
	endgenerate
	genvar l1;
	generate
		for (l1 = 8; l1 < 32; l1 = l1 + 1) begin: mux_fourth_layer_1
			assign out_layer4[l1] = ctrl_shiftamt[3] ? out_layer3[l1 - 8] : out_layer3[l1];
		end
	endgenerate
	
	//  Fifth layer, shift amount is 16
	genvar m0;
	generate
		for (m0 = 0; m0 < 16; m0 = m0 + 1) begin: mux_fifth_layer_0
			assign out[m0] = ctrl_shiftamt[4] ? 1'b0 : out_layer4[m0];
		end
	endgenerate
	genvar m1;
	generate
		for (m1 = 16; m1 < 32; m1 = m1 + 1) begin: mux_fifth_layer_1
			assign out[m1] = ctrl_shiftamt[4] ? out_layer4[m1 - 16] : out_layer4[m1];
		end
	endgenerate
endmodule