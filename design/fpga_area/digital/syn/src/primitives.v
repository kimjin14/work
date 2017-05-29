/////////////////////////////////////////////////////
/////////////////////// buf /////////////////////////
/////////////////////////////////////////////////////
module buffer_wire (
	input in,
	output out
);

assign out = in;

endmodule

/////////////////////////////////////////////////////
/////////////////////// fle /////////////////////////
/////////////////////////////////////////////////////
module fle (
	input [7:0]in,
	input [66:0]config_in,
	input config_reset,
	input clk,
	output [1:0]out
);

wire out_lut4_0;
wire out_lut4_1;
wire out_lut4_2;
wire out_lut4_3;

wire in_4;
wire in_5;

//assign in_4 = config_in[64]?in[2]:in[4];
//assign in_5 = config_in[64]?in[3]:in[5];

mux2_inner fracture_lut_in_4 ( .config_in(config_in[64]), .config_reset(1'b0), .in({in[4], in[2]}), .out(in_4) );
mux2_inner fracture_lut_in_5 ( .config_in(config_in[64]), .config_reset(1'b0), .in({in[5], in[3]}), .out(in_5) );

lut4 lut4_0 ( .config_in(config_in[15:0]), .config_reset(config_reset), .in(in[3:0]), .out(out_lut4_0) );
lut4 lut4_1 ( .config_in(config_in[31:16]), .config_reset(config_reset), .in(in[3:0]), .out(out_lut4_1) );
lut4 lut4_2 ( .config_in(config_in[47:32]), .config_reset(config_reset), .in({in_5, in_4, in[1:0]}), .out(out_lut4_2) );
lut4 lut4_3 ( .config_in(config_in[63:48]), .config_reset(config_reset), .in({in_5, in_4, in[1:0]}), .out(out_lut4_3) );

wire out_lut5_0;
wire out_lut5_1;
wire out_lut6;

mux2_inner lut5_0_0 ( .config_in(in[6]), .config_reset(config_reset), .in({out_lut4_1, out_lut4_0}), .out(out_lut5_0) ); //[6][3][2][1][0]
mux2_inner lut5_0_1 ( .config_in(in[6]), .config_reset(config_reset), .in({out_lut4_3, out_lut4_2}), .out(out_lut5_1) ); 
mux2_inner lut6 ( .config_in(in[7]), .config_reset(config_reset), .in({out_lut5_1, out_lut5_0}), .out(out_lut6) ); //[7][6][3][2][1][0]

wire out_lut_0;
wire out_lut_1;
wire out_ff_0;
wire out_ff_1;

mux2_inner fracture_lut ( .config_in(config_in[64]), .config_reset(config_reset), .in({out_lut5_0, out_lut6}), .out(out_lut_0) ); 
mux2_inner lut5_1 ( .config_in(in[7]), .config_reset(config_reset), .in({out_lut4_3, out_lut4_2}), .out(out_lut_1) ); //[7][5][4][1][0]

ff ff_0 ( .D(out_lut_0), .clk(clk), .Q(out_ff_0) );
ff ff_1 ( .D(out_lut_1), .clk(clk), .Q(out_ff_1) );

mux2_inner mux_bypass_0 ( .config_in(config_in[65]), .config_reset(config_reset), .in({out_ff_0, out_lut_0}), .out(out[0]) );
mux2_inner mux_bypass_1 ( .config_in(config_in[66]), .config_reset(config_reset), .in({out_ff_1, out_lut_1}), .out(out[1]) );

endmodule

/////////////////////////////////////////////////////
/////////////////////// lut /////////////////////////
/////////////////////////////////////////////////////
module lut4 ( input [15:0]config_in, input config_reset, input [3:0]in, output reg out );

wire [3:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3]};

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(in)
			4'd0: out = config_in[0];
			4'd1: out = config_in[1];
			4'd2: out = config_in[2];
			4'd3: out = config_in[3];
			4'd4: out = config_in[4];
			4'd5: out = config_in[5];
			4'd6: out = config_in[6];
			4'd7: out = config_in[7];
			4'd8: out = config_in[8];
			4'd9: out = config_in[9];
			4'd10: out = config_in[10];
			4'd11: out = config_in[11];
			4'd12: out = config_in[12];
			4'd13: out = config_in[13];
			4'd14: out = config_in[14];
			4'd15: out = config_in[15];
		endcase
	end
end

endmodule

module lut6 ( input [63:0]config_in, input config_reset, input [5:0]in, output reg out );

wire [5:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3], in[4], in[5]};

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(in)
			6'd0: out = config_in[0];
			6'd1: out = config_in[1];
			6'd2: out = config_in[2];
			6'd3: out = config_in[3];
			6'd4: out = config_in[4];
			6'd5: out = config_in[5];
			6'd6: out = config_in[6];
			6'd7: out = config_in[7];
			6'd8: out = config_in[8];
			6'd9: out = config_in[9];
			6'd10: out = config_in[10];
			6'd11: out = config_in[11];
			6'd12: out = config_in[12];
			6'd13: out = config_in[13];
			6'd14: out = config_in[14];
			6'd15: out = config_in[15];
			6'd16: out = config_in[16];
			6'd17: out = config_in[17];
			6'd18: out = config_in[18];
			6'd19: out = config_in[19];
			6'd20: out = config_in[20];
			6'd21: out = config_in[21];
			6'd22: out = config_in[22];
			6'd23: out = config_in[23];
			6'd24: out = config_in[24];
			6'd25: out = config_in[25];
			6'd26: out = config_in[26];
			6'd27: out = config_in[27];
			6'd28: out = config_in[28];
			6'd29: out = config_in[29];
			6'd30: out = config_in[30];
			6'd31: out = config_in[31];
			6'd32: out = config_in[32];
			6'd33: out = config_in[33];
			6'd34: out = config_in[34];
			6'd35: out = config_in[35];
			6'd36: out = config_in[36];
			6'd37: out = config_in[37];
			6'd38: out = config_in[38];
			6'd39: out = config_in[39];
			6'd40: out = config_in[40];
			6'd41: out = config_in[41];
			6'd42: out = config_in[42];
			6'd43: out = config_in[43];
			6'd44: out = config_in[44];
			6'd45: out = config_in[45];
			6'd46: out = config_in[46];
			6'd47: out = config_in[47];
			6'd48: out = config_in[48];
			6'd49: out = config_in[49];
			6'd50: out = config_in[50];
			6'd51: out = config_in[51];
			6'd52: out = config_in[52];
			6'd53: out = config_in[53];
			6'd54: out = config_in[54];
			6'd55: out = config_in[55];
			6'd56: out = config_in[56];
			6'd57: out = config_in[57];
			6'd58: out = config_in[58];
			6'd59: out = config_in[59];
			6'd60: out = config_in[60];
			6'd61: out = config_in[61];
			6'd62: out = config_in[62];
			6'd63: out = config_in[63];
		endcase
	end
end

endmodule


/////////////////////////////////////////////////////
///////////////////// latch /////////////////////////
/////////////////////////////////////////////////////
module latch ( input clk, input reset, input en, input in, output reg out );

always @ (posedge clk) begin
	if(!reset) begin
		out<=0;
	end
	else if (en) begin
		out<=in;
	end
end

endmodule

/////////////////////////////////////////////////////
///////////////////// ff /////////////////////////
/////////////////////////////////////////////////////
module ff ( input D, input clk, output reg Q );

always @ (posedge clk) begin
	Q <= D;
end

endmodule

/////////////////////////////////////////////////////
///////////////////// mux2_inner /////////////////////////
/////////////////////////////////////////////////////
module mux2_inner (
	input [1:0]in,
	input [0:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			1'd0: out = in[0];
			1'd1: out = in[1];
			default: out = 1'b1;
		endcase
	end
end

endmodule

