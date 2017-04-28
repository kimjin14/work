module mux2 (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[0:0])
		1'd0: out_r = in[0];
		1'd1: out_r = in[1];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux3 (
	input [2:0]in,
	input [1:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[1:0])
		2'd0: out_r = in[0];
		2'd1: out_r = in[1];
		2'd2: out_r = in[2];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux4 (
	input [3:0]in,
	input [1:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[1:0])
		2'd0: out_r = in[0];
		2'd1: out_r = in[1];
		2'd2: out_r = in[2];
		2'd3: out_r = in[3];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux5 (
	input [4:0]in,
	input [2:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[2:0])
		3'd0: out_r = in[0];
		3'd1: out_r = in[1];
		3'd2: out_r = in[2];
		3'd3: out_r = in[3];
		3'd4: out_r = in[4];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux6 (
	input [5:0]in,
	input [2:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[2:0])
		3'd0: out_r = in[0];
		3'd1: out_r = in[1];
		3'd2: out_r = in[2];
		3'd3: out_r = in[3];
		3'd4: out_r = in[4];
		3'd5: out_r = in[5];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux7 (
	input [6:0]in,
	input [2:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[2:0])
		3'd0: out_r = in[0];
		3'd1: out_r = in[1];
		3'd2: out_r = in[2];
		3'd3: out_r = in[3];
		3'd4: out_r = in[4];
		3'd5: out_r = in[5];
		3'd6: out_r = in[6];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux8 (
	input [7:0]in,
	input [2:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
reg out_r;

always @ (*) begin
	case(config_in[2:0])
		3'd0: out_r = in[0];
		3'd1: out_r = in[1];
		3'd2: out_r = in[2];
		3'd3: out_r = in[3];
		3'd4: out_r = in[4];
		3'd5: out_r = in[5];
		3'd6: out_r = in[6];
		3'd7: out_r = in[7];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	out_mux = out_r;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux9 (
	input [8:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(1'b0), .I10(1'b0), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux10 (
	input [9:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(1'b0), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux11 (
	input [10:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux12 (
	input [11:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux13 (
	input [12:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux14 (
	input [13:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux15 (
	input [14:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux16 (
	input [15:0]in,
	input [5:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	out_mux = out_mux16_0;
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux17 (
	input [16:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	out_r = in[16];
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux18 (
	input [17:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux19 (
	input [18:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux20 (
	input [19:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		6'b001000: out_r = in[19];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux21 (
	input [20:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		6'b001000: out_r = in[19];
		6'b010001: out_r = in[20];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux22 (
	input [21:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		6'b001000: out_r = in[19];
		6'b010001: out_r = in[20];
		6'b010010: out_r = in[21];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux23 (
	input [22:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		6'b001000: out_r = in[19];
		6'b010001: out_r = in[20];
		6'b010010: out_r = in[21];
		6'b010100: out_r = in[22];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux24 (
	input [23:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[16];
		6'b000010: out_r = in[17];
		6'b000100: out_r = in[18];
		6'b001000: out_r = in[19];
		6'b010001: out_r = in[20];
		6'b010010: out_r = in[21];
		6'b010100: out_r = in[22];
		6'b011000: out_r = in[23];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[6:6])
		1'd0: out_mux = out_mux16_0;
		1'd1: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux25 (
	input [24:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(1'b0), .I10(1'b0), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux26 (
	input [25:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(1'b0), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux27 (
	input [26:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(1'b0), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux28 (
	input [27:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(1'b0), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux29 (
	input [28:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(1'b0), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux30 (
	input [29:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(1'b0), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux31 (
	input [30:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(1'b0), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux32 (
	input [31:0]in,
	input [6:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
end

always @ (*) begin
	case(config_in[6:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux33 (
	input [32:0]in,
	input [7:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
	out_r = in[32];
end

always @ (*) begin
	case(config_in[7:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		2'd2: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux34 (
	input [33:0]in,
	input [7:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[32];
		6'b000010: out_r = in[33];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[7:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		2'd2: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux35 (
	input [34:0]in,
	input [7:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[32];
		6'b000010: out_r = in[33];
		6'b000100: out_r = in[34];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[7:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		2'd2: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux36 (
	input [35:0]in,
	input [7:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[32];
		6'b000010: out_r = in[33];
		6'b000100: out_r = in[34];
		6'b001000: out_r = in[35];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[7:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		2'd2: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

module mux37 (
	input [36:0]in,
	input [7:0]config_in,
	input config_rst,
	output out
);

reg out_mux;
wire out_mux16_0;
NPASSMUX16 mux_0 (.I0(in[0]), .I1(in[1]), .I2(in[2]), .I3(in[3]), .I4(in[4]), .I5(in[5]), .I6(in[6]), .I7(in[7]), .I8(in[8]), .I9(in[9]), .I10(in[10]), .I11(in[11]), .I12(in[12]), .I13(in[13]), .I14(in[14]), .I15(in[15]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_0));

wire out_mux16_1;
NPASSMUX16 mux_1 (.I0(in[16]), .I1(in[17]), .I2(in[18]), .I3(in[19]), .I4(in[20]), .I5(in[21]), .I6(in[22]), .I7(in[23]), .I8(in[24]), .I9(in[25]), .I10(in[26]), .I11(in[27]), .I12(in[28]), .I13(in[29]), .I14(in[30]), .I15(in[31]), .S0(config_in[0]), .S1(config_in[1]), .S2(config_in[2]), .S3(config_in[3]), .S4(config_in[4]), .S5(config_in[5]), .O(out_mux16_1));

reg out_r;

always @ (*) begin
	case(config_in[5:0])
		6'b000001: out_r = in[32];
		6'b000010: out_r = in[33];
		6'b000100: out_r = in[34];
		6'b001000: out_r = in[35];
		6'b010001: out_r = in[36];
		default: out_r = 1'b1;
	endcase
end

always @ (*) begin
	case(config_in[7:6])
		2'd0: out_mux = out_mux16_0;
		2'd1: out_mux = out_mux16_1;
		2'd2: out_mux = out_r;
		default: out_mux = 1'b1;
	endcase
end

assign out = config_rst?1'b1:out_mux;

endmodule

