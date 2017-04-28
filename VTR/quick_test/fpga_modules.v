//////////////////////////////////
//physical block modules
//////////////////////////////////

/////////////////////////////////////////////////////
///////////////////// io /////////////////////////
/////////////////////////////////////////////////////
module io (
	output [7:0]outpad,
	output [7:0]inpad,
	inout [7:0]io_ext,
	input [7:0]config_in
);

assign io_ext[0] = config_in[0]?1'bz:outpad[0];
assign io_ext[1] = config_in[1]?1'bz:outpad[1];
assign io_ext[2] = config_in[2]?1'bz:outpad[2];
assign io_ext[3] = config_in[3]?1'bz:outpad[3];
assign io_ext[4] = config_in[4]?1'bz:outpad[4];
assign io_ext[5] = config_in[5]?1'bz:outpad[5];
assign io_ext[6] = config_in[6]?1'bz:outpad[6];
assign io_ext[7] = config_in[7]?1'bz:outpad[7];

assign inpad[0] = config_in[0]?io_ext[0]:1'bz;
assign inpad[1] = config_in[1]?io_ext[1]:1'bz;
assign inpad[2] = config_in[2]?io_ext[2]:1'bz;
assign inpad[3] = config_in[3]?io_ext[3]:1'bz;
assign inpad[4] = config_in[4]?io_ext[4]:1'bz;
assign inpad[5] = config_in[5]?io_ext[5]:1'bz;
assign inpad[6] = config_in[6]?io_ext[6]:1'bz;
assign inpad[7] = config_in[7]?io_ext[7]:1'bz;

endmodule

/////////////////////////////////////////////////////
///////////////////// lut6 /////////////////////////
/////////////////////////////////////////////////////
module lut6 ( input [63:0]config_in, input [5:0]in, output reg out );

wire [5:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3], in[4], in[5]};

always @ (*) begin: MUX
	case(in_flip)
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

endmodule

/////////////////////////////////////////////////////
///////////////////// soft_logic /////////////////////////
/////////////////////////////////////////////////////
module soft_logic (
	input [5:0]in,
	output [0:0]out,
	input [63:0]config_in
);

////////child (0,0,0)////////
wire [5:0]in_lut6_0;//input to child
wire [0:0]out_lut6_0;//output from child
 
wire ground;

assign in_lut6_0[0] = in[0];
assign in_lut6_0[1] = in[1];
assign in_lut6_0[2] = in[2];
assign in_lut6_0[3] = in[3];
assign in_lut6_0[4] = in[4];
assign in_lut6_0[5] = in[5];
 
lut6 lut6_0 ( .in(in_lut6_0), .out(out_lut6_0), .config_in(config_in[63:0]) ); //block instantiation

//child output to block output
assign out[0] = out_lut6_0[0];

assign ground = 1'b0;

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
///////////////////// ble /////////////////////////
/////////////////////////////////////////////////////
module ble (
	input [5:0]in,
	input [0:0]clk,
	output [0:0]out,
	input [64:0]config_in
);

////////child (0,0,0)////////
wire [5:0]in_soft_logic_0;//input to child
wire [0:0]out_soft_logic_0;//output from child
 
////////child (0,1,0)////////
wire [0:0]D_ff_0;//input to child
wire [0:0]clk_ff_0;//clock to child
wire [0:0]Q_ff_0;//output from child
 
wire ground;

assign in_soft_logic_0[0] = in[0];
assign in_soft_logic_0[1] = in[1];
assign in_soft_logic_0[2] = in[2];
assign in_soft_logic_0[3] = in[3];
assign in_soft_logic_0[4] = in[4];
assign in_soft_logic_0[5] = in[5];
 
soft_logic soft_logic_0 ( .in(in_soft_logic_0), .out(out_soft_logic_0), .config_in(config_in[63:0]) ); //block instantiation

assign D_ff_0[0] = out_soft_logic_0[0];
assign clk_ff_0[0] = clk[0];
 
ff ff_0 ( .clk(clk_ff_0), .D(D_ff_0), .Q(Q_ff_0) );

//child output to block output
mux2 mux_64 ( .in({Q_ff_0[0], out_soft_logic_0[0]}), .config_in(config_in[64:64]), .out(out[0]) );

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// clb /////////////////////////
/////////////////////////////////////////////////////
module clb (
	input [32:0]I,
	input [0:0]clk,
	output [9:0]O,
	input [1009:0]config_in
);

////////child (0,0,0)////////
wire [5:0]in_ble_0;//input to child
wire [0:0]clk_ble_0;//clock to child
wire [0:0]out_ble_0;//output from child
 
////////child (0,0,1)////////
wire [5:0]in_ble_1;//input to child
wire [0:0]clk_ble_1;//clock to child
wire [0:0]out_ble_1;//output from child
 
////////child (0,0,2)////////
wire [5:0]in_ble_2;//input to child
wire [0:0]clk_ble_2;//clock to child
wire [0:0]out_ble_2;//output from child
 
////////child (0,0,3)////////
wire [5:0]in_ble_3;//input to child
wire [0:0]clk_ble_3;//clock to child
wire [0:0]out_ble_3;//output from child
 
////////child (0,0,4)////////
wire [5:0]in_ble_4;//input to child
wire [0:0]clk_ble_4;//clock to child
wire [0:0]out_ble_4;//output from child
 
////////child (0,0,5)////////
wire [5:0]in_ble_5;//input to child
wire [0:0]clk_ble_5;//clock to child
wire [0:0]out_ble_5;//output from child
 
////////child (0,0,6)////////
wire [5:0]in_ble_6;//input to child
wire [0:0]clk_ble_6;//clock to child
wire [0:0]out_ble_6;//output from child
 
////////child (0,0,7)////////
wire [5:0]in_ble_7;//input to child
wire [0:0]clk_ble_7;//clock to child
wire [0:0]out_ble_7;//output from child
 
////////child (0,0,8)////////
wire [5:0]in_ble_8;//input to child
wire [0:0]clk_ble_8;//clock to child
wire [0:0]out_ble_8;//output from child
 
////////child (0,0,9)////////
wire [5:0]in_ble_9;//input to child
wire [0:0]clk_ble_9;//clock to child
wire [0:0]out_ble_9;//output from child
 
wire ground;

mux44 mux_0 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[5:0]), .out(in_ble_0[0]) );
mux44 mux_6 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[11:6]), .out(in_ble_0[1]) );
mux44 mux_12 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[17:12]), .out(in_ble_0[2]) );
mux44 mux_18 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[23:18]), .out(in_ble_0[3]) );
mux44 mux_24 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[29:24]), .out(in_ble_0[4]) );
mux44 mux_30 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[35:30]), .out(in_ble_0[5]) );
assign clk_ble_0[0] = clk[0];
 
ble ble_0 ( .clk(clk_ble_0), .in(in_ble_0), .out(out_ble_0), .config_in(config_in[100:36]) ); //block instantiation

mux44 mux_101 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[106:101]), .out(in_ble_1[0]) );
mux44 mux_107 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[112:107]), .out(in_ble_1[1]) );
mux44 mux_113 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[118:113]), .out(in_ble_1[2]) );
mux44 mux_119 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[124:119]), .out(in_ble_1[3]) );
mux44 mux_125 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[130:125]), .out(in_ble_1[4]) );
mux44 mux_131 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[136:131]), .out(in_ble_1[5]) );
assign clk_ble_1[0] = clk[0];
 
ble ble_1 ( .clk(clk_ble_1), .in(in_ble_1), .out(out_ble_1), .config_in(config_in[201:137]) ); //block instantiation

mux44 mux_202 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[207:202]), .out(in_ble_2[0]) );
mux44 mux_208 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[213:208]), .out(in_ble_2[1]) );
mux44 mux_214 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[219:214]), .out(in_ble_2[2]) );
mux44 mux_220 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[225:220]), .out(in_ble_2[3]) );
mux44 mux_226 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[231:226]), .out(in_ble_2[4]) );
mux44 mux_232 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[237:232]), .out(in_ble_2[5]) );
assign clk_ble_2[0] = clk[0];
 
ble ble_2 ( .clk(clk_ble_2), .in(in_ble_2), .out(out_ble_2), .config_in(config_in[302:238]) ); //block instantiation

mux44 mux_303 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[308:303]), .out(in_ble_3[0]) );
mux44 mux_309 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[314:309]), .out(in_ble_3[1]) );
mux44 mux_315 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[320:315]), .out(in_ble_3[2]) );
mux44 mux_321 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[326:321]), .out(in_ble_3[3]) );
mux44 mux_327 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[332:327]), .out(in_ble_3[4]) );
mux44 mux_333 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[338:333]), .out(in_ble_3[5]) );
assign clk_ble_3[0] = clk[0];
 
ble ble_3 ( .clk(clk_ble_3), .in(in_ble_3), .out(out_ble_3), .config_in(config_in[403:339]) ); //block instantiation

mux44 mux_404 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[409:404]), .out(in_ble_4[0]) );
mux44 mux_410 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[415:410]), .out(in_ble_4[1]) );
mux44 mux_416 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[421:416]), .out(in_ble_4[2]) );
mux44 mux_422 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[427:422]), .out(in_ble_4[3]) );
mux44 mux_428 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[433:428]), .out(in_ble_4[4]) );
mux44 mux_434 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[439:434]), .out(in_ble_4[5]) );
assign clk_ble_4[0] = clk[0];
 
ble ble_4 ( .clk(clk_ble_4), .in(in_ble_4), .out(out_ble_4), .config_in(config_in[504:440]) ); //block instantiation

mux44 mux_505 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[510:505]), .out(in_ble_5[0]) );
mux44 mux_511 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[516:511]), .out(in_ble_5[1]) );
mux44 mux_517 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[522:517]), .out(in_ble_5[2]) );
mux44 mux_523 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[528:523]), .out(in_ble_5[3]) );
mux44 mux_529 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[534:529]), .out(in_ble_5[4]) );
mux44 mux_535 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[540:535]), .out(in_ble_5[5]) );
assign clk_ble_5[0] = clk[0];
 
ble ble_5 ( .clk(clk_ble_5), .in(in_ble_5), .out(out_ble_5), .config_in(config_in[605:541]) ); //block instantiation

mux44 mux_606 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[611:606]), .out(in_ble_6[0]) );
mux44 mux_612 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[617:612]), .out(in_ble_6[1]) );
mux44 mux_618 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[623:618]), .out(in_ble_6[2]) );
mux44 mux_624 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[629:624]), .out(in_ble_6[3]) );
mux44 mux_630 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[635:630]), .out(in_ble_6[4]) );
mux44 mux_636 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[641:636]), .out(in_ble_6[5]) );
assign clk_ble_6[0] = clk[0];
 
ble ble_6 ( .clk(clk_ble_6), .in(in_ble_6), .out(out_ble_6), .config_in(config_in[706:642]) ); //block instantiation

mux44 mux_707 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[712:707]), .out(in_ble_7[0]) );
mux44 mux_713 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[718:713]), .out(in_ble_7[1]) );
mux44 mux_719 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[724:719]), .out(in_ble_7[2]) );
mux44 mux_725 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[730:725]), .out(in_ble_7[3]) );
mux44 mux_731 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[736:731]), .out(in_ble_7[4]) );
mux44 mux_737 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[742:737]), .out(in_ble_7[5]) );
assign clk_ble_7[0] = clk[0];
 
ble ble_7 ( .clk(clk_ble_7), .in(in_ble_7), .out(out_ble_7), .config_in(config_in[807:743]) ); //block instantiation

mux44 mux_808 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[813:808]), .out(in_ble_8[0]) );
mux44 mux_814 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[819:814]), .out(in_ble_8[1]) );
mux44 mux_820 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[825:820]), .out(in_ble_8[2]) );
mux44 mux_826 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[831:826]), .out(in_ble_8[3]) );
mux44 mux_832 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[837:832]), .out(in_ble_8[4]) );
mux44 mux_838 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[843:838]), .out(in_ble_8[5]) );
assign clk_ble_8[0] = clk[0];
 
ble ble_8 ( .clk(clk_ble_8), .in(in_ble_8), .out(out_ble_8), .config_in(config_in[908:844]) ); //block instantiation

mux44 mux_909 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[914:909]), .out(in_ble_9[0]) );
mux44 mux_915 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[920:915]), .out(in_ble_9[1]) );
mux44 mux_921 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[926:921]), .out(in_ble_9[2]) );
mux44 mux_927 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[932:927]), .out(in_ble_9[3]) );
mux44 mux_933 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[938:933]), .out(in_ble_9[4]) );
mux44 mux_939 ( .in({I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], out_ble_0[0], out_ble_1[0], out_ble_2[0], out_ble_3[0], out_ble_4[0], out_ble_5[0], out_ble_6[0], out_ble_7[0], out_ble_8[0], out_ble_9[0], ground}), .config_in(config_in[944:939]), .out(in_ble_9[5]) );
assign clk_ble_9[0] = clk[0];
 
ble ble_9 ( .clk(clk_ble_9), .in(in_ble_9), .out(out_ble_9), .config_in(config_in[1009:945]) ); //block instantiation

//child output to block output
assign O[0] = out_ble_0[0];
assign O[1] = out_ble_1[0];
assign O[2] = out_ble_2[0];
assign O[3] = out_ble_3[0];
assign O[4] = out_ble_4[0];
assign O[5] = out_ble_5[0];
assign O[6] = out_ble_6[0];
assign O[7] = out_ble_7[0];
assign O[8] = out_ble_8[0];
assign O[9] = out_ble_9[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_9x9 /////////////////////////
/////////////////////////////////////////////////////
module mult_9x9 (
	input [8:0]a,
	input [8:0]b,
	output [17:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_9x9_slice /////////////////////////
/////////////////////////////////////////////////////
module mult_9x9_slice (
	input [8:0]A_cfg,
	input [8:0]B_cfg,
	output [17:0]OUT_cfg
);

////////child (0,0,0)////////
wire [8:0]a_mult_9x9_0;//input to child
wire [8:0]b_mult_9x9_0;//input to child
wire [17:0]out_mult_9x9_0;//output from child
 
wire ground;

assign a_mult_9x9_0[0] = A_cfg[0];
assign a_mult_9x9_0[1] = A_cfg[1];
assign a_mult_9x9_0[2] = A_cfg[2];
assign a_mult_9x9_0[3] = A_cfg[3];
assign a_mult_9x9_0[4] = A_cfg[4];
assign a_mult_9x9_0[5] = A_cfg[5];
assign a_mult_9x9_0[6] = A_cfg[6];
assign a_mult_9x9_0[7] = A_cfg[7];
assign a_mult_9x9_0[8] = A_cfg[8];
assign b_mult_9x9_0[0] = B_cfg[0];
assign b_mult_9x9_0[1] = B_cfg[1];
assign b_mult_9x9_0[2] = B_cfg[2];
assign b_mult_9x9_0[3] = B_cfg[3];
assign b_mult_9x9_0[4] = B_cfg[4];
assign b_mult_9x9_0[5] = B_cfg[5];
assign b_mult_9x9_0[6] = B_cfg[6];
assign b_mult_9x9_0[7] = B_cfg[7];
assign b_mult_9x9_0[8] = B_cfg[8];
 
mult_9x9 mult_9x9_0 ( .a(a_mult_9x9_0), .b(b_mult_9x9_0), .out(out_mult_9x9_0) );

//child output to block output
assign OUT_cfg[0] = out_mult_9x9_0[0];
assign OUT_cfg[1] = out_mult_9x9_0[1];
assign OUT_cfg[2] = out_mult_9x9_0[2];
assign OUT_cfg[3] = out_mult_9x9_0[3];
assign OUT_cfg[4] = out_mult_9x9_0[4];
assign OUT_cfg[5] = out_mult_9x9_0[5];
assign OUT_cfg[6] = out_mult_9x9_0[6];
assign OUT_cfg[7] = out_mult_9x9_0[7];
assign OUT_cfg[8] = out_mult_9x9_0[8];
assign OUT_cfg[9] = out_mult_9x9_0[9];
assign OUT_cfg[10] = out_mult_9x9_0[10];
assign OUT_cfg[11] = out_mult_9x9_0[11];
assign OUT_cfg[12] = out_mult_9x9_0[12];
assign OUT_cfg[13] = out_mult_9x9_0[13];
assign OUT_cfg[14] = out_mult_9x9_0[14];
assign OUT_cfg[15] = out_mult_9x9_0[15];
assign OUT_cfg[16] = out_mult_9x9_0[16];
assign OUT_cfg[17] = out_mult_9x9_0[17];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_18x18 /////////////////////////
/////////////////////////////////////////////////////
module mult_18x18 (
	input [17:0]a,
	input [17:0]b,
	output [35:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_18x18_slice /////////////////////////
/////////////////////////////////////////////////////
module mult_18x18_slice (
	input [17:0]A_cfg,
	input [17:0]B_cfg,
	output [35:0]OUT_cfg
);

////////child (0,0,0)////////
wire [17:0]a_mult_18x18_0;//input to child
wire [17:0]b_mult_18x18_0;//input to child
wire [35:0]out_mult_18x18_0;//output from child
 
wire ground;

assign a_mult_18x18_0[0] = A_cfg[0];
assign a_mult_18x18_0[1] = A_cfg[1];
assign a_mult_18x18_0[2] = A_cfg[2];
assign a_mult_18x18_0[3] = A_cfg[3];
assign a_mult_18x18_0[4] = A_cfg[4];
assign a_mult_18x18_0[5] = A_cfg[5];
assign a_mult_18x18_0[6] = A_cfg[6];
assign a_mult_18x18_0[7] = A_cfg[7];
assign a_mult_18x18_0[8] = A_cfg[8];
assign a_mult_18x18_0[9] = A_cfg[9];
assign a_mult_18x18_0[10] = A_cfg[10];
assign a_mult_18x18_0[11] = A_cfg[11];
assign a_mult_18x18_0[12] = A_cfg[12];
assign a_mult_18x18_0[13] = A_cfg[13];
assign a_mult_18x18_0[14] = A_cfg[14];
assign a_mult_18x18_0[15] = A_cfg[15];
assign a_mult_18x18_0[16] = A_cfg[16];
assign a_mult_18x18_0[17] = A_cfg[17];
assign b_mult_18x18_0[0] = B_cfg[0];
assign b_mult_18x18_0[1] = B_cfg[1];
assign b_mult_18x18_0[2] = B_cfg[2];
assign b_mult_18x18_0[3] = B_cfg[3];
assign b_mult_18x18_0[4] = B_cfg[4];
assign b_mult_18x18_0[5] = B_cfg[5];
assign b_mult_18x18_0[6] = B_cfg[6];
assign b_mult_18x18_0[7] = B_cfg[7];
assign b_mult_18x18_0[8] = B_cfg[8];
assign b_mult_18x18_0[9] = B_cfg[9];
assign b_mult_18x18_0[10] = B_cfg[10];
assign b_mult_18x18_0[11] = B_cfg[11];
assign b_mult_18x18_0[12] = B_cfg[12];
assign b_mult_18x18_0[13] = B_cfg[13];
assign b_mult_18x18_0[14] = B_cfg[14];
assign b_mult_18x18_0[15] = B_cfg[15];
assign b_mult_18x18_0[16] = B_cfg[16];
assign b_mult_18x18_0[17] = B_cfg[17];
 
mult_18x18 mult_18x18_0 ( .a(a_mult_18x18_0), .b(b_mult_18x18_0), .out(out_mult_18x18_0) );

//child output to block output
assign OUT_cfg[0] = out_mult_18x18_0[0];
assign OUT_cfg[1] = out_mult_18x18_0[1];
assign OUT_cfg[2] = out_mult_18x18_0[2];
assign OUT_cfg[3] = out_mult_18x18_0[3];
assign OUT_cfg[4] = out_mult_18x18_0[4];
assign OUT_cfg[5] = out_mult_18x18_0[5];
assign OUT_cfg[6] = out_mult_18x18_0[6];
assign OUT_cfg[7] = out_mult_18x18_0[7];
assign OUT_cfg[8] = out_mult_18x18_0[8];
assign OUT_cfg[9] = out_mult_18x18_0[9];
assign OUT_cfg[10] = out_mult_18x18_0[10];
assign OUT_cfg[11] = out_mult_18x18_0[11];
assign OUT_cfg[12] = out_mult_18x18_0[12];
assign OUT_cfg[13] = out_mult_18x18_0[13];
assign OUT_cfg[14] = out_mult_18x18_0[14];
assign OUT_cfg[15] = out_mult_18x18_0[15];
assign OUT_cfg[16] = out_mult_18x18_0[16];
assign OUT_cfg[17] = out_mult_18x18_0[17];
assign OUT_cfg[18] = out_mult_18x18_0[18];
assign OUT_cfg[19] = out_mult_18x18_0[19];
assign OUT_cfg[20] = out_mult_18x18_0[20];
assign OUT_cfg[21] = out_mult_18x18_0[21];
assign OUT_cfg[22] = out_mult_18x18_0[22];
assign OUT_cfg[23] = out_mult_18x18_0[23];
assign OUT_cfg[24] = out_mult_18x18_0[24];
assign OUT_cfg[25] = out_mult_18x18_0[25];
assign OUT_cfg[26] = out_mult_18x18_0[26];
assign OUT_cfg[27] = out_mult_18x18_0[27];
assign OUT_cfg[28] = out_mult_18x18_0[28];
assign OUT_cfg[29] = out_mult_18x18_0[29];
assign OUT_cfg[30] = out_mult_18x18_0[30];
assign OUT_cfg[31] = out_mult_18x18_0[31];
assign OUT_cfg[32] = out_mult_18x18_0[32];
assign OUT_cfg[33] = out_mult_18x18_0[33];
assign OUT_cfg[34] = out_mult_18x18_0[34];
assign OUT_cfg[35] = out_mult_18x18_0[35];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// divisible_mult_18x18 /////////////////////////
/////////////////////////////////////////////////////
module divisible_mult_18x18 (
	input [17:0]a,
	input [17:0]b,
	output [35:0]out,
	input [35:0]config_in
);

////////child (0,0,0)////////
wire [8:0]A_cfg_mult_9x9_slice_0;//input to child
wire [8:0]B_cfg_mult_9x9_slice_0;//input to child
wire [17:0]OUT_cfg_mult_9x9_slice_0;//output from child
 
////////child (0,0,1)////////
wire [8:0]A_cfg_mult_9x9_slice_1;//input to child
wire [8:0]B_cfg_mult_9x9_slice_1;//input to child
wire [17:0]OUT_cfg_mult_9x9_slice_1;//output from child
 
////////child (1,0,0)////////
wire [17:0]A_cfg_mult_18x18_slice_0;//input to child
wire [17:0]B_cfg_mult_18x18_slice_0;//input to child
wire [35:0]OUT_cfg_mult_18x18_slice_0;//output from child
 
wire ground;

assign A_cfg_mult_9x9_slice_0[0] = a[0];
assign A_cfg_mult_9x9_slice_0[1] = a[1];
assign A_cfg_mult_9x9_slice_0[2] = a[2];
assign A_cfg_mult_9x9_slice_0[3] = a[3];
assign A_cfg_mult_9x9_slice_0[4] = a[4];
assign A_cfg_mult_9x9_slice_0[5] = a[5];
assign A_cfg_mult_9x9_slice_0[6] = a[6];
assign A_cfg_mult_9x9_slice_0[7] = a[7];
assign A_cfg_mult_9x9_slice_0[8] = a[8];
assign B_cfg_mult_9x9_slice_0[0] = b[0];
assign B_cfg_mult_9x9_slice_0[1] = b[1];
assign B_cfg_mult_9x9_slice_0[2] = b[2];
assign B_cfg_mult_9x9_slice_0[3] = b[3];
assign B_cfg_mult_9x9_slice_0[4] = b[4];
assign B_cfg_mult_9x9_slice_0[5] = b[5];
assign B_cfg_mult_9x9_slice_0[6] = b[6];
assign B_cfg_mult_9x9_slice_0[7] = b[7];
assign B_cfg_mult_9x9_slice_0[8] = b[8];
 
mult_9x9_slice mult_9x9_slice_0 ( .A_cfg(A_cfg_mult_9x9_slice_0), .B_cfg(B_cfg_mult_9x9_slice_0), .OUT_cfg(OUT_cfg_mult_9x9_slice_0) );

assign A_cfg_mult_9x9_slice_1[0] = a[9];
assign A_cfg_mult_9x9_slice_1[1] = a[10];
assign A_cfg_mult_9x9_slice_1[2] = a[11];
assign A_cfg_mult_9x9_slice_1[3] = a[12];
assign A_cfg_mult_9x9_slice_1[4] = a[13];
assign A_cfg_mult_9x9_slice_1[5] = a[14];
assign A_cfg_mult_9x9_slice_1[6] = a[15];
assign A_cfg_mult_9x9_slice_1[7] = a[16];
assign A_cfg_mult_9x9_slice_1[8] = a[17];
assign B_cfg_mult_9x9_slice_1[0] = b[9];
assign B_cfg_mult_9x9_slice_1[1] = b[10];
assign B_cfg_mult_9x9_slice_1[2] = b[11];
assign B_cfg_mult_9x9_slice_1[3] = b[12];
assign B_cfg_mult_9x9_slice_1[4] = b[13];
assign B_cfg_mult_9x9_slice_1[5] = b[14];
assign B_cfg_mult_9x9_slice_1[6] = b[15];
assign B_cfg_mult_9x9_slice_1[7] = b[16];
assign B_cfg_mult_9x9_slice_1[8] = b[17];
 
mult_9x9_slice mult_9x9_slice_1 ( .A_cfg(A_cfg_mult_9x9_slice_1), .B_cfg(B_cfg_mult_9x9_slice_1), .OUT_cfg(OUT_cfg_mult_9x9_slice_1) );

assign A_cfg_mult_18x18_slice_0[0] = a[0];
assign A_cfg_mult_18x18_slice_0[1] = a[1];
assign A_cfg_mult_18x18_slice_0[2] = a[2];
assign A_cfg_mult_18x18_slice_0[3] = a[3];
assign A_cfg_mult_18x18_slice_0[4] = a[4];
assign A_cfg_mult_18x18_slice_0[5] = a[5];
assign A_cfg_mult_18x18_slice_0[6] = a[6];
assign A_cfg_mult_18x18_slice_0[7] = a[7];
assign A_cfg_mult_18x18_slice_0[8] = a[8];
assign A_cfg_mult_18x18_slice_0[9] = a[9];
assign A_cfg_mult_18x18_slice_0[10] = a[10];
assign A_cfg_mult_18x18_slice_0[11] = a[11];
assign A_cfg_mult_18x18_slice_0[12] = a[12];
assign A_cfg_mult_18x18_slice_0[13] = a[13];
assign A_cfg_mult_18x18_slice_0[14] = a[14];
assign A_cfg_mult_18x18_slice_0[15] = a[15];
assign A_cfg_mult_18x18_slice_0[16] = a[16];
assign A_cfg_mult_18x18_slice_0[17] = a[17];
assign B_cfg_mult_18x18_slice_0[0] = b[0];
assign B_cfg_mult_18x18_slice_0[1] = b[1];
assign B_cfg_mult_18x18_slice_0[2] = b[2];
assign B_cfg_mult_18x18_slice_0[3] = b[3];
assign B_cfg_mult_18x18_slice_0[4] = b[4];
assign B_cfg_mult_18x18_slice_0[5] = b[5];
assign B_cfg_mult_18x18_slice_0[6] = b[6];
assign B_cfg_mult_18x18_slice_0[7] = b[7];
assign B_cfg_mult_18x18_slice_0[8] = b[8];
assign B_cfg_mult_18x18_slice_0[9] = b[9];
assign B_cfg_mult_18x18_slice_0[10] = b[10];
assign B_cfg_mult_18x18_slice_0[11] = b[11];
assign B_cfg_mult_18x18_slice_0[12] = b[12];
assign B_cfg_mult_18x18_slice_0[13] = b[13];
assign B_cfg_mult_18x18_slice_0[14] = b[14];
assign B_cfg_mult_18x18_slice_0[15] = b[15];
assign B_cfg_mult_18x18_slice_0[16] = b[16];
assign B_cfg_mult_18x18_slice_0[17] = b[17];
 
mult_18x18_slice mult_18x18_slice_0 ( .A_cfg(A_cfg_mult_18x18_slice_0), .B_cfg(B_cfg_mult_18x18_slice_0), .OUT_cfg(OUT_cfg_mult_18x18_slice_0) );

//child output to block output
mux2 mux_0 ( .in({OUT_cfg_mult_9x9_slice_0[0], OUT_cfg_mult_18x18_slice_0[0]}), .config_in(config_in[0:0]), .out(out[0]) );
mux2 mux_1 ( .in({OUT_cfg_mult_9x9_slice_0[1], OUT_cfg_mult_18x18_slice_0[1]}), .config_in(config_in[1:1]), .out(out[1]) );
mux2 mux_2 ( .in({OUT_cfg_mult_9x9_slice_0[2], OUT_cfg_mult_18x18_slice_0[2]}), .config_in(config_in[2:2]), .out(out[2]) );
mux2 mux_3 ( .in({OUT_cfg_mult_9x9_slice_0[3], OUT_cfg_mult_18x18_slice_0[3]}), .config_in(config_in[3:3]), .out(out[3]) );
mux2 mux_4 ( .in({OUT_cfg_mult_9x9_slice_0[4], OUT_cfg_mult_18x18_slice_0[4]}), .config_in(config_in[4:4]), .out(out[4]) );
mux2 mux_5 ( .in({OUT_cfg_mult_9x9_slice_0[5], OUT_cfg_mult_18x18_slice_0[5]}), .config_in(config_in[5:5]), .out(out[5]) );
mux2 mux_6 ( .in({OUT_cfg_mult_9x9_slice_0[6], OUT_cfg_mult_18x18_slice_0[6]}), .config_in(config_in[6:6]), .out(out[6]) );
mux2 mux_7 ( .in({OUT_cfg_mult_9x9_slice_0[7], OUT_cfg_mult_18x18_slice_0[7]}), .config_in(config_in[7:7]), .out(out[7]) );
mux2 mux_8 ( .in({OUT_cfg_mult_9x9_slice_0[8], OUT_cfg_mult_18x18_slice_0[8]}), .config_in(config_in[8:8]), .out(out[8]) );
mux2 mux_9 ( .in({OUT_cfg_mult_9x9_slice_0[9], OUT_cfg_mult_18x18_slice_0[9]}), .config_in(config_in[9:9]), .out(out[9]) );
mux2 mux_10 ( .in({OUT_cfg_mult_9x9_slice_0[10], OUT_cfg_mult_18x18_slice_0[10]}), .config_in(config_in[10:10]), .out(out[10]) );
mux2 mux_11 ( .in({OUT_cfg_mult_9x9_slice_0[11], OUT_cfg_mult_18x18_slice_0[11]}), .config_in(config_in[11:11]), .out(out[11]) );
mux2 mux_12 ( .in({OUT_cfg_mult_9x9_slice_0[12], OUT_cfg_mult_18x18_slice_0[12]}), .config_in(config_in[12:12]), .out(out[12]) );
mux2 mux_13 ( .in({OUT_cfg_mult_9x9_slice_0[13], OUT_cfg_mult_18x18_slice_0[13]}), .config_in(config_in[13:13]), .out(out[13]) );
mux2 mux_14 ( .in({OUT_cfg_mult_9x9_slice_0[14], OUT_cfg_mult_18x18_slice_0[14]}), .config_in(config_in[14:14]), .out(out[14]) );
mux2 mux_15 ( .in({OUT_cfg_mult_9x9_slice_0[15], OUT_cfg_mult_18x18_slice_0[15]}), .config_in(config_in[15:15]), .out(out[15]) );
mux2 mux_16 ( .in({OUT_cfg_mult_9x9_slice_0[16], OUT_cfg_mult_18x18_slice_0[16]}), .config_in(config_in[16:16]), .out(out[16]) );
mux2 mux_17 ( .in({OUT_cfg_mult_9x9_slice_0[17], OUT_cfg_mult_18x18_slice_0[17]}), .config_in(config_in[17:17]), .out(out[17]) );
mux2 mux_18 ( .in({OUT_cfg_mult_9x9_slice_1[0], OUT_cfg_mult_18x18_slice_0[18]}), .config_in(config_in[18:18]), .out(out[18]) );
mux2 mux_19 ( .in({OUT_cfg_mult_9x9_slice_1[1], OUT_cfg_mult_18x18_slice_0[19]}), .config_in(config_in[19:19]), .out(out[19]) );
mux2 mux_20 ( .in({OUT_cfg_mult_9x9_slice_1[2], OUT_cfg_mult_18x18_slice_0[20]}), .config_in(config_in[20:20]), .out(out[20]) );
mux2 mux_21 ( .in({OUT_cfg_mult_9x9_slice_1[3], OUT_cfg_mult_18x18_slice_0[21]}), .config_in(config_in[21:21]), .out(out[21]) );
mux2 mux_22 ( .in({OUT_cfg_mult_9x9_slice_1[4], OUT_cfg_mult_18x18_slice_0[22]}), .config_in(config_in[22:22]), .out(out[22]) );
mux2 mux_23 ( .in({OUT_cfg_mult_9x9_slice_1[5], OUT_cfg_mult_18x18_slice_0[23]}), .config_in(config_in[23:23]), .out(out[23]) );
mux2 mux_24 ( .in({OUT_cfg_mult_9x9_slice_1[6], OUT_cfg_mult_18x18_slice_0[24]}), .config_in(config_in[24:24]), .out(out[24]) );
mux2 mux_25 ( .in({OUT_cfg_mult_9x9_slice_1[7], OUT_cfg_mult_18x18_slice_0[25]}), .config_in(config_in[25:25]), .out(out[25]) );
mux2 mux_26 ( .in({OUT_cfg_mult_9x9_slice_1[8], OUT_cfg_mult_18x18_slice_0[26]}), .config_in(config_in[26:26]), .out(out[26]) );
mux2 mux_27 ( .in({OUT_cfg_mult_9x9_slice_1[9], OUT_cfg_mult_18x18_slice_0[27]}), .config_in(config_in[27:27]), .out(out[27]) );
mux2 mux_28 ( .in({OUT_cfg_mult_9x9_slice_1[10], OUT_cfg_mult_18x18_slice_0[28]}), .config_in(config_in[28:28]), .out(out[28]) );
mux2 mux_29 ( .in({OUT_cfg_mult_9x9_slice_1[11], OUT_cfg_mult_18x18_slice_0[29]}), .config_in(config_in[29:29]), .out(out[29]) );
mux2 mux_30 ( .in({OUT_cfg_mult_9x9_slice_1[12], OUT_cfg_mult_18x18_slice_0[30]}), .config_in(config_in[30:30]), .out(out[30]) );
mux2 mux_31 ( .in({OUT_cfg_mult_9x9_slice_1[13], OUT_cfg_mult_18x18_slice_0[31]}), .config_in(config_in[31:31]), .out(out[31]) );
mux2 mux_32 ( .in({OUT_cfg_mult_9x9_slice_1[14], OUT_cfg_mult_18x18_slice_0[32]}), .config_in(config_in[32:32]), .out(out[32]) );
mux2 mux_33 ( .in({OUT_cfg_mult_9x9_slice_1[15], OUT_cfg_mult_18x18_slice_0[33]}), .config_in(config_in[33:33]), .out(out[33]) );
mux2 mux_34 ( .in({OUT_cfg_mult_9x9_slice_1[16], OUT_cfg_mult_18x18_slice_0[34]}), .config_in(config_in[34:34]), .out(out[34]) );
mux2 mux_35 ( .in({OUT_cfg_mult_9x9_slice_1[17], OUT_cfg_mult_18x18_slice_0[35]}), .config_in(config_in[35:35]), .out(out[35]) );

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_36x36 /////////////////////////
/////////////////////////////////////////////////////
module mult_36x36 (
	input [35:0]a,
	input [35:0]b,
	output [71:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_36x36_slice /////////////////////////
/////////////////////////////////////////////////////
module mult_36x36_slice (
	input [35:0]A_cfg,
	input [35:0]B_cfg,
	output [71:0]OUT_cfg
);

////////child (0,0,0)////////
wire [35:0]a_mult_36x36_0;//input to child
wire [35:0]b_mult_36x36_0;//input to child
wire [71:0]out_mult_36x36_0;//output from child
 
wire ground;

assign a_mult_36x36_0[0] = A_cfg[0];
assign a_mult_36x36_0[1] = A_cfg[1];
assign a_mult_36x36_0[2] = A_cfg[2];
assign a_mult_36x36_0[3] = A_cfg[3];
assign a_mult_36x36_0[4] = A_cfg[4];
assign a_mult_36x36_0[5] = A_cfg[5];
assign a_mult_36x36_0[6] = A_cfg[6];
assign a_mult_36x36_0[7] = A_cfg[7];
assign a_mult_36x36_0[8] = A_cfg[8];
assign a_mult_36x36_0[9] = A_cfg[9];
assign a_mult_36x36_0[10] = A_cfg[10];
assign a_mult_36x36_0[11] = A_cfg[11];
assign a_mult_36x36_0[12] = A_cfg[12];
assign a_mult_36x36_0[13] = A_cfg[13];
assign a_mult_36x36_0[14] = A_cfg[14];
assign a_mult_36x36_0[15] = A_cfg[15];
assign a_mult_36x36_0[16] = A_cfg[16];
assign a_mult_36x36_0[17] = A_cfg[17];
assign a_mult_36x36_0[18] = A_cfg[18];
assign a_mult_36x36_0[19] = A_cfg[19];
assign a_mult_36x36_0[20] = A_cfg[20];
assign a_mult_36x36_0[21] = A_cfg[21];
assign a_mult_36x36_0[22] = A_cfg[22];
assign a_mult_36x36_0[23] = A_cfg[23];
assign a_mult_36x36_0[24] = A_cfg[24];
assign a_mult_36x36_0[25] = A_cfg[25];
assign a_mult_36x36_0[26] = A_cfg[26];
assign a_mult_36x36_0[27] = A_cfg[27];
assign a_mult_36x36_0[28] = A_cfg[28];
assign a_mult_36x36_0[29] = A_cfg[29];
assign a_mult_36x36_0[30] = A_cfg[30];
assign a_mult_36x36_0[31] = A_cfg[31];
assign a_mult_36x36_0[32] = A_cfg[32];
assign a_mult_36x36_0[33] = A_cfg[33];
assign a_mult_36x36_0[34] = A_cfg[34];
assign a_mult_36x36_0[35] = A_cfg[35];
assign b_mult_36x36_0[0] = B_cfg[0];
assign b_mult_36x36_0[1] = B_cfg[1];
assign b_mult_36x36_0[2] = B_cfg[2];
assign b_mult_36x36_0[3] = B_cfg[3];
assign b_mult_36x36_0[4] = B_cfg[4];
assign b_mult_36x36_0[5] = B_cfg[5];
assign b_mult_36x36_0[6] = B_cfg[6];
assign b_mult_36x36_0[7] = B_cfg[7];
assign b_mult_36x36_0[8] = B_cfg[8];
assign b_mult_36x36_0[9] = B_cfg[9];
assign b_mult_36x36_0[10] = B_cfg[10];
assign b_mult_36x36_0[11] = B_cfg[11];
assign b_mult_36x36_0[12] = B_cfg[12];
assign b_mult_36x36_0[13] = B_cfg[13];
assign b_mult_36x36_0[14] = B_cfg[14];
assign b_mult_36x36_0[15] = B_cfg[15];
assign b_mult_36x36_0[16] = B_cfg[16];
assign b_mult_36x36_0[17] = B_cfg[17];
assign b_mult_36x36_0[18] = B_cfg[18];
assign b_mult_36x36_0[19] = B_cfg[19];
assign b_mult_36x36_0[20] = B_cfg[20];
assign b_mult_36x36_0[21] = B_cfg[21];
assign b_mult_36x36_0[22] = B_cfg[22];
assign b_mult_36x36_0[23] = B_cfg[23];
assign b_mult_36x36_0[24] = B_cfg[24];
assign b_mult_36x36_0[25] = B_cfg[25];
assign b_mult_36x36_0[26] = B_cfg[26];
assign b_mult_36x36_0[27] = B_cfg[27];
assign b_mult_36x36_0[28] = B_cfg[28];
assign b_mult_36x36_0[29] = B_cfg[29];
assign b_mult_36x36_0[30] = B_cfg[30];
assign b_mult_36x36_0[31] = B_cfg[31];
assign b_mult_36x36_0[32] = B_cfg[32];
assign b_mult_36x36_0[33] = B_cfg[33];
assign b_mult_36x36_0[34] = B_cfg[34];
assign b_mult_36x36_0[35] = B_cfg[35];
 
mult_36x36 mult_36x36_0 ( .a(a_mult_36x36_0), .b(b_mult_36x36_0), .out(out_mult_36x36_0) );

//child output to block output
assign OUT_cfg[0] = out_mult_36x36_0[0];
assign OUT_cfg[1] = out_mult_36x36_0[1];
assign OUT_cfg[2] = out_mult_36x36_0[2];
assign OUT_cfg[3] = out_mult_36x36_0[3];
assign OUT_cfg[4] = out_mult_36x36_0[4];
assign OUT_cfg[5] = out_mult_36x36_0[5];
assign OUT_cfg[6] = out_mult_36x36_0[6];
assign OUT_cfg[7] = out_mult_36x36_0[7];
assign OUT_cfg[8] = out_mult_36x36_0[8];
assign OUT_cfg[9] = out_mult_36x36_0[9];
assign OUT_cfg[10] = out_mult_36x36_0[10];
assign OUT_cfg[11] = out_mult_36x36_0[11];
assign OUT_cfg[12] = out_mult_36x36_0[12];
assign OUT_cfg[13] = out_mult_36x36_0[13];
assign OUT_cfg[14] = out_mult_36x36_0[14];
assign OUT_cfg[15] = out_mult_36x36_0[15];
assign OUT_cfg[16] = out_mult_36x36_0[16];
assign OUT_cfg[17] = out_mult_36x36_0[17];
assign OUT_cfg[18] = out_mult_36x36_0[18];
assign OUT_cfg[19] = out_mult_36x36_0[19];
assign OUT_cfg[20] = out_mult_36x36_0[20];
assign OUT_cfg[21] = out_mult_36x36_0[21];
assign OUT_cfg[22] = out_mult_36x36_0[22];
assign OUT_cfg[23] = out_mult_36x36_0[23];
assign OUT_cfg[24] = out_mult_36x36_0[24];
assign OUT_cfg[25] = out_mult_36x36_0[25];
assign OUT_cfg[26] = out_mult_36x36_0[26];
assign OUT_cfg[27] = out_mult_36x36_0[27];
assign OUT_cfg[28] = out_mult_36x36_0[28];
assign OUT_cfg[29] = out_mult_36x36_0[29];
assign OUT_cfg[30] = out_mult_36x36_0[30];
assign OUT_cfg[31] = out_mult_36x36_0[31];
assign OUT_cfg[32] = out_mult_36x36_0[32];
assign OUT_cfg[33] = out_mult_36x36_0[33];
assign OUT_cfg[34] = out_mult_36x36_0[34];
assign OUT_cfg[35] = out_mult_36x36_0[35];
assign OUT_cfg[36] = out_mult_36x36_0[36];
assign OUT_cfg[37] = out_mult_36x36_0[37];
assign OUT_cfg[38] = out_mult_36x36_0[38];
assign OUT_cfg[39] = out_mult_36x36_0[39];
assign OUT_cfg[40] = out_mult_36x36_0[40];
assign OUT_cfg[41] = out_mult_36x36_0[41];
assign OUT_cfg[42] = out_mult_36x36_0[42];
assign OUT_cfg[43] = out_mult_36x36_0[43];
assign OUT_cfg[44] = out_mult_36x36_0[44];
assign OUT_cfg[45] = out_mult_36x36_0[45];
assign OUT_cfg[46] = out_mult_36x36_0[46];
assign OUT_cfg[47] = out_mult_36x36_0[47];
assign OUT_cfg[48] = out_mult_36x36_0[48];
assign OUT_cfg[49] = out_mult_36x36_0[49];
assign OUT_cfg[50] = out_mult_36x36_0[50];
assign OUT_cfg[51] = out_mult_36x36_0[51];
assign OUT_cfg[52] = out_mult_36x36_0[52];
assign OUT_cfg[53] = out_mult_36x36_0[53];
assign OUT_cfg[54] = out_mult_36x36_0[54];
assign OUT_cfg[55] = out_mult_36x36_0[55];
assign OUT_cfg[56] = out_mult_36x36_0[56];
assign OUT_cfg[57] = out_mult_36x36_0[57];
assign OUT_cfg[58] = out_mult_36x36_0[58];
assign OUT_cfg[59] = out_mult_36x36_0[59];
assign OUT_cfg[60] = out_mult_36x36_0[60];
assign OUT_cfg[61] = out_mult_36x36_0[61];
assign OUT_cfg[62] = out_mult_36x36_0[62];
assign OUT_cfg[63] = out_mult_36x36_0[63];
assign OUT_cfg[64] = out_mult_36x36_0[64];
assign OUT_cfg[65] = out_mult_36x36_0[65];
assign OUT_cfg[66] = out_mult_36x36_0[66];
assign OUT_cfg[67] = out_mult_36x36_0[67];
assign OUT_cfg[68] = out_mult_36x36_0[68];
assign OUT_cfg[69] = out_mult_36x36_0[69];
assign OUT_cfg[70] = out_mult_36x36_0[70];
assign OUT_cfg[71] = out_mult_36x36_0[71];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mult_36 /////////////////////////
/////////////////////////////////////////////////////
module mult_36 (
	input [35:0]a,
	input [35:0]b,
	output [71:0]out,
	input [143:0]config_in
);

////////child (0,0,0)////////
wire [17:0]a_divisible_mult_18x18_0;//input to child
wire [17:0]b_divisible_mult_18x18_0;//input to child
wire [35:0]out_divisible_mult_18x18_0;//output from child
 
////////child (0,0,1)////////
wire [17:0]a_divisible_mult_18x18_1;//input to child
wire [17:0]b_divisible_mult_18x18_1;//input to child
wire [35:0]out_divisible_mult_18x18_1;//output from child
 
////////child (1,0,0)////////
wire [35:0]A_cfg_mult_36x36_slice_0;//input to child
wire [35:0]B_cfg_mult_36x36_slice_0;//input to child
wire [71:0]OUT_cfg_mult_36x36_slice_0;//output from child
 
wire ground;

assign a_divisible_mult_18x18_0[0] = a[0];
assign a_divisible_mult_18x18_0[1] = a[1];
assign a_divisible_mult_18x18_0[2] = a[2];
assign a_divisible_mult_18x18_0[3] = a[3];
assign a_divisible_mult_18x18_0[4] = a[4];
assign a_divisible_mult_18x18_0[5] = a[5];
assign a_divisible_mult_18x18_0[6] = a[6];
assign a_divisible_mult_18x18_0[7] = a[7];
assign a_divisible_mult_18x18_0[8] = a[8];
assign a_divisible_mult_18x18_0[9] = a[9];
assign a_divisible_mult_18x18_0[10] = a[10];
assign a_divisible_mult_18x18_0[11] = a[11];
assign a_divisible_mult_18x18_0[12] = a[12];
assign a_divisible_mult_18x18_0[13] = a[13];
assign a_divisible_mult_18x18_0[14] = a[14];
assign a_divisible_mult_18x18_0[15] = a[15];
assign a_divisible_mult_18x18_0[16] = a[16];
assign a_divisible_mult_18x18_0[17] = a[17];
assign b_divisible_mult_18x18_0[0] = b[0];
assign b_divisible_mult_18x18_0[1] = b[1];
assign b_divisible_mult_18x18_0[2] = b[2];
assign b_divisible_mult_18x18_0[3] = b[3];
assign b_divisible_mult_18x18_0[4] = b[4];
assign b_divisible_mult_18x18_0[5] = b[5];
assign b_divisible_mult_18x18_0[6] = b[6];
assign b_divisible_mult_18x18_0[7] = b[7];
assign b_divisible_mult_18x18_0[8] = b[8];
assign b_divisible_mult_18x18_0[9] = b[9];
assign b_divisible_mult_18x18_0[10] = b[10];
assign b_divisible_mult_18x18_0[11] = b[11];
assign b_divisible_mult_18x18_0[12] = b[12];
assign b_divisible_mult_18x18_0[13] = b[13];
assign b_divisible_mult_18x18_0[14] = b[14];
assign b_divisible_mult_18x18_0[15] = b[15];
assign b_divisible_mult_18x18_0[16] = b[16];
assign b_divisible_mult_18x18_0[17] = b[17];
 
divisible_mult_18x18 divisible_mult_18x18_0 ( .a(a_divisible_mult_18x18_0), .b(b_divisible_mult_18x18_0), .out(out_divisible_mult_18x18_0), .config_in(config_in[35:0]) ); //block instantiation

assign a_divisible_mult_18x18_1[0] = a[18];
assign a_divisible_mult_18x18_1[1] = a[19];
assign a_divisible_mult_18x18_1[2] = a[20];
assign a_divisible_mult_18x18_1[3] = a[21];
assign a_divisible_mult_18x18_1[4] = a[22];
assign a_divisible_mult_18x18_1[5] = a[23];
assign a_divisible_mult_18x18_1[6] = a[24];
assign a_divisible_mult_18x18_1[7] = a[25];
assign a_divisible_mult_18x18_1[8] = a[26];
assign a_divisible_mult_18x18_1[9] = a[27];
assign a_divisible_mult_18x18_1[10] = a[28];
assign a_divisible_mult_18x18_1[11] = a[29];
assign a_divisible_mult_18x18_1[12] = a[30];
assign a_divisible_mult_18x18_1[13] = a[31];
assign a_divisible_mult_18x18_1[14] = a[32];
assign a_divisible_mult_18x18_1[15] = a[33];
assign a_divisible_mult_18x18_1[16] = a[34];
assign a_divisible_mult_18x18_1[17] = a[35];
assign b_divisible_mult_18x18_1[0] = b[18];
assign b_divisible_mult_18x18_1[1] = b[19];
assign b_divisible_mult_18x18_1[2] = b[20];
assign b_divisible_mult_18x18_1[3] = b[21];
assign b_divisible_mult_18x18_1[4] = b[22];
assign b_divisible_mult_18x18_1[5] = b[23];
assign b_divisible_mult_18x18_1[6] = b[24];
assign b_divisible_mult_18x18_1[7] = b[25];
assign b_divisible_mult_18x18_1[8] = b[26];
assign b_divisible_mult_18x18_1[9] = b[27];
assign b_divisible_mult_18x18_1[10] = b[28];
assign b_divisible_mult_18x18_1[11] = b[29];
assign b_divisible_mult_18x18_1[12] = b[30];
assign b_divisible_mult_18x18_1[13] = b[31];
assign b_divisible_mult_18x18_1[14] = b[32];
assign b_divisible_mult_18x18_1[15] = b[33];
assign b_divisible_mult_18x18_1[16] = b[34];
assign b_divisible_mult_18x18_1[17] = b[35];
 
divisible_mult_18x18 divisible_mult_18x18_1 ( .a(a_divisible_mult_18x18_1), .b(b_divisible_mult_18x18_1), .out(out_divisible_mult_18x18_1), .config_in(config_in[71:36]) ); //block instantiation

assign A_cfg_mult_36x36_slice_0[0] = a[0];
assign A_cfg_mult_36x36_slice_0[1] = a[1];
assign A_cfg_mult_36x36_slice_0[2] = a[2];
assign A_cfg_mult_36x36_slice_0[3] = a[3];
assign A_cfg_mult_36x36_slice_0[4] = a[4];
assign A_cfg_mult_36x36_slice_0[5] = a[5];
assign A_cfg_mult_36x36_slice_0[6] = a[6];
assign A_cfg_mult_36x36_slice_0[7] = a[7];
assign A_cfg_mult_36x36_slice_0[8] = a[8];
assign A_cfg_mult_36x36_slice_0[9] = a[9];
assign A_cfg_mult_36x36_slice_0[10] = a[10];
assign A_cfg_mult_36x36_slice_0[11] = a[11];
assign A_cfg_mult_36x36_slice_0[12] = a[12];
assign A_cfg_mult_36x36_slice_0[13] = a[13];
assign A_cfg_mult_36x36_slice_0[14] = a[14];
assign A_cfg_mult_36x36_slice_0[15] = a[15];
assign A_cfg_mult_36x36_slice_0[16] = a[16];
assign A_cfg_mult_36x36_slice_0[17] = a[17];
assign A_cfg_mult_36x36_slice_0[18] = a[18];
assign A_cfg_mult_36x36_slice_0[19] = a[19];
assign A_cfg_mult_36x36_slice_0[20] = a[20];
assign A_cfg_mult_36x36_slice_0[21] = a[21];
assign A_cfg_mult_36x36_slice_0[22] = a[22];
assign A_cfg_mult_36x36_slice_0[23] = a[23];
assign A_cfg_mult_36x36_slice_0[24] = a[24];
assign A_cfg_mult_36x36_slice_0[25] = a[25];
assign A_cfg_mult_36x36_slice_0[26] = a[26];
assign A_cfg_mult_36x36_slice_0[27] = a[27];
assign A_cfg_mult_36x36_slice_0[28] = a[28];
assign A_cfg_mult_36x36_slice_0[29] = a[29];
assign A_cfg_mult_36x36_slice_0[30] = a[30];
assign A_cfg_mult_36x36_slice_0[31] = a[31];
assign A_cfg_mult_36x36_slice_0[32] = a[32];
assign A_cfg_mult_36x36_slice_0[33] = a[33];
assign A_cfg_mult_36x36_slice_0[34] = a[34];
assign A_cfg_mult_36x36_slice_0[35] = a[35];
assign B_cfg_mult_36x36_slice_0[0] = b[0];
assign B_cfg_mult_36x36_slice_0[1] = b[1];
assign B_cfg_mult_36x36_slice_0[2] = b[2];
assign B_cfg_mult_36x36_slice_0[3] = b[3];
assign B_cfg_mult_36x36_slice_0[4] = b[4];
assign B_cfg_mult_36x36_slice_0[5] = b[5];
assign B_cfg_mult_36x36_slice_0[6] = b[6];
assign B_cfg_mult_36x36_slice_0[7] = b[7];
assign B_cfg_mult_36x36_slice_0[8] = b[8];
assign B_cfg_mult_36x36_slice_0[9] = b[9];
assign B_cfg_mult_36x36_slice_0[10] = b[10];
assign B_cfg_mult_36x36_slice_0[11] = b[11];
assign B_cfg_mult_36x36_slice_0[12] = b[12];
assign B_cfg_mult_36x36_slice_0[13] = b[13];
assign B_cfg_mult_36x36_slice_0[14] = b[14];
assign B_cfg_mult_36x36_slice_0[15] = b[15];
assign B_cfg_mult_36x36_slice_0[16] = b[16];
assign B_cfg_mult_36x36_slice_0[17] = b[17];
assign B_cfg_mult_36x36_slice_0[18] = b[18];
assign B_cfg_mult_36x36_slice_0[19] = b[19];
assign B_cfg_mult_36x36_slice_0[20] = b[20];
assign B_cfg_mult_36x36_slice_0[21] = b[21];
assign B_cfg_mult_36x36_slice_0[22] = b[22];
assign B_cfg_mult_36x36_slice_0[23] = b[23];
assign B_cfg_mult_36x36_slice_0[24] = b[24];
assign B_cfg_mult_36x36_slice_0[25] = b[25];
assign B_cfg_mult_36x36_slice_0[26] = b[26];
assign B_cfg_mult_36x36_slice_0[27] = b[27];
assign B_cfg_mult_36x36_slice_0[28] = b[28];
assign B_cfg_mult_36x36_slice_0[29] = b[29];
assign B_cfg_mult_36x36_slice_0[30] = b[30];
assign B_cfg_mult_36x36_slice_0[31] = b[31];
assign B_cfg_mult_36x36_slice_0[32] = b[32];
assign B_cfg_mult_36x36_slice_0[33] = b[33];
assign B_cfg_mult_36x36_slice_0[34] = b[34];
assign B_cfg_mult_36x36_slice_0[35] = b[35];
 
mult_36x36_slice mult_36x36_slice_0 ( .A_cfg(A_cfg_mult_36x36_slice_0), .B_cfg(B_cfg_mult_36x36_slice_0), .OUT_cfg(OUT_cfg_mult_36x36_slice_0) );

//child output to block output
mux2 mux_72 ( .in({out_divisible_mult_18x18_0[0], OUT_cfg_mult_36x36_slice_0[0]}), .config_in(config_in[72:72]), .out(out[0]) );
mux2 mux_73 ( .in({out_divisible_mult_18x18_0[1], OUT_cfg_mult_36x36_slice_0[1]}), .config_in(config_in[73:73]), .out(out[1]) );
mux2 mux_74 ( .in({out_divisible_mult_18x18_0[2], OUT_cfg_mult_36x36_slice_0[2]}), .config_in(config_in[74:74]), .out(out[2]) );
mux2 mux_75 ( .in({out_divisible_mult_18x18_0[3], OUT_cfg_mult_36x36_slice_0[3]}), .config_in(config_in[75:75]), .out(out[3]) );
mux2 mux_76 ( .in({out_divisible_mult_18x18_0[4], OUT_cfg_mult_36x36_slice_0[4]}), .config_in(config_in[76:76]), .out(out[4]) );
mux2 mux_77 ( .in({out_divisible_mult_18x18_0[5], OUT_cfg_mult_36x36_slice_0[5]}), .config_in(config_in[77:77]), .out(out[5]) );
mux2 mux_78 ( .in({out_divisible_mult_18x18_0[6], OUT_cfg_mult_36x36_slice_0[6]}), .config_in(config_in[78:78]), .out(out[6]) );
mux2 mux_79 ( .in({out_divisible_mult_18x18_0[7], OUT_cfg_mult_36x36_slice_0[7]}), .config_in(config_in[79:79]), .out(out[7]) );
mux2 mux_80 ( .in({out_divisible_mult_18x18_0[8], OUT_cfg_mult_36x36_slice_0[8]}), .config_in(config_in[80:80]), .out(out[8]) );
mux2 mux_81 ( .in({out_divisible_mult_18x18_0[9], OUT_cfg_mult_36x36_slice_0[9]}), .config_in(config_in[81:81]), .out(out[9]) );
mux2 mux_82 ( .in({out_divisible_mult_18x18_0[10], OUT_cfg_mult_36x36_slice_0[10]}), .config_in(config_in[82:82]), .out(out[10]) );
mux2 mux_83 ( .in({out_divisible_mult_18x18_0[11], OUT_cfg_mult_36x36_slice_0[11]}), .config_in(config_in[83:83]), .out(out[11]) );
mux2 mux_84 ( .in({out_divisible_mult_18x18_0[12], OUT_cfg_mult_36x36_slice_0[12]}), .config_in(config_in[84:84]), .out(out[12]) );
mux2 mux_85 ( .in({out_divisible_mult_18x18_0[13], OUT_cfg_mult_36x36_slice_0[13]}), .config_in(config_in[85:85]), .out(out[13]) );
mux2 mux_86 ( .in({out_divisible_mult_18x18_0[14], OUT_cfg_mult_36x36_slice_0[14]}), .config_in(config_in[86:86]), .out(out[14]) );
mux2 mux_87 ( .in({out_divisible_mult_18x18_0[15], OUT_cfg_mult_36x36_slice_0[15]}), .config_in(config_in[87:87]), .out(out[15]) );
mux2 mux_88 ( .in({out_divisible_mult_18x18_0[16], OUT_cfg_mult_36x36_slice_0[16]}), .config_in(config_in[88:88]), .out(out[16]) );
mux2 mux_89 ( .in({out_divisible_mult_18x18_0[17], OUT_cfg_mult_36x36_slice_0[17]}), .config_in(config_in[89:89]), .out(out[17]) );
mux2 mux_90 ( .in({out_divisible_mult_18x18_0[18], OUT_cfg_mult_36x36_slice_0[18]}), .config_in(config_in[90:90]), .out(out[18]) );
mux2 mux_91 ( .in({out_divisible_mult_18x18_0[19], OUT_cfg_mult_36x36_slice_0[19]}), .config_in(config_in[91:91]), .out(out[19]) );
mux2 mux_92 ( .in({out_divisible_mult_18x18_0[20], OUT_cfg_mult_36x36_slice_0[20]}), .config_in(config_in[92:92]), .out(out[20]) );
mux2 mux_93 ( .in({out_divisible_mult_18x18_0[21], OUT_cfg_mult_36x36_slice_0[21]}), .config_in(config_in[93:93]), .out(out[21]) );
mux2 mux_94 ( .in({out_divisible_mult_18x18_0[22], OUT_cfg_mult_36x36_slice_0[22]}), .config_in(config_in[94:94]), .out(out[22]) );
mux2 mux_95 ( .in({out_divisible_mult_18x18_0[23], OUT_cfg_mult_36x36_slice_0[23]}), .config_in(config_in[95:95]), .out(out[23]) );
mux2 mux_96 ( .in({out_divisible_mult_18x18_0[24], OUT_cfg_mult_36x36_slice_0[24]}), .config_in(config_in[96:96]), .out(out[24]) );
mux2 mux_97 ( .in({out_divisible_mult_18x18_0[25], OUT_cfg_mult_36x36_slice_0[25]}), .config_in(config_in[97:97]), .out(out[25]) );
mux2 mux_98 ( .in({out_divisible_mult_18x18_0[26], OUT_cfg_mult_36x36_slice_0[26]}), .config_in(config_in[98:98]), .out(out[26]) );
mux2 mux_99 ( .in({out_divisible_mult_18x18_0[27], OUT_cfg_mult_36x36_slice_0[27]}), .config_in(config_in[99:99]), .out(out[27]) );
mux2 mux_100 ( .in({out_divisible_mult_18x18_0[28], OUT_cfg_mult_36x36_slice_0[28]}), .config_in(config_in[100:100]), .out(out[28]) );
mux2 mux_101 ( .in({out_divisible_mult_18x18_0[29], OUT_cfg_mult_36x36_slice_0[29]}), .config_in(config_in[101:101]), .out(out[29]) );
mux2 mux_102 ( .in({out_divisible_mult_18x18_0[30], OUT_cfg_mult_36x36_slice_0[30]}), .config_in(config_in[102:102]), .out(out[30]) );
mux2 mux_103 ( .in({out_divisible_mult_18x18_0[31], OUT_cfg_mult_36x36_slice_0[31]}), .config_in(config_in[103:103]), .out(out[31]) );
mux2 mux_104 ( .in({out_divisible_mult_18x18_0[32], OUT_cfg_mult_36x36_slice_0[32]}), .config_in(config_in[104:104]), .out(out[32]) );
mux2 mux_105 ( .in({out_divisible_mult_18x18_0[33], OUT_cfg_mult_36x36_slice_0[33]}), .config_in(config_in[105:105]), .out(out[33]) );
mux2 mux_106 ( .in({out_divisible_mult_18x18_0[34], OUT_cfg_mult_36x36_slice_0[34]}), .config_in(config_in[106:106]), .out(out[34]) );
mux2 mux_107 ( .in({out_divisible_mult_18x18_0[35], OUT_cfg_mult_36x36_slice_0[35]}), .config_in(config_in[107:107]), .out(out[35]) );
mux2 mux_108 ( .in({out_divisible_mult_18x18_1[0], OUT_cfg_mult_36x36_slice_0[36]}), .config_in(config_in[108:108]), .out(out[36]) );
mux2 mux_109 ( .in({out_divisible_mult_18x18_1[1], OUT_cfg_mult_36x36_slice_0[37]}), .config_in(config_in[109:109]), .out(out[37]) );
mux2 mux_110 ( .in({out_divisible_mult_18x18_1[2], OUT_cfg_mult_36x36_slice_0[38]}), .config_in(config_in[110:110]), .out(out[38]) );
mux2 mux_111 ( .in({out_divisible_mult_18x18_1[3], OUT_cfg_mult_36x36_slice_0[39]}), .config_in(config_in[111:111]), .out(out[39]) );
mux2 mux_112 ( .in({out_divisible_mult_18x18_1[4], OUT_cfg_mult_36x36_slice_0[40]}), .config_in(config_in[112:112]), .out(out[40]) );
mux2 mux_113 ( .in({out_divisible_mult_18x18_1[5], OUT_cfg_mult_36x36_slice_0[41]}), .config_in(config_in[113:113]), .out(out[41]) );
mux2 mux_114 ( .in({out_divisible_mult_18x18_1[6], OUT_cfg_mult_36x36_slice_0[42]}), .config_in(config_in[114:114]), .out(out[42]) );
mux2 mux_115 ( .in({out_divisible_mult_18x18_1[7], OUT_cfg_mult_36x36_slice_0[43]}), .config_in(config_in[115:115]), .out(out[43]) );
mux2 mux_116 ( .in({out_divisible_mult_18x18_1[8], OUT_cfg_mult_36x36_slice_0[44]}), .config_in(config_in[116:116]), .out(out[44]) );
mux2 mux_117 ( .in({out_divisible_mult_18x18_1[9], OUT_cfg_mult_36x36_slice_0[45]}), .config_in(config_in[117:117]), .out(out[45]) );
mux2 mux_118 ( .in({out_divisible_mult_18x18_1[10], OUT_cfg_mult_36x36_slice_0[46]}), .config_in(config_in[118:118]), .out(out[46]) );
mux2 mux_119 ( .in({out_divisible_mult_18x18_1[11], OUT_cfg_mult_36x36_slice_0[47]}), .config_in(config_in[119:119]), .out(out[47]) );
mux2 mux_120 ( .in({out_divisible_mult_18x18_1[12], OUT_cfg_mult_36x36_slice_0[48]}), .config_in(config_in[120:120]), .out(out[48]) );
mux2 mux_121 ( .in({out_divisible_mult_18x18_1[13], OUT_cfg_mult_36x36_slice_0[49]}), .config_in(config_in[121:121]), .out(out[49]) );
mux2 mux_122 ( .in({out_divisible_mult_18x18_1[14], OUT_cfg_mult_36x36_slice_0[50]}), .config_in(config_in[122:122]), .out(out[50]) );
mux2 mux_123 ( .in({out_divisible_mult_18x18_1[15], OUT_cfg_mult_36x36_slice_0[51]}), .config_in(config_in[123:123]), .out(out[51]) );
mux2 mux_124 ( .in({out_divisible_mult_18x18_1[16], OUT_cfg_mult_36x36_slice_0[52]}), .config_in(config_in[124:124]), .out(out[52]) );
mux2 mux_125 ( .in({out_divisible_mult_18x18_1[17], OUT_cfg_mult_36x36_slice_0[53]}), .config_in(config_in[125:125]), .out(out[53]) );
mux2 mux_126 ( .in({out_divisible_mult_18x18_1[18], OUT_cfg_mult_36x36_slice_0[54]}), .config_in(config_in[126:126]), .out(out[54]) );
mux2 mux_127 ( .in({out_divisible_mult_18x18_1[19], OUT_cfg_mult_36x36_slice_0[55]}), .config_in(config_in[127:127]), .out(out[55]) );
mux2 mux_128 ( .in({out_divisible_mult_18x18_1[20], OUT_cfg_mult_36x36_slice_0[56]}), .config_in(config_in[128:128]), .out(out[56]) );
mux2 mux_129 ( .in({out_divisible_mult_18x18_1[21], OUT_cfg_mult_36x36_slice_0[57]}), .config_in(config_in[129:129]), .out(out[57]) );
mux2 mux_130 ( .in({out_divisible_mult_18x18_1[22], OUT_cfg_mult_36x36_slice_0[58]}), .config_in(config_in[130:130]), .out(out[58]) );
mux2 mux_131 ( .in({out_divisible_mult_18x18_1[23], OUT_cfg_mult_36x36_slice_0[59]}), .config_in(config_in[131:131]), .out(out[59]) );
mux2 mux_132 ( .in({out_divisible_mult_18x18_1[24], OUT_cfg_mult_36x36_slice_0[60]}), .config_in(config_in[132:132]), .out(out[60]) );
mux2 mux_133 ( .in({out_divisible_mult_18x18_1[25], OUT_cfg_mult_36x36_slice_0[61]}), .config_in(config_in[133:133]), .out(out[61]) );
mux2 mux_134 ( .in({out_divisible_mult_18x18_1[26], OUT_cfg_mult_36x36_slice_0[62]}), .config_in(config_in[134:134]), .out(out[62]) );
mux2 mux_135 ( .in({out_divisible_mult_18x18_1[27], OUT_cfg_mult_36x36_slice_0[63]}), .config_in(config_in[135:135]), .out(out[63]) );
mux2 mux_136 ( .in({out_divisible_mult_18x18_1[28], OUT_cfg_mult_36x36_slice_0[64]}), .config_in(config_in[136:136]), .out(out[64]) );
mux2 mux_137 ( .in({out_divisible_mult_18x18_1[29], OUT_cfg_mult_36x36_slice_0[65]}), .config_in(config_in[137:137]), .out(out[65]) );
mux2 mux_138 ( .in({out_divisible_mult_18x18_1[30], OUT_cfg_mult_36x36_slice_0[66]}), .config_in(config_in[138:138]), .out(out[66]) );
mux2 mux_139 ( .in({out_divisible_mult_18x18_1[31], OUT_cfg_mult_36x36_slice_0[67]}), .config_in(config_in[139:139]), .out(out[67]) );
mux2 mux_140 ( .in({out_divisible_mult_18x18_1[32], OUT_cfg_mult_36x36_slice_0[68]}), .config_in(config_in[140:140]), .out(out[68]) );
mux2 mux_141 ( .in({out_divisible_mult_18x18_1[33], OUT_cfg_mult_36x36_slice_0[69]}), .config_in(config_in[141:141]), .out(out[69]) );
mux2 mux_142 ( .in({out_divisible_mult_18x18_1[34], OUT_cfg_mult_36x36_slice_0[70]}), .config_in(config_in[142:142]), .out(out[70]) );
mux2 mux_143 ( .in({out_divisible_mult_18x18_1[35], OUT_cfg_mult_36x36_slice_0[71]}), .config_in(config_in[143:143]), .out(out[71]) );

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [10:0]addr,
	input [0:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [0:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_2048x72_sp /////////////////////////
/////////////////////////////////////////////////////
module mem_2048x72_sp (
	input [10:0]addr,
	input [71:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [71:0]out
);

////////child (0,0,0)////////
wire [10:0]addr_memory_slice_0;//input to child
wire [0:0]data_memory_slice_0;//input to child
wire [0:0]we_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [10:0]addr_memory_slice_1;//input to child
wire [0:0]data_memory_slice_1;//input to child
wire [0:0]we_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [10:0]addr_memory_slice_2;//input to child
wire [0:0]data_memory_slice_2;//input to child
wire [0:0]we_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [10:0]addr_memory_slice_3;//input to child
wire [0:0]data_memory_slice_3;//input to child
wire [0:0]we_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [10:0]addr_memory_slice_4;//input to child
wire [0:0]data_memory_slice_4;//input to child
wire [0:0]we_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [10:0]addr_memory_slice_5;//input to child
wire [0:0]data_memory_slice_5;//input to child
wire [0:0]we_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [10:0]addr_memory_slice_6;//input to child
wire [0:0]data_memory_slice_6;//input to child
wire [0:0]we_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [10:0]addr_memory_slice_7;//input to child
wire [0:0]data_memory_slice_7;//input to child
wire [0:0]we_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [10:0]addr_memory_slice_8;//input to child
wire [0:0]data_memory_slice_8;//input to child
wire [0:0]we_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out_memory_slice_8;//output from child
 
////////child (0,0,9)////////
wire [10:0]addr_memory_slice_9;//input to child
wire [0:0]data_memory_slice_9;//input to child
wire [0:0]we_memory_slice_9;//input to child
wire [0:0]clk_memory_slice_9;//clock to child
wire [0:0]out_memory_slice_9;//output from child
 
////////child (0,0,10)////////
wire [10:0]addr_memory_slice_10;//input to child
wire [0:0]data_memory_slice_10;//input to child
wire [0:0]we_memory_slice_10;//input to child
wire [0:0]clk_memory_slice_10;//clock to child
wire [0:0]out_memory_slice_10;//output from child
 
////////child (0,0,11)////////
wire [10:0]addr_memory_slice_11;//input to child
wire [0:0]data_memory_slice_11;//input to child
wire [0:0]we_memory_slice_11;//input to child
wire [0:0]clk_memory_slice_11;//clock to child
wire [0:0]out_memory_slice_11;//output from child
 
////////child (0,0,12)////////
wire [10:0]addr_memory_slice_12;//input to child
wire [0:0]data_memory_slice_12;//input to child
wire [0:0]we_memory_slice_12;//input to child
wire [0:0]clk_memory_slice_12;//clock to child
wire [0:0]out_memory_slice_12;//output from child
 
////////child (0,0,13)////////
wire [10:0]addr_memory_slice_13;//input to child
wire [0:0]data_memory_slice_13;//input to child
wire [0:0]we_memory_slice_13;//input to child
wire [0:0]clk_memory_slice_13;//clock to child
wire [0:0]out_memory_slice_13;//output from child
 
////////child (0,0,14)////////
wire [10:0]addr_memory_slice_14;//input to child
wire [0:0]data_memory_slice_14;//input to child
wire [0:0]we_memory_slice_14;//input to child
wire [0:0]clk_memory_slice_14;//clock to child
wire [0:0]out_memory_slice_14;//output from child
 
////////child (0,0,15)////////
wire [10:0]addr_memory_slice_15;//input to child
wire [0:0]data_memory_slice_15;//input to child
wire [0:0]we_memory_slice_15;//input to child
wire [0:0]clk_memory_slice_15;//clock to child
wire [0:0]out_memory_slice_15;//output from child
 
////////child (0,0,16)////////
wire [10:0]addr_memory_slice_16;//input to child
wire [0:0]data_memory_slice_16;//input to child
wire [0:0]we_memory_slice_16;//input to child
wire [0:0]clk_memory_slice_16;//clock to child
wire [0:0]out_memory_slice_16;//output from child
 
////////child (0,0,17)////////
wire [10:0]addr_memory_slice_17;//input to child
wire [0:0]data_memory_slice_17;//input to child
wire [0:0]we_memory_slice_17;//input to child
wire [0:0]clk_memory_slice_17;//clock to child
wire [0:0]out_memory_slice_17;//output from child
 
////////child (0,0,18)////////
wire [10:0]addr_memory_slice_18;//input to child
wire [0:0]data_memory_slice_18;//input to child
wire [0:0]we_memory_slice_18;//input to child
wire [0:0]clk_memory_slice_18;//clock to child
wire [0:0]out_memory_slice_18;//output from child
 
////////child (0,0,19)////////
wire [10:0]addr_memory_slice_19;//input to child
wire [0:0]data_memory_slice_19;//input to child
wire [0:0]we_memory_slice_19;//input to child
wire [0:0]clk_memory_slice_19;//clock to child
wire [0:0]out_memory_slice_19;//output from child
 
////////child (0,0,20)////////
wire [10:0]addr_memory_slice_20;//input to child
wire [0:0]data_memory_slice_20;//input to child
wire [0:0]we_memory_slice_20;//input to child
wire [0:0]clk_memory_slice_20;//clock to child
wire [0:0]out_memory_slice_20;//output from child
 
////////child (0,0,21)////////
wire [10:0]addr_memory_slice_21;//input to child
wire [0:0]data_memory_slice_21;//input to child
wire [0:0]we_memory_slice_21;//input to child
wire [0:0]clk_memory_slice_21;//clock to child
wire [0:0]out_memory_slice_21;//output from child
 
////////child (0,0,22)////////
wire [10:0]addr_memory_slice_22;//input to child
wire [0:0]data_memory_slice_22;//input to child
wire [0:0]we_memory_slice_22;//input to child
wire [0:0]clk_memory_slice_22;//clock to child
wire [0:0]out_memory_slice_22;//output from child
 
////////child (0,0,23)////////
wire [10:0]addr_memory_slice_23;//input to child
wire [0:0]data_memory_slice_23;//input to child
wire [0:0]we_memory_slice_23;//input to child
wire [0:0]clk_memory_slice_23;//clock to child
wire [0:0]out_memory_slice_23;//output from child
 
////////child (0,0,24)////////
wire [10:0]addr_memory_slice_24;//input to child
wire [0:0]data_memory_slice_24;//input to child
wire [0:0]we_memory_slice_24;//input to child
wire [0:0]clk_memory_slice_24;//clock to child
wire [0:0]out_memory_slice_24;//output from child
 
////////child (0,0,25)////////
wire [10:0]addr_memory_slice_25;//input to child
wire [0:0]data_memory_slice_25;//input to child
wire [0:0]we_memory_slice_25;//input to child
wire [0:0]clk_memory_slice_25;//clock to child
wire [0:0]out_memory_slice_25;//output from child
 
////////child (0,0,26)////////
wire [10:0]addr_memory_slice_26;//input to child
wire [0:0]data_memory_slice_26;//input to child
wire [0:0]we_memory_slice_26;//input to child
wire [0:0]clk_memory_slice_26;//clock to child
wire [0:0]out_memory_slice_26;//output from child
 
////////child (0,0,27)////////
wire [10:0]addr_memory_slice_27;//input to child
wire [0:0]data_memory_slice_27;//input to child
wire [0:0]we_memory_slice_27;//input to child
wire [0:0]clk_memory_slice_27;//clock to child
wire [0:0]out_memory_slice_27;//output from child
 
////////child (0,0,28)////////
wire [10:0]addr_memory_slice_28;//input to child
wire [0:0]data_memory_slice_28;//input to child
wire [0:0]we_memory_slice_28;//input to child
wire [0:0]clk_memory_slice_28;//clock to child
wire [0:0]out_memory_slice_28;//output from child
 
////////child (0,0,29)////////
wire [10:0]addr_memory_slice_29;//input to child
wire [0:0]data_memory_slice_29;//input to child
wire [0:0]we_memory_slice_29;//input to child
wire [0:0]clk_memory_slice_29;//clock to child
wire [0:0]out_memory_slice_29;//output from child
 
////////child (0,0,30)////////
wire [10:0]addr_memory_slice_30;//input to child
wire [0:0]data_memory_slice_30;//input to child
wire [0:0]we_memory_slice_30;//input to child
wire [0:0]clk_memory_slice_30;//clock to child
wire [0:0]out_memory_slice_30;//output from child
 
////////child (0,0,31)////////
wire [10:0]addr_memory_slice_31;//input to child
wire [0:0]data_memory_slice_31;//input to child
wire [0:0]we_memory_slice_31;//input to child
wire [0:0]clk_memory_slice_31;//clock to child
wire [0:0]out_memory_slice_31;//output from child
 
////////child (0,0,32)////////
wire [10:0]addr_memory_slice_32;//input to child
wire [0:0]data_memory_slice_32;//input to child
wire [0:0]we_memory_slice_32;//input to child
wire [0:0]clk_memory_slice_32;//clock to child
wire [0:0]out_memory_slice_32;//output from child
 
////////child (0,0,33)////////
wire [10:0]addr_memory_slice_33;//input to child
wire [0:0]data_memory_slice_33;//input to child
wire [0:0]we_memory_slice_33;//input to child
wire [0:0]clk_memory_slice_33;//clock to child
wire [0:0]out_memory_slice_33;//output from child
 
////////child (0,0,34)////////
wire [10:0]addr_memory_slice_34;//input to child
wire [0:0]data_memory_slice_34;//input to child
wire [0:0]we_memory_slice_34;//input to child
wire [0:0]clk_memory_slice_34;//clock to child
wire [0:0]out_memory_slice_34;//output from child
 
////////child (0,0,35)////////
wire [10:0]addr_memory_slice_35;//input to child
wire [0:0]data_memory_slice_35;//input to child
wire [0:0]we_memory_slice_35;//input to child
wire [0:0]clk_memory_slice_35;//clock to child
wire [0:0]out_memory_slice_35;//output from child
 
////////child (0,0,36)////////
wire [10:0]addr_memory_slice_36;//input to child
wire [0:0]data_memory_slice_36;//input to child
wire [0:0]we_memory_slice_36;//input to child
wire [0:0]clk_memory_slice_36;//clock to child
wire [0:0]out_memory_slice_36;//output from child
 
////////child (0,0,37)////////
wire [10:0]addr_memory_slice_37;//input to child
wire [0:0]data_memory_slice_37;//input to child
wire [0:0]we_memory_slice_37;//input to child
wire [0:0]clk_memory_slice_37;//clock to child
wire [0:0]out_memory_slice_37;//output from child
 
////////child (0,0,38)////////
wire [10:0]addr_memory_slice_38;//input to child
wire [0:0]data_memory_slice_38;//input to child
wire [0:0]we_memory_slice_38;//input to child
wire [0:0]clk_memory_slice_38;//clock to child
wire [0:0]out_memory_slice_38;//output from child
 
////////child (0,0,39)////////
wire [10:0]addr_memory_slice_39;//input to child
wire [0:0]data_memory_slice_39;//input to child
wire [0:0]we_memory_slice_39;//input to child
wire [0:0]clk_memory_slice_39;//clock to child
wire [0:0]out_memory_slice_39;//output from child
 
////////child (0,0,40)////////
wire [10:0]addr_memory_slice_40;//input to child
wire [0:0]data_memory_slice_40;//input to child
wire [0:0]we_memory_slice_40;//input to child
wire [0:0]clk_memory_slice_40;//clock to child
wire [0:0]out_memory_slice_40;//output from child
 
////////child (0,0,41)////////
wire [10:0]addr_memory_slice_41;//input to child
wire [0:0]data_memory_slice_41;//input to child
wire [0:0]we_memory_slice_41;//input to child
wire [0:0]clk_memory_slice_41;//clock to child
wire [0:0]out_memory_slice_41;//output from child
 
////////child (0,0,42)////////
wire [10:0]addr_memory_slice_42;//input to child
wire [0:0]data_memory_slice_42;//input to child
wire [0:0]we_memory_slice_42;//input to child
wire [0:0]clk_memory_slice_42;//clock to child
wire [0:0]out_memory_slice_42;//output from child
 
////////child (0,0,43)////////
wire [10:0]addr_memory_slice_43;//input to child
wire [0:0]data_memory_slice_43;//input to child
wire [0:0]we_memory_slice_43;//input to child
wire [0:0]clk_memory_slice_43;//clock to child
wire [0:0]out_memory_slice_43;//output from child
 
////////child (0,0,44)////////
wire [10:0]addr_memory_slice_44;//input to child
wire [0:0]data_memory_slice_44;//input to child
wire [0:0]we_memory_slice_44;//input to child
wire [0:0]clk_memory_slice_44;//clock to child
wire [0:0]out_memory_slice_44;//output from child
 
////////child (0,0,45)////////
wire [10:0]addr_memory_slice_45;//input to child
wire [0:0]data_memory_slice_45;//input to child
wire [0:0]we_memory_slice_45;//input to child
wire [0:0]clk_memory_slice_45;//clock to child
wire [0:0]out_memory_slice_45;//output from child
 
////////child (0,0,46)////////
wire [10:0]addr_memory_slice_46;//input to child
wire [0:0]data_memory_slice_46;//input to child
wire [0:0]we_memory_slice_46;//input to child
wire [0:0]clk_memory_slice_46;//clock to child
wire [0:0]out_memory_slice_46;//output from child
 
////////child (0,0,47)////////
wire [10:0]addr_memory_slice_47;//input to child
wire [0:0]data_memory_slice_47;//input to child
wire [0:0]we_memory_slice_47;//input to child
wire [0:0]clk_memory_slice_47;//clock to child
wire [0:0]out_memory_slice_47;//output from child
 
////////child (0,0,48)////////
wire [10:0]addr_memory_slice_48;//input to child
wire [0:0]data_memory_slice_48;//input to child
wire [0:0]we_memory_slice_48;//input to child
wire [0:0]clk_memory_slice_48;//clock to child
wire [0:0]out_memory_slice_48;//output from child
 
////////child (0,0,49)////////
wire [10:0]addr_memory_slice_49;//input to child
wire [0:0]data_memory_slice_49;//input to child
wire [0:0]we_memory_slice_49;//input to child
wire [0:0]clk_memory_slice_49;//clock to child
wire [0:0]out_memory_slice_49;//output from child
 
////////child (0,0,50)////////
wire [10:0]addr_memory_slice_50;//input to child
wire [0:0]data_memory_slice_50;//input to child
wire [0:0]we_memory_slice_50;//input to child
wire [0:0]clk_memory_slice_50;//clock to child
wire [0:0]out_memory_slice_50;//output from child
 
////////child (0,0,51)////////
wire [10:0]addr_memory_slice_51;//input to child
wire [0:0]data_memory_slice_51;//input to child
wire [0:0]we_memory_slice_51;//input to child
wire [0:0]clk_memory_slice_51;//clock to child
wire [0:0]out_memory_slice_51;//output from child
 
////////child (0,0,52)////////
wire [10:0]addr_memory_slice_52;//input to child
wire [0:0]data_memory_slice_52;//input to child
wire [0:0]we_memory_slice_52;//input to child
wire [0:0]clk_memory_slice_52;//clock to child
wire [0:0]out_memory_slice_52;//output from child
 
////////child (0,0,53)////////
wire [10:0]addr_memory_slice_53;//input to child
wire [0:0]data_memory_slice_53;//input to child
wire [0:0]we_memory_slice_53;//input to child
wire [0:0]clk_memory_slice_53;//clock to child
wire [0:0]out_memory_slice_53;//output from child
 
////////child (0,0,54)////////
wire [10:0]addr_memory_slice_54;//input to child
wire [0:0]data_memory_slice_54;//input to child
wire [0:0]we_memory_slice_54;//input to child
wire [0:0]clk_memory_slice_54;//clock to child
wire [0:0]out_memory_slice_54;//output from child
 
////////child (0,0,55)////////
wire [10:0]addr_memory_slice_55;//input to child
wire [0:0]data_memory_slice_55;//input to child
wire [0:0]we_memory_slice_55;//input to child
wire [0:0]clk_memory_slice_55;//clock to child
wire [0:0]out_memory_slice_55;//output from child
 
////////child (0,0,56)////////
wire [10:0]addr_memory_slice_56;//input to child
wire [0:0]data_memory_slice_56;//input to child
wire [0:0]we_memory_slice_56;//input to child
wire [0:0]clk_memory_slice_56;//clock to child
wire [0:0]out_memory_slice_56;//output from child
 
////////child (0,0,57)////////
wire [10:0]addr_memory_slice_57;//input to child
wire [0:0]data_memory_slice_57;//input to child
wire [0:0]we_memory_slice_57;//input to child
wire [0:0]clk_memory_slice_57;//clock to child
wire [0:0]out_memory_slice_57;//output from child
 
////////child (0,0,58)////////
wire [10:0]addr_memory_slice_58;//input to child
wire [0:0]data_memory_slice_58;//input to child
wire [0:0]we_memory_slice_58;//input to child
wire [0:0]clk_memory_slice_58;//clock to child
wire [0:0]out_memory_slice_58;//output from child
 
////////child (0,0,59)////////
wire [10:0]addr_memory_slice_59;//input to child
wire [0:0]data_memory_slice_59;//input to child
wire [0:0]we_memory_slice_59;//input to child
wire [0:0]clk_memory_slice_59;//clock to child
wire [0:0]out_memory_slice_59;//output from child
 
////////child (0,0,60)////////
wire [10:0]addr_memory_slice_60;//input to child
wire [0:0]data_memory_slice_60;//input to child
wire [0:0]we_memory_slice_60;//input to child
wire [0:0]clk_memory_slice_60;//clock to child
wire [0:0]out_memory_slice_60;//output from child
 
////////child (0,0,61)////////
wire [10:0]addr_memory_slice_61;//input to child
wire [0:0]data_memory_slice_61;//input to child
wire [0:0]we_memory_slice_61;//input to child
wire [0:0]clk_memory_slice_61;//clock to child
wire [0:0]out_memory_slice_61;//output from child
 
////////child (0,0,62)////////
wire [10:0]addr_memory_slice_62;//input to child
wire [0:0]data_memory_slice_62;//input to child
wire [0:0]we_memory_slice_62;//input to child
wire [0:0]clk_memory_slice_62;//clock to child
wire [0:0]out_memory_slice_62;//output from child
 
////////child (0,0,63)////////
wire [10:0]addr_memory_slice_63;//input to child
wire [0:0]data_memory_slice_63;//input to child
wire [0:0]we_memory_slice_63;//input to child
wire [0:0]clk_memory_slice_63;//clock to child
wire [0:0]out_memory_slice_63;//output from child
 
////////child (0,0,64)////////
wire [10:0]addr_memory_slice_64;//input to child
wire [0:0]data_memory_slice_64;//input to child
wire [0:0]we_memory_slice_64;//input to child
wire [0:0]clk_memory_slice_64;//clock to child
wire [0:0]out_memory_slice_64;//output from child
 
////////child (0,0,65)////////
wire [10:0]addr_memory_slice_65;//input to child
wire [0:0]data_memory_slice_65;//input to child
wire [0:0]we_memory_slice_65;//input to child
wire [0:0]clk_memory_slice_65;//clock to child
wire [0:0]out_memory_slice_65;//output from child
 
////////child (0,0,66)////////
wire [10:0]addr_memory_slice_66;//input to child
wire [0:0]data_memory_slice_66;//input to child
wire [0:0]we_memory_slice_66;//input to child
wire [0:0]clk_memory_slice_66;//clock to child
wire [0:0]out_memory_slice_66;//output from child
 
////////child (0,0,67)////////
wire [10:0]addr_memory_slice_67;//input to child
wire [0:0]data_memory_slice_67;//input to child
wire [0:0]we_memory_slice_67;//input to child
wire [0:0]clk_memory_slice_67;//clock to child
wire [0:0]out_memory_slice_67;//output from child
 
////////child (0,0,68)////////
wire [10:0]addr_memory_slice_68;//input to child
wire [0:0]data_memory_slice_68;//input to child
wire [0:0]we_memory_slice_68;//input to child
wire [0:0]clk_memory_slice_68;//clock to child
wire [0:0]out_memory_slice_68;//output from child
 
////////child (0,0,69)////////
wire [10:0]addr_memory_slice_69;//input to child
wire [0:0]data_memory_slice_69;//input to child
wire [0:0]we_memory_slice_69;//input to child
wire [0:0]clk_memory_slice_69;//clock to child
wire [0:0]out_memory_slice_69;//output from child
 
////////child (0,0,70)////////
wire [10:0]addr_memory_slice_70;//input to child
wire [0:0]data_memory_slice_70;//input to child
wire [0:0]we_memory_slice_70;//input to child
wire [0:0]clk_memory_slice_70;//clock to child
wire [0:0]out_memory_slice_70;//output from child
 
////////child (0,0,71)////////
wire [10:0]addr_memory_slice_71;//input to child
wire [0:0]data_memory_slice_71;//input to child
wire [0:0]we_memory_slice_71;//input to child
wire [0:0]clk_memory_slice_71;//clock to child
wire [0:0]out_memory_slice_71;//output from child
 
wire ground;

assign addr_memory_slice_0[0] = addr[0];
assign addr_memory_slice_0[1] = addr[1];
assign addr_memory_slice_0[2] = addr[2];
assign addr_memory_slice_0[3] = addr[3];
assign addr_memory_slice_0[4] = addr[4];
assign addr_memory_slice_0[5] = addr[5];
assign addr_memory_slice_0[6] = addr[6];
assign addr_memory_slice_0[7] = addr[7];
assign addr_memory_slice_0[8] = addr[8];
assign addr_memory_slice_0[9] = addr[9];
assign addr_memory_slice_0[10] = addr[10];
assign data_memory_slice_0[0] = data[0];
assign we_memory_slice_0[0] = we[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr(addr_memory_slice_0), .data(data_memory_slice_0), .we(we_memory_slice_0), .out(out_memory_slice_0) );

assign addr_memory_slice_1[0] = addr[0];
assign addr_memory_slice_1[1] = addr[1];
assign addr_memory_slice_1[2] = addr[2];
assign addr_memory_slice_1[3] = addr[3];
assign addr_memory_slice_1[4] = addr[4];
assign addr_memory_slice_1[5] = addr[5];
assign addr_memory_slice_1[6] = addr[6];
assign addr_memory_slice_1[7] = addr[7];
assign addr_memory_slice_1[8] = addr[8];
assign addr_memory_slice_1[9] = addr[9];
assign addr_memory_slice_1[10] = addr[10];
assign data_memory_slice_1[0] = data[1];
assign we_memory_slice_1[0] = we[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr(addr_memory_slice_1), .data(data_memory_slice_1), .we(we_memory_slice_1), .out(out_memory_slice_1) );

assign addr_memory_slice_2[0] = addr[0];
assign addr_memory_slice_2[1] = addr[1];
assign addr_memory_slice_2[2] = addr[2];
assign addr_memory_slice_2[3] = addr[3];
assign addr_memory_slice_2[4] = addr[4];
assign addr_memory_slice_2[5] = addr[5];
assign addr_memory_slice_2[6] = addr[6];
assign addr_memory_slice_2[7] = addr[7];
assign addr_memory_slice_2[8] = addr[8];
assign addr_memory_slice_2[9] = addr[9];
assign addr_memory_slice_2[10] = addr[10];
assign data_memory_slice_2[0] = data[2];
assign we_memory_slice_2[0] = we[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr(addr_memory_slice_2), .data(data_memory_slice_2), .we(we_memory_slice_2), .out(out_memory_slice_2) );

assign addr_memory_slice_3[0] = addr[0];
assign addr_memory_slice_3[1] = addr[1];
assign addr_memory_slice_3[2] = addr[2];
assign addr_memory_slice_3[3] = addr[3];
assign addr_memory_slice_3[4] = addr[4];
assign addr_memory_slice_3[5] = addr[5];
assign addr_memory_slice_3[6] = addr[6];
assign addr_memory_slice_3[7] = addr[7];
assign addr_memory_slice_3[8] = addr[8];
assign addr_memory_slice_3[9] = addr[9];
assign addr_memory_slice_3[10] = addr[10];
assign data_memory_slice_3[0] = data[3];
assign we_memory_slice_3[0] = we[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr(addr_memory_slice_3), .data(data_memory_slice_3), .we(we_memory_slice_3), .out(out_memory_slice_3) );

assign addr_memory_slice_4[0] = addr[0];
assign addr_memory_slice_4[1] = addr[1];
assign addr_memory_slice_4[2] = addr[2];
assign addr_memory_slice_4[3] = addr[3];
assign addr_memory_slice_4[4] = addr[4];
assign addr_memory_slice_4[5] = addr[5];
assign addr_memory_slice_4[6] = addr[6];
assign addr_memory_slice_4[7] = addr[7];
assign addr_memory_slice_4[8] = addr[8];
assign addr_memory_slice_4[9] = addr[9];
assign addr_memory_slice_4[10] = addr[10];
assign data_memory_slice_4[0] = data[4];
assign we_memory_slice_4[0] = we[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr(addr_memory_slice_4), .data(data_memory_slice_4), .we(we_memory_slice_4), .out(out_memory_slice_4) );

assign addr_memory_slice_5[0] = addr[0];
assign addr_memory_slice_5[1] = addr[1];
assign addr_memory_slice_5[2] = addr[2];
assign addr_memory_slice_5[3] = addr[3];
assign addr_memory_slice_5[4] = addr[4];
assign addr_memory_slice_5[5] = addr[5];
assign addr_memory_slice_5[6] = addr[6];
assign addr_memory_slice_5[7] = addr[7];
assign addr_memory_slice_5[8] = addr[8];
assign addr_memory_slice_5[9] = addr[9];
assign addr_memory_slice_5[10] = addr[10];
assign data_memory_slice_5[0] = data[5];
assign we_memory_slice_5[0] = we[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr(addr_memory_slice_5), .data(data_memory_slice_5), .we(we_memory_slice_5), .out(out_memory_slice_5) );

assign addr_memory_slice_6[0] = addr[0];
assign addr_memory_slice_6[1] = addr[1];
assign addr_memory_slice_6[2] = addr[2];
assign addr_memory_slice_6[3] = addr[3];
assign addr_memory_slice_6[4] = addr[4];
assign addr_memory_slice_6[5] = addr[5];
assign addr_memory_slice_6[6] = addr[6];
assign addr_memory_slice_6[7] = addr[7];
assign addr_memory_slice_6[8] = addr[8];
assign addr_memory_slice_6[9] = addr[9];
assign addr_memory_slice_6[10] = addr[10];
assign data_memory_slice_6[0] = data[6];
assign we_memory_slice_6[0] = we[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr(addr_memory_slice_6), .data(data_memory_slice_6), .we(we_memory_slice_6), .out(out_memory_slice_6) );

assign addr_memory_slice_7[0] = addr[0];
assign addr_memory_slice_7[1] = addr[1];
assign addr_memory_slice_7[2] = addr[2];
assign addr_memory_slice_7[3] = addr[3];
assign addr_memory_slice_7[4] = addr[4];
assign addr_memory_slice_7[5] = addr[5];
assign addr_memory_slice_7[6] = addr[6];
assign addr_memory_slice_7[7] = addr[7];
assign addr_memory_slice_7[8] = addr[8];
assign addr_memory_slice_7[9] = addr[9];
assign addr_memory_slice_7[10] = addr[10];
assign data_memory_slice_7[0] = data[7];
assign we_memory_slice_7[0] = we[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr(addr_memory_slice_7), .data(data_memory_slice_7), .we(we_memory_slice_7), .out(out_memory_slice_7) );

assign addr_memory_slice_8[0] = addr[0];
assign addr_memory_slice_8[1] = addr[1];
assign addr_memory_slice_8[2] = addr[2];
assign addr_memory_slice_8[3] = addr[3];
assign addr_memory_slice_8[4] = addr[4];
assign addr_memory_slice_8[5] = addr[5];
assign addr_memory_slice_8[6] = addr[6];
assign addr_memory_slice_8[7] = addr[7];
assign addr_memory_slice_8[8] = addr[8];
assign addr_memory_slice_8[9] = addr[9];
assign addr_memory_slice_8[10] = addr[10];
assign data_memory_slice_8[0] = data[8];
assign we_memory_slice_8[0] = we[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr(addr_memory_slice_8), .data(data_memory_slice_8), .we(we_memory_slice_8), .out(out_memory_slice_8) );

assign addr_memory_slice_9[0] = addr[0];
assign addr_memory_slice_9[1] = addr[1];
assign addr_memory_slice_9[2] = addr[2];
assign addr_memory_slice_9[3] = addr[3];
assign addr_memory_slice_9[4] = addr[4];
assign addr_memory_slice_9[5] = addr[5];
assign addr_memory_slice_9[6] = addr[6];
assign addr_memory_slice_9[7] = addr[7];
assign addr_memory_slice_9[8] = addr[8];
assign addr_memory_slice_9[9] = addr[9];
assign addr_memory_slice_9[10] = addr[10];
assign data_memory_slice_9[0] = data[9];
assign we_memory_slice_9[0] = we[0];
assign clk_memory_slice_9[0] = clk[0];
 
memory_slice memory_slice_9 ( .clk(clk_memory_slice_9), .addr(addr_memory_slice_9), .data(data_memory_slice_9), .we(we_memory_slice_9), .out(out_memory_slice_9) );

assign addr_memory_slice_10[0] = addr[0];
assign addr_memory_slice_10[1] = addr[1];
assign addr_memory_slice_10[2] = addr[2];
assign addr_memory_slice_10[3] = addr[3];
assign addr_memory_slice_10[4] = addr[4];
assign addr_memory_slice_10[5] = addr[5];
assign addr_memory_slice_10[6] = addr[6];
assign addr_memory_slice_10[7] = addr[7];
assign addr_memory_slice_10[8] = addr[8];
assign addr_memory_slice_10[9] = addr[9];
assign addr_memory_slice_10[10] = addr[10];
assign data_memory_slice_10[0] = data[10];
assign we_memory_slice_10[0] = we[0];
assign clk_memory_slice_10[0] = clk[0];
 
memory_slice memory_slice_10 ( .clk(clk_memory_slice_10), .addr(addr_memory_slice_10), .data(data_memory_slice_10), .we(we_memory_slice_10), .out(out_memory_slice_10) );

assign addr_memory_slice_11[0] = addr[0];
assign addr_memory_slice_11[1] = addr[1];
assign addr_memory_slice_11[2] = addr[2];
assign addr_memory_slice_11[3] = addr[3];
assign addr_memory_slice_11[4] = addr[4];
assign addr_memory_slice_11[5] = addr[5];
assign addr_memory_slice_11[6] = addr[6];
assign addr_memory_slice_11[7] = addr[7];
assign addr_memory_slice_11[8] = addr[8];
assign addr_memory_slice_11[9] = addr[9];
assign addr_memory_slice_11[10] = addr[10];
assign data_memory_slice_11[0] = data[11];
assign we_memory_slice_11[0] = we[0];
assign clk_memory_slice_11[0] = clk[0];
 
memory_slice memory_slice_11 ( .clk(clk_memory_slice_11), .addr(addr_memory_slice_11), .data(data_memory_slice_11), .we(we_memory_slice_11), .out(out_memory_slice_11) );

assign addr_memory_slice_12[0] = addr[0];
assign addr_memory_slice_12[1] = addr[1];
assign addr_memory_slice_12[2] = addr[2];
assign addr_memory_slice_12[3] = addr[3];
assign addr_memory_slice_12[4] = addr[4];
assign addr_memory_slice_12[5] = addr[5];
assign addr_memory_slice_12[6] = addr[6];
assign addr_memory_slice_12[7] = addr[7];
assign addr_memory_slice_12[8] = addr[8];
assign addr_memory_slice_12[9] = addr[9];
assign addr_memory_slice_12[10] = addr[10];
assign data_memory_slice_12[0] = data[12];
assign we_memory_slice_12[0] = we[0];
assign clk_memory_slice_12[0] = clk[0];
 
memory_slice memory_slice_12 ( .clk(clk_memory_slice_12), .addr(addr_memory_slice_12), .data(data_memory_slice_12), .we(we_memory_slice_12), .out(out_memory_slice_12) );

assign addr_memory_slice_13[0] = addr[0];
assign addr_memory_slice_13[1] = addr[1];
assign addr_memory_slice_13[2] = addr[2];
assign addr_memory_slice_13[3] = addr[3];
assign addr_memory_slice_13[4] = addr[4];
assign addr_memory_slice_13[5] = addr[5];
assign addr_memory_slice_13[6] = addr[6];
assign addr_memory_slice_13[7] = addr[7];
assign addr_memory_slice_13[8] = addr[8];
assign addr_memory_slice_13[9] = addr[9];
assign addr_memory_slice_13[10] = addr[10];
assign data_memory_slice_13[0] = data[13];
assign we_memory_slice_13[0] = we[0];
assign clk_memory_slice_13[0] = clk[0];
 
memory_slice memory_slice_13 ( .clk(clk_memory_slice_13), .addr(addr_memory_slice_13), .data(data_memory_slice_13), .we(we_memory_slice_13), .out(out_memory_slice_13) );

assign addr_memory_slice_14[0] = addr[0];
assign addr_memory_slice_14[1] = addr[1];
assign addr_memory_slice_14[2] = addr[2];
assign addr_memory_slice_14[3] = addr[3];
assign addr_memory_slice_14[4] = addr[4];
assign addr_memory_slice_14[5] = addr[5];
assign addr_memory_slice_14[6] = addr[6];
assign addr_memory_slice_14[7] = addr[7];
assign addr_memory_slice_14[8] = addr[8];
assign addr_memory_slice_14[9] = addr[9];
assign addr_memory_slice_14[10] = addr[10];
assign data_memory_slice_14[0] = data[14];
assign we_memory_slice_14[0] = we[0];
assign clk_memory_slice_14[0] = clk[0];
 
memory_slice memory_slice_14 ( .clk(clk_memory_slice_14), .addr(addr_memory_slice_14), .data(data_memory_slice_14), .we(we_memory_slice_14), .out(out_memory_slice_14) );

assign addr_memory_slice_15[0] = addr[0];
assign addr_memory_slice_15[1] = addr[1];
assign addr_memory_slice_15[2] = addr[2];
assign addr_memory_slice_15[3] = addr[3];
assign addr_memory_slice_15[4] = addr[4];
assign addr_memory_slice_15[5] = addr[5];
assign addr_memory_slice_15[6] = addr[6];
assign addr_memory_slice_15[7] = addr[7];
assign addr_memory_slice_15[8] = addr[8];
assign addr_memory_slice_15[9] = addr[9];
assign addr_memory_slice_15[10] = addr[10];
assign data_memory_slice_15[0] = data[15];
assign we_memory_slice_15[0] = we[0];
assign clk_memory_slice_15[0] = clk[0];
 
memory_slice memory_slice_15 ( .clk(clk_memory_slice_15), .addr(addr_memory_slice_15), .data(data_memory_slice_15), .we(we_memory_slice_15), .out(out_memory_slice_15) );

assign addr_memory_slice_16[0] = addr[0];
assign addr_memory_slice_16[1] = addr[1];
assign addr_memory_slice_16[2] = addr[2];
assign addr_memory_slice_16[3] = addr[3];
assign addr_memory_slice_16[4] = addr[4];
assign addr_memory_slice_16[5] = addr[5];
assign addr_memory_slice_16[6] = addr[6];
assign addr_memory_slice_16[7] = addr[7];
assign addr_memory_slice_16[8] = addr[8];
assign addr_memory_slice_16[9] = addr[9];
assign addr_memory_slice_16[10] = addr[10];
assign data_memory_slice_16[0] = data[16];
assign we_memory_slice_16[0] = we[0];
assign clk_memory_slice_16[0] = clk[0];
 
memory_slice memory_slice_16 ( .clk(clk_memory_slice_16), .addr(addr_memory_slice_16), .data(data_memory_slice_16), .we(we_memory_slice_16), .out(out_memory_slice_16) );

assign addr_memory_slice_17[0] = addr[0];
assign addr_memory_slice_17[1] = addr[1];
assign addr_memory_slice_17[2] = addr[2];
assign addr_memory_slice_17[3] = addr[3];
assign addr_memory_slice_17[4] = addr[4];
assign addr_memory_slice_17[5] = addr[5];
assign addr_memory_slice_17[6] = addr[6];
assign addr_memory_slice_17[7] = addr[7];
assign addr_memory_slice_17[8] = addr[8];
assign addr_memory_slice_17[9] = addr[9];
assign addr_memory_slice_17[10] = addr[10];
assign data_memory_slice_17[0] = data[17];
assign we_memory_slice_17[0] = we[0];
assign clk_memory_slice_17[0] = clk[0];
 
memory_slice memory_slice_17 ( .clk(clk_memory_slice_17), .addr(addr_memory_slice_17), .data(data_memory_slice_17), .we(we_memory_slice_17), .out(out_memory_slice_17) );

assign addr_memory_slice_18[0] = addr[0];
assign addr_memory_slice_18[1] = addr[1];
assign addr_memory_slice_18[2] = addr[2];
assign addr_memory_slice_18[3] = addr[3];
assign addr_memory_slice_18[4] = addr[4];
assign addr_memory_slice_18[5] = addr[5];
assign addr_memory_slice_18[6] = addr[6];
assign addr_memory_slice_18[7] = addr[7];
assign addr_memory_slice_18[8] = addr[8];
assign addr_memory_slice_18[9] = addr[9];
assign addr_memory_slice_18[10] = addr[10];
assign data_memory_slice_18[0] = data[18];
assign we_memory_slice_18[0] = we[0];
assign clk_memory_slice_18[0] = clk[0];
 
memory_slice memory_slice_18 ( .clk(clk_memory_slice_18), .addr(addr_memory_slice_18), .data(data_memory_slice_18), .we(we_memory_slice_18), .out(out_memory_slice_18) );

assign addr_memory_slice_19[0] = addr[0];
assign addr_memory_slice_19[1] = addr[1];
assign addr_memory_slice_19[2] = addr[2];
assign addr_memory_slice_19[3] = addr[3];
assign addr_memory_slice_19[4] = addr[4];
assign addr_memory_slice_19[5] = addr[5];
assign addr_memory_slice_19[6] = addr[6];
assign addr_memory_slice_19[7] = addr[7];
assign addr_memory_slice_19[8] = addr[8];
assign addr_memory_slice_19[9] = addr[9];
assign addr_memory_slice_19[10] = addr[10];
assign data_memory_slice_19[0] = data[19];
assign we_memory_slice_19[0] = we[0];
assign clk_memory_slice_19[0] = clk[0];
 
memory_slice memory_slice_19 ( .clk(clk_memory_slice_19), .addr(addr_memory_slice_19), .data(data_memory_slice_19), .we(we_memory_slice_19), .out(out_memory_slice_19) );

assign addr_memory_slice_20[0] = addr[0];
assign addr_memory_slice_20[1] = addr[1];
assign addr_memory_slice_20[2] = addr[2];
assign addr_memory_slice_20[3] = addr[3];
assign addr_memory_slice_20[4] = addr[4];
assign addr_memory_slice_20[5] = addr[5];
assign addr_memory_slice_20[6] = addr[6];
assign addr_memory_slice_20[7] = addr[7];
assign addr_memory_slice_20[8] = addr[8];
assign addr_memory_slice_20[9] = addr[9];
assign addr_memory_slice_20[10] = addr[10];
assign data_memory_slice_20[0] = data[20];
assign we_memory_slice_20[0] = we[0];
assign clk_memory_slice_20[0] = clk[0];
 
memory_slice memory_slice_20 ( .clk(clk_memory_slice_20), .addr(addr_memory_slice_20), .data(data_memory_slice_20), .we(we_memory_slice_20), .out(out_memory_slice_20) );

assign addr_memory_slice_21[0] = addr[0];
assign addr_memory_slice_21[1] = addr[1];
assign addr_memory_slice_21[2] = addr[2];
assign addr_memory_slice_21[3] = addr[3];
assign addr_memory_slice_21[4] = addr[4];
assign addr_memory_slice_21[5] = addr[5];
assign addr_memory_slice_21[6] = addr[6];
assign addr_memory_slice_21[7] = addr[7];
assign addr_memory_slice_21[8] = addr[8];
assign addr_memory_slice_21[9] = addr[9];
assign addr_memory_slice_21[10] = addr[10];
assign data_memory_slice_21[0] = data[21];
assign we_memory_slice_21[0] = we[0];
assign clk_memory_slice_21[0] = clk[0];
 
memory_slice memory_slice_21 ( .clk(clk_memory_slice_21), .addr(addr_memory_slice_21), .data(data_memory_slice_21), .we(we_memory_slice_21), .out(out_memory_slice_21) );

assign addr_memory_slice_22[0] = addr[0];
assign addr_memory_slice_22[1] = addr[1];
assign addr_memory_slice_22[2] = addr[2];
assign addr_memory_slice_22[3] = addr[3];
assign addr_memory_slice_22[4] = addr[4];
assign addr_memory_slice_22[5] = addr[5];
assign addr_memory_slice_22[6] = addr[6];
assign addr_memory_slice_22[7] = addr[7];
assign addr_memory_slice_22[8] = addr[8];
assign addr_memory_slice_22[9] = addr[9];
assign addr_memory_slice_22[10] = addr[10];
assign data_memory_slice_22[0] = data[22];
assign we_memory_slice_22[0] = we[0];
assign clk_memory_slice_22[0] = clk[0];
 
memory_slice memory_slice_22 ( .clk(clk_memory_slice_22), .addr(addr_memory_slice_22), .data(data_memory_slice_22), .we(we_memory_slice_22), .out(out_memory_slice_22) );

assign addr_memory_slice_23[0] = addr[0];
assign addr_memory_slice_23[1] = addr[1];
assign addr_memory_slice_23[2] = addr[2];
assign addr_memory_slice_23[3] = addr[3];
assign addr_memory_slice_23[4] = addr[4];
assign addr_memory_slice_23[5] = addr[5];
assign addr_memory_slice_23[6] = addr[6];
assign addr_memory_slice_23[7] = addr[7];
assign addr_memory_slice_23[8] = addr[8];
assign addr_memory_slice_23[9] = addr[9];
assign addr_memory_slice_23[10] = addr[10];
assign data_memory_slice_23[0] = data[23];
assign we_memory_slice_23[0] = we[0];
assign clk_memory_slice_23[0] = clk[0];
 
memory_slice memory_slice_23 ( .clk(clk_memory_slice_23), .addr(addr_memory_slice_23), .data(data_memory_slice_23), .we(we_memory_slice_23), .out(out_memory_slice_23) );

assign addr_memory_slice_24[0] = addr[0];
assign addr_memory_slice_24[1] = addr[1];
assign addr_memory_slice_24[2] = addr[2];
assign addr_memory_slice_24[3] = addr[3];
assign addr_memory_slice_24[4] = addr[4];
assign addr_memory_slice_24[5] = addr[5];
assign addr_memory_slice_24[6] = addr[6];
assign addr_memory_slice_24[7] = addr[7];
assign addr_memory_slice_24[8] = addr[8];
assign addr_memory_slice_24[9] = addr[9];
assign addr_memory_slice_24[10] = addr[10];
assign data_memory_slice_24[0] = data[24];
assign we_memory_slice_24[0] = we[0];
assign clk_memory_slice_24[0] = clk[0];
 
memory_slice memory_slice_24 ( .clk(clk_memory_slice_24), .addr(addr_memory_slice_24), .data(data_memory_slice_24), .we(we_memory_slice_24), .out(out_memory_slice_24) );

assign addr_memory_slice_25[0] = addr[0];
assign addr_memory_slice_25[1] = addr[1];
assign addr_memory_slice_25[2] = addr[2];
assign addr_memory_slice_25[3] = addr[3];
assign addr_memory_slice_25[4] = addr[4];
assign addr_memory_slice_25[5] = addr[5];
assign addr_memory_slice_25[6] = addr[6];
assign addr_memory_slice_25[7] = addr[7];
assign addr_memory_slice_25[8] = addr[8];
assign addr_memory_slice_25[9] = addr[9];
assign addr_memory_slice_25[10] = addr[10];
assign data_memory_slice_25[0] = data[25];
assign we_memory_slice_25[0] = we[0];
assign clk_memory_slice_25[0] = clk[0];
 
memory_slice memory_slice_25 ( .clk(clk_memory_slice_25), .addr(addr_memory_slice_25), .data(data_memory_slice_25), .we(we_memory_slice_25), .out(out_memory_slice_25) );

assign addr_memory_slice_26[0] = addr[0];
assign addr_memory_slice_26[1] = addr[1];
assign addr_memory_slice_26[2] = addr[2];
assign addr_memory_slice_26[3] = addr[3];
assign addr_memory_slice_26[4] = addr[4];
assign addr_memory_slice_26[5] = addr[5];
assign addr_memory_slice_26[6] = addr[6];
assign addr_memory_slice_26[7] = addr[7];
assign addr_memory_slice_26[8] = addr[8];
assign addr_memory_slice_26[9] = addr[9];
assign addr_memory_slice_26[10] = addr[10];
assign data_memory_slice_26[0] = data[26];
assign we_memory_slice_26[0] = we[0];
assign clk_memory_slice_26[0] = clk[0];
 
memory_slice memory_slice_26 ( .clk(clk_memory_slice_26), .addr(addr_memory_slice_26), .data(data_memory_slice_26), .we(we_memory_slice_26), .out(out_memory_slice_26) );

assign addr_memory_slice_27[0] = addr[0];
assign addr_memory_slice_27[1] = addr[1];
assign addr_memory_slice_27[2] = addr[2];
assign addr_memory_slice_27[3] = addr[3];
assign addr_memory_slice_27[4] = addr[4];
assign addr_memory_slice_27[5] = addr[5];
assign addr_memory_slice_27[6] = addr[6];
assign addr_memory_slice_27[7] = addr[7];
assign addr_memory_slice_27[8] = addr[8];
assign addr_memory_slice_27[9] = addr[9];
assign addr_memory_slice_27[10] = addr[10];
assign data_memory_slice_27[0] = data[27];
assign we_memory_slice_27[0] = we[0];
assign clk_memory_slice_27[0] = clk[0];
 
memory_slice memory_slice_27 ( .clk(clk_memory_slice_27), .addr(addr_memory_slice_27), .data(data_memory_slice_27), .we(we_memory_slice_27), .out(out_memory_slice_27) );

assign addr_memory_slice_28[0] = addr[0];
assign addr_memory_slice_28[1] = addr[1];
assign addr_memory_slice_28[2] = addr[2];
assign addr_memory_slice_28[3] = addr[3];
assign addr_memory_slice_28[4] = addr[4];
assign addr_memory_slice_28[5] = addr[5];
assign addr_memory_slice_28[6] = addr[6];
assign addr_memory_slice_28[7] = addr[7];
assign addr_memory_slice_28[8] = addr[8];
assign addr_memory_slice_28[9] = addr[9];
assign addr_memory_slice_28[10] = addr[10];
assign data_memory_slice_28[0] = data[28];
assign we_memory_slice_28[0] = we[0];
assign clk_memory_slice_28[0] = clk[0];
 
memory_slice memory_slice_28 ( .clk(clk_memory_slice_28), .addr(addr_memory_slice_28), .data(data_memory_slice_28), .we(we_memory_slice_28), .out(out_memory_slice_28) );

assign addr_memory_slice_29[0] = addr[0];
assign addr_memory_slice_29[1] = addr[1];
assign addr_memory_slice_29[2] = addr[2];
assign addr_memory_slice_29[3] = addr[3];
assign addr_memory_slice_29[4] = addr[4];
assign addr_memory_slice_29[5] = addr[5];
assign addr_memory_slice_29[6] = addr[6];
assign addr_memory_slice_29[7] = addr[7];
assign addr_memory_slice_29[8] = addr[8];
assign addr_memory_slice_29[9] = addr[9];
assign addr_memory_slice_29[10] = addr[10];
assign data_memory_slice_29[0] = data[29];
assign we_memory_slice_29[0] = we[0];
assign clk_memory_slice_29[0] = clk[0];
 
memory_slice memory_slice_29 ( .clk(clk_memory_slice_29), .addr(addr_memory_slice_29), .data(data_memory_slice_29), .we(we_memory_slice_29), .out(out_memory_slice_29) );

assign addr_memory_slice_30[0] = addr[0];
assign addr_memory_slice_30[1] = addr[1];
assign addr_memory_slice_30[2] = addr[2];
assign addr_memory_slice_30[3] = addr[3];
assign addr_memory_slice_30[4] = addr[4];
assign addr_memory_slice_30[5] = addr[5];
assign addr_memory_slice_30[6] = addr[6];
assign addr_memory_slice_30[7] = addr[7];
assign addr_memory_slice_30[8] = addr[8];
assign addr_memory_slice_30[9] = addr[9];
assign addr_memory_slice_30[10] = addr[10];
assign data_memory_slice_30[0] = data[30];
assign we_memory_slice_30[0] = we[0];
assign clk_memory_slice_30[0] = clk[0];
 
memory_slice memory_slice_30 ( .clk(clk_memory_slice_30), .addr(addr_memory_slice_30), .data(data_memory_slice_30), .we(we_memory_slice_30), .out(out_memory_slice_30) );

assign addr_memory_slice_31[0] = addr[0];
assign addr_memory_slice_31[1] = addr[1];
assign addr_memory_slice_31[2] = addr[2];
assign addr_memory_slice_31[3] = addr[3];
assign addr_memory_slice_31[4] = addr[4];
assign addr_memory_slice_31[5] = addr[5];
assign addr_memory_slice_31[6] = addr[6];
assign addr_memory_slice_31[7] = addr[7];
assign addr_memory_slice_31[8] = addr[8];
assign addr_memory_slice_31[9] = addr[9];
assign addr_memory_slice_31[10] = addr[10];
assign data_memory_slice_31[0] = data[31];
assign we_memory_slice_31[0] = we[0];
assign clk_memory_slice_31[0] = clk[0];
 
memory_slice memory_slice_31 ( .clk(clk_memory_slice_31), .addr(addr_memory_slice_31), .data(data_memory_slice_31), .we(we_memory_slice_31), .out(out_memory_slice_31) );

assign addr_memory_slice_32[0] = addr[0];
assign addr_memory_slice_32[1] = addr[1];
assign addr_memory_slice_32[2] = addr[2];
assign addr_memory_slice_32[3] = addr[3];
assign addr_memory_slice_32[4] = addr[4];
assign addr_memory_slice_32[5] = addr[5];
assign addr_memory_slice_32[6] = addr[6];
assign addr_memory_slice_32[7] = addr[7];
assign addr_memory_slice_32[8] = addr[8];
assign addr_memory_slice_32[9] = addr[9];
assign addr_memory_slice_32[10] = addr[10];
assign data_memory_slice_32[0] = data[32];
assign we_memory_slice_32[0] = we[0];
assign clk_memory_slice_32[0] = clk[0];
 
memory_slice memory_slice_32 ( .clk(clk_memory_slice_32), .addr(addr_memory_slice_32), .data(data_memory_slice_32), .we(we_memory_slice_32), .out(out_memory_slice_32) );

assign addr_memory_slice_33[0] = addr[0];
assign addr_memory_slice_33[1] = addr[1];
assign addr_memory_slice_33[2] = addr[2];
assign addr_memory_slice_33[3] = addr[3];
assign addr_memory_slice_33[4] = addr[4];
assign addr_memory_slice_33[5] = addr[5];
assign addr_memory_slice_33[6] = addr[6];
assign addr_memory_slice_33[7] = addr[7];
assign addr_memory_slice_33[8] = addr[8];
assign addr_memory_slice_33[9] = addr[9];
assign addr_memory_slice_33[10] = addr[10];
assign data_memory_slice_33[0] = data[33];
assign we_memory_slice_33[0] = we[0];
assign clk_memory_slice_33[0] = clk[0];
 
memory_slice memory_slice_33 ( .clk(clk_memory_slice_33), .addr(addr_memory_slice_33), .data(data_memory_slice_33), .we(we_memory_slice_33), .out(out_memory_slice_33) );

assign addr_memory_slice_34[0] = addr[0];
assign addr_memory_slice_34[1] = addr[1];
assign addr_memory_slice_34[2] = addr[2];
assign addr_memory_slice_34[3] = addr[3];
assign addr_memory_slice_34[4] = addr[4];
assign addr_memory_slice_34[5] = addr[5];
assign addr_memory_slice_34[6] = addr[6];
assign addr_memory_slice_34[7] = addr[7];
assign addr_memory_slice_34[8] = addr[8];
assign addr_memory_slice_34[9] = addr[9];
assign addr_memory_slice_34[10] = addr[10];
assign data_memory_slice_34[0] = data[34];
assign we_memory_slice_34[0] = we[0];
assign clk_memory_slice_34[0] = clk[0];
 
memory_slice memory_slice_34 ( .clk(clk_memory_slice_34), .addr(addr_memory_slice_34), .data(data_memory_slice_34), .we(we_memory_slice_34), .out(out_memory_slice_34) );

assign addr_memory_slice_35[0] = addr[0];
assign addr_memory_slice_35[1] = addr[1];
assign addr_memory_slice_35[2] = addr[2];
assign addr_memory_slice_35[3] = addr[3];
assign addr_memory_slice_35[4] = addr[4];
assign addr_memory_slice_35[5] = addr[5];
assign addr_memory_slice_35[6] = addr[6];
assign addr_memory_slice_35[7] = addr[7];
assign addr_memory_slice_35[8] = addr[8];
assign addr_memory_slice_35[9] = addr[9];
assign addr_memory_slice_35[10] = addr[10];
assign data_memory_slice_35[0] = data[35];
assign we_memory_slice_35[0] = we[0];
assign clk_memory_slice_35[0] = clk[0];
 
memory_slice memory_slice_35 ( .clk(clk_memory_slice_35), .addr(addr_memory_slice_35), .data(data_memory_slice_35), .we(we_memory_slice_35), .out(out_memory_slice_35) );

assign addr_memory_slice_36[0] = addr[0];
assign addr_memory_slice_36[1] = addr[1];
assign addr_memory_slice_36[2] = addr[2];
assign addr_memory_slice_36[3] = addr[3];
assign addr_memory_slice_36[4] = addr[4];
assign addr_memory_slice_36[5] = addr[5];
assign addr_memory_slice_36[6] = addr[6];
assign addr_memory_slice_36[7] = addr[7];
assign addr_memory_slice_36[8] = addr[8];
assign addr_memory_slice_36[9] = addr[9];
assign addr_memory_slice_36[10] = addr[10];
assign data_memory_slice_36[0] = data[36];
assign we_memory_slice_36[0] = we[0];
assign clk_memory_slice_36[0] = clk[0];
 
memory_slice memory_slice_36 ( .clk(clk_memory_slice_36), .addr(addr_memory_slice_36), .data(data_memory_slice_36), .we(we_memory_slice_36), .out(out_memory_slice_36) );

assign addr_memory_slice_37[0] = addr[0];
assign addr_memory_slice_37[1] = addr[1];
assign addr_memory_slice_37[2] = addr[2];
assign addr_memory_slice_37[3] = addr[3];
assign addr_memory_slice_37[4] = addr[4];
assign addr_memory_slice_37[5] = addr[5];
assign addr_memory_slice_37[6] = addr[6];
assign addr_memory_slice_37[7] = addr[7];
assign addr_memory_slice_37[8] = addr[8];
assign addr_memory_slice_37[9] = addr[9];
assign addr_memory_slice_37[10] = addr[10];
assign data_memory_slice_37[0] = data[37];
assign we_memory_slice_37[0] = we[0];
assign clk_memory_slice_37[0] = clk[0];
 
memory_slice memory_slice_37 ( .clk(clk_memory_slice_37), .addr(addr_memory_slice_37), .data(data_memory_slice_37), .we(we_memory_slice_37), .out(out_memory_slice_37) );

assign addr_memory_slice_38[0] = addr[0];
assign addr_memory_slice_38[1] = addr[1];
assign addr_memory_slice_38[2] = addr[2];
assign addr_memory_slice_38[3] = addr[3];
assign addr_memory_slice_38[4] = addr[4];
assign addr_memory_slice_38[5] = addr[5];
assign addr_memory_slice_38[6] = addr[6];
assign addr_memory_slice_38[7] = addr[7];
assign addr_memory_slice_38[8] = addr[8];
assign addr_memory_slice_38[9] = addr[9];
assign addr_memory_slice_38[10] = addr[10];
assign data_memory_slice_38[0] = data[38];
assign we_memory_slice_38[0] = we[0];
assign clk_memory_slice_38[0] = clk[0];
 
memory_slice memory_slice_38 ( .clk(clk_memory_slice_38), .addr(addr_memory_slice_38), .data(data_memory_slice_38), .we(we_memory_slice_38), .out(out_memory_slice_38) );

assign addr_memory_slice_39[0] = addr[0];
assign addr_memory_slice_39[1] = addr[1];
assign addr_memory_slice_39[2] = addr[2];
assign addr_memory_slice_39[3] = addr[3];
assign addr_memory_slice_39[4] = addr[4];
assign addr_memory_slice_39[5] = addr[5];
assign addr_memory_slice_39[6] = addr[6];
assign addr_memory_slice_39[7] = addr[7];
assign addr_memory_slice_39[8] = addr[8];
assign addr_memory_slice_39[9] = addr[9];
assign addr_memory_slice_39[10] = addr[10];
assign data_memory_slice_39[0] = data[39];
assign we_memory_slice_39[0] = we[0];
assign clk_memory_slice_39[0] = clk[0];
 
memory_slice memory_slice_39 ( .clk(clk_memory_slice_39), .addr(addr_memory_slice_39), .data(data_memory_slice_39), .we(we_memory_slice_39), .out(out_memory_slice_39) );

assign addr_memory_slice_40[0] = addr[0];
assign addr_memory_slice_40[1] = addr[1];
assign addr_memory_slice_40[2] = addr[2];
assign addr_memory_slice_40[3] = addr[3];
assign addr_memory_slice_40[4] = addr[4];
assign addr_memory_slice_40[5] = addr[5];
assign addr_memory_slice_40[6] = addr[6];
assign addr_memory_slice_40[7] = addr[7];
assign addr_memory_slice_40[8] = addr[8];
assign addr_memory_slice_40[9] = addr[9];
assign addr_memory_slice_40[10] = addr[10];
assign data_memory_slice_40[0] = data[40];
assign we_memory_slice_40[0] = we[0];
assign clk_memory_slice_40[0] = clk[0];
 
memory_slice memory_slice_40 ( .clk(clk_memory_slice_40), .addr(addr_memory_slice_40), .data(data_memory_slice_40), .we(we_memory_slice_40), .out(out_memory_slice_40) );

assign addr_memory_slice_41[0] = addr[0];
assign addr_memory_slice_41[1] = addr[1];
assign addr_memory_slice_41[2] = addr[2];
assign addr_memory_slice_41[3] = addr[3];
assign addr_memory_slice_41[4] = addr[4];
assign addr_memory_slice_41[5] = addr[5];
assign addr_memory_slice_41[6] = addr[6];
assign addr_memory_slice_41[7] = addr[7];
assign addr_memory_slice_41[8] = addr[8];
assign addr_memory_slice_41[9] = addr[9];
assign addr_memory_slice_41[10] = addr[10];
assign data_memory_slice_41[0] = data[41];
assign we_memory_slice_41[0] = we[0];
assign clk_memory_slice_41[0] = clk[0];
 
memory_slice memory_slice_41 ( .clk(clk_memory_slice_41), .addr(addr_memory_slice_41), .data(data_memory_slice_41), .we(we_memory_slice_41), .out(out_memory_slice_41) );

assign addr_memory_slice_42[0] = addr[0];
assign addr_memory_slice_42[1] = addr[1];
assign addr_memory_slice_42[2] = addr[2];
assign addr_memory_slice_42[3] = addr[3];
assign addr_memory_slice_42[4] = addr[4];
assign addr_memory_slice_42[5] = addr[5];
assign addr_memory_slice_42[6] = addr[6];
assign addr_memory_slice_42[7] = addr[7];
assign addr_memory_slice_42[8] = addr[8];
assign addr_memory_slice_42[9] = addr[9];
assign addr_memory_slice_42[10] = addr[10];
assign data_memory_slice_42[0] = data[42];
assign we_memory_slice_42[0] = we[0];
assign clk_memory_slice_42[0] = clk[0];
 
memory_slice memory_slice_42 ( .clk(clk_memory_slice_42), .addr(addr_memory_slice_42), .data(data_memory_slice_42), .we(we_memory_slice_42), .out(out_memory_slice_42) );

assign addr_memory_slice_43[0] = addr[0];
assign addr_memory_slice_43[1] = addr[1];
assign addr_memory_slice_43[2] = addr[2];
assign addr_memory_slice_43[3] = addr[3];
assign addr_memory_slice_43[4] = addr[4];
assign addr_memory_slice_43[5] = addr[5];
assign addr_memory_slice_43[6] = addr[6];
assign addr_memory_slice_43[7] = addr[7];
assign addr_memory_slice_43[8] = addr[8];
assign addr_memory_slice_43[9] = addr[9];
assign addr_memory_slice_43[10] = addr[10];
assign data_memory_slice_43[0] = data[43];
assign we_memory_slice_43[0] = we[0];
assign clk_memory_slice_43[0] = clk[0];
 
memory_slice memory_slice_43 ( .clk(clk_memory_slice_43), .addr(addr_memory_slice_43), .data(data_memory_slice_43), .we(we_memory_slice_43), .out(out_memory_slice_43) );

assign addr_memory_slice_44[0] = addr[0];
assign addr_memory_slice_44[1] = addr[1];
assign addr_memory_slice_44[2] = addr[2];
assign addr_memory_slice_44[3] = addr[3];
assign addr_memory_slice_44[4] = addr[4];
assign addr_memory_slice_44[5] = addr[5];
assign addr_memory_slice_44[6] = addr[6];
assign addr_memory_slice_44[7] = addr[7];
assign addr_memory_slice_44[8] = addr[8];
assign addr_memory_slice_44[9] = addr[9];
assign addr_memory_slice_44[10] = addr[10];
assign data_memory_slice_44[0] = data[44];
assign we_memory_slice_44[0] = we[0];
assign clk_memory_slice_44[0] = clk[0];
 
memory_slice memory_slice_44 ( .clk(clk_memory_slice_44), .addr(addr_memory_slice_44), .data(data_memory_slice_44), .we(we_memory_slice_44), .out(out_memory_slice_44) );

assign addr_memory_slice_45[0] = addr[0];
assign addr_memory_slice_45[1] = addr[1];
assign addr_memory_slice_45[2] = addr[2];
assign addr_memory_slice_45[3] = addr[3];
assign addr_memory_slice_45[4] = addr[4];
assign addr_memory_slice_45[5] = addr[5];
assign addr_memory_slice_45[6] = addr[6];
assign addr_memory_slice_45[7] = addr[7];
assign addr_memory_slice_45[8] = addr[8];
assign addr_memory_slice_45[9] = addr[9];
assign addr_memory_slice_45[10] = addr[10];
assign data_memory_slice_45[0] = data[45];
assign we_memory_slice_45[0] = we[0];
assign clk_memory_slice_45[0] = clk[0];
 
memory_slice memory_slice_45 ( .clk(clk_memory_slice_45), .addr(addr_memory_slice_45), .data(data_memory_slice_45), .we(we_memory_slice_45), .out(out_memory_slice_45) );

assign addr_memory_slice_46[0] = addr[0];
assign addr_memory_slice_46[1] = addr[1];
assign addr_memory_slice_46[2] = addr[2];
assign addr_memory_slice_46[3] = addr[3];
assign addr_memory_slice_46[4] = addr[4];
assign addr_memory_slice_46[5] = addr[5];
assign addr_memory_slice_46[6] = addr[6];
assign addr_memory_slice_46[7] = addr[7];
assign addr_memory_slice_46[8] = addr[8];
assign addr_memory_slice_46[9] = addr[9];
assign addr_memory_slice_46[10] = addr[10];
assign data_memory_slice_46[0] = data[46];
assign we_memory_slice_46[0] = we[0];
assign clk_memory_slice_46[0] = clk[0];
 
memory_slice memory_slice_46 ( .clk(clk_memory_slice_46), .addr(addr_memory_slice_46), .data(data_memory_slice_46), .we(we_memory_slice_46), .out(out_memory_slice_46) );

assign addr_memory_slice_47[0] = addr[0];
assign addr_memory_slice_47[1] = addr[1];
assign addr_memory_slice_47[2] = addr[2];
assign addr_memory_slice_47[3] = addr[3];
assign addr_memory_slice_47[4] = addr[4];
assign addr_memory_slice_47[5] = addr[5];
assign addr_memory_slice_47[6] = addr[6];
assign addr_memory_slice_47[7] = addr[7];
assign addr_memory_slice_47[8] = addr[8];
assign addr_memory_slice_47[9] = addr[9];
assign addr_memory_slice_47[10] = addr[10];
assign data_memory_slice_47[0] = data[47];
assign we_memory_slice_47[0] = we[0];
assign clk_memory_slice_47[0] = clk[0];
 
memory_slice memory_slice_47 ( .clk(clk_memory_slice_47), .addr(addr_memory_slice_47), .data(data_memory_slice_47), .we(we_memory_slice_47), .out(out_memory_slice_47) );

assign addr_memory_slice_48[0] = addr[0];
assign addr_memory_slice_48[1] = addr[1];
assign addr_memory_slice_48[2] = addr[2];
assign addr_memory_slice_48[3] = addr[3];
assign addr_memory_slice_48[4] = addr[4];
assign addr_memory_slice_48[5] = addr[5];
assign addr_memory_slice_48[6] = addr[6];
assign addr_memory_slice_48[7] = addr[7];
assign addr_memory_slice_48[8] = addr[8];
assign addr_memory_slice_48[9] = addr[9];
assign addr_memory_slice_48[10] = addr[10];
assign data_memory_slice_48[0] = data[48];
assign we_memory_slice_48[0] = we[0];
assign clk_memory_slice_48[0] = clk[0];
 
memory_slice memory_slice_48 ( .clk(clk_memory_slice_48), .addr(addr_memory_slice_48), .data(data_memory_slice_48), .we(we_memory_slice_48), .out(out_memory_slice_48) );

assign addr_memory_slice_49[0] = addr[0];
assign addr_memory_slice_49[1] = addr[1];
assign addr_memory_slice_49[2] = addr[2];
assign addr_memory_slice_49[3] = addr[3];
assign addr_memory_slice_49[4] = addr[4];
assign addr_memory_slice_49[5] = addr[5];
assign addr_memory_slice_49[6] = addr[6];
assign addr_memory_slice_49[7] = addr[7];
assign addr_memory_slice_49[8] = addr[8];
assign addr_memory_slice_49[9] = addr[9];
assign addr_memory_slice_49[10] = addr[10];
assign data_memory_slice_49[0] = data[49];
assign we_memory_slice_49[0] = we[0];
assign clk_memory_slice_49[0] = clk[0];
 
memory_slice memory_slice_49 ( .clk(clk_memory_slice_49), .addr(addr_memory_slice_49), .data(data_memory_slice_49), .we(we_memory_slice_49), .out(out_memory_slice_49) );

assign addr_memory_slice_50[0] = addr[0];
assign addr_memory_slice_50[1] = addr[1];
assign addr_memory_slice_50[2] = addr[2];
assign addr_memory_slice_50[3] = addr[3];
assign addr_memory_slice_50[4] = addr[4];
assign addr_memory_slice_50[5] = addr[5];
assign addr_memory_slice_50[6] = addr[6];
assign addr_memory_slice_50[7] = addr[7];
assign addr_memory_slice_50[8] = addr[8];
assign addr_memory_slice_50[9] = addr[9];
assign addr_memory_slice_50[10] = addr[10];
assign data_memory_slice_50[0] = data[50];
assign we_memory_slice_50[0] = we[0];
assign clk_memory_slice_50[0] = clk[0];
 
memory_slice memory_slice_50 ( .clk(clk_memory_slice_50), .addr(addr_memory_slice_50), .data(data_memory_slice_50), .we(we_memory_slice_50), .out(out_memory_slice_50) );

assign addr_memory_slice_51[0] = addr[0];
assign addr_memory_slice_51[1] = addr[1];
assign addr_memory_slice_51[2] = addr[2];
assign addr_memory_slice_51[3] = addr[3];
assign addr_memory_slice_51[4] = addr[4];
assign addr_memory_slice_51[5] = addr[5];
assign addr_memory_slice_51[6] = addr[6];
assign addr_memory_slice_51[7] = addr[7];
assign addr_memory_slice_51[8] = addr[8];
assign addr_memory_slice_51[9] = addr[9];
assign addr_memory_slice_51[10] = addr[10];
assign data_memory_slice_51[0] = data[51];
assign we_memory_slice_51[0] = we[0];
assign clk_memory_slice_51[0] = clk[0];
 
memory_slice memory_slice_51 ( .clk(clk_memory_slice_51), .addr(addr_memory_slice_51), .data(data_memory_slice_51), .we(we_memory_slice_51), .out(out_memory_slice_51) );

assign addr_memory_slice_52[0] = addr[0];
assign addr_memory_slice_52[1] = addr[1];
assign addr_memory_slice_52[2] = addr[2];
assign addr_memory_slice_52[3] = addr[3];
assign addr_memory_slice_52[4] = addr[4];
assign addr_memory_slice_52[5] = addr[5];
assign addr_memory_slice_52[6] = addr[6];
assign addr_memory_slice_52[7] = addr[7];
assign addr_memory_slice_52[8] = addr[8];
assign addr_memory_slice_52[9] = addr[9];
assign addr_memory_slice_52[10] = addr[10];
assign data_memory_slice_52[0] = data[52];
assign we_memory_slice_52[0] = we[0];
assign clk_memory_slice_52[0] = clk[0];
 
memory_slice memory_slice_52 ( .clk(clk_memory_slice_52), .addr(addr_memory_slice_52), .data(data_memory_slice_52), .we(we_memory_slice_52), .out(out_memory_slice_52) );

assign addr_memory_slice_53[0] = addr[0];
assign addr_memory_slice_53[1] = addr[1];
assign addr_memory_slice_53[2] = addr[2];
assign addr_memory_slice_53[3] = addr[3];
assign addr_memory_slice_53[4] = addr[4];
assign addr_memory_slice_53[5] = addr[5];
assign addr_memory_slice_53[6] = addr[6];
assign addr_memory_slice_53[7] = addr[7];
assign addr_memory_slice_53[8] = addr[8];
assign addr_memory_slice_53[9] = addr[9];
assign addr_memory_slice_53[10] = addr[10];
assign data_memory_slice_53[0] = data[53];
assign we_memory_slice_53[0] = we[0];
assign clk_memory_slice_53[0] = clk[0];
 
memory_slice memory_slice_53 ( .clk(clk_memory_slice_53), .addr(addr_memory_slice_53), .data(data_memory_slice_53), .we(we_memory_slice_53), .out(out_memory_slice_53) );

assign addr_memory_slice_54[0] = addr[0];
assign addr_memory_slice_54[1] = addr[1];
assign addr_memory_slice_54[2] = addr[2];
assign addr_memory_slice_54[3] = addr[3];
assign addr_memory_slice_54[4] = addr[4];
assign addr_memory_slice_54[5] = addr[5];
assign addr_memory_slice_54[6] = addr[6];
assign addr_memory_slice_54[7] = addr[7];
assign addr_memory_slice_54[8] = addr[8];
assign addr_memory_slice_54[9] = addr[9];
assign addr_memory_slice_54[10] = addr[10];
assign data_memory_slice_54[0] = data[54];
assign we_memory_slice_54[0] = we[0];
assign clk_memory_slice_54[0] = clk[0];
 
memory_slice memory_slice_54 ( .clk(clk_memory_slice_54), .addr(addr_memory_slice_54), .data(data_memory_slice_54), .we(we_memory_slice_54), .out(out_memory_slice_54) );

assign addr_memory_slice_55[0] = addr[0];
assign addr_memory_slice_55[1] = addr[1];
assign addr_memory_slice_55[2] = addr[2];
assign addr_memory_slice_55[3] = addr[3];
assign addr_memory_slice_55[4] = addr[4];
assign addr_memory_slice_55[5] = addr[5];
assign addr_memory_slice_55[6] = addr[6];
assign addr_memory_slice_55[7] = addr[7];
assign addr_memory_slice_55[8] = addr[8];
assign addr_memory_slice_55[9] = addr[9];
assign addr_memory_slice_55[10] = addr[10];
assign data_memory_slice_55[0] = data[55];
assign we_memory_slice_55[0] = we[0];
assign clk_memory_slice_55[0] = clk[0];
 
memory_slice memory_slice_55 ( .clk(clk_memory_slice_55), .addr(addr_memory_slice_55), .data(data_memory_slice_55), .we(we_memory_slice_55), .out(out_memory_slice_55) );

assign addr_memory_slice_56[0] = addr[0];
assign addr_memory_slice_56[1] = addr[1];
assign addr_memory_slice_56[2] = addr[2];
assign addr_memory_slice_56[3] = addr[3];
assign addr_memory_slice_56[4] = addr[4];
assign addr_memory_slice_56[5] = addr[5];
assign addr_memory_slice_56[6] = addr[6];
assign addr_memory_slice_56[7] = addr[7];
assign addr_memory_slice_56[8] = addr[8];
assign addr_memory_slice_56[9] = addr[9];
assign addr_memory_slice_56[10] = addr[10];
assign data_memory_slice_56[0] = data[56];
assign we_memory_slice_56[0] = we[0];
assign clk_memory_slice_56[0] = clk[0];
 
memory_slice memory_slice_56 ( .clk(clk_memory_slice_56), .addr(addr_memory_slice_56), .data(data_memory_slice_56), .we(we_memory_slice_56), .out(out_memory_slice_56) );

assign addr_memory_slice_57[0] = addr[0];
assign addr_memory_slice_57[1] = addr[1];
assign addr_memory_slice_57[2] = addr[2];
assign addr_memory_slice_57[3] = addr[3];
assign addr_memory_slice_57[4] = addr[4];
assign addr_memory_slice_57[5] = addr[5];
assign addr_memory_slice_57[6] = addr[6];
assign addr_memory_slice_57[7] = addr[7];
assign addr_memory_slice_57[8] = addr[8];
assign addr_memory_slice_57[9] = addr[9];
assign addr_memory_slice_57[10] = addr[10];
assign data_memory_slice_57[0] = data[57];
assign we_memory_slice_57[0] = we[0];
assign clk_memory_slice_57[0] = clk[0];
 
memory_slice memory_slice_57 ( .clk(clk_memory_slice_57), .addr(addr_memory_slice_57), .data(data_memory_slice_57), .we(we_memory_slice_57), .out(out_memory_slice_57) );

assign addr_memory_slice_58[0] = addr[0];
assign addr_memory_slice_58[1] = addr[1];
assign addr_memory_slice_58[2] = addr[2];
assign addr_memory_slice_58[3] = addr[3];
assign addr_memory_slice_58[4] = addr[4];
assign addr_memory_slice_58[5] = addr[5];
assign addr_memory_slice_58[6] = addr[6];
assign addr_memory_slice_58[7] = addr[7];
assign addr_memory_slice_58[8] = addr[8];
assign addr_memory_slice_58[9] = addr[9];
assign addr_memory_slice_58[10] = addr[10];
assign data_memory_slice_58[0] = data[58];
assign we_memory_slice_58[0] = we[0];
assign clk_memory_slice_58[0] = clk[0];
 
memory_slice memory_slice_58 ( .clk(clk_memory_slice_58), .addr(addr_memory_slice_58), .data(data_memory_slice_58), .we(we_memory_slice_58), .out(out_memory_slice_58) );

assign addr_memory_slice_59[0] = addr[0];
assign addr_memory_slice_59[1] = addr[1];
assign addr_memory_slice_59[2] = addr[2];
assign addr_memory_slice_59[3] = addr[3];
assign addr_memory_slice_59[4] = addr[4];
assign addr_memory_slice_59[5] = addr[5];
assign addr_memory_slice_59[6] = addr[6];
assign addr_memory_slice_59[7] = addr[7];
assign addr_memory_slice_59[8] = addr[8];
assign addr_memory_slice_59[9] = addr[9];
assign addr_memory_slice_59[10] = addr[10];
assign data_memory_slice_59[0] = data[59];
assign we_memory_slice_59[0] = we[0];
assign clk_memory_slice_59[0] = clk[0];
 
memory_slice memory_slice_59 ( .clk(clk_memory_slice_59), .addr(addr_memory_slice_59), .data(data_memory_slice_59), .we(we_memory_slice_59), .out(out_memory_slice_59) );

assign addr_memory_slice_60[0] = addr[0];
assign addr_memory_slice_60[1] = addr[1];
assign addr_memory_slice_60[2] = addr[2];
assign addr_memory_slice_60[3] = addr[3];
assign addr_memory_slice_60[4] = addr[4];
assign addr_memory_slice_60[5] = addr[5];
assign addr_memory_slice_60[6] = addr[6];
assign addr_memory_slice_60[7] = addr[7];
assign addr_memory_slice_60[8] = addr[8];
assign addr_memory_slice_60[9] = addr[9];
assign addr_memory_slice_60[10] = addr[10];
assign data_memory_slice_60[0] = data[60];
assign we_memory_slice_60[0] = we[0];
assign clk_memory_slice_60[0] = clk[0];
 
memory_slice memory_slice_60 ( .clk(clk_memory_slice_60), .addr(addr_memory_slice_60), .data(data_memory_slice_60), .we(we_memory_slice_60), .out(out_memory_slice_60) );

assign addr_memory_slice_61[0] = addr[0];
assign addr_memory_slice_61[1] = addr[1];
assign addr_memory_slice_61[2] = addr[2];
assign addr_memory_slice_61[3] = addr[3];
assign addr_memory_slice_61[4] = addr[4];
assign addr_memory_slice_61[5] = addr[5];
assign addr_memory_slice_61[6] = addr[6];
assign addr_memory_slice_61[7] = addr[7];
assign addr_memory_slice_61[8] = addr[8];
assign addr_memory_slice_61[9] = addr[9];
assign addr_memory_slice_61[10] = addr[10];
assign data_memory_slice_61[0] = data[61];
assign we_memory_slice_61[0] = we[0];
assign clk_memory_slice_61[0] = clk[0];
 
memory_slice memory_slice_61 ( .clk(clk_memory_slice_61), .addr(addr_memory_slice_61), .data(data_memory_slice_61), .we(we_memory_slice_61), .out(out_memory_slice_61) );

assign addr_memory_slice_62[0] = addr[0];
assign addr_memory_slice_62[1] = addr[1];
assign addr_memory_slice_62[2] = addr[2];
assign addr_memory_slice_62[3] = addr[3];
assign addr_memory_slice_62[4] = addr[4];
assign addr_memory_slice_62[5] = addr[5];
assign addr_memory_slice_62[6] = addr[6];
assign addr_memory_slice_62[7] = addr[7];
assign addr_memory_slice_62[8] = addr[8];
assign addr_memory_slice_62[9] = addr[9];
assign addr_memory_slice_62[10] = addr[10];
assign data_memory_slice_62[0] = data[62];
assign we_memory_slice_62[0] = we[0];
assign clk_memory_slice_62[0] = clk[0];
 
memory_slice memory_slice_62 ( .clk(clk_memory_slice_62), .addr(addr_memory_slice_62), .data(data_memory_slice_62), .we(we_memory_slice_62), .out(out_memory_slice_62) );

assign addr_memory_slice_63[0] = addr[0];
assign addr_memory_slice_63[1] = addr[1];
assign addr_memory_slice_63[2] = addr[2];
assign addr_memory_slice_63[3] = addr[3];
assign addr_memory_slice_63[4] = addr[4];
assign addr_memory_slice_63[5] = addr[5];
assign addr_memory_slice_63[6] = addr[6];
assign addr_memory_slice_63[7] = addr[7];
assign addr_memory_slice_63[8] = addr[8];
assign addr_memory_slice_63[9] = addr[9];
assign addr_memory_slice_63[10] = addr[10];
assign data_memory_slice_63[0] = data[63];
assign we_memory_slice_63[0] = we[0];
assign clk_memory_slice_63[0] = clk[0];
 
memory_slice memory_slice_63 ( .clk(clk_memory_slice_63), .addr(addr_memory_slice_63), .data(data_memory_slice_63), .we(we_memory_slice_63), .out(out_memory_slice_63) );

assign addr_memory_slice_64[0] = addr[0];
assign addr_memory_slice_64[1] = addr[1];
assign addr_memory_slice_64[2] = addr[2];
assign addr_memory_slice_64[3] = addr[3];
assign addr_memory_slice_64[4] = addr[4];
assign addr_memory_slice_64[5] = addr[5];
assign addr_memory_slice_64[6] = addr[6];
assign addr_memory_slice_64[7] = addr[7];
assign addr_memory_slice_64[8] = addr[8];
assign addr_memory_slice_64[9] = addr[9];
assign addr_memory_slice_64[10] = addr[10];
assign data_memory_slice_64[0] = data[64];
assign we_memory_slice_64[0] = we[0];
assign clk_memory_slice_64[0] = clk[0];
 
memory_slice memory_slice_64 ( .clk(clk_memory_slice_64), .addr(addr_memory_slice_64), .data(data_memory_slice_64), .we(we_memory_slice_64), .out(out_memory_slice_64) );

assign addr_memory_slice_65[0] = addr[0];
assign addr_memory_slice_65[1] = addr[1];
assign addr_memory_slice_65[2] = addr[2];
assign addr_memory_slice_65[3] = addr[3];
assign addr_memory_slice_65[4] = addr[4];
assign addr_memory_slice_65[5] = addr[5];
assign addr_memory_slice_65[6] = addr[6];
assign addr_memory_slice_65[7] = addr[7];
assign addr_memory_slice_65[8] = addr[8];
assign addr_memory_slice_65[9] = addr[9];
assign addr_memory_slice_65[10] = addr[10];
assign data_memory_slice_65[0] = data[65];
assign we_memory_slice_65[0] = we[0];
assign clk_memory_slice_65[0] = clk[0];
 
memory_slice memory_slice_65 ( .clk(clk_memory_slice_65), .addr(addr_memory_slice_65), .data(data_memory_slice_65), .we(we_memory_slice_65), .out(out_memory_slice_65) );

assign addr_memory_slice_66[0] = addr[0];
assign addr_memory_slice_66[1] = addr[1];
assign addr_memory_slice_66[2] = addr[2];
assign addr_memory_slice_66[3] = addr[3];
assign addr_memory_slice_66[4] = addr[4];
assign addr_memory_slice_66[5] = addr[5];
assign addr_memory_slice_66[6] = addr[6];
assign addr_memory_slice_66[7] = addr[7];
assign addr_memory_slice_66[8] = addr[8];
assign addr_memory_slice_66[9] = addr[9];
assign addr_memory_slice_66[10] = addr[10];
assign data_memory_slice_66[0] = data[66];
assign we_memory_slice_66[0] = we[0];
assign clk_memory_slice_66[0] = clk[0];
 
memory_slice memory_slice_66 ( .clk(clk_memory_slice_66), .addr(addr_memory_slice_66), .data(data_memory_slice_66), .we(we_memory_slice_66), .out(out_memory_slice_66) );

assign addr_memory_slice_67[0] = addr[0];
assign addr_memory_slice_67[1] = addr[1];
assign addr_memory_slice_67[2] = addr[2];
assign addr_memory_slice_67[3] = addr[3];
assign addr_memory_slice_67[4] = addr[4];
assign addr_memory_slice_67[5] = addr[5];
assign addr_memory_slice_67[6] = addr[6];
assign addr_memory_slice_67[7] = addr[7];
assign addr_memory_slice_67[8] = addr[8];
assign addr_memory_slice_67[9] = addr[9];
assign addr_memory_slice_67[10] = addr[10];
assign data_memory_slice_67[0] = data[67];
assign we_memory_slice_67[0] = we[0];
assign clk_memory_slice_67[0] = clk[0];
 
memory_slice memory_slice_67 ( .clk(clk_memory_slice_67), .addr(addr_memory_slice_67), .data(data_memory_slice_67), .we(we_memory_slice_67), .out(out_memory_slice_67) );

assign addr_memory_slice_68[0] = addr[0];
assign addr_memory_slice_68[1] = addr[1];
assign addr_memory_slice_68[2] = addr[2];
assign addr_memory_slice_68[3] = addr[3];
assign addr_memory_slice_68[4] = addr[4];
assign addr_memory_slice_68[5] = addr[5];
assign addr_memory_slice_68[6] = addr[6];
assign addr_memory_slice_68[7] = addr[7];
assign addr_memory_slice_68[8] = addr[8];
assign addr_memory_slice_68[9] = addr[9];
assign addr_memory_slice_68[10] = addr[10];
assign data_memory_slice_68[0] = data[68];
assign we_memory_slice_68[0] = we[0];
assign clk_memory_slice_68[0] = clk[0];
 
memory_slice memory_slice_68 ( .clk(clk_memory_slice_68), .addr(addr_memory_slice_68), .data(data_memory_slice_68), .we(we_memory_slice_68), .out(out_memory_slice_68) );

assign addr_memory_slice_69[0] = addr[0];
assign addr_memory_slice_69[1] = addr[1];
assign addr_memory_slice_69[2] = addr[2];
assign addr_memory_slice_69[3] = addr[3];
assign addr_memory_slice_69[4] = addr[4];
assign addr_memory_slice_69[5] = addr[5];
assign addr_memory_slice_69[6] = addr[6];
assign addr_memory_slice_69[7] = addr[7];
assign addr_memory_slice_69[8] = addr[8];
assign addr_memory_slice_69[9] = addr[9];
assign addr_memory_slice_69[10] = addr[10];
assign data_memory_slice_69[0] = data[69];
assign we_memory_slice_69[0] = we[0];
assign clk_memory_slice_69[0] = clk[0];
 
memory_slice memory_slice_69 ( .clk(clk_memory_slice_69), .addr(addr_memory_slice_69), .data(data_memory_slice_69), .we(we_memory_slice_69), .out(out_memory_slice_69) );

assign addr_memory_slice_70[0] = addr[0];
assign addr_memory_slice_70[1] = addr[1];
assign addr_memory_slice_70[2] = addr[2];
assign addr_memory_slice_70[3] = addr[3];
assign addr_memory_slice_70[4] = addr[4];
assign addr_memory_slice_70[5] = addr[5];
assign addr_memory_slice_70[6] = addr[6];
assign addr_memory_slice_70[7] = addr[7];
assign addr_memory_slice_70[8] = addr[8];
assign addr_memory_slice_70[9] = addr[9];
assign addr_memory_slice_70[10] = addr[10];
assign data_memory_slice_70[0] = data[70];
assign we_memory_slice_70[0] = we[0];
assign clk_memory_slice_70[0] = clk[0];
 
memory_slice memory_slice_70 ( .clk(clk_memory_slice_70), .addr(addr_memory_slice_70), .data(data_memory_slice_70), .we(we_memory_slice_70), .out(out_memory_slice_70) );

assign addr_memory_slice_71[0] = addr[0];
assign addr_memory_slice_71[1] = addr[1];
assign addr_memory_slice_71[2] = addr[2];
assign addr_memory_slice_71[3] = addr[3];
assign addr_memory_slice_71[4] = addr[4];
assign addr_memory_slice_71[5] = addr[5];
assign addr_memory_slice_71[6] = addr[6];
assign addr_memory_slice_71[7] = addr[7];
assign addr_memory_slice_71[8] = addr[8];
assign addr_memory_slice_71[9] = addr[9];
assign addr_memory_slice_71[10] = addr[10];
assign data_memory_slice_71[0] = data[71];
assign we_memory_slice_71[0] = we[0];
assign clk_memory_slice_71[0] = clk[0];
 
memory_slice memory_slice_71 ( .clk(clk_memory_slice_71), .addr(addr_memory_slice_71), .data(data_memory_slice_71), .we(we_memory_slice_71), .out(out_memory_slice_71) );

//child output to block output
assign out[0] = out_memory_slice_0[0];
assign out[1] = out_memory_slice_1[0];
assign out[2] = out_memory_slice_2[0];
assign out[3] = out_memory_slice_3[0];
assign out[4] = out_memory_slice_4[0];
assign out[5] = out_memory_slice_5[0];
assign out[6] = out_memory_slice_6[0];
assign out[7] = out_memory_slice_7[0];
assign out[8] = out_memory_slice_8[0];
assign out[9] = out_memory_slice_9[0];
assign out[10] = out_memory_slice_10[0];
assign out[11] = out_memory_slice_11[0];
assign out[12] = out_memory_slice_12[0];
assign out[13] = out_memory_slice_13[0];
assign out[14] = out_memory_slice_14[0];
assign out[15] = out_memory_slice_15[0];
assign out[16] = out_memory_slice_16[0];
assign out[17] = out_memory_slice_17[0];
assign out[18] = out_memory_slice_18[0];
assign out[19] = out_memory_slice_19[0];
assign out[20] = out_memory_slice_20[0];
assign out[21] = out_memory_slice_21[0];
assign out[22] = out_memory_slice_22[0];
assign out[23] = out_memory_slice_23[0];
assign out[24] = out_memory_slice_24[0];
assign out[25] = out_memory_slice_25[0];
assign out[26] = out_memory_slice_26[0];
assign out[27] = out_memory_slice_27[0];
assign out[28] = out_memory_slice_28[0];
assign out[29] = out_memory_slice_29[0];
assign out[30] = out_memory_slice_30[0];
assign out[31] = out_memory_slice_31[0];
assign out[32] = out_memory_slice_32[0];
assign out[33] = out_memory_slice_33[0];
assign out[34] = out_memory_slice_34[0];
assign out[35] = out_memory_slice_35[0];
assign out[36] = out_memory_slice_36[0];
assign out[37] = out_memory_slice_37[0];
assign out[38] = out_memory_slice_38[0];
assign out[39] = out_memory_slice_39[0];
assign out[40] = out_memory_slice_40[0];
assign out[41] = out_memory_slice_41[0];
assign out[42] = out_memory_slice_42[0];
assign out[43] = out_memory_slice_43[0];
assign out[44] = out_memory_slice_44[0];
assign out[45] = out_memory_slice_45[0];
assign out[46] = out_memory_slice_46[0];
assign out[47] = out_memory_slice_47[0];
assign out[48] = out_memory_slice_48[0];
assign out[49] = out_memory_slice_49[0];
assign out[50] = out_memory_slice_50[0];
assign out[51] = out_memory_slice_51[0];
assign out[52] = out_memory_slice_52[0];
assign out[53] = out_memory_slice_53[0];
assign out[54] = out_memory_slice_54[0];
assign out[55] = out_memory_slice_55[0];
assign out[56] = out_memory_slice_56[0];
assign out[57] = out_memory_slice_57[0];
assign out[58] = out_memory_slice_58[0];
assign out[59] = out_memory_slice_59[0];
assign out[60] = out_memory_slice_60[0];
assign out[61] = out_memory_slice_61[0];
assign out[62] = out_memory_slice_62[0];
assign out[63] = out_memory_slice_63[0];
assign out[64] = out_memory_slice_64[0];
assign out[65] = out_memory_slice_65[0];
assign out[66] = out_memory_slice_66[0];
assign out[67] = out_memory_slice_67[0];
assign out[68] = out_memory_slice_68[0];
assign out[69] = out_memory_slice_69[0];
assign out[70] = out_memory_slice_70[0];
assign out[71] = out_memory_slice_71[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [11:0]addr1,
	input [11:0]addr2,
	input [0:0]data1,
	input [0:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [0:0]out1,
	output [0:0]out2
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_4096x36_dp /////////////////////////
/////////////////////////////////////////////////////
module mem_4096x36_dp (
	input [11:0]addr1,
	input [11:0]addr2,
	input [35:0]data1,
	input [35:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [35:0]out1,
	output [35:0]out2
);

////////child (0,0,0)////////
wire [11:0]addr1_memory_slice_0;//input to child
wire [11:0]addr2_memory_slice_0;//input to child
wire [0:0]data1_memory_slice_0;//input to child
wire [0:0]data2_memory_slice_0;//input to child
wire [0:0]we1_memory_slice_0;//input to child
wire [0:0]we2_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out1_memory_slice_0;//output from child
wire [0:0]out2_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [11:0]addr1_memory_slice_1;//input to child
wire [11:0]addr2_memory_slice_1;//input to child
wire [0:0]data1_memory_slice_1;//input to child
wire [0:0]data2_memory_slice_1;//input to child
wire [0:0]we1_memory_slice_1;//input to child
wire [0:0]we2_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out1_memory_slice_1;//output from child
wire [0:0]out2_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [11:0]addr1_memory_slice_2;//input to child
wire [11:0]addr2_memory_slice_2;//input to child
wire [0:0]data1_memory_slice_2;//input to child
wire [0:0]data2_memory_slice_2;//input to child
wire [0:0]we1_memory_slice_2;//input to child
wire [0:0]we2_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out1_memory_slice_2;//output from child
wire [0:0]out2_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [11:0]addr1_memory_slice_3;//input to child
wire [11:0]addr2_memory_slice_3;//input to child
wire [0:0]data1_memory_slice_3;//input to child
wire [0:0]data2_memory_slice_3;//input to child
wire [0:0]we1_memory_slice_3;//input to child
wire [0:0]we2_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out1_memory_slice_3;//output from child
wire [0:0]out2_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [11:0]addr1_memory_slice_4;//input to child
wire [11:0]addr2_memory_slice_4;//input to child
wire [0:0]data1_memory_slice_4;//input to child
wire [0:0]data2_memory_slice_4;//input to child
wire [0:0]we1_memory_slice_4;//input to child
wire [0:0]we2_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out1_memory_slice_4;//output from child
wire [0:0]out2_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [11:0]addr1_memory_slice_5;//input to child
wire [11:0]addr2_memory_slice_5;//input to child
wire [0:0]data1_memory_slice_5;//input to child
wire [0:0]data2_memory_slice_5;//input to child
wire [0:0]we1_memory_slice_5;//input to child
wire [0:0]we2_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out1_memory_slice_5;//output from child
wire [0:0]out2_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [11:0]addr1_memory_slice_6;//input to child
wire [11:0]addr2_memory_slice_6;//input to child
wire [0:0]data1_memory_slice_6;//input to child
wire [0:0]data2_memory_slice_6;//input to child
wire [0:0]we1_memory_slice_6;//input to child
wire [0:0]we2_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out1_memory_slice_6;//output from child
wire [0:0]out2_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [11:0]addr1_memory_slice_7;//input to child
wire [11:0]addr2_memory_slice_7;//input to child
wire [0:0]data1_memory_slice_7;//input to child
wire [0:0]data2_memory_slice_7;//input to child
wire [0:0]we1_memory_slice_7;//input to child
wire [0:0]we2_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out1_memory_slice_7;//output from child
wire [0:0]out2_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [11:0]addr1_memory_slice_8;//input to child
wire [11:0]addr2_memory_slice_8;//input to child
wire [0:0]data1_memory_slice_8;//input to child
wire [0:0]data2_memory_slice_8;//input to child
wire [0:0]we1_memory_slice_8;//input to child
wire [0:0]we2_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out1_memory_slice_8;//output from child
wire [0:0]out2_memory_slice_8;//output from child
 
////////child (0,0,9)////////
wire [11:0]addr1_memory_slice_9;//input to child
wire [11:0]addr2_memory_slice_9;//input to child
wire [0:0]data1_memory_slice_9;//input to child
wire [0:0]data2_memory_slice_9;//input to child
wire [0:0]we1_memory_slice_9;//input to child
wire [0:0]we2_memory_slice_9;//input to child
wire [0:0]clk_memory_slice_9;//clock to child
wire [0:0]out1_memory_slice_9;//output from child
wire [0:0]out2_memory_slice_9;//output from child
 
////////child (0,0,10)////////
wire [11:0]addr1_memory_slice_10;//input to child
wire [11:0]addr2_memory_slice_10;//input to child
wire [0:0]data1_memory_slice_10;//input to child
wire [0:0]data2_memory_slice_10;//input to child
wire [0:0]we1_memory_slice_10;//input to child
wire [0:0]we2_memory_slice_10;//input to child
wire [0:0]clk_memory_slice_10;//clock to child
wire [0:0]out1_memory_slice_10;//output from child
wire [0:0]out2_memory_slice_10;//output from child
 
////////child (0,0,11)////////
wire [11:0]addr1_memory_slice_11;//input to child
wire [11:0]addr2_memory_slice_11;//input to child
wire [0:0]data1_memory_slice_11;//input to child
wire [0:0]data2_memory_slice_11;//input to child
wire [0:0]we1_memory_slice_11;//input to child
wire [0:0]we2_memory_slice_11;//input to child
wire [0:0]clk_memory_slice_11;//clock to child
wire [0:0]out1_memory_slice_11;//output from child
wire [0:0]out2_memory_slice_11;//output from child
 
////////child (0,0,12)////////
wire [11:0]addr1_memory_slice_12;//input to child
wire [11:0]addr2_memory_slice_12;//input to child
wire [0:0]data1_memory_slice_12;//input to child
wire [0:0]data2_memory_slice_12;//input to child
wire [0:0]we1_memory_slice_12;//input to child
wire [0:0]we2_memory_slice_12;//input to child
wire [0:0]clk_memory_slice_12;//clock to child
wire [0:0]out1_memory_slice_12;//output from child
wire [0:0]out2_memory_slice_12;//output from child
 
////////child (0,0,13)////////
wire [11:0]addr1_memory_slice_13;//input to child
wire [11:0]addr2_memory_slice_13;//input to child
wire [0:0]data1_memory_slice_13;//input to child
wire [0:0]data2_memory_slice_13;//input to child
wire [0:0]we1_memory_slice_13;//input to child
wire [0:0]we2_memory_slice_13;//input to child
wire [0:0]clk_memory_slice_13;//clock to child
wire [0:0]out1_memory_slice_13;//output from child
wire [0:0]out2_memory_slice_13;//output from child
 
////////child (0,0,14)////////
wire [11:0]addr1_memory_slice_14;//input to child
wire [11:0]addr2_memory_slice_14;//input to child
wire [0:0]data1_memory_slice_14;//input to child
wire [0:0]data2_memory_slice_14;//input to child
wire [0:0]we1_memory_slice_14;//input to child
wire [0:0]we2_memory_slice_14;//input to child
wire [0:0]clk_memory_slice_14;//clock to child
wire [0:0]out1_memory_slice_14;//output from child
wire [0:0]out2_memory_slice_14;//output from child
 
////////child (0,0,15)////////
wire [11:0]addr1_memory_slice_15;//input to child
wire [11:0]addr2_memory_slice_15;//input to child
wire [0:0]data1_memory_slice_15;//input to child
wire [0:0]data2_memory_slice_15;//input to child
wire [0:0]we1_memory_slice_15;//input to child
wire [0:0]we2_memory_slice_15;//input to child
wire [0:0]clk_memory_slice_15;//clock to child
wire [0:0]out1_memory_slice_15;//output from child
wire [0:0]out2_memory_slice_15;//output from child
 
////////child (0,0,16)////////
wire [11:0]addr1_memory_slice_16;//input to child
wire [11:0]addr2_memory_slice_16;//input to child
wire [0:0]data1_memory_slice_16;//input to child
wire [0:0]data2_memory_slice_16;//input to child
wire [0:0]we1_memory_slice_16;//input to child
wire [0:0]we2_memory_slice_16;//input to child
wire [0:0]clk_memory_slice_16;//clock to child
wire [0:0]out1_memory_slice_16;//output from child
wire [0:0]out2_memory_slice_16;//output from child
 
////////child (0,0,17)////////
wire [11:0]addr1_memory_slice_17;//input to child
wire [11:0]addr2_memory_slice_17;//input to child
wire [0:0]data1_memory_slice_17;//input to child
wire [0:0]data2_memory_slice_17;//input to child
wire [0:0]we1_memory_slice_17;//input to child
wire [0:0]we2_memory_slice_17;//input to child
wire [0:0]clk_memory_slice_17;//clock to child
wire [0:0]out1_memory_slice_17;//output from child
wire [0:0]out2_memory_slice_17;//output from child
 
////////child (0,0,18)////////
wire [11:0]addr1_memory_slice_18;//input to child
wire [11:0]addr2_memory_slice_18;//input to child
wire [0:0]data1_memory_slice_18;//input to child
wire [0:0]data2_memory_slice_18;//input to child
wire [0:0]we1_memory_slice_18;//input to child
wire [0:0]we2_memory_slice_18;//input to child
wire [0:0]clk_memory_slice_18;//clock to child
wire [0:0]out1_memory_slice_18;//output from child
wire [0:0]out2_memory_slice_18;//output from child
 
////////child (0,0,19)////////
wire [11:0]addr1_memory_slice_19;//input to child
wire [11:0]addr2_memory_slice_19;//input to child
wire [0:0]data1_memory_slice_19;//input to child
wire [0:0]data2_memory_slice_19;//input to child
wire [0:0]we1_memory_slice_19;//input to child
wire [0:0]we2_memory_slice_19;//input to child
wire [0:0]clk_memory_slice_19;//clock to child
wire [0:0]out1_memory_slice_19;//output from child
wire [0:0]out2_memory_slice_19;//output from child
 
////////child (0,0,20)////////
wire [11:0]addr1_memory_slice_20;//input to child
wire [11:0]addr2_memory_slice_20;//input to child
wire [0:0]data1_memory_slice_20;//input to child
wire [0:0]data2_memory_slice_20;//input to child
wire [0:0]we1_memory_slice_20;//input to child
wire [0:0]we2_memory_slice_20;//input to child
wire [0:0]clk_memory_slice_20;//clock to child
wire [0:0]out1_memory_slice_20;//output from child
wire [0:0]out2_memory_slice_20;//output from child
 
////////child (0,0,21)////////
wire [11:0]addr1_memory_slice_21;//input to child
wire [11:0]addr2_memory_slice_21;//input to child
wire [0:0]data1_memory_slice_21;//input to child
wire [0:0]data2_memory_slice_21;//input to child
wire [0:0]we1_memory_slice_21;//input to child
wire [0:0]we2_memory_slice_21;//input to child
wire [0:0]clk_memory_slice_21;//clock to child
wire [0:0]out1_memory_slice_21;//output from child
wire [0:0]out2_memory_slice_21;//output from child
 
////////child (0,0,22)////////
wire [11:0]addr1_memory_slice_22;//input to child
wire [11:0]addr2_memory_slice_22;//input to child
wire [0:0]data1_memory_slice_22;//input to child
wire [0:0]data2_memory_slice_22;//input to child
wire [0:0]we1_memory_slice_22;//input to child
wire [0:0]we2_memory_slice_22;//input to child
wire [0:0]clk_memory_slice_22;//clock to child
wire [0:0]out1_memory_slice_22;//output from child
wire [0:0]out2_memory_slice_22;//output from child
 
////////child (0,0,23)////////
wire [11:0]addr1_memory_slice_23;//input to child
wire [11:0]addr2_memory_slice_23;//input to child
wire [0:0]data1_memory_slice_23;//input to child
wire [0:0]data2_memory_slice_23;//input to child
wire [0:0]we1_memory_slice_23;//input to child
wire [0:0]we2_memory_slice_23;//input to child
wire [0:0]clk_memory_slice_23;//clock to child
wire [0:0]out1_memory_slice_23;//output from child
wire [0:0]out2_memory_slice_23;//output from child
 
////////child (0,0,24)////////
wire [11:0]addr1_memory_slice_24;//input to child
wire [11:0]addr2_memory_slice_24;//input to child
wire [0:0]data1_memory_slice_24;//input to child
wire [0:0]data2_memory_slice_24;//input to child
wire [0:0]we1_memory_slice_24;//input to child
wire [0:0]we2_memory_slice_24;//input to child
wire [0:0]clk_memory_slice_24;//clock to child
wire [0:0]out1_memory_slice_24;//output from child
wire [0:0]out2_memory_slice_24;//output from child
 
////////child (0,0,25)////////
wire [11:0]addr1_memory_slice_25;//input to child
wire [11:0]addr2_memory_slice_25;//input to child
wire [0:0]data1_memory_slice_25;//input to child
wire [0:0]data2_memory_slice_25;//input to child
wire [0:0]we1_memory_slice_25;//input to child
wire [0:0]we2_memory_slice_25;//input to child
wire [0:0]clk_memory_slice_25;//clock to child
wire [0:0]out1_memory_slice_25;//output from child
wire [0:0]out2_memory_slice_25;//output from child
 
////////child (0,0,26)////////
wire [11:0]addr1_memory_slice_26;//input to child
wire [11:0]addr2_memory_slice_26;//input to child
wire [0:0]data1_memory_slice_26;//input to child
wire [0:0]data2_memory_slice_26;//input to child
wire [0:0]we1_memory_slice_26;//input to child
wire [0:0]we2_memory_slice_26;//input to child
wire [0:0]clk_memory_slice_26;//clock to child
wire [0:0]out1_memory_slice_26;//output from child
wire [0:0]out2_memory_slice_26;//output from child
 
////////child (0,0,27)////////
wire [11:0]addr1_memory_slice_27;//input to child
wire [11:0]addr2_memory_slice_27;//input to child
wire [0:0]data1_memory_slice_27;//input to child
wire [0:0]data2_memory_slice_27;//input to child
wire [0:0]we1_memory_slice_27;//input to child
wire [0:0]we2_memory_slice_27;//input to child
wire [0:0]clk_memory_slice_27;//clock to child
wire [0:0]out1_memory_slice_27;//output from child
wire [0:0]out2_memory_slice_27;//output from child
 
////////child (0,0,28)////////
wire [11:0]addr1_memory_slice_28;//input to child
wire [11:0]addr2_memory_slice_28;//input to child
wire [0:0]data1_memory_slice_28;//input to child
wire [0:0]data2_memory_slice_28;//input to child
wire [0:0]we1_memory_slice_28;//input to child
wire [0:0]we2_memory_slice_28;//input to child
wire [0:0]clk_memory_slice_28;//clock to child
wire [0:0]out1_memory_slice_28;//output from child
wire [0:0]out2_memory_slice_28;//output from child
 
////////child (0,0,29)////////
wire [11:0]addr1_memory_slice_29;//input to child
wire [11:0]addr2_memory_slice_29;//input to child
wire [0:0]data1_memory_slice_29;//input to child
wire [0:0]data2_memory_slice_29;//input to child
wire [0:0]we1_memory_slice_29;//input to child
wire [0:0]we2_memory_slice_29;//input to child
wire [0:0]clk_memory_slice_29;//clock to child
wire [0:0]out1_memory_slice_29;//output from child
wire [0:0]out2_memory_slice_29;//output from child
 
////////child (0,0,30)////////
wire [11:0]addr1_memory_slice_30;//input to child
wire [11:0]addr2_memory_slice_30;//input to child
wire [0:0]data1_memory_slice_30;//input to child
wire [0:0]data2_memory_slice_30;//input to child
wire [0:0]we1_memory_slice_30;//input to child
wire [0:0]we2_memory_slice_30;//input to child
wire [0:0]clk_memory_slice_30;//clock to child
wire [0:0]out1_memory_slice_30;//output from child
wire [0:0]out2_memory_slice_30;//output from child
 
////////child (0,0,31)////////
wire [11:0]addr1_memory_slice_31;//input to child
wire [11:0]addr2_memory_slice_31;//input to child
wire [0:0]data1_memory_slice_31;//input to child
wire [0:0]data2_memory_slice_31;//input to child
wire [0:0]we1_memory_slice_31;//input to child
wire [0:0]we2_memory_slice_31;//input to child
wire [0:0]clk_memory_slice_31;//clock to child
wire [0:0]out1_memory_slice_31;//output from child
wire [0:0]out2_memory_slice_31;//output from child
 
////////child (0,0,32)////////
wire [11:0]addr1_memory_slice_32;//input to child
wire [11:0]addr2_memory_slice_32;//input to child
wire [0:0]data1_memory_slice_32;//input to child
wire [0:0]data2_memory_slice_32;//input to child
wire [0:0]we1_memory_slice_32;//input to child
wire [0:0]we2_memory_slice_32;//input to child
wire [0:0]clk_memory_slice_32;//clock to child
wire [0:0]out1_memory_slice_32;//output from child
wire [0:0]out2_memory_slice_32;//output from child
 
////////child (0,0,33)////////
wire [11:0]addr1_memory_slice_33;//input to child
wire [11:0]addr2_memory_slice_33;//input to child
wire [0:0]data1_memory_slice_33;//input to child
wire [0:0]data2_memory_slice_33;//input to child
wire [0:0]we1_memory_slice_33;//input to child
wire [0:0]we2_memory_slice_33;//input to child
wire [0:0]clk_memory_slice_33;//clock to child
wire [0:0]out1_memory_slice_33;//output from child
wire [0:0]out2_memory_slice_33;//output from child
 
////////child (0,0,34)////////
wire [11:0]addr1_memory_slice_34;//input to child
wire [11:0]addr2_memory_slice_34;//input to child
wire [0:0]data1_memory_slice_34;//input to child
wire [0:0]data2_memory_slice_34;//input to child
wire [0:0]we1_memory_slice_34;//input to child
wire [0:0]we2_memory_slice_34;//input to child
wire [0:0]clk_memory_slice_34;//clock to child
wire [0:0]out1_memory_slice_34;//output from child
wire [0:0]out2_memory_slice_34;//output from child
 
////////child (0,0,35)////////
wire [11:0]addr1_memory_slice_35;//input to child
wire [11:0]addr2_memory_slice_35;//input to child
wire [0:0]data1_memory_slice_35;//input to child
wire [0:0]data2_memory_slice_35;//input to child
wire [0:0]we1_memory_slice_35;//input to child
wire [0:0]we2_memory_slice_35;//input to child
wire [0:0]clk_memory_slice_35;//clock to child
wire [0:0]out1_memory_slice_35;//output from child
wire [0:0]out2_memory_slice_35;//output from child
 
wire ground;

assign addr1_memory_slice_0[0] = addr1[0];
assign addr1_memory_slice_0[1] = addr1[1];
assign addr1_memory_slice_0[2] = addr1[2];
assign addr1_memory_slice_0[3] = addr1[3];
assign addr1_memory_slice_0[4] = addr1[4];
assign addr1_memory_slice_0[5] = addr1[5];
assign addr1_memory_slice_0[6] = addr1[6];
assign addr1_memory_slice_0[7] = addr1[7];
assign addr1_memory_slice_0[8] = addr1[8];
assign addr1_memory_slice_0[9] = addr1[9];
assign addr1_memory_slice_0[10] = addr1[10];
assign addr1_memory_slice_0[11] = addr1[11];
assign addr2_memory_slice_0[0] = addr2[0];
assign addr2_memory_slice_0[1] = addr2[1];
assign addr2_memory_slice_0[2] = addr2[2];
assign addr2_memory_slice_0[3] = addr2[3];
assign addr2_memory_slice_0[4] = addr2[4];
assign addr2_memory_slice_0[5] = addr2[5];
assign addr2_memory_slice_0[6] = addr2[6];
assign addr2_memory_slice_0[7] = addr2[7];
assign addr2_memory_slice_0[8] = addr2[8];
assign addr2_memory_slice_0[9] = addr2[9];
assign addr2_memory_slice_0[10] = addr2[10];
assign addr2_memory_slice_0[11] = addr2[11];
assign data1_memory_slice_0[0] = data1[0];
assign data2_memory_slice_0[0] = data2[0];
assign we1_memory_slice_0[0] = we1[0];
assign we2_memory_slice_0[0] = we2[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr1(addr1_memory_slice_0), .addr2(addr2_memory_slice_0), .data1(data1_memory_slice_0), .data2(data2_memory_slice_0), .we1(we1_memory_slice_0), .we2(we2_memory_slice_0), .out1(out1_memory_slice_0), .out2(out2_memory_slice_0) );

assign addr1_memory_slice_1[0] = addr1[0];
assign addr1_memory_slice_1[1] = addr1[1];
assign addr1_memory_slice_1[2] = addr1[2];
assign addr1_memory_slice_1[3] = addr1[3];
assign addr1_memory_slice_1[4] = addr1[4];
assign addr1_memory_slice_1[5] = addr1[5];
assign addr1_memory_slice_1[6] = addr1[6];
assign addr1_memory_slice_1[7] = addr1[7];
assign addr1_memory_slice_1[8] = addr1[8];
assign addr1_memory_slice_1[9] = addr1[9];
assign addr1_memory_slice_1[10] = addr1[10];
assign addr1_memory_slice_1[11] = addr1[11];
assign addr2_memory_slice_1[0] = addr2[0];
assign addr2_memory_slice_1[1] = addr2[1];
assign addr2_memory_slice_1[2] = addr2[2];
assign addr2_memory_slice_1[3] = addr2[3];
assign addr2_memory_slice_1[4] = addr2[4];
assign addr2_memory_slice_1[5] = addr2[5];
assign addr2_memory_slice_1[6] = addr2[6];
assign addr2_memory_slice_1[7] = addr2[7];
assign addr2_memory_slice_1[8] = addr2[8];
assign addr2_memory_slice_1[9] = addr2[9];
assign addr2_memory_slice_1[10] = addr2[10];
assign addr2_memory_slice_1[11] = addr2[11];
assign data1_memory_slice_1[0] = data1[1];
assign data2_memory_slice_1[0] = data2[1];
assign we1_memory_slice_1[0] = we1[0];
assign we2_memory_slice_1[0] = we2[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr1(addr1_memory_slice_1), .addr2(addr2_memory_slice_1), .data1(data1_memory_slice_1), .data2(data2_memory_slice_1), .we1(we1_memory_slice_1), .we2(we2_memory_slice_1), .out1(out1_memory_slice_1), .out2(out2_memory_slice_1) );

assign addr1_memory_slice_2[0] = addr1[0];
assign addr1_memory_slice_2[1] = addr1[1];
assign addr1_memory_slice_2[2] = addr1[2];
assign addr1_memory_slice_2[3] = addr1[3];
assign addr1_memory_slice_2[4] = addr1[4];
assign addr1_memory_slice_2[5] = addr1[5];
assign addr1_memory_slice_2[6] = addr1[6];
assign addr1_memory_slice_2[7] = addr1[7];
assign addr1_memory_slice_2[8] = addr1[8];
assign addr1_memory_slice_2[9] = addr1[9];
assign addr1_memory_slice_2[10] = addr1[10];
assign addr1_memory_slice_2[11] = addr1[11];
assign addr2_memory_slice_2[0] = addr2[0];
assign addr2_memory_slice_2[1] = addr2[1];
assign addr2_memory_slice_2[2] = addr2[2];
assign addr2_memory_slice_2[3] = addr2[3];
assign addr2_memory_slice_2[4] = addr2[4];
assign addr2_memory_slice_2[5] = addr2[5];
assign addr2_memory_slice_2[6] = addr2[6];
assign addr2_memory_slice_2[7] = addr2[7];
assign addr2_memory_slice_2[8] = addr2[8];
assign addr2_memory_slice_2[9] = addr2[9];
assign addr2_memory_slice_2[10] = addr2[10];
assign addr2_memory_slice_2[11] = addr2[11];
assign data1_memory_slice_2[0] = data1[2];
assign data2_memory_slice_2[0] = data2[2];
assign we1_memory_slice_2[0] = we1[0];
assign we2_memory_slice_2[0] = we2[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr1(addr1_memory_slice_2), .addr2(addr2_memory_slice_2), .data1(data1_memory_slice_2), .data2(data2_memory_slice_2), .we1(we1_memory_slice_2), .we2(we2_memory_slice_2), .out1(out1_memory_slice_2), .out2(out2_memory_slice_2) );

assign addr1_memory_slice_3[0] = addr1[0];
assign addr1_memory_slice_3[1] = addr1[1];
assign addr1_memory_slice_3[2] = addr1[2];
assign addr1_memory_slice_3[3] = addr1[3];
assign addr1_memory_slice_3[4] = addr1[4];
assign addr1_memory_slice_3[5] = addr1[5];
assign addr1_memory_slice_3[6] = addr1[6];
assign addr1_memory_slice_3[7] = addr1[7];
assign addr1_memory_slice_3[8] = addr1[8];
assign addr1_memory_slice_3[9] = addr1[9];
assign addr1_memory_slice_3[10] = addr1[10];
assign addr1_memory_slice_3[11] = addr1[11];
assign addr2_memory_slice_3[0] = addr2[0];
assign addr2_memory_slice_3[1] = addr2[1];
assign addr2_memory_slice_3[2] = addr2[2];
assign addr2_memory_slice_3[3] = addr2[3];
assign addr2_memory_slice_3[4] = addr2[4];
assign addr2_memory_slice_3[5] = addr2[5];
assign addr2_memory_slice_3[6] = addr2[6];
assign addr2_memory_slice_3[7] = addr2[7];
assign addr2_memory_slice_3[8] = addr2[8];
assign addr2_memory_slice_3[9] = addr2[9];
assign addr2_memory_slice_3[10] = addr2[10];
assign addr2_memory_slice_3[11] = addr2[11];
assign data1_memory_slice_3[0] = data1[3];
assign data2_memory_slice_3[0] = data2[3];
assign we1_memory_slice_3[0] = we1[0];
assign we2_memory_slice_3[0] = we2[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr1(addr1_memory_slice_3), .addr2(addr2_memory_slice_3), .data1(data1_memory_slice_3), .data2(data2_memory_slice_3), .we1(we1_memory_slice_3), .we2(we2_memory_slice_3), .out1(out1_memory_slice_3), .out2(out2_memory_slice_3) );

assign addr1_memory_slice_4[0] = addr1[0];
assign addr1_memory_slice_4[1] = addr1[1];
assign addr1_memory_slice_4[2] = addr1[2];
assign addr1_memory_slice_4[3] = addr1[3];
assign addr1_memory_slice_4[4] = addr1[4];
assign addr1_memory_slice_4[5] = addr1[5];
assign addr1_memory_slice_4[6] = addr1[6];
assign addr1_memory_slice_4[7] = addr1[7];
assign addr1_memory_slice_4[8] = addr1[8];
assign addr1_memory_slice_4[9] = addr1[9];
assign addr1_memory_slice_4[10] = addr1[10];
assign addr1_memory_slice_4[11] = addr1[11];
assign addr2_memory_slice_4[0] = addr2[0];
assign addr2_memory_slice_4[1] = addr2[1];
assign addr2_memory_slice_4[2] = addr2[2];
assign addr2_memory_slice_4[3] = addr2[3];
assign addr2_memory_slice_4[4] = addr2[4];
assign addr2_memory_slice_4[5] = addr2[5];
assign addr2_memory_slice_4[6] = addr2[6];
assign addr2_memory_slice_4[7] = addr2[7];
assign addr2_memory_slice_4[8] = addr2[8];
assign addr2_memory_slice_4[9] = addr2[9];
assign addr2_memory_slice_4[10] = addr2[10];
assign addr2_memory_slice_4[11] = addr2[11];
assign data1_memory_slice_4[0] = data1[4];
assign data2_memory_slice_4[0] = data2[4];
assign we1_memory_slice_4[0] = we1[0];
assign we2_memory_slice_4[0] = we2[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr1(addr1_memory_slice_4), .addr2(addr2_memory_slice_4), .data1(data1_memory_slice_4), .data2(data2_memory_slice_4), .we1(we1_memory_slice_4), .we2(we2_memory_slice_4), .out1(out1_memory_slice_4), .out2(out2_memory_slice_4) );

assign addr1_memory_slice_5[0] = addr1[0];
assign addr1_memory_slice_5[1] = addr1[1];
assign addr1_memory_slice_5[2] = addr1[2];
assign addr1_memory_slice_5[3] = addr1[3];
assign addr1_memory_slice_5[4] = addr1[4];
assign addr1_memory_slice_5[5] = addr1[5];
assign addr1_memory_slice_5[6] = addr1[6];
assign addr1_memory_slice_5[7] = addr1[7];
assign addr1_memory_slice_5[8] = addr1[8];
assign addr1_memory_slice_5[9] = addr1[9];
assign addr1_memory_slice_5[10] = addr1[10];
assign addr1_memory_slice_5[11] = addr1[11];
assign addr2_memory_slice_5[0] = addr2[0];
assign addr2_memory_slice_5[1] = addr2[1];
assign addr2_memory_slice_5[2] = addr2[2];
assign addr2_memory_slice_5[3] = addr2[3];
assign addr2_memory_slice_5[4] = addr2[4];
assign addr2_memory_slice_5[5] = addr2[5];
assign addr2_memory_slice_5[6] = addr2[6];
assign addr2_memory_slice_5[7] = addr2[7];
assign addr2_memory_slice_5[8] = addr2[8];
assign addr2_memory_slice_5[9] = addr2[9];
assign addr2_memory_slice_5[10] = addr2[10];
assign addr2_memory_slice_5[11] = addr2[11];
assign data1_memory_slice_5[0] = data1[5];
assign data2_memory_slice_5[0] = data2[5];
assign we1_memory_slice_5[0] = we1[0];
assign we2_memory_slice_5[0] = we2[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr1(addr1_memory_slice_5), .addr2(addr2_memory_slice_5), .data1(data1_memory_slice_5), .data2(data2_memory_slice_5), .we1(we1_memory_slice_5), .we2(we2_memory_slice_5), .out1(out1_memory_slice_5), .out2(out2_memory_slice_5) );

assign addr1_memory_slice_6[0] = addr1[0];
assign addr1_memory_slice_6[1] = addr1[1];
assign addr1_memory_slice_6[2] = addr1[2];
assign addr1_memory_slice_6[3] = addr1[3];
assign addr1_memory_slice_6[4] = addr1[4];
assign addr1_memory_slice_6[5] = addr1[5];
assign addr1_memory_slice_6[6] = addr1[6];
assign addr1_memory_slice_6[7] = addr1[7];
assign addr1_memory_slice_6[8] = addr1[8];
assign addr1_memory_slice_6[9] = addr1[9];
assign addr1_memory_slice_6[10] = addr1[10];
assign addr1_memory_slice_6[11] = addr1[11];
assign addr2_memory_slice_6[0] = addr2[0];
assign addr2_memory_slice_6[1] = addr2[1];
assign addr2_memory_slice_6[2] = addr2[2];
assign addr2_memory_slice_6[3] = addr2[3];
assign addr2_memory_slice_6[4] = addr2[4];
assign addr2_memory_slice_6[5] = addr2[5];
assign addr2_memory_slice_6[6] = addr2[6];
assign addr2_memory_slice_6[7] = addr2[7];
assign addr2_memory_slice_6[8] = addr2[8];
assign addr2_memory_slice_6[9] = addr2[9];
assign addr2_memory_slice_6[10] = addr2[10];
assign addr2_memory_slice_6[11] = addr2[11];
assign data1_memory_slice_6[0] = data1[6];
assign data2_memory_slice_6[0] = data2[6];
assign we1_memory_slice_6[0] = we1[0];
assign we2_memory_slice_6[0] = we2[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr1(addr1_memory_slice_6), .addr2(addr2_memory_slice_6), .data1(data1_memory_slice_6), .data2(data2_memory_slice_6), .we1(we1_memory_slice_6), .we2(we2_memory_slice_6), .out1(out1_memory_slice_6), .out2(out2_memory_slice_6) );

assign addr1_memory_slice_7[0] = addr1[0];
assign addr1_memory_slice_7[1] = addr1[1];
assign addr1_memory_slice_7[2] = addr1[2];
assign addr1_memory_slice_7[3] = addr1[3];
assign addr1_memory_slice_7[4] = addr1[4];
assign addr1_memory_slice_7[5] = addr1[5];
assign addr1_memory_slice_7[6] = addr1[6];
assign addr1_memory_slice_7[7] = addr1[7];
assign addr1_memory_slice_7[8] = addr1[8];
assign addr1_memory_slice_7[9] = addr1[9];
assign addr1_memory_slice_7[10] = addr1[10];
assign addr1_memory_slice_7[11] = addr1[11];
assign addr2_memory_slice_7[0] = addr2[0];
assign addr2_memory_slice_7[1] = addr2[1];
assign addr2_memory_slice_7[2] = addr2[2];
assign addr2_memory_slice_7[3] = addr2[3];
assign addr2_memory_slice_7[4] = addr2[4];
assign addr2_memory_slice_7[5] = addr2[5];
assign addr2_memory_slice_7[6] = addr2[6];
assign addr2_memory_slice_7[7] = addr2[7];
assign addr2_memory_slice_7[8] = addr2[8];
assign addr2_memory_slice_7[9] = addr2[9];
assign addr2_memory_slice_7[10] = addr2[10];
assign addr2_memory_slice_7[11] = addr2[11];
assign data1_memory_slice_7[0] = data1[7];
assign data2_memory_slice_7[0] = data2[7];
assign we1_memory_slice_7[0] = we1[0];
assign we2_memory_slice_7[0] = we2[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr1(addr1_memory_slice_7), .addr2(addr2_memory_slice_7), .data1(data1_memory_slice_7), .data2(data2_memory_slice_7), .we1(we1_memory_slice_7), .we2(we2_memory_slice_7), .out1(out1_memory_slice_7), .out2(out2_memory_slice_7) );

assign addr1_memory_slice_8[0] = addr1[0];
assign addr1_memory_slice_8[1] = addr1[1];
assign addr1_memory_slice_8[2] = addr1[2];
assign addr1_memory_slice_8[3] = addr1[3];
assign addr1_memory_slice_8[4] = addr1[4];
assign addr1_memory_slice_8[5] = addr1[5];
assign addr1_memory_slice_8[6] = addr1[6];
assign addr1_memory_slice_8[7] = addr1[7];
assign addr1_memory_slice_8[8] = addr1[8];
assign addr1_memory_slice_8[9] = addr1[9];
assign addr1_memory_slice_8[10] = addr1[10];
assign addr1_memory_slice_8[11] = addr1[11];
assign addr2_memory_slice_8[0] = addr2[0];
assign addr2_memory_slice_8[1] = addr2[1];
assign addr2_memory_slice_8[2] = addr2[2];
assign addr2_memory_slice_8[3] = addr2[3];
assign addr2_memory_slice_8[4] = addr2[4];
assign addr2_memory_slice_8[5] = addr2[5];
assign addr2_memory_slice_8[6] = addr2[6];
assign addr2_memory_slice_8[7] = addr2[7];
assign addr2_memory_slice_8[8] = addr2[8];
assign addr2_memory_slice_8[9] = addr2[9];
assign addr2_memory_slice_8[10] = addr2[10];
assign addr2_memory_slice_8[11] = addr2[11];
assign data1_memory_slice_8[0] = data1[8];
assign data2_memory_slice_8[0] = data2[8];
assign we1_memory_slice_8[0] = we1[0];
assign we2_memory_slice_8[0] = we2[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr1(addr1_memory_slice_8), .addr2(addr2_memory_slice_8), .data1(data1_memory_slice_8), .data2(data2_memory_slice_8), .we1(we1_memory_slice_8), .we2(we2_memory_slice_8), .out1(out1_memory_slice_8), .out2(out2_memory_slice_8) );

assign addr1_memory_slice_9[0] = addr1[0];
assign addr1_memory_slice_9[1] = addr1[1];
assign addr1_memory_slice_9[2] = addr1[2];
assign addr1_memory_slice_9[3] = addr1[3];
assign addr1_memory_slice_9[4] = addr1[4];
assign addr1_memory_slice_9[5] = addr1[5];
assign addr1_memory_slice_9[6] = addr1[6];
assign addr1_memory_slice_9[7] = addr1[7];
assign addr1_memory_slice_9[8] = addr1[8];
assign addr1_memory_slice_9[9] = addr1[9];
assign addr1_memory_slice_9[10] = addr1[10];
assign addr1_memory_slice_9[11] = addr1[11];
assign addr2_memory_slice_9[0] = addr2[0];
assign addr2_memory_slice_9[1] = addr2[1];
assign addr2_memory_slice_9[2] = addr2[2];
assign addr2_memory_slice_9[3] = addr2[3];
assign addr2_memory_slice_9[4] = addr2[4];
assign addr2_memory_slice_9[5] = addr2[5];
assign addr2_memory_slice_9[6] = addr2[6];
assign addr2_memory_slice_9[7] = addr2[7];
assign addr2_memory_slice_9[8] = addr2[8];
assign addr2_memory_slice_9[9] = addr2[9];
assign addr2_memory_slice_9[10] = addr2[10];
assign addr2_memory_slice_9[11] = addr2[11];
assign data1_memory_slice_9[0] = data1[9];
assign data2_memory_slice_9[0] = data2[9];
assign we1_memory_slice_9[0] = we1[0];
assign we2_memory_slice_9[0] = we2[0];
assign clk_memory_slice_9[0] = clk[0];
 
memory_slice memory_slice_9 ( .clk(clk_memory_slice_9), .addr1(addr1_memory_slice_9), .addr2(addr2_memory_slice_9), .data1(data1_memory_slice_9), .data2(data2_memory_slice_9), .we1(we1_memory_slice_9), .we2(we2_memory_slice_9), .out1(out1_memory_slice_9), .out2(out2_memory_slice_9) );

assign addr1_memory_slice_10[0] = addr1[0];
assign addr1_memory_slice_10[1] = addr1[1];
assign addr1_memory_slice_10[2] = addr1[2];
assign addr1_memory_slice_10[3] = addr1[3];
assign addr1_memory_slice_10[4] = addr1[4];
assign addr1_memory_slice_10[5] = addr1[5];
assign addr1_memory_slice_10[6] = addr1[6];
assign addr1_memory_slice_10[7] = addr1[7];
assign addr1_memory_slice_10[8] = addr1[8];
assign addr1_memory_slice_10[9] = addr1[9];
assign addr1_memory_slice_10[10] = addr1[10];
assign addr1_memory_slice_10[11] = addr1[11];
assign addr2_memory_slice_10[0] = addr2[0];
assign addr2_memory_slice_10[1] = addr2[1];
assign addr2_memory_slice_10[2] = addr2[2];
assign addr2_memory_slice_10[3] = addr2[3];
assign addr2_memory_slice_10[4] = addr2[4];
assign addr2_memory_slice_10[5] = addr2[5];
assign addr2_memory_slice_10[6] = addr2[6];
assign addr2_memory_slice_10[7] = addr2[7];
assign addr2_memory_slice_10[8] = addr2[8];
assign addr2_memory_slice_10[9] = addr2[9];
assign addr2_memory_slice_10[10] = addr2[10];
assign addr2_memory_slice_10[11] = addr2[11];
assign data1_memory_slice_10[0] = data1[10];
assign data2_memory_slice_10[0] = data2[10];
assign we1_memory_slice_10[0] = we1[0];
assign we2_memory_slice_10[0] = we2[0];
assign clk_memory_slice_10[0] = clk[0];
 
memory_slice memory_slice_10 ( .clk(clk_memory_slice_10), .addr1(addr1_memory_slice_10), .addr2(addr2_memory_slice_10), .data1(data1_memory_slice_10), .data2(data2_memory_slice_10), .we1(we1_memory_slice_10), .we2(we2_memory_slice_10), .out1(out1_memory_slice_10), .out2(out2_memory_slice_10) );

assign addr1_memory_slice_11[0] = addr1[0];
assign addr1_memory_slice_11[1] = addr1[1];
assign addr1_memory_slice_11[2] = addr1[2];
assign addr1_memory_slice_11[3] = addr1[3];
assign addr1_memory_slice_11[4] = addr1[4];
assign addr1_memory_slice_11[5] = addr1[5];
assign addr1_memory_slice_11[6] = addr1[6];
assign addr1_memory_slice_11[7] = addr1[7];
assign addr1_memory_slice_11[8] = addr1[8];
assign addr1_memory_slice_11[9] = addr1[9];
assign addr1_memory_slice_11[10] = addr1[10];
assign addr1_memory_slice_11[11] = addr1[11];
assign addr2_memory_slice_11[0] = addr2[0];
assign addr2_memory_slice_11[1] = addr2[1];
assign addr2_memory_slice_11[2] = addr2[2];
assign addr2_memory_slice_11[3] = addr2[3];
assign addr2_memory_slice_11[4] = addr2[4];
assign addr2_memory_slice_11[5] = addr2[5];
assign addr2_memory_slice_11[6] = addr2[6];
assign addr2_memory_slice_11[7] = addr2[7];
assign addr2_memory_slice_11[8] = addr2[8];
assign addr2_memory_slice_11[9] = addr2[9];
assign addr2_memory_slice_11[10] = addr2[10];
assign addr2_memory_slice_11[11] = addr2[11];
assign data1_memory_slice_11[0] = data1[11];
assign data2_memory_slice_11[0] = data2[11];
assign we1_memory_slice_11[0] = we1[0];
assign we2_memory_slice_11[0] = we2[0];
assign clk_memory_slice_11[0] = clk[0];
 
memory_slice memory_slice_11 ( .clk(clk_memory_slice_11), .addr1(addr1_memory_slice_11), .addr2(addr2_memory_slice_11), .data1(data1_memory_slice_11), .data2(data2_memory_slice_11), .we1(we1_memory_slice_11), .we2(we2_memory_slice_11), .out1(out1_memory_slice_11), .out2(out2_memory_slice_11) );

assign addr1_memory_slice_12[0] = addr1[0];
assign addr1_memory_slice_12[1] = addr1[1];
assign addr1_memory_slice_12[2] = addr1[2];
assign addr1_memory_slice_12[3] = addr1[3];
assign addr1_memory_slice_12[4] = addr1[4];
assign addr1_memory_slice_12[5] = addr1[5];
assign addr1_memory_slice_12[6] = addr1[6];
assign addr1_memory_slice_12[7] = addr1[7];
assign addr1_memory_slice_12[8] = addr1[8];
assign addr1_memory_slice_12[9] = addr1[9];
assign addr1_memory_slice_12[10] = addr1[10];
assign addr1_memory_slice_12[11] = addr1[11];
assign addr2_memory_slice_12[0] = addr2[0];
assign addr2_memory_slice_12[1] = addr2[1];
assign addr2_memory_slice_12[2] = addr2[2];
assign addr2_memory_slice_12[3] = addr2[3];
assign addr2_memory_slice_12[4] = addr2[4];
assign addr2_memory_slice_12[5] = addr2[5];
assign addr2_memory_slice_12[6] = addr2[6];
assign addr2_memory_slice_12[7] = addr2[7];
assign addr2_memory_slice_12[8] = addr2[8];
assign addr2_memory_slice_12[9] = addr2[9];
assign addr2_memory_slice_12[10] = addr2[10];
assign addr2_memory_slice_12[11] = addr2[11];
assign data1_memory_slice_12[0] = data1[12];
assign data2_memory_slice_12[0] = data2[12];
assign we1_memory_slice_12[0] = we1[0];
assign we2_memory_slice_12[0] = we2[0];
assign clk_memory_slice_12[0] = clk[0];
 
memory_slice memory_slice_12 ( .clk(clk_memory_slice_12), .addr1(addr1_memory_slice_12), .addr2(addr2_memory_slice_12), .data1(data1_memory_slice_12), .data2(data2_memory_slice_12), .we1(we1_memory_slice_12), .we2(we2_memory_slice_12), .out1(out1_memory_slice_12), .out2(out2_memory_slice_12) );

assign addr1_memory_slice_13[0] = addr1[0];
assign addr1_memory_slice_13[1] = addr1[1];
assign addr1_memory_slice_13[2] = addr1[2];
assign addr1_memory_slice_13[3] = addr1[3];
assign addr1_memory_slice_13[4] = addr1[4];
assign addr1_memory_slice_13[5] = addr1[5];
assign addr1_memory_slice_13[6] = addr1[6];
assign addr1_memory_slice_13[7] = addr1[7];
assign addr1_memory_slice_13[8] = addr1[8];
assign addr1_memory_slice_13[9] = addr1[9];
assign addr1_memory_slice_13[10] = addr1[10];
assign addr1_memory_slice_13[11] = addr1[11];
assign addr2_memory_slice_13[0] = addr2[0];
assign addr2_memory_slice_13[1] = addr2[1];
assign addr2_memory_slice_13[2] = addr2[2];
assign addr2_memory_slice_13[3] = addr2[3];
assign addr2_memory_slice_13[4] = addr2[4];
assign addr2_memory_slice_13[5] = addr2[5];
assign addr2_memory_slice_13[6] = addr2[6];
assign addr2_memory_slice_13[7] = addr2[7];
assign addr2_memory_slice_13[8] = addr2[8];
assign addr2_memory_slice_13[9] = addr2[9];
assign addr2_memory_slice_13[10] = addr2[10];
assign addr2_memory_slice_13[11] = addr2[11];
assign data1_memory_slice_13[0] = data1[13];
assign data2_memory_slice_13[0] = data2[13];
assign we1_memory_slice_13[0] = we1[0];
assign we2_memory_slice_13[0] = we2[0];
assign clk_memory_slice_13[0] = clk[0];
 
memory_slice memory_slice_13 ( .clk(clk_memory_slice_13), .addr1(addr1_memory_slice_13), .addr2(addr2_memory_slice_13), .data1(data1_memory_slice_13), .data2(data2_memory_slice_13), .we1(we1_memory_slice_13), .we2(we2_memory_slice_13), .out1(out1_memory_slice_13), .out2(out2_memory_slice_13) );

assign addr1_memory_slice_14[0] = addr1[0];
assign addr1_memory_slice_14[1] = addr1[1];
assign addr1_memory_slice_14[2] = addr1[2];
assign addr1_memory_slice_14[3] = addr1[3];
assign addr1_memory_slice_14[4] = addr1[4];
assign addr1_memory_slice_14[5] = addr1[5];
assign addr1_memory_slice_14[6] = addr1[6];
assign addr1_memory_slice_14[7] = addr1[7];
assign addr1_memory_slice_14[8] = addr1[8];
assign addr1_memory_slice_14[9] = addr1[9];
assign addr1_memory_slice_14[10] = addr1[10];
assign addr1_memory_slice_14[11] = addr1[11];
assign addr2_memory_slice_14[0] = addr2[0];
assign addr2_memory_slice_14[1] = addr2[1];
assign addr2_memory_slice_14[2] = addr2[2];
assign addr2_memory_slice_14[3] = addr2[3];
assign addr2_memory_slice_14[4] = addr2[4];
assign addr2_memory_slice_14[5] = addr2[5];
assign addr2_memory_slice_14[6] = addr2[6];
assign addr2_memory_slice_14[7] = addr2[7];
assign addr2_memory_slice_14[8] = addr2[8];
assign addr2_memory_slice_14[9] = addr2[9];
assign addr2_memory_slice_14[10] = addr2[10];
assign addr2_memory_slice_14[11] = addr2[11];
assign data1_memory_slice_14[0] = data1[14];
assign data2_memory_slice_14[0] = data2[14];
assign we1_memory_slice_14[0] = we1[0];
assign we2_memory_slice_14[0] = we2[0];
assign clk_memory_slice_14[0] = clk[0];
 
memory_slice memory_slice_14 ( .clk(clk_memory_slice_14), .addr1(addr1_memory_slice_14), .addr2(addr2_memory_slice_14), .data1(data1_memory_slice_14), .data2(data2_memory_slice_14), .we1(we1_memory_slice_14), .we2(we2_memory_slice_14), .out1(out1_memory_slice_14), .out2(out2_memory_slice_14) );

assign addr1_memory_slice_15[0] = addr1[0];
assign addr1_memory_slice_15[1] = addr1[1];
assign addr1_memory_slice_15[2] = addr1[2];
assign addr1_memory_slice_15[3] = addr1[3];
assign addr1_memory_slice_15[4] = addr1[4];
assign addr1_memory_slice_15[5] = addr1[5];
assign addr1_memory_slice_15[6] = addr1[6];
assign addr1_memory_slice_15[7] = addr1[7];
assign addr1_memory_slice_15[8] = addr1[8];
assign addr1_memory_slice_15[9] = addr1[9];
assign addr1_memory_slice_15[10] = addr1[10];
assign addr1_memory_slice_15[11] = addr1[11];
assign addr2_memory_slice_15[0] = addr2[0];
assign addr2_memory_slice_15[1] = addr2[1];
assign addr2_memory_slice_15[2] = addr2[2];
assign addr2_memory_slice_15[3] = addr2[3];
assign addr2_memory_slice_15[4] = addr2[4];
assign addr2_memory_slice_15[5] = addr2[5];
assign addr2_memory_slice_15[6] = addr2[6];
assign addr2_memory_slice_15[7] = addr2[7];
assign addr2_memory_slice_15[8] = addr2[8];
assign addr2_memory_slice_15[9] = addr2[9];
assign addr2_memory_slice_15[10] = addr2[10];
assign addr2_memory_slice_15[11] = addr2[11];
assign data1_memory_slice_15[0] = data1[15];
assign data2_memory_slice_15[0] = data2[15];
assign we1_memory_slice_15[0] = we1[0];
assign we2_memory_slice_15[0] = we2[0];
assign clk_memory_slice_15[0] = clk[0];
 
memory_slice memory_slice_15 ( .clk(clk_memory_slice_15), .addr1(addr1_memory_slice_15), .addr2(addr2_memory_slice_15), .data1(data1_memory_slice_15), .data2(data2_memory_slice_15), .we1(we1_memory_slice_15), .we2(we2_memory_slice_15), .out1(out1_memory_slice_15), .out2(out2_memory_slice_15) );

assign addr1_memory_slice_16[0] = addr1[0];
assign addr1_memory_slice_16[1] = addr1[1];
assign addr1_memory_slice_16[2] = addr1[2];
assign addr1_memory_slice_16[3] = addr1[3];
assign addr1_memory_slice_16[4] = addr1[4];
assign addr1_memory_slice_16[5] = addr1[5];
assign addr1_memory_slice_16[6] = addr1[6];
assign addr1_memory_slice_16[7] = addr1[7];
assign addr1_memory_slice_16[8] = addr1[8];
assign addr1_memory_slice_16[9] = addr1[9];
assign addr1_memory_slice_16[10] = addr1[10];
assign addr1_memory_slice_16[11] = addr1[11];
assign addr2_memory_slice_16[0] = addr2[0];
assign addr2_memory_slice_16[1] = addr2[1];
assign addr2_memory_slice_16[2] = addr2[2];
assign addr2_memory_slice_16[3] = addr2[3];
assign addr2_memory_slice_16[4] = addr2[4];
assign addr2_memory_slice_16[5] = addr2[5];
assign addr2_memory_slice_16[6] = addr2[6];
assign addr2_memory_slice_16[7] = addr2[7];
assign addr2_memory_slice_16[8] = addr2[8];
assign addr2_memory_slice_16[9] = addr2[9];
assign addr2_memory_slice_16[10] = addr2[10];
assign addr2_memory_slice_16[11] = addr2[11];
assign data1_memory_slice_16[0] = data1[16];
assign data2_memory_slice_16[0] = data2[16];
assign we1_memory_slice_16[0] = we1[0];
assign we2_memory_slice_16[0] = we2[0];
assign clk_memory_slice_16[0] = clk[0];
 
memory_slice memory_slice_16 ( .clk(clk_memory_slice_16), .addr1(addr1_memory_slice_16), .addr2(addr2_memory_slice_16), .data1(data1_memory_slice_16), .data2(data2_memory_slice_16), .we1(we1_memory_slice_16), .we2(we2_memory_slice_16), .out1(out1_memory_slice_16), .out2(out2_memory_slice_16) );

assign addr1_memory_slice_17[0] = addr1[0];
assign addr1_memory_slice_17[1] = addr1[1];
assign addr1_memory_slice_17[2] = addr1[2];
assign addr1_memory_slice_17[3] = addr1[3];
assign addr1_memory_slice_17[4] = addr1[4];
assign addr1_memory_slice_17[5] = addr1[5];
assign addr1_memory_slice_17[6] = addr1[6];
assign addr1_memory_slice_17[7] = addr1[7];
assign addr1_memory_slice_17[8] = addr1[8];
assign addr1_memory_slice_17[9] = addr1[9];
assign addr1_memory_slice_17[10] = addr1[10];
assign addr1_memory_slice_17[11] = addr1[11];
assign addr2_memory_slice_17[0] = addr2[0];
assign addr2_memory_slice_17[1] = addr2[1];
assign addr2_memory_slice_17[2] = addr2[2];
assign addr2_memory_slice_17[3] = addr2[3];
assign addr2_memory_slice_17[4] = addr2[4];
assign addr2_memory_slice_17[5] = addr2[5];
assign addr2_memory_slice_17[6] = addr2[6];
assign addr2_memory_slice_17[7] = addr2[7];
assign addr2_memory_slice_17[8] = addr2[8];
assign addr2_memory_slice_17[9] = addr2[9];
assign addr2_memory_slice_17[10] = addr2[10];
assign addr2_memory_slice_17[11] = addr2[11];
assign data1_memory_slice_17[0] = data1[17];
assign data2_memory_slice_17[0] = data2[17];
assign we1_memory_slice_17[0] = we1[0];
assign we2_memory_slice_17[0] = we2[0];
assign clk_memory_slice_17[0] = clk[0];
 
memory_slice memory_slice_17 ( .clk(clk_memory_slice_17), .addr1(addr1_memory_slice_17), .addr2(addr2_memory_slice_17), .data1(data1_memory_slice_17), .data2(data2_memory_slice_17), .we1(we1_memory_slice_17), .we2(we2_memory_slice_17), .out1(out1_memory_slice_17), .out2(out2_memory_slice_17) );

assign addr1_memory_slice_18[0] = addr1[0];
assign addr1_memory_slice_18[1] = addr1[1];
assign addr1_memory_slice_18[2] = addr1[2];
assign addr1_memory_slice_18[3] = addr1[3];
assign addr1_memory_slice_18[4] = addr1[4];
assign addr1_memory_slice_18[5] = addr1[5];
assign addr1_memory_slice_18[6] = addr1[6];
assign addr1_memory_slice_18[7] = addr1[7];
assign addr1_memory_slice_18[8] = addr1[8];
assign addr1_memory_slice_18[9] = addr1[9];
assign addr1_memory_slice_18[10] = addr1[10];
assign addr1_memory_slice_18[11] = addr1[11];
assign addr2_memory_slice_18[0] = addr2[0];
assign addr2_memory_slice_18[1] = addr2[1];
assign addr2_memory_slice_18[2] = addr2[2];
assign addr2_memory_slice_18[3] = addr2[3];
assign addr2_memory_slice_18[4] = addr2[4];
assign addr2_memory_slice_18[5] = addr2[5];
assign addr2_memory_slice_18[6] = addr2[6];
assign addr2_memory_slice_18[7] = addr2[7];
assign addr2_memory_slice_18[8] = addr2[8];
assign addr2_memory_slice_18[9] = addr2[9];
assign addr2_memory_slice_18[10] = addr2[10];
assign addr2_memory_slice_18[11] = addr2[11];
assign data1_memory_slice_18[0] = data1[18];
assign data2_memory_slice_18[0] = data2[18];
assign we1_memory_slice_18[0] = we1[0];
assign we2_memory_slice_18[0] = we2[0];
assign clk_memory_slice_18[0] = clk[0];
 
memory_slice memory_slice_18 ( .clk(clk_memory_slice_18), .addr1(addr1_memory_slice_18), .addr2(addr2_memory_slice_18), .data1(data1_memory_slice_18), .data2(data2_memory_slice_18), .we1(we1_memory_slice_18), .we2(we2_memory_slice_18), .out1(out1_memory_slice_18), .out2(out2_memory_slice_18) );

assign addr1_memory_slice_19[0] = addr1[0];
assign addr1_memory_slice_19[1] = addr1[1];
assign addr1_memory_slice_19[2] = addr1[2];
assign addr1_memory_slice_19[3] = addr1[3];
assign addr1_memory_slice_19[4] = addr1[4];
assign addr1_memory_slice_19[5] = addr1[5];
assign addr1_memory_slice_19[6] = addr1[6];
assign addr1_memory_slice_19[7] = addr1[7];
assign addr1_memory_slice_19[8] = addr1[8];
assign addr1_memory_slice_19[9] = addr1[9];
assign addr1_memory_slice_19[10] = addr1[10];
assign addr1_memory_slice_19[11] = addr1[11];
assign addr2_memory_slice_19[0] = addr2[0];
assign addr2_memory_slice_19[1] = addr2[1];
assign addr2_memory_slice_19[2] = addr2[2];
assign addr2_memory_slice_19[3] = addr2[3];
assign addr2_memory_slice_19[4] = addr2[4];
assign addr2_memory_slice_19[5] = addr2[5];
assign addr2_memory_slice_19[6] = addr2[6];
assign addr2_memory_slice_19[7] = addr2[7];
assign addr2_memory_slice_19[8] = addr2[8];
assign addr2_memory_slice_19[9] = addr2[9];
assign addr2_memory_slice_19[10] = addr2[10];
assign addr2_memory_slice_19[11] = addr2[11];
assign data1_memory_slice_19[0] = data1[19];
assign data2_memory_slice_19[0] = data2[19];
assign we1_memory_slice_19[0] = we1[0];
assign we2_memory_slice_19[0] = we2[0];
assign clk_memory_slice_19[0] = clk[0];
 
memory_slice memory_slice_19 ( .clk(clk_memory_slice_19), .addr1(addr1_memory_slice_19), .addr2(addr2_memory_slice_19), .data1(data1_memory_slice_19), .data2(data2_memory_slice_19), .we1(we1_memory_slice_19), .we2(we2_memory_slice_19), .out1(out1_memory_slice_19), .out2(out2_memory_slice_19) );

assign addr1_memory_slice_20[0] = addr1[0];
assign addr1_memory_slice_20[1] = addr1[1];
assign addr1_memory_slice_20[2] = addr1[2];
assign addr1_memory_slice_20[3] = addr1[3];
assign addr1_memory_slice_20[4] = addr1[4];
assign addr1_memory_slice_20[5] = addr1[5];
assign addr1_memory_slice_20[6] = addr1[6];
assign addr1_memory_slice_20[7] = addr1[7];
assign addr1_memory_slice_20[8] = addr1[8];
assign addr1_memory_slice_20[9] = addr1[9];
assign addr1_memory_slice_20[10] = addr1[10];
assign addr1_memory_slice_20[11] = addr1[11];
assign addr2_memory_slice_20[0] = addr2[0];
assign addr2_memory_slice_20[1] = addr2[1];
assign addr2_memory_slice_20[2] = addr2[2];
assign addr2_memory_slice_20[3] = addr2[3];
assign addr2_memory_slice_20[4] = addr2[4];
assign addr2_memory_slice_20[5] = addr2[5];
assign addr2_memory_slice_20[6] = addr2[6];
assign addr2_memory_slice_20[7] = addr2[7];
assign addr2_memory_slice_20[8] = addr2[8];
assign addr2_memory_slice_20[9] = addr2[9];
assign addr2_memory_slice_20[10] = addr2[10];
assign addr2_memory_slice_20[11] = addr2[11];
assign data1_memory_slice_20[0] = data1[20];
assign data2_memory_slice_20[0] = data2[20];
assign we1_memory_slice_20[0] = we1[0];
assign we2_memory_slice_20[0] = we2[0];
assign clk_memory_slice_20[0] = clk[0];
 
memory_slice memory_slice_20 ( .clk(clk_memory_slice_20), .addr1(addr1_memory_slice_20), .addr2(addr2_memory_slice_20), .data1(data1_memory_slice_20), .data2(data2_memory_slice_20), .we1(we1_memory_slice_20), .we2(we2_memory_slice_20), .out1(out1_memory_slice_20), .out2(out2_memory_slice_20) );

assign addr1_memory_slice_21[0] = addr1[0];
assign addr1_memory_slice_21[1] = addr1[1];
assign addr1_memory_slice_21[2] = addr1[2];
assign addr1_memory_slice_21[3] = addr1[3];
assign addr1_memory_slice_21[4] = addr1[4];
assign addr1_memory_slice_21[5] = addr1[5];
assign addr1_memory_slice_21[6] = addr1[6];
assign addr1_memory_slice_21[7] = addr1[7];
assign addr1_memory_slice_21[8] = addr1[8];
assign addr1_memory_slice_21[9] = addr1[9];
assign addr1_memory_slice_21[10] = addr1[10];
assign addr1_memory_slice_21[11] = addr1[11];
assign addr2_memory_slice_21[0] = addr2[0];
assign addr2_memory_slice_21[1] = addr2[1];
assign addr2_memory_slice_21[2] = addr2[2];
assign addr2_memory_slice_21[3] = addr2[3];
assign addr2_memory_slice_21[4] = addr2[4];
assign addr2_memory_slice_21[5] = addr2[5];
assign addr2_memory_slice_21[6] = addr2[6];
assign addr2_memory_slice_21[7] = addr2[7];
assign addr2_memory_slice_21[8] = addr2[8];
assign addr2_memory_slice_21[9] = addr2[9];
assign addr2_memory_slice_21[10] = addr2[10];
assign addr2_memory_slice_21[11] = addr2[11];
assign data1_memory_slice_21[0] = data1[21];
assign data2_memory_slice_21[0] = data2[21];
assign we1_memory_slice_21[0] = we1[0];
assign we2_memory_slice_21[0] = we2[0];
assign clk_memory_slice_21[0] = clk[0];
 
memory_slice memory_slice_21 ( .clk(clk_memory_slice_21), .addr1(addr1_memory_slice_21), .addr2(addr2_memory_slice_21), .data1(data1_memory_slice_21), .data2(data2_memory_slice_21), .we1(we1_memory_slice_21), .we2(we2_memory_slice_21), .out1(out1_memory_slice_21), .out2(out2_memory_slice_21) );

assign addr1_memory_slice_22[0] = addr1[0];
assign addr1_memory_slice_22[1] = addr1[1];
assign addr1_memory_slice_22[2] = addr1[2];
assign addr1_memory_slice_22[3] = addr1[3];
assign addr1_memory_slice_22[4] = addr1[4];
assign addr1_memory_slice_22[5] = addr1[5];
assign addr1_memory_slice_22[6] = addr1[6];
assign addr1_memory_slice_22[7] = addr1[7];
assign addr1_memory_slice_22[8] = addr1[8];
assign addr1_memory_slice_22[9] = addr1[9];
assign addr1_memory_slice_22[10] = addr1[10];
assign addr1_memory_slice_22[11] = addr1[11];
assign addr2_memory_slice_22[0] = addr2[0];
assign addr2_memory_slice_22[1] = addr2[1];
assign addr2_memory_slice_22[2] = addr2[2];
assign addr2_memory_slice_22[3] = addr2[3];
assign addr2_memory_slice_22[4] = addr2[4];
assign addr2_memory_slice_22[5] = addr2[5];
assign addr2_memory_slice_22[6] = addr2[6];
assign addr2_memory_slice_22[7] = addr2[7];
assign addr2_memory_slice_22[8] = addr2[8];
assign addr2_memory_slice_22[9] = addr2[9];
assign addr2_memory_slice_22[10] = addr2[10];
assign addr2_memory_slice_22[11] = addr2[11];
assign data1_memory_slice_22[0] = data1[22];
assign data2_memory_slice_22[0] = data2[22];
assign we1_memory_slice_22[0] = we1[0];
assign we2_memory_slice_22[0] = we2[0];
assign clk_memory_slice_22[0] = clk[0];
 
memory_slice memory_slice_22 ( .clk(clk_memory_slice_22), .addr1(addr1_memory_slice_22), .addr2(addr2_memory_slice_22), .data1(data1_memory_slice_22), .data2(data2_memory_slice_22), .we1(we1_memory_slice_22), .we2(we2_memory_slice_22), .out1(out1_memory_slice_22), .out2(out2_memory_slice_22) );

assign addr1_memory_slice_23[0] = addr1[0];
assign addr1_memory_slice_23[1] = addr1[1];
assign addr1_memory_slice_23[2] = addr1[2];
assign addr1_memory_slice_23[3] = addr1[3];
assign addr1_memory_slice_23[4] = addr1[4];
assign addr1_memory_slice_23[5] = addr1[5];
assign addr1_memory_slice_23[6] = addr1[6];
assign addr1_memory_slice_23[7] = addr1[7];
assign addr1_memory_slice_23[8] = addr1[8];
assign addr1_memory_slice_23[9] = addr1[9];
assign addr1_memory_slice_23[10] = addr1[10];
assign addr1_memory_slice_23[11] = addr1[11];
assign addr2_memory_slice_23[0] = addr2[0];
assign addr2_memory_slice_23[1] = addr2[1];
assign addr2_memory_slice_23[2] = addr2[2];
assign addr2_memory_slice_23[3] = addr2[3];
assign addr2_memory_slice_23[4] = addr2[4];
assign addr2_memory_slice_23[5] = addr2[5];
assign addr2_memory_slice_23[6] = addr2[6];
assign addr2_memory_slice_23[7] = addr2[7];
assign addr2_memory_slice_23[8] = addr2[8];
assign addr2_memory_slice_23[9] = addr2[9];
assign addr2_memory_slice_23[10] = addr2[10];
assign addr2_memory_slice_23[11] = addr2[11];
assign data1_memory_slice_23[0] = data1[23];
assign data2_memory_slice_23[0] = data2[23];
assign we1_memory_slice_23[0] = we1[0];
assign we2_memory_slice_23[0] = we2[0];
assign clk_memory_slice_23[0] = clk[0];
 
memory_slice memory_slice_23 ( .clk(clk_memory_slice_23), .addr1(addr1_memory_slice_23), .addr2(addr2_memory_slice_23), .data1(data1_memory_slice_23), .data2(data2_memory_slice_23), .we1(we1_memory_slice_23), .we2(we2_memory_slice_23), .out1(out1_memory_slice_23), .out2(out2_memory_slice_23) );

assign addr1_memory_slice_24[0] = addr1[0];
assign addr1_memory_slice_24[1] = addr1[1];
assign addr1_memory_slice_24[2] = addr1[2];
assign addr1_memory_slice_24[3] = addr1[3];
assign addr1_memory_slice_24[4] = addr1[4];
assign addr1_memory_slice_24[5] = addr1[5];
assign addr1_memory_slice_24[6] = addr1[6];
assign addr1_memory_slice_24[7] = addr1[7];
assign addr1_memory_slice_24[8] = addr1[8];
assign addr1_memory_slice_24[9] = addr1[9];
assign addr1_memory_slice_24[10] = addr1[10];
assign addr1_memory_slice_24[11] = addr1[11];
assign addr2_memory_slice_24[0] = addr2[0];
assign addr2_memory_slice_24[1] = addr2[1];
assign addr2_memory_slice_24[2] = addr2[2];
assign addr2_memory_slice_24[3] = addr2[3];
assign addr2_memory_slice_24[4] = addr2[4];
assign addr2_memory_slice_24[5] = addr2[5];
assign addr2_memory_slice_24[6] = addr2[6];
assign addr2_memory_slice_24[7] = addr2[7];
assign addr2_memory_slice_24[8] = addr2[8];
assign addr2_memory_slice_24[9] = addr2[9];
assign addr2_memory_slice_24[10] = addr2[10];
assign addr2_memory_slice_24[11] = addr2[11];
assign data1_memory_slice_24[0] = data1[24];
assign data2_memory_slice_24[0] = data2[24];
assign we1_memory_slice_24[0] = we1[0];
assign we2_memory_slice_24[0] = we2[0];
assign clk_memory_slice_24[0] = clk[0];
 
memory_slice memory_slice_24 ( .clk(clk_memory_slice_24), .addr1(addr1_memory_slice_24), .addr2(addr2_memory_slice_24), .data1(data1_memory_slice_24), .data2(data2_memory_slice_24), .we1(we1_memory_slice_24), .we2(we2_memory_slice_24), .out1(out1_memory_slice_24), .out2(out2_memory_slice_24) );

assign addr1_memory_slice_25[0] = addr1[0];
assign addr1_memory_slice_25[1] = addr1[1];
assign addr1_memory_slice_25[2] = addr1[2];
assign addr1_memory_slice_25[3] = addr1[3];
assign addr1_memory_slice_25[4] = addr1[4];
assign addr1_memory_slice_25[5] = addr1[5];
assign addr1_memory_slice_25[6] = addr1[6];
assign addr1_memory_slice_25[7] = addr1[7];
assign addr1_memory_slice_25[8] = addr1[8];
assign addr1_memory_slice_25[9] = addr1[9];
assign addr1_memory_slice_25[10] = addr1[10];
assign addr1_memory_slice_25[11] = addr1[11];
assign addr2_memory_slice_25[0] = addr2[0];
assign addr2_memory_slice_25[1] = addr2[1];
assign addr2_memory_slice_25[2] = addr2[2];
assign addr2_memory_slice_25[3] = addr2[3];
assign addr2_memory_slice_25[4] = addr2[4];
assign addr2_memory_slice_25[5] = addr2[5];
assign addr2_memory_slice_25[6] = addr2[6];
assign addr2_memory_slice_25[7] = addr2[7];
assign addr2_memory_slice_25[8] = addr2[8];
assign addr2_memory_slice_25[9] = addr2[9];
assign addr2_memory_slice_25[10] = addr2[10];
assign addr2_memory_slice_25[11] = addr2[11];
assign data1_memory_slice_25[0] = data1[25];
assign data2_memory_slice_25[0] = data2[25];
assign we1_memory_slice_25[0] = we1[0];
assign we2_memory_slice_25[0] = we2[0];
assign clk_memory_slice_25[0] = clk[0];
 
memory_slice memory_slice_25 ( .clk(clk_memory_slice_25), .addr1(addr1_memory_slice_25), .addr2(addr2_memory_slice_25), .data1(data1_memory_slice_25), .data2(data2_memory_slice_25), .we1(we1_memory_slice_25), .we2(we2_memory_slice_25), .out1(out1_memory_slice_25), .out2(out2_memory_slice_25) );

assign addr1_memory_slice_26[0] = addr1[0];
assign addr1_memory_slice_26[1] = addr1[1];
assign addr1_memory_slice_26[2] = addr1[2];
assign addr1_memory_slice_26[3] = addr1[3];
assign addr1_memory_slice_26[4] = addr1[4];
assign addr1_memory_slice_26[5] = addr1[5];
assign addr1_memory_slice_26[6] = addr1[6];
assign addr1_memory_slice_26[7] = addr1[7];
assign addr1_memory_slice_26[8] = addr1[8];
assign addr1_memory_slice_26[9] = addr1[9];
assign addr1_memory_slice_26[10] = addr1[10];
assign addr1_memory_slice_26[11] = addr1[11];
assign addr2_memory_slice_26[0] = addr2[0];
assign addr2_memory_slice_26[1] = addr2[1];
assign addr2_memory_slice_26[2] = addr2[2];
assign addr2_memory_slice_26[3] = addr2[3];
assign addr2_memory_slice_26[4] = addr2[4];
assign addr2_memory_slice_26[5] = addr2[5];
assign addr2_memory_slice_26[6] = addr2[6];
assign addr2_memory_slice_26[7] = addr2[7];
assign addr2_memory_slice_26[8] = addr2[8];
assign addr2_memory_slice_26[9] = addr2[9];
assign addr2_memory_slice_26[10] = addr2[10];
assign addr2_memory_slice_26[11] = addr2[11];
assign data1_memory_slice_26[0] = data1[26];
assign data2_memory_slice_26[0] = data2[26];
assign we1_memory_slice_26[0] = we1[0];
assign we2_memory_slice_26[0] = we2[0];
assign clk_memory_slice_26[0] = clk[0];
 
memory_slice memory_slice_26 ( .clk(clk_memory_slice_26), .addr1(addr1_memory_slice_26), .addr2(addr2_memory_slice_26), .data1(data1_memory_slice_26), .data2(data2_memory_slice_26), .we1(we1_memory_slice_26), .we2(we2_memory_slice_26), .out1(out1_memory_slice_26), .out2(out2_memory_slice_26) );

assign addr1_memory_slice_27[0] = addr1[0];
assign addr1_memory_slice_27[1] = addr1[1];
assign addr1_memory_slice_27[2] = addr1[2];
assign addr1_memory_slice_27[3] = addr1[3];
assign addr1_memory_slice_27[4] = addr1[4];
assign addr1_memory_slice_27[5] = addr1[5];
assign addr1_memory_slice_27[6] = addr1[6];
assign addr1_memory_slice_27[7] = addr1[7];
assign addr1_memory_slice_27[8] = addr1[8];
assign addr1_memory_slice_27[9] = addr1[9];
assign addr1_memory_slice_27[10] = addr1[10];
assign addr1_memory_slice_27[11] = addr1[11];
assign addr2_memory_slice_27[0] = addr2[0];
assign addr2_memory_slice_27[1] = addr2[1];
assign addr2_memory_slice_27[2] = addr2[2];
assign addr2_memory_slice_27[3] = addr2[3];
assign addr2_memory_slice_27[4] = addr2[4];
assign addr2_memory_slice_27[5] = addr2[5];
assign addr2_memory_slice_27[6] = addr2[6];
assign addr2_memory_slice_27[7] = addr2[7];
assign addr2_memory_slice_27[8] = addr2[8];
assign addr2_memory_slice_27[9] = addr2[9];
assign addr2_memory_slice_27[10] = addr2[10];
assign addr2_memory_slice_27[11] = addr2[11];
assign data1_memory_slice_27[0] = data1[27];
assign data2_memory_slice_27[0] = data2[27];
assign we1_memory_slice_27[0] = we1[0];
assign we2_memory_slice_27[0] = we2[0];
assign clk_memory_slice_27[0] = clk[0];
 
memory_slice memory_slice_27 ( .clk(clk_memory_slice_27), .addr1(addr1_memory_slice_27), .addr2(addr2_memory_slice_27), .data1(data1_memory_slice_27), .data2(data2_memory_slice_27), .we1(we1_memory_slice_27), .we2(we2_memory_slice_27), .out1(out1_memory_slice_27), .out2(out2_memory_slice_27) );

assign addr1_memory_slice_28[0] = addr1[0];
assign addr1_memory_slice_28[1] = addr1[1];
assign addr1_memory_slice_28[2] = addr1[2];
assign addr1_memory_slice_28[3] = addr1[3];
assign addr1_memory_slice_28[4] = addr1[4];
assign addr1_memory_slice_28[5] = addr1[5];
assign addr1_memory_slice_28[6] = addr1[6];
assign addr1_memory_slice_28[7] = addr1[7];
assign addr1_memory_slice_28[8] = addr1[8];
assign addr1_memory_slice_28[9] = addr1[9];
assign addr1_memory_slice_28[10] = addr1[10];
assign addr1_memory_slice_28[11] = addr1[11];
assign addr2_memory_slice_28[0] = addr2[0];
assign addr2_memory_slice_28[1] = addr2[1];
assign addr2_memory_slice_28[2] = addr2[2];
assign addr2_memory_slice_28[3] = addr2[3];
assign addr2_memory_slice_28[4] = addr2[4];
assign addr2_memory_slice_28[5] = addr2[5];
assign addr2_memory_slice_28[6] = addr2[6];
assign addr2_memory_slice_28[7] = addr2[7];
assign addr2_memory_slice_28[8] = addr2[8];
assign addr2_memory_slice_28[9] = addr2[9];
assign addr2_memory_slice_28[10] = addr2[10];
assign addr2_memory_slice_28[11] = addr2[11];
assign data1_memory_slice_28[0] = data1[28];
assign data2_memory_slice_28[0] = data2[28];
assign we1_memory_slice_28[0] = we1[0];
assign we2_memory_slice_28[0] = we2[0];
assign clk_memory_slice_28[0] = clk[0];
 
memory_slice memory_slice_28 ( .clk(clk_memory_slice_28), .addr1(addr1_memory_slice_28), .addr2(addr2_memory_slice_28), .data1(data1_memory_slice_28), .data2(data2_memory_slice_28), .we1(we1_memory_slice_28), .we2(we2_memory_slice_28), .out1(out1_memory_slice_28), .out2(out2_memory_slice_28) );

assign addr1_memory_slice_29[0] = addr1[0];
assign addr1_memory_slice_29[1] = addr1[1];
assign addr1_memory_slice_29[2] = addr1[2];
assign addr1_memory_slice_29[3] = addr1[3];
assign addr1_memory_slice_29[4] = addr1[4];
assign addr1_memory_slice_29[5] = addr1[5];
assign addr1_memory_slice_29[6] = addr1[6];
assign addr1_memory_slice_29[7] = addr1[7];
assign addr1_memory_slice_29[8] = addr1[8];
assign addr1_memory_slice_29[9] = addr1[9];
assign addr1_memory_slice_29[10] = addr1[10];
assign addr1_memory_slice_29[11] = addr1[11];
assign addr2_memory_slice_29[0] = addr2[0];
assign addr2_memory_slice_29[1] = addr2[1];
assign addr2_memory_slice_29[2] = addr2[2];
assign addr2_memory_slice_29[3] = addr2[3];
assign addr2_memory_slice_29[4] = addr2[4];
assign addr2_memory_slice_29[5] = addr2[5];
assign addr2_memory_slice_29[6] = addr2[6];
assign addr2_memory_slice_29[7] = addr2[7];
assign addr2_memory_slice_29[8] = addr2[8];
assign addr2_memory_slice_29[9] = addr2[9];
assign addr2_memory_slice_29[10] = addr2[10];
assign addr2_memory_slice_29[11] = addr2[11];
assign data1_memory_slice_29[0] = data1[29];
assign data2_memory_slice_29[0] = data2[29];
assign we1_memory_slice_29[0] = we1[0];
assign we2_memory_slice_29[0] = we2[0];
assign clk_memory_slice_29[0] = clk[0];
 
memory_slice memory_slice_29 ( .clk(clk_memory_slice_29), .addr1(addr1_memory_slice_29), .addr2(addr2_memory_slice_29), .data1(data1_memory_slice_29), .data2(data2_memory_slice_29), .we1(we1_memory_slice_29), .we2(we2_memory_slice_29), .out1(out1_memory_slice_29), .out2(out2_memory_slice_29) );

assign addr1_memory_slice_30[0] = addr1[0];
assign addr1_memory_slice_30[1] = addr1[1];
assign addr1_memory_slice_30[2] = addr1[2];
assign addr1_memory_slice_30[3] = addr1[3];
assign addr1_memory_slice_30[4] = addr1[4];
assign addr1_memory_slice_30[5] = addr1[5];
assign addr1_memory_slice_30[6] = addr1[6];
assign addr1_memory_slice_30[7] = addr1[7];
assign addr1_memory_slice_30[8] = addr1[8];
assign addr1_memory_slice_30[9] = addr1[9];
assign addr1_memory_slice_30[10] = addr1[10];
assign addr1_memory_slice_30[11] = addr1[11];
assign addr2_memory_slice_30[0] = addr2[0];
assign addr2_memory_slice_30[1] = addr2[1];
assign addr2_memory_slice_30[2] = addr2[2];
assign addr2_memory_slice_30[3] = addr2[3];
assign addr2_memory_slice_30[4] = addr2[4];
assign addr2_memory_slice_30[5] = addr2[5];
assign addr2_memory_slice_30[6] = addr2[6];
assign addr2_memory_slice_30[7] = addr2[7];
assign addr2_memory_slice_30[8] = addr2[8];
assign addr2_memory_slice_30[9] = addr2[9];
assign addr2_memory_slice_30[10] = addr2[10];
assign addr2_memory_slice_30[11] = addr2[11];
assign data1_memory_slice_30[0] = data1[30];
assign data2_memory_slice_30[0] = data2[30];
assign we1_memory_slice_30[0] = we1[0];
assign we2_memory_slice_30[0] = we2[0];
assign clk_memory_slice_30[0] = clk[0];
 
memory_slice memory_slice_30 ( .clk(clk_memory_slice_30), .addr1(addr1_memory_slice_30), .addr2(addr2_memory_slice_30), .data1(data1_memory_slice_30), .data2(data2_memory_slice_30), .we1(we1_memory_slice_30), .we2(we2_memory_slice_30), .out1(out1_memory_slice_30), .out2(out2_memory_slice_30) );

assign addr1_memory_slice_31[0] = addr1[0];
assign addr1_memory_slice_31[1] = addr1[1];
assign addr1_memory_slice_31[2] = addr1[2];
assign addr1_memory_slice_31[3] = addr1[3];
assign addr1_memory_slice_31[4] = addr1[4];
assign addr1_memory_slice_31[5] = addr1[5];
assign addr1_memory_slice_31[6] = addr1[6];
assign addr1_memory_slice_31[7] = addr1[7];
assign addr1_memory_slice_31[8] = addr1[8];
assign addr1_memory_slice_31[9] = addr1[9];
assign addr1_memory_slice_31[10] = addr1[10];
assign addr1_memory_slice_31[11] = addr1[11];
assign addr2_memory_slice_31[0] = addr2[0];
assign addr2_memory_slice_31[1] = addr2[1];
assign addr2_memory_slice_31[2] = addr2[2];
assign addr2_memory_slice_31[3] = addr2[3];
assign addr2_memory_slice_31[4] = addr2[4];
assign addr2_memory_slice_31[5] = addr2[5];
assign addr2_memory_slice_31[6] = addr2[6];
assign addr2_memory_slice_31[7] = addr2[7];
assign addr2_memory_slice_31[8] = addr2[8];
assign addr2_memory_slice_31[9] = addr2[9];
assign addr2_memory_slice_31[10] = addr2[10];
assign addr2_memory_slice_31[11] = addr2[11];
assign data1_memory_slice_31[0] = data1[31];
assign data2_memory_slice_31[0] = data2[31];
assign we1_memory_slice_31[0] = we1[0];
assign we2_memory_slice_31[0] = we2[0];
assign clk_memory_slice_31[0] = clk[0];
 
memory_slice memory_slice_31 ( .clk(clk_memory_slice_31), .addr1(addr1_memory_slice_31), .addr2(addr2_memory_slice_31), .data1(data1_memory_slice_31), .data2(data2_memory_slice_31), .we1(we1_memory_slice_31), .we2(we2_memory_slice_31), .out1(out1_memory_slice_31), .out2(out2_memory_slice_31) );

assign addr1_memory_slice_32[0] = addr1[0];
assign addr1_memory_slice_32[1] = addr1[1];
assign addr1_memory_slice_32[2] = addr1[2];
assign addr1_memory_slice_32[3] = addr1[3];
assign addr1_memory_slice_32[4] = addr1[4];
assign addr1_memory_slice_32[5] = addr1[5];
assign addr1_memory_slice_32[6] = addr1[6];
assign addr1_memory_slice_32[7] = addr1[7];
assign addr1_memory_slice_32[8] = addr1[8];
assign addr1_memory_slice_32[9] = addr1[9];
assign addr1_memory_slice_32[10] = addr1[10];
assign addr1_memory_slice_32[11] = addr1[11];
assign addr2_memory_slice_32[0] = addr2[0];
assign addr2_memory_slice_32[1] = addr2[1];
assign addr2_memory_slice_32[2] = addr2[2];
assign addr2_memory_slice_32[3] = addr2[3];
assign addr2_memory_slice_32[4] = addr2[4];
assign addr2_memory_slice_32[5] = addr2[5];
assign addr2_memory_slice_32[6] = addr2[6];
assign addr2_memory_slice_32[7] = addr2[7];
assign addr2_memory_slice_32[8] = addr2[8];
assign addr2_memory_slice_32[9] = addr2[9];
assign addr2_memory_slice_32[10] = addr2[10];
assign addr2_memory_slice_32[11] = addr2[11];
assign data1_memory_slice_32[0] = data1[32];
assign data2_memory_slice_32[0] = data2[32];
assign we1_memory_slice_32[0] = we1[0];
assign we2_memory_slice_32[0] = we2[0];
assign clk_memory_slice_32[0] = clk[0];
 
memory_slice memory_slice_32 ( .clk(clk_memory_slice_32), .addr1(addr1_memory_slice_32), .addr2(addr2_memory_slice_32), .data1(data1_memory_slice_32), .data2(data2_memory_slice_32), .we1(we1_memory_slice_32), .we2(we2_memory_slice_32), .out1(out1_memory_slice_32), .out2(out2_memory_slice_32) );

assign addr1_memory_slice_33[0] = addr1[0];
assign addr1_memory_slice_33[1] = addr1[1];
assign addr1_memory_slice_33[2] = addr1[2];
assign addr1_memory_slice_33[3] = addr1[3];
assign addr1_memory_slice_33[4] = addr1[4];
assign addr1_memory_slice_33[5] = addr1[5];
assign addr1_memory_slice_33[6] = addr1[6];
assign addr1_memory_slice_33[7] = addr1[7];
assign addr1_memory_slice_33[8] = addr1[8];
assign addr1_memory_slice_33[9] = addr1[9];
assign addr1_memory_slice_33[10] = addr1[10];
assign addr1_memory_slice_33[11] = addr1[11];
assign addr2_memory_slice_33[0] = addr2[0];
assign addr2_memory_slice_33[1] = addr2[1];
assign addr2_memory_slice_33[2] = addr2[2];
assign addr2_memory_slice_33[3] = addr2[3];
assign addr2_memory_slice_33[4] = addr2[4];
assign addr2_memory_slice_33[5] = addr2[5];
assign addr2_memory_slice_33[6] = addr2[6];
assign addr2_memory_slice_33[7] = addr2[7];
assign addr2_memory_slice_33[8] = addr2[8];
assign addr2_memory_slice_33[9] = addr2[9];
assign addr2_memory_slice_33[10] = addr2[10];
assign addr2_memory_slice_33[11] = addr2[11];
assign data1_memory_slice_33[0] = data1[33];
assign data2_memory_slice_33[0] = data2[33];
assign we1_memory_slice_33[0] = we1[0];
assign we2_memory_slice_33[0] = we2[0];
assign clk_memory_slice_33[0] = clk[0];
 
memory_slice memory_slice_33 ( .clk(clk_memory_slice_33), .addr1(addr1_memory_slice_33), .addr2(addr2_memory_slice_33), .data1(data1_memory_slice_33), .data2(data2_memory_slice_33), .we1(we1_memory_slice_33), .we2(we2_memory_slice_33), .out1(out1_memory_slice_33), .out2(out2_memory_slice_33) );

assign addr1_memory_slice_34[0] = addr1[0];
assign addr1_memory_slice_34[1] = addr1[1];
assign addr1_memory_slice_34[2] = addr1[2];
assign addr1_memory_slice_34[3] = addr1[3];
assign addr1_memory_slice_34[4] = addr1[4];
assign addr1_memory_slice_34[5] = addr1[5];
assign addr1_memory_slice_34[6] = addr1[6];
assign addr1_memory_slice_34[7] = addr1[7];
assign addr1_memory_slice_34[8] = addr1[8];
assign addr1_memory_slice_34[9] = addr1[9];
assign addr1_memory_slice_34[10] = addr1[10];
assign addr1_memory_slice_34[11] = addr1[11];
assign addr2_memory_slice_34[0] = addr2[0];
assign addr2_memory_slice_34[1] = addr2[1];
assign addr2_memory_slice_34[2] = addr2[2];
assign addr2_memory_slice_34[3] = addr2[3];
assign addr2_memory_slice_34[4] = addr2[4];
assign addr2_memory_slice_34[5] = addr2[5];
assign addr2_memory_slice_34[6] = addr2[6];
assign addr2_memory_slice_34[7] = addr2[7];
assign addr2_memory_slice_34[8] = addr2[8];
assign addr2_memory_slice_34[9] = addr2[9];
assign addr2_memory_slice_34[10] = addr2[10];
assign addr2_memory_slice_34[11] = addr2[11];
assign data1_memory_slice_34[0] = data1[34];
assign data2_memory_slice_34[0] = data2[34];
assign we1_memory_slice_34[0] = we1[0];
assign we2_memory_slice_34[0] = we2[0];
assign clk_memory_slice_34[0] = clk[0];
 
memory_slice memory_slice_34 ( .clk(clk_memory_slice_34), .addr1(addr1_memory_slice_34), .addr2(addr2_memory_slice_34), .data1(data1_memory_slice_34), .data2(data2_memory_slice_34), .we1(we1_memory_slice_34), .we2(we2_memory_slice_34), .out1(out1_memory_slice_34), .out2(out2_memory_slice_34) );

assign addr1_memory_slice_35[0] = addr1[0];
assign addr1_memory_slice_35[1] = addr1[1];
assign addr1_memory_slice_35[2] = addr1[2];
assign addr1_memory_slice_35[3] = addr1[3];
assign addr1_memory_slice_35[4] = addr1[4];
assign addr1_memory_slice_35[5] = addr1[5];
assign addr1_memory_slice_35[6] = addr1[6];
assign addr1_memory_slice_35[7] = addr1[7];
assign addr1_memory_slice_35[8] = addr1[8];
assign addr1_memory_slice_35[9] = addr1[9];
assign addr1_memory_slice_35[10] = addr1[10];
assign addr1_memory_slice_35[11] = addr1[11];
assign addr2_memory_slice_35[0] = addr2[0];
assign addr2_memory_slice_35[1] = addr2[1];
assign addr2_memory_slice_35[2] = addr2[2];
assign addr2_memory_slice_35[3] = addr2[3];
assign addr2_memory_slice_35[4] = addr2[4];
assign addr2_memory_slice_35[5] = addr2[5];
assign addr2_memory_slice_35[6] = addr2[6];
assign addr2_memory_slice_35[7] = addr2[7];
assign addr2_memory_slice_35[8] = addr2[8];
assign addr2_memory_slice_35[9] = addr2[9];
assign addr2_memory_slice_35[10] = addr2[10];
assign addr2_memory_slice_35[11] = addr2[11];
assign data1_memory_slice_35[0] = data1[35];
assign data2_memory_slice_35[0] = data2[35];
assign we1_memory_slice_35[0] = we1[0];
assign we2_memory_slice_35[0] = we2[0];
assign clk_memory_slice_35[0] = clk[0];
 
memory_slice memory_slice_35 ( .clk(clk_memory_slice_35), .addr1(addr1_memory_slice_35), .addr2(addr2_memory_slice_35), .data1(data1_memory_slice_35), .data2(data2_memory_slice_35), .we1(we1_memory_slice_35), .we2(we2_memory_slice_35), .out1(out1_memory_slice_35), .out2(out2_memory_slice_35) );

//child output to block output
assign out1[0] = out1_memory_slice_0[0];
assign out1[1] = out1_memory_slice_1[0];
assign out1[2] = out1_memory_slice_2[0];
assign out1[3] = out1_memory_slice_3[0];
assign out1[4] = out1_memory_slice_4[0];
assign out1[5] = out1_memory_slice_5[0];
assign out1[6] = out1_memory_slice_6[0];
assign out1[7] = out1_memory_slice_7[0];
assign out1[8] = out1_memory_slice_8[0];
assign out1[9] = out1_memory_slice_9[0];
assign out1[10] = out1_memory_slice_10[0];
assign out1[11] = out1_memory_slice_11[0];
assign out1[12] = out1_memory_slice_12[0];
assign out1[13] = out1_memory_slice_13[0];
assign out1[14] = out1_memory_slice_14[0];
assign out1[15] = out1_memory_slice_15[0];
assign out1[16] = out1_memory_slice_16[0];
assign out1[17] = out1_memory_slice_17[0];
assign out1[18] = out1_memory_slice_18[0];
assign out1[19] = out1_memory_slice_19[0];
assign out1[20] = out1_memory_slice_20[0];
assign out1[21] = out1_memory_slice_21[0];
assign out1[22] = out1_memory_slice_22[0];
assign out1[23] = out1_memory_slice_23[0];
assign out1[24] = out1_memory_slice_24[0];
assign out1[25] = out1_memory_slice_25[0];
assign out1[26] = out1_memory_slice_26[0];
assign out1[27] = out1_memory_slice_27[0];
assign out1[28] = out1_memory_slice_28[0];
assign out1[29] = out1_memory_slice_29[0];
assign out1[30] = out1_memory_slice_30[0];
assign out1[31] = out1_memory_slice_31[0];
assign out1[32] = out1_memory_slice_32[0];
assign out1[33] = out1_memory_slice_33[0];
assign out1[34] = out1_memory_slice_34[0];
assign out1[35] = out1_memory_slice_35[0];
assign out2[0] = out2_memory_slice_0[0];
assign out2[1] = out2_memory_slice_1[0];
assign out2[2] = out2_memory_slice_2[0];
assign out2[3] = out2_memory_slice_3[0];
assign out2[4] = out2_memory_slice_4[0];
assign out2[5] = out2_memory_slice_5[0];
assign out2[6] = out2_memory_slice_6[0];
assign out2[7] = out2_memory_slice_7[0];
assign out2[8] = out2_memory_slice_8[0];
assign out2[9] = out2_memory_slice_9[0];
assign out2[10] = out2_memory_slice_10[0];
assign out2[11] = out2_memory_slice_11[0];
assign out2[12] = out2_memory_slice_12[0];
assign out2[13] = out2_memory_slice_13[0];
assign out2[14] = out2_memory_slice_14[0];
assign out2[15] = out2_memory_slice_15[0];
assign out2[16] = out2_memory_slice_16[0];
assign out2[17] = out2_memory_slice_17[0];
assign out2[18] = out2_memory_slice_18[0];
assign out2[19] = out2_memory_slice_19[0];
assign out2[20] = out2_memory_slice_20[0];
assign out2[21] = out2_memory_slice_21[0];
assign out2[22] = out2_memory_slice_22[0];
assign out2[23] = out2_memory_slice_23[0];
assign out2[24] = out2_memory_slice_24[0];
assign out2[25] = out2_memory_slice_25[0];
assign out2[26] = out2_memory_slice_26[0];
assign out2[27] = out2_memory_slice_27[0];
assign out2[28] = out2_memory_slice_28[0];
assign out2[29] = out2_memory_slice_29[0];
assign out2[30] = out2_memory_slice_30[0];
assign out2[31] = out2_memory_slice_31[0];
assign out2[32] = out2_memory_slice_32[0];
assign out2[33] = out2_memory_slice_33[0];
assign out2[34] = out2_memory_slice_34[0];
assign out2[35] = out2_memory_slice_35[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [11:0]addr,
	input [0:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [0:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_4096x36_sp /////////////////////////
/////////////////////////////////////////////////////
module mem_4096x36_sp (
	input [11:0]addr,
	input [35:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [35:0]out
);

////////child (0,0,0)////////
wire [11:0]addr_memory_slice_0;//input to child
wire [0:0]data_memory_slice_0;//input to child
wire [0:0]we_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [11:0]addr_memory_slice_1;//input to child
wire [0:0]data_memory_slice_1;//input to child
wire [0:0]we_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [11:0]addr_memory_slice_2;//input to child
wire [0:0]data_memory_slice_2;//input to child
wire [0:0]we_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [11:0]addr_memory_slice_3;//input to child
wire [0:0]data_memory_slice_3;//input to child
wire [0:0]we_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [11:0]addr_memory_slice_4;//input to child
wire [0:0]data_memory_slice_4;//input to child
wire [0:0]we_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [11:0]addr_memory_slice_5;//input to child
wire [0:0]data_memory_slice_5;//input to child
wire [0:0]we_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [11:0]addr_memory_slice_6;//input to child
wire [0:0]data_memory_slice_6;//input to child
wire [0:0]we_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [11:0]addr_memory_slice_7;//input to child
wire [0:0]data_memory_slice_7;//input to child
wire [0:0]we_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [11:0]addr_memory_slice_8;//input to child
wire [0:0]data_memory_slice_8;//input to child
wire [0:0]we_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out_memory_slice_8;//output from child
 
////////child (0,0,9)////////
wire [11:0]addr_memory_slice_9;//input to child
wire [0:0]data_memory_slice_9;//input to child
wire [0:0]we_memory_slice_9;//input to child
wire [0:0]clk_memory_slice_9;//clock to child
wire [0:0]out_memory_slice_9;//output from child
 
////////child (0,0,10)////////
wire [11:0]addr_memory_slice_10;//input to child
wire [0:0]data_memory_slice_10;//input to child
wire [0:0]we_memory_slice_10;//input to child
wire [0:0]clk_memory_slice_10;//clock to child
wire [0:0]out_memory_slice_10;//output from child
 
////////child (0,0,11)////////
wire [11:0]addr_memory_slice_11;//input to child
wire [0:0]data_memory_slice_11;//input to child
wire [0:0]we_memory_slice_11;//input to child
wire [0:0]clk_memory_slice_11;//clock to child
wire [0:0]out_memory_slice_11;//output from child
 
////////child (0,0,12)////////
wire [11:0]addr_memory_slice_12;//input to child
wire [0:0]data_memory_slice_12;//input to child
wire [0:0]we_memory_slice_12;//input to child
wire [0:0]clk_memory_slice_12;//clock to child
wire [0:0]out_memory_slice_12;//output from child
 
////////child (0,0,13)////////
wire [11:0]addr_memory_slice_13;//input to child
wire [0:0]data_memory_slice_13;//input to child
wire [0:0]we_memory_slice_13;//input to child
wire [0:0]clk_memory_slice_13;//clock to child
wire [0:0]out_memory_slice_13;//output from child
 
////////child (0,0,14)////////
wire [11:0]addr_memory_slice_14;//input to child
wire [0:0]data_memory_slice_14;//input to child
wire [0:0]we_memory_slice_14;//input to child
wire [0:0]clk_memory_slice_14;//clock to child
wire [0:0]out_memory_slice_14;//output from child
 
////////child (0,0,15)////////
wire [11:0]addr_memory_slice_15;//input to child
wire [0:0]data_memory_slice_15;//input to child
wire [0:0]we_memory_slice_15;//input to child
wire [0:0]clk_memory_slice_15;//clock to child
wire [0:0]out_memory_slice_15;//output from child
 
////////child (0,0,16)////////
wire [11:0]addr_memory_slice_16;//input to child
wire [0:0]data_memory_slice_16;//input to child
wire [0:0]we_memory_slice_16;//input to child
wire [0:0]clk_memory_slice_16;//clock to child
wire [0:0]out_memory_slice_16;//output from child
 
////////child (0,0,17)////////
wire [11:0]addr_memory_slice_17;//input to child
wire [0:0]data_memory_slice_17;//input to child
wire [0:0]we_memory_slice_17;//input to child
wire [0:0]clk_memory_slice_17;//clock to child
wire [0:0]out_memory_slice_17;//output from child
 
////////child (0,0,18)////////
wire [11:0]addr_memory_slice_18;//input to child
wire [0:0]data_memory_slice_18;//input to child
wire [0:0]we_memory_slice_18;//input to child
wire [0:0]clk_memory_slice_18;//clock to child
wire [0:0]out_memory_slice_18;//output from child
 
////////child (0,0,19)////////
wire [11:0]addr_memory_slice_19;//input to child
wire [0:0]data_memory_slice_19;//input to child
wire [0:0]we_memory_slice_19;//input to child
wire [0:0]clk_memory_slice_19;//clock to child
wire [0:0]out_memory_slice_19;//output from child
 
////////child (0,0,20)////////
wire [11:0]addr_memory_slice_20;//input to child
wire [0:0]data_memory_slice_20;//input to child
wire [0:0]we_memory_slice_20;//input to child
wire [0:0]clk_memory_slice_20;//clock to child
wire [0:0]out_memory_slice_20;//output from child
 
////////child (0,0,21)////////
wire [11:0]addr_memory_slice_21;//input to child
wire [0:0]data_memory_slice_21;//input to child
wire [0:0]we_memory_slice_21;//input to child
wire [0:0]clk_memory_slice_21;//clock to child
wire [0:0]out_memory_slice_21;//output from child
 
////////child (0,0,22)////////
wire [11:0]addr_memory_slice_22;//input to child
wire [0:0]data_memory_slice_22;//input to child
wire [0:0]we_memory_slice_22;//input to child
wire [0:0]clk_memory_slice_22;//clock to child
wire [0:0]out_memory_slice_22;//output from child
 
////////child (0,0,23)////////
wire [11:0]addr_memory_slice_23;//input to child
wire [0:0]data_memory_slice_23;//input to child
wire [0:0]we_memory_slice_23;//input to child
wire [0:0]clk_memory_slice_23;//clock to child
wire [0:0]out_memory_slice_23;//output from child
 
////////child (0,0,24)////////
wire [11:0]addr_memory_slice_24;//input to child
wire [0:0]data_memory_slice_24;//input to child
wire [0:0]we_memory_slice_24;//input to child
wire [0:0]clk_memory_slice_24;//clock to child
wire [0:0]out_memory_slice_24;//output from child
 
////////child (0,0,25)////////
wire [11:0]addr_memory_slice_25;//input to child
wire [0:0]data_memory_slice_25;//input to child
wire [0:0]we_memory_slice_25;//input to child
wire [0:0]clk_memory_slice_25;//clock to child
wire [0:0]out_memory_slice_25;//output from child
 
////////child (0,0,26)////////
wire [11:0]addr_memory_slice_26;//input to child
wire [0:0]data_memory_slice_26;//input to child
wire [0:0]we_memory_slice_26;//input to child
wire [0:0]clk_memory_slice_26;//clock to child
wire [0:0]out_memory_slice_26;//output from child
 
////////child (0,0,27)////////
wire [11:0]addr_memory_slice_27;//input to child
wire [0:0]data_memory_slice_27;//input to child
wire [0:0]we_memory_slice_27;//input to child
wire [0:0]clk_memory_slice_27;//clock to child
wire [0:0]out_memory_slice_27;//output from child
 
////////child (0,0,28)////////
wire [11:0]addr_memory_slice_28;//input to child
wire [0:0]data_memory_slice_28;//input to child
wire [0:0]we_memory_slice_28;//input to child
wire [0:0]clk_memory_slice_28;//clock to child
wire [0:0]out_memory_slice_28;//output from child
 
////////child (0,0,29)////////
wire [11:0]addr_memory_slice_29;//input to child
wire [0:0]data_memory_slice_29;//input to child
wire [0:0]we_memory_slice_29;//input to child
wire [0:0]clk_memory_slice_29;//clock to child
wire [0:0]out_memory_slice_29;//output from child
 
////////child (0,0,30)////////
wire [11:0]addr_memory_slice_30;//input to child
wire [0:0]data_memory_slice_30;//input to child
wire [0:0]we_memory_slice_30;//input to child
wire [0:0]clk_memory_slice_30;//clock to child
wire [0:0]out_memory_slice_30;//output from child
 
////////child (0,0,31)////////
wire [11:0]addr_memory_slice_31;//input to child
wire [0:0]data_memory_slice_31;//input to child
wire [0:0]we_memory_slice_31;//input to child
wire [0:0]clk_memory_slice_31;//clock to child
wire [0:0]out_memory_slice_31;//output from child
 
////////child (0,0,32)////////
wire [11:0]addr_memory_slice_32;//input to child
wire [0:0]data_memory_slice_32;//input to child
wire [0:0]we_memory_slice_32;//input to child
wire [0:0]clk_memory_slice_32;//clock to child
wire [0:0]out_memory_slice_32;//output from child
 
////////child (0,0,33)////////
wire [11:0]addr_memory_slice_33;//input to child
wire [0:0]data_memory_slice_33;//input to child
wire [0:0]we_memory_slice_33;//input to child
wire [0:0]clk_memory_slice_33;//clock to child
wire [0:0]out_memory_slice_33;//output from child
 
////////child (0,0,34)////////
wire [11:0]addr_memory_slice_34;//input to child
wire [0:0]data_memory_slice_34;//input to child
wire [0:0]we_memory_slice_34;//input to child
wire [0:0]clk_memory_slice_34;//clock to child
wire [0:0]out_memory_slice_34;//output from child
 
////////child (0,0,35)////////
wire [11:0]addr_memory_slice_35;//input to child
wire [0:0]data_memory_slice_35;//input to child
wire [0:0]we_memory_slice_35;//input to child
wire [0:0]clk_memory_slice_35;//clock to child
wire [0:0]out_memory_slice_35;//output from child
 
wire ground;

assign addr_memory_slice_0[0] = addr[0];
assign addr_memory_slice_0[1] = addr[1];
assign addr_memory_slice_0[2] = addr[2];
assign addr_memory_slice_0[3] = addr[3];
assign addr_memory_slice_0[4] = addr[4];
assign addr_memory_slice_0[5] = addr[5];
assign addr_memory_slice_0[6] = addr[6];
assign addr_memory_slice_0[7] = addr[7];
assign addr_memory_slice_0[8] = addr[8];
assign addr_memory_slice_0[9] = addr[9];
assign addr_memory_slice_0[10] = addr[10];
assign addr_memory_slice_0[11] = addr[11];
assign data_memory_slice_0[0] = data[0];
assign we_memory_slice_0[0] = we[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr(addr_memory_slice_0), .data(data_memory_slice_0), .we(we_memory_slice_0), .out(out_memory_slice_0) );

assign addr_memory_slice_1[0] = addr[0];
assign addr_memory_slice_1[1] = addr[1];
assign addr_memory_slice_1[2] = addr[2];
assign addr_memory_slice_1[3] = addr[3];
assign addr_memory_slice_1[4] = addr[4];
assign addr_memory_slice_1[5] = addr[5];
assign addr_memory_slice_1[6] = addr[6];
assign addr_memory_slice_1[7] = addr[7];
assign addr_memory_slice_1[8] = addr[8];
assign addr_memory_slice_1[9] = addr[9];
assign addr_memory_slice_1[10] = addr[10];
assign addr_memory_slice_1[11] = addr[11];
assign data_memory_slice_1[0] = data[1];
assign we_memory_slice_1[0] = we[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr(addr_memory_slice_1), .data(data_memory_slice_1), .we(we_memory_slice_1), .out(out_memory_slice_1) );

assign addr_memory_slice_2[0] = addr[0];
assign addr_memory_slice_2[1] = addr[1];
assign addr_memory_slice_2[2] = addr[2];
assign addr_memory_slice_2[3] = addr[3];
assign addr_memory_slice_2[4] = addr[4];
assign addr_memory_slice_2[5] = addr[5];
assign addr_memory_slice_2[6] = addr[6];
assign addr_memory_slice_2[7] = addr[7];
assign addr_memory_slice_2[8] = addr[8];
assign addr_memory_slice_2[9] = addr[9];
assign addr_memory_slice_2[10] = addr[10];
assign addr_memory_slice_2[11] = addr[11];
assign data_memory_slice_2[0] = data[2];
assign we_memory_slice_2[0] = we[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr(addr_memory_slice_2), .data(data_memory_slice_2), .we(we_memory_slice_2), .out(out_memory_slice_2) );

assign addr_memory_slice_3[0] = addr[0];
assign addr_memory_slice_3[1] = addr[1];
assign addr_memory_slice_3[2] = addr[2];
assign addr_memory_slice_3[3] = addr[3];
assign addr_memory_slice_3[4] = addr[4];
assign addr_memory_slice_3[5] = addr[5];
assign addr_memory_slice_3[6] = addr[6];
assign addr_memory_slice_3[7] = addr[7];
assign addr_memory_slice_3[8] = addr[8];
assign addr_memory_slice_3[9] = addr[9];
assign addr_memory_slice_3[10] = addr[10];
assign addr_memory_slice_3[11] = addr[11];
assign data_memory_slice_3[0] = data[3];
assign we_memory_slice_3[0] = we[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr(addr_memory_slice_3), .data(data_memory_slice_3), .we(we_memory_slice_3), .out(out_memory_slice_3) );

assign addr_memory_slice_4[0] = addr[0];
assign addr_memory_slice_4[1] = addr[1];
assign addr_memory_slice_4[2] = addr[2];
assign addr_memory_slice_4[3] = addr[3];
assign addr_memory_slice_4[4] = addr[4];
assign addr_memory_slice_4[5] = addr[5];
assign addr_memory_slice_4[6] = addr[6];
assign addr_memory_slice_4[7] = addr[7];
assign addr_memory_slice_4[8] = addr[8];
assign addr_memory_slice_4[9] = addr[9];
assign addr_memory_slice_4[10] = addr[10];
assign addr_memory_slice_4[11] = addr[11];
assign data_memory_slice_4[0] = data[4];
assign we_memory_slice_4[0] = we[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr(addr_memory_slice_4), .data(data_memory_slice_4), .we(we_memory_slice_4), .out(out_memory_slice_4) );

assign addr_memory_slice_5[0] = addr[0];
assign addr_memory_slice_5[1] = addr[1];
assign addr_memory_slice_5[2] = addr[2];
assign addr_memory_slice_5[3] = addr[3];
assign addr_memory_slice_5[4] = addr[4];
assign addr_memory_slice_5[5] = addr[5];
assign addr_memory_slice_5[6] = addr[6];
assign addr_memory_slice_5[7] = addr[7];
assign addr_memory_slice_5[8] = addr[8];
assign addr_memory_slice_5[9] = addr[9];
assign addr_memory_slice_5[10] = addr[10];
assign addr_memory_slice_5[11] = addr[11];
assign data_memory_slice_5[0] = data[5];
assign we_memory_slice_5[0] = we[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr(addr_memory_slice_5), .data(data_memory_slice_5), .we(we_memory_slice_5), .out(out_memory_slice_5) );

assign addr_memory_slice_6[0] = addr[0];
assign addr_memory_slice_6[1] = addr[1];
assign addr_memory_slice_6[2] = addr[2];
assign addr_memory_slice_6[3] = addr[3];
assign addr_memory_slice_6[4] = addr[4];
assign addr_memory_slice_6[5] = addr[5];
assign addr_memory_slice_6[6] = addr[6];
assign addr_memory_slice_6[7] = addr[7];
assign addr_memory_slice_6[8] = addr[8];
assign addr_memory_slice_6[9] = addr[9];
assign addr_memory_slice_6[10] = addr[10];
assign addr_memory_slice_6[11] = addr[11];
assign data_memory_slice_6[0] = data[6];
assign we_memory_slice_6[0] = we[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr(addr_memory_slice_6), .data(data_memory_slice_6), .we(we_memory_slice_6), .out(out_memory_slice_6) );

assign addr_memory_slice_7[0] = addr[0];
assign addr_memory_slice_7[1] = addr[1];
assign addr_memory_slice_7[2] = addr[2];
assign addr_memory_slice_7[3] = addr[3];
assign addr_memory_slice_7[4] = addr[4];
assign addr_memory_slice_7[5] = addr[5];
assign addr_memory_slice_7[6] = addr[6];
assign addr_memory_slice_7[7] = addr[7];
assign addr_memory_slice_7[8] = addr[8];
assign addr_memory_slice_7[9] = addr[9];
assign addr_memory_slice_7[10] = addr[10];
assign addr_memory_slice_7[11] = addr[11];
assign data_memory_slice_7[0] = data[7];
assign we_memory_slice_7[0] = we[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr(addr_memory_slice_7), .data(data_memory_slice_7), .we(we_memory_slice_7), .out(out_memory_slice_7) );

assign addr_memory_slice_8[0] = addr[0];
assign addr_memory_slice_8[1] = addr[1];
assign addr_memory_slice_8[2] = addr[2];
assign addr_memory_slice_8[3] = addr[3];
assign addr_memory_slice_8[4] = addr[4];
assign addr_memory_slice_8[5] = addr[5];
assign addr_memory_slice_8[6] = addr[6];
assign addr_memory_slice_8[7] = addr[7];
assign addr_memory_slice_8[8] = addr[8];
assign addr_memory_slice_8[9] = addr[9];
assign addr_memory_slice_8[10] = addr[10];
assign addr_memory_slice_8[11] = addr[11];
assign data_memory_slice_8[0] = data[8];
assign we_memory_slice_8[0] = we[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr(addr_memory_slice_8), .data(data_memory_slice_8), .we(we_memory_slice_8), .out(out_memory_slice_8) );

assign addr_memory_slice_9[0] = addr[0];
assign addr_memory_slice_9[1] = addr[1];
assign addr_memory_slice_9[2] = addr[2];
assign addr_memory_slice_9[3] = addr[3];
assign addr_memory_slice_9[4] = addr[4];
assign addr_memory_slice_9[5] = addr[5];
assign addr_memory_slice_9[6] = addr[6];
assign addr_memory_slice_9[7] = addr[7];
assign addr_memory_slice_9[8] = addr[8];
assign addr_memory_slice_9[9] = addr[9];
assign addr_memory_slice_9[10] = addr[10];
assign addr_memory_slice_9[11] = addr[11];
assign data_memory_slice_9[0] = data[9];
assign we_memory_slice_9[0] = we[0];
assign clk_memory_slice_9[0] = clk[0];
 
memory_slice memory_slice_9 ( .clk(clk_memory_slice_9), .addr(addr_memory_slice_9), .data(data_memory_slice_9), .we(we_memory_slice_9), .out(out_memory_slice_9) );

assign addr_memory_slice_10[0] = addr[0];
assign addr_memory_slice_10[1] = addr[1];
assign addr_memory_slice_10[2] = addr[2];
assign addr_memory_slice_10[3] = addr[3];
assign addr_memory_slice_10[4] = addr[4];
assign addr_memory_slice_10[5] = addr[5];
assign addr_memory_slice_10[6] = addr[6];
assign addr_memory_slice_10[7] = addr[7];
assign addr_memory_slice_10[8] = addr[8];
assign addr_memory_slice_10[9] = addr[9];
assign addr_memory_slice_10[10] = addr[10];
assign addr_memory_slice_10[11] = addr[11];
assign data_memory_slice_10[0] = data[10];
assign we_memory_slice_10[0] = we[0];
assign clk_memory_slice_10[0] = clk[0];
 
memory_slice memory_slice_10 ( .clk(clk_memory_slice_10), .addr(addr_memory_slice_10), .data(data_memory_slice_10), .we(we_memory_slice_10), .out(out_memory_slice_10) );

assign addr_memory_slice_11[0] = addr[0];
assign addr_memory_slice_11[1] = addr[1];
assign addr_memory_slice_11[2] = addr[2];
assign addr_memory_slice_11[3] = addr[3];
assign addr_memory_slice_11[4] = addr[4];
assign addr_memory_slice_11[5] = addr[5];
assign addr_memory_slice_11[6] = addr[6];
assign addr_memory_slice_11[7] = addr[7];
assign addr_memory_slice_11[8] = addr[8];
assign addr_memory_slice_11[9] = addr[9];
assign addr_memory_slice_11[10] = addr[10];
assign addr_memory_slice_11[11] = addr[11];
assign data_memory_slice_11[0] = data[11];
assign we_memory_slice_11[0] = we[0];
assign clk_memory_slice_11[0] = clk[0];
 
memory_slice memory_slice_11 ( .clk(clk_memory_slice_11), .addr(addr_memory_slice_11), .data(data_memory_slice_11), .we(we_memory_slice_11), .out(out_memory_slice_11) );

assign addr_memory_slice_12[0] = addr[0];
assign addr_memory_slice_12[1] = addr[1];
assign addr_memory_slice_12[2] = addr[2];
assign addr_memory_slice_12[3] = addr[3];
assign addr_memory_slice_12[4] = addr[4];
assign addr_memory_slice_12[5] = addr[5];
assign addr_memory_slice_12[6] = addr[6];
assign addr_memory_slice_12[7] = addr[7];
assign addr_memory_slice_12[8] = addr[8];
assign addr_memory_slice_12[9] = addr[9];
assign addr_memory_slice_12[10] = addr[10];
assign addr_memory_slice_12[11] = addr[11];
assign data_memory_slice_12[0] = data[12];
assign we_memory_slice_12[0] = we[0];
assign clk_memory_slice_12[0] = clk[0];
 
memory_slice memory_slice_12 ( .clk(clk_memory_slice_12), .addr(addr_memory_slice_12), .data(data_memory_slice_12), .we(we_memory_slice_12), .out(out_memory_slice_12) );

assign addr_memory_slice_13[0] = addr[0];
assign addr_memory_slice_13[1] = addr[1];
assign addr_memory_slice_13[2] = addr[2];
assign addr_memory_slice_13[3] = addr[3];
assign addr_memory_slice_13[4] = addr[4];
assign addr_memory_slice_13[5] = addr[5];
assign addr_memory_slice_13[6] = addr[6];
assign addr_memory_slice_13[7] = addr[7];
assign addr_memory_slice_13[8] = addr[8];
assign addr_memory_slice_13[9] = addr[9];
assign addr_memory_slice_13[10] = addr[10];
assign addr_memory_slice_13[11] = addr[11];
assign data_memory_slice_13[0] = data[13];
assign we_memory_slice_13[0] = we[0];
assign clk_memory_slice_13[0] = clk[0];
 
memory_slice memory_slice_13 ( .clk(clk_memory_slice_13), .addr(addr_memory_slice_13), .data(data_memory_slice_13), .we(we_memory_slice_13), .out(out_memory_slice_13) );

assign addr_memory_slice_14[0] = addr[0];
assign addr_memory_slice_14[1] = addr[1];
assign addr_memory_slice_14[2] = addr[2];
assign addr_memory_slice_14[3] = addr[3];
assign addr_memory_slice_14[4] = addr[4];
assign addr_memory_slice_14[5] = addr[5];
assign addr_memory_slice_14[6] = addr[6];
assign addr_memory_slice_14[7] = addr[7];
assign addr_memory_slice_14[8] = addr[8];
assign addr_memory_slice_14[9] = addr[9];
assign addr_memory_slice_14[10] = addr[10];
assign addr_memory_slice_14[11] = addr[11];
assign data_memory_slice_14[0] = data[14];
assign we_memory_slice_14[0] = we[0];
assign clk_memory_slice_14[0] = clk[0];
 
memory_slice memory_slice_14 ( .clk(clk_memory_slice_14), .addr(addr_memory_slice_14), .data(data_memory_slice_14), .we(we_memory_slice_14), .out(out_memory_slice_14) );

assign addr_memory_slice_15[0] = addr[0];
assign addr_memory_slice_15[1] = addr[1];
assign addr_memory_slice_15[2] = addr[2];
assign addr_memory_slice_15[3] = addr[3];
assign addr_memory_slice_15[4] = addr[4];
assign addr_memory_slice_15[5] = addr[5];
assign addr_memory_slice_15[6] = addr[6];
assign addr_memory_slice_15[7] = addr[7];
assign addr_memory_slice_15[8] = addr[8];
assign addr_memory_slice_15[9] = addr[9];
assign addr_memory_slice_15[10] = addr[10];
assign addr_memory_slice_15[11] = addr[11];
assign data_memory_slice_15[0] = data[15];
assign we_memory_slice_15[0] = we[0];
assign clk_memory_slice_15[0] = clk[0];
 
memory_slice memory_slice_15 ( .clk(clk_memory_slice_15), .addr(addr_memory_slice_15), .data(data_memory_slice_15), .we(we_memory_slice_15), .out(out_memory_slice_15) );

assign addr_memory_slice_16[0] = addr[0];
assign addr_memory_slice_16[1] = addr[1];
assign addr_memory_slice_16[2] = addr[2];
assign addr_memory_slice_16[3] = addr[3];
assign addr_memory_slice_16[4] = addr[4];
assign addr_memory_slice_16[5] = addr[5];
assign addr_memory_slice_16[6] = addr[6];
assign addr_memory_slice_16[7] = addr[7];
assign addr_memory_slice_16[8] = addr[8];
assign addr_memory_slice_16[9] = addr[9];
assign addr_memory_slice_16[10] = addr[10];
assign addr_memory_slice_16[11] = addr[11];
assign data_memory_slice_16[0] = data[16];
assign we_memory_slice_16[0] = we[0];
assign clk_memory_slice_16[0] = clk[0];
 
memory_slice memory_slice_16 ( .clk(clk_memory_slice_16), .addr(addr_memory_slice_16), .data(data_memory_slice_16), .we(we_memory_slice_16), .out(out_memory_slice_16) );

assign addr_memory_slice_17[0] = addr[0];
assign addr_memory_slice_17[1] = addr[1];
assign addr_memory_slice_17[2] = addr[2];
assign addr_memory_slice_17[3] = addr[3];
assign addr_memory_slice_17[4] = addr[4];
assign addr_memory_slice_17[5] = addr[5];
assign addr_memory_slice_17[6] = addr[6];
assign addr_memory_slice_17[7] = addr[7];
assign addr_memory_slice_17[8] = addr[8];
assign addr_memory_slice_17[9] = addr[9];
assign addr_memory_slice_17[10] = addr[10];
assign addr_memory_slice_17[11] = addr[11];
assign data_memory_slice_17[0] = data[17];
assign we_memory_slice_17[0] = we[0];
assign clk_memory_slice_17[0] = clk[0];
 
memory_slice memory_slice_17 ( .clk(clk_memory_slice_17), .addr(addr_memory_slice_17), .data(data_memory_slice_17), .we(we_memory_slice_17), .out(out_memory_slice_17) );

assign addr_memory_slice_18[0] = addr[0];
assign addr_memory_slice_18[1] = addr[1];
assign addr_memory_slice_18[2] = addr[2];
assign addr_memory_slice_18[3] = addr[3];
assign addr_memory_slice_18[4] = addr[4];
assign addr_memory_slice_18[5] = addr[5];
assign addr_memory_slice_18[6] = addr[6];
assign addr_memory_slice_18[7] = addr[7];
assign addr_memory_slice_18[8] = addr[8];
assign addr_memory_slice_18[9] = addr[9];
assign addr_memory_slice_18[10] = addr[10];
assign addr_memory_slice_18[11] = addr[11];
assign data_memory_slice_18[0] = data[18];
assign we_memory_slice_18[0] = we[0];
assign clk_memory_slice_18[0] = clk[0];
 
memory_slice memory_slice_18 ( .clk(clk_memory_slice_18), .addr(addr_memory_slice_18), .data(data_memory_slice_18), .we(we_memory_slice_18), .out(out_memory_slice_18) );

assign addr_memory_slice_19[0] = addr[0];
assign addr_memory_slice_19[1] = addr[1];
assign addr_memory_slice_19[2] = addr[2];
assign addr_memory_slice_19[3] = addr[3];
assign addr_memory_slice_19[4] = addr[4];
assign addr_memory_slice_19[5] = addr[5];
assign addr_memory_slice_19[6] = addr[6];
assign addr_memory_slice_19[7] = addr[7];
assign addr_memory_slice_19[8] = addr[8];
assign addr_memory_slice_19[9] = addr[9];
assign addr_memory_slice_19[10] = addr[10];
assign addr_memory_slice_19[11] = addr[11];
assign data_memory_slice_19[0] = data[19];
assign we_memory_slice_19[0] = we[0];
assign clk_memory_slice_19[0] = clk[0];
 
memory_slice memory_slice_19 ( .clk(clk_memory_slice_19), .addr(addr_memory_slice_19), .data(data_memory_slice_19), .we(we_memory_slice_19), .out(out_memory_slice_19) );

assign addr_memory_slice_20[0] = addr[0];
assign addr_memory_slice_20[1] = addr[1];
assign addr_memory_slice_20[2] = addr[2];
assign addr_memory_slice_20[3] = addr[3];
assign addr_memory_slice_20[4] = addr[4];
assign addr_memory_slice_20[5] = addr[5];
assign addr_memory_slice_20[6] = addr[6];
assign addr_memory_slice_20[7] = addr[7];
assign addr_memory_slice_20[8] = addr[8];
assign addr_memory_slice_20[9] = addr[9];
assign addr_memory_slice_20[10] = addr[10];
assign addr_memory_slice_20[11] = addr[11];
assign data_memory_slice_20[0] = data[20];
assign we_memory_slice_20[0] = we[0];
assign clk_memory_slice_20[0] = clk[0];
 
memory_slice memory_slice_20 ( .clk(clk_memory_slice_20), .addr(addr_memory_slice_20), .data(data_memory_slice_20), .we(we_memory_slice_20), .out(out_memory_slice_20) );

assign addr_memory_slice_21[0] = addr[0];
assign addr_memory_slice_21[1] = addr[1];
assign addr_memory_slice_21[2] = addr[2];
assign addr_memory_slice_21[3] = addr[3];
assign addr_memory_slice_21[4] = addr[4];
assign addr_memory_slice_21[5] = addr[5];
assign addr_memory_slice_21[6] = addr[6];
assign addr_memory_slice_21[7] = addr[7];
assign addr_memory_slice_21[8] = addr[8];
assign addr_memory_slice_21[9] = addr[9];
assign addr_memory_slice_21[10] = addr[10];
assign addr_memory_slice_21[11] = addr[11];
assign data_memory_slice_21[0] = data[21];
assign we_memory_slice_21[0] = we[0];
assign clk_memory_slice_21[0] = clk[0];
 
memory_slice memory_slice_21 ( .clk(clk_memory_slice_21), .addr(addr_memory_slice_21), .data(data_memory_slice_21), .we(we_memory_slice_21), .out(out_memory_slice_21) );

assign addr_memory_slice_22[0] = addr[0];
assign addr_memory_slice_22[1] = addr[1];
assign addr_memory_slice_22[2] = addr[2];
assign addr_memory_slice_22[3] = addr[3];
assign addr_memory_slice_22[4] = addr[4];
assign addr_memory_slice_22[5] = addr[5];
assign addr_memory_slice_22[6] = addr[6];
assign addr_memory_slice_22[7] = addr[7];
assign addr_memory_slice_22[8] = addr[8];
assign addr_memory_slice_22[9] = addr[9];
assign addr_memory_slice_22[10] = addr[10];
assign addr_memory_slice_22[11] = addr[11];
assign data_memory_slice_22[0] = data[22];
assign we_memory_slice_22[0] = we[0];
assign clk_memory_slice_22[0] = clk[0];
 
memory_slice memory_slice_22 ( .clk(clk_memory_slice_22), .addr(addr_memory_slice_22), .data(data_memory_slice_22), .we(we_memory_slice_22), .out(out_memory_slice_22) );

assign addr_memory_slice_23[0] = addr[0];
assign addr_memory_slice_23[1] = addr[1];
assign addr_memory_slice_23[2] = addr[2];
assign addr_memory_slice_23[3] = addr[3];
assign addr_memory_slice_23[4] = addr[4];
assign addr_memory_slice_23[5] = addr[5];
assign addr_memory_slice_23[6] = addr[6];
assign addr_memory_slice_23[7] = addr[7];
assign addr_memory_slice_23[8] = addr[8];
assign addr_memory_slice_23[9] = addr[9];
assign addr_memory_slice_23[10] = addr[10];
assign addr_memory_slice_23[11] = addr[11];
assign data_memory_slice_23[0] = data[23];
assign we_memory_slice_23[0] = we[0];
assign clk_memory_slice_23[0] = clk[0];
 
memory_slice memory_slice_23 ( .clk(clk_memory_slice_23), .addr(addr_memory_slice_23), .data(data_memory_slice_23), .we(we_memory_slice_23), .out(out_memory_slice_23) );

assign addr_memory_slice_24[0] = addr[0];
assign addr_memory_slice_24[1] = addr[1];
assign addr_memory_slice_24[2] = addr[2];
assign addr_memory_slice_24[3] = addr[3];
assign addr_memory_slice_24[4] = addr[4];
assign addr_memory_slice_24[5] = addr[5];
assign addr_memory_slice_24[6] = addr[6];
assign addr_memory_slice_24[7] = addr[7];
assign addr_memory_slice_24[8] = addr[8];
assign addr_memory_slice_24[9] = addr[9];
assign addr_memory_slice_24[10] = addr[10];
assign addr_memory_slice_24[11] = addr[11];
assign data_memory_slice_24[0] = data[24];
assign we_memory_slice_24[0] = we[0];
assign clk_memory_slice_24[0] = clk[0];
 
memory_slice memory_slice_24 ( .clk(clk_memory_slice_24), .addr(addr_memory_slice_24), .data(data_memory_slice_24), .we(we_memory_slice_24), .out(out_memory_slice_24) );

assign addr_memory_slice_25[0] = addr[0];
assign addr_memory_slice_25[1] = addr[1];
assign addr_memory_slice_25[2] = addr[2];
assign addr_memory_slice_25[3] = addr[3];
assign addr_memory_slice_25[4] = addr[4];
assign addr_memory_slice_25[5] = addr[5];
assign addr_memory_slice_25[6] = addr[6];
assign addr_memory_slice_25[7] = addr[7];
assign addr_memory_slice_25[8] = addr[8];
assign addr_memory_slice_25[9] = addr[9];
assign addr_memory_slice_25[10] = addr[10];
assign addr_memory_slice_25[11] = addr[11];
assign data_memory_slice_25[0] = data[25];
assign we_memory_slice_25[0] = we[0];
assign clk_memory_slice_25[0] = clk[0];
 
memory_slice memory_slice_25 ( .clk(clk_memory_slice_25), .addr(addr_memory_slice_25), .data(data_memory_slice_25), .we(we_memory_slice_25), .out(out_memory_slice_25) );

assign addr_memory_slice_26[0] = addr[0];
assign addr_memory_slice_26[1] = addr[1];
assign addr_memory_slice_26[2] = addr[2];
assign addr_memory_slice_26[3] = addr[3];
assign addr_memory_slice_26[4] = addr[4];
assign addr_memory_slice_26[5] = addr[5];
assign addr_memory_slice_26[6] = addr[6];
assign addr_memory_slice_26[7] = addr[7];
assign addr_memory_slice_26[8] = addr[8];
assign addr_memory_slice_26[9] = addr[9];
assign addr_memory_slice_26[10] = addr[10];
assign addr_memory_slice_26[11] = addr[11];
assign data_memory_slice_26[0] = data[26];
assign we_memory_slice_26[0] = we[0];
assign clk_memory_slice_26[0] = clk[0];
 
memory_slice memory_slice_26 ( .clk(clk_memory_slice_26), .addr(addr_memory_slice_26), .data(data_memory_slice_26), .we(we_memory_slice_26), .out(out_memory_slice_26) );

assign addr_memory_slice_27[0] = addr[0];
assign addr_memory_slice_27[1] = addr[1];
assign addr_memory_slice_27[2] = addr[2];
assign addr_memory_slice_27[3] = addr[3];
assign addr_memory_slice_27[4] = addr[4];
assign addr_memory_slice_27[5] = addr[5];
assign addr_memory_slice_27[6] = addr[6];
assign addr_memory_slice_27[7] = addr[7];
assign addr_memory_slice_27[8] = addr[8];
assign addr_memory_slice_27[9] = addr[9];
assign addr_memory_slice_27[10] = addr[10];
assign addr_memory_slice_27[11] = addr[11];
assign data_memory_slice_27[0] = data[27];
assign we_memory_slice_27[0] = we[0];
assign clk_memory_slice_27[0] = clk[0];
 
memory_slice memory_slice_27 ( .clk(clk_memory_slice_27), .addr(addr_memory_slice_27), .data(data_memory_slice_27), .we(we_memory_slice_27), .out(out_memory_slice_27) );

assign addr_memory_slice_28[0] = addr[0];
assign addr_memory_slice_28[1] = addr[1];
assign addr_memory_slice_28[2] = addr[2];
assign addr_memory_slice_28[3] = addr[3];
assign addr_memory_slice_28[4] = addr[4];
assign addr_memory_slice_28[5] = addr[5];
assign addr_memory_slice_28[6] = addr[6];
assign addr_memory_slice_28[7] = addr[7];
assign addr_memory_slice_28[8] = addr[8];
assign addr_memory_slice_28[9] = addr[9];
assign addr_memory_slice_28[10] = addr[10];
assign addr_memory_slice_28[11] = addr[11];
assign data_memory_slice_28[0] = data[28];
assign we_memory_slice_28[0] = we[0];
assign clk_memory_slice_28[0] = clk[0];
 
memory_slice memory_slice_28 ( .clk(clk_memory_slice_28), .addr(addr_memory_slice_28), .data(data_memory_slice_28), .we(we_memory_slice_28), .out(out_memory_slice_28) );

assign addr_memory_slice_29[0] = addr[0];
assign addr_memory_slice_29[1] = addr[1];
assign addr_memory_slice_29[2] = addr[2];
assign addr_memory_slice_29[3] = addr[3];
assign addr_memory_slice_29[4] = addr[4];
assign addr_memory_slice_29[5] = addr[5];
assign addr_memory_slice_29[6] = addr[6];
assign addr_memory_slice_29[7] = addr[7];
assign addr_memory_slice_29[8] = addr[8];
assign addr_memory_slice_29[9] = addr[9];
assign addr_memory_slice_29[10] = addr[10];
assign addr_memory_slice_29[11] = addr[11];
assign data_memory_slice_29[0] = data[29];
assign we_memory_slice_29[0] = we[0];
assign clk_memory_slice_29[0] = clk[0];
 
memory_slice memory_slice_29 ( .clk(clk_memory_slice_29), .addr(addr_memory_slice_29), .data(data_memory_slice_29), .we(we_memory_slice_29), .out(out_memory_slice_29) );

assign addr_memory_slice_30[0] = addr[0];
assign addr_memory_slice_30[1] = addr[1];
assign addr_memory_slice_30[2] = addr[2];
assign addr_memory_slice_30[3] = addr[3];
assign addr_memory_slice_30[4] = addr[4];
assign addr_memory_slice_30[5] = addr[5];
assign addr_memory_slice_30[6] = addr[6];
assign addr_memory_slice_30[7] = addr[7];
assign addr_memory_slice_30[8] = addr[8];
assign addr_memory_slice_30[9] = addr[9];
assign addr_memory_slice_30[10] = addr[10];
assign addr_memory_slice_30[11] = addr[11];
assign data_memory_slice_30[0] = data[30];
assign we_memory_slice_30[0] = we[0];
assign clk_memory_slice_30[0] = clk[0];
 
memory_slice memory_slice_30 ( .clk(clk_memory_slice_30), .addr(addr_memory_slice_30), .data(data_memory_slice_30), .we(we_memory_slice_30), .out(out_memory_slice_30) );

assign addr_memory_slice_31[0] = addr[0];
assign addr_memory_slice_31[1] = addr[1];
assign addr_memory_slice_31[2] = addr[2];
assign addr_memory_slice_31[3] = addr[3];
assign addr_memory_slice_31[4] = addr[4];
assign addr_memory_slice_31[5] = addr[5];
assign addr_memory_slice_31[6] = addr[6];
assign addr_memory_slice_31[7] = addr[7];
assign addr_memory_slice_31[8] = addr[8];
assign addr_memory_slice_31[9] = addr[9];
assign addr_memory_slice_31[10] = addr[10];
assign addr_memory_slice_31[11] = addr[11];
assign data_memory_slice_31[0] = data[31];
assign we_memory_slice_31[0] = we[0];
assign clk_memory_slice_31[0] = clk[0];
 
memory_slice memory_slice_31 ( .clk(clk_memory_slice_31), .addr(addr_memory_slice_31), .data(data_memory_slice_31), .we(we_memory_slice_31), .out(out_memory_slice_31) );

assign addr_memory_slice_32[0] = addr[0];
assign addr_memory_slice_32[1] = addr[1];
assign addr_memory_slice_32[2] = addr[2];
assign addr_memory_slice_32[3] = addr[3];
assign addr_memory_slice_32[4] = addr[4];
assign addr_memory_slice_32[5] = addr[5];
assign addr_memory_slice_32[6] = addr[6];
assign addr_memory_slice_32[7] = addr[7];
assign addr_memory_slice_32[8] = addr[8];
assign addr_memory_slice_32[9] = addr[9];
assign addr_memory_slice_32[10] = addr[10];
assign addr_memory_slice_32[11] = addr[11];
assign data_memory_slice_32[0] = data[32];
assign we_memory_slice_32[0] = we[0];
assign clk_memory_slice_32[0] = clk[0];
 
memory_slice memory_slice_32 ( .clk(clk_memory_slice_32), .addr(addr_memory_slice_32), .data(data_memory_slice_32), .we(we_memory_slice_32), .out(out_memory_slice_32) );

assign addr_memory_slice_33[0] = addr[0];
assign addr_memory_slice_33[1] = addr[1];
assign addr_memory_slice_33[2] = addr[2];
assign addr_memory_slice_33[3] = addr[3];
assign addr_memory_slice_33[4] = addr[4];
assign addr_memory_slice_33[5] = addr[5];
assign addr_memory_slice_33[6] = addr[6];
assign addr_memory_slice_33[7] = addr[7];
assign addr_memory_slice_33[8] = addr[8];
assign addr_memory_slice_33[9] = addr[9];
assign addr_memory_slice_33[10] = addr[10];
assign addr_memory_slice_33[11] = addr[11];
assign data_memory_slice_33[0] = data[33];
assign we_memory_slice_33[0] = we[0];
assign clk_memory_slice_33[0] = clk[0];
 
memory_slice memory_slice_33 ( .clk(clk_memory_slice_33), .addr(addr_memory_slice_33), .data(data_memory_slice_33), .we(we_memory_slice_33), .out(out_memory_slice_33) );

assign addr_memory_slice_34[0] = addr[0];
assign addr_memory_slice_34[1] = addr[1];
assign addr_memory_slice_34[2] = addr[2];
assign addr_memory_slice_34[3] = addr[3];
assign addr_memory_slice_34[4] = addr[4];
assign addr_memory_slice_34[5] = addr[5];
assign addr_memory_slice_34[6] = addr[6];
assign addr_memory_slice_34[7] = addr[7];
assign addr_memory_slice_34[8] = addr[8];
assign addr_memory_slice_34[9] = addr[9];
assign addr_memory_slice_34[10] = addr[10];
assign addr_memory_slice_34[11] = addr[11];
assign data_memory_slice_34[0] = data[34];
assign we_memory_slice_34[0] = we[0];
assign clk_memory_slice_34[0] = clk[0];
 
memory_slice memory_slice_34 ( .clk(clk_memory_slice_34), .addr(addr_memory_slice_34), .data(data_memory_slice_34), .we(we_memory_slice_34), .out(out_memory_slice_34) );

assign addr_memory_slice_35[0] = addr[0];
assign addr_memory_slice_35[1] = addr[1];
assign addr_memory_slice_35[2] = addr[2];
assign addr_memory_slice_35[3] = addr[3];
assign addr_memory_slice_35[4] = addr[4];
assign addr_memory_slice_35[5] = addr[5];
assign addr_memory_slice_35[6] = addr[6];
assign addr_memory_slice_35[7] = addr[7];
assign addr_memory_slice_35[8] = addr[8];
assign addr_memory_slice_35[9] = addr[9];
assign addr_memory_slice_35[10] = addr[10];
assign addr_memory_slice_35[11] = addr[11];
assign data_memory_slice_35[0] = data[35];
assign we_memory_slice_35[0] = we[0];
assign clk_memory_slice_35[0] = clk[0];
 
memory_slice memory_slice_35 ( .clk(clk_memory_slice_35), .addr(addr_memory_slice_35), .data(data_memory_slice_35), .we(we_memory_slice_35), .out(out_memory_slice_35) );

//child output to block output
assign out[0] = out_memory_slice_0[0];
assign out[1] = out_memory_slice_1[0];
assign out[2] = out_memory_slice_2[0];
assign out[3] = out_memory_slice_3[0];
assign out[4] = out_memory_slice_4[0];
assign out[5] = out_memory_slice_5[0];
assign out[6] = out_memory_slice_6[0];
assign out[7] = out_memory_slice_7[0];
assign out[8] = out_memory_slice_8[0];
assign out[9] = out_memory_slice_9[0];
assign out[10] = out_memory_slice_10[0];
assign out[11] = out_memory_slice_11[0];
assign out[12] = out_memory_slice_12[0];
assign out[13] = out_memory_slice_13[0];
assign out[14] = out_memory_slice_14[0];
assign out[15] = out_memory_slice_15[0];
assign out[16] = out_memory_slice_16[0];
assign out[17] = out_memory_slice_17[0];
assign out[18] = out_memory_slice_18[0];
assign out[19] = out_memory_slice_19[0];
assign out[20] = out_memory_slice_20[0];
assign out[21] = out_memory_slice_21[0];
assign out[22] = out_memory_slice_22[0];
assign out[23] = out_memory_slice_23[0];
assign out[24] = out_memory_slice_24[0];
assign out[25] = out_memory_slice_25[0];
assign out[26] = out_memory_slice_26[0];
assign out[27] = out_memory_slice_27[0];
assign out[28] = out_memory_slice_28[0];
assign out[29] = out_memory_slice_29[0];
assign out[30] = out_memory_slice_30[0];
assign out[31] = out_memory_slice_31[0];
assign out[32] = out_memory_slice_32[0];
assign out[33] = out_memory_slice_33[0];
assign out[34] = out_memory_slice_34[0];
assign out[35] = out_memory_slice_35[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [12:0]addr1,
	input [12:0]addr2,
	input [0:0]data1,
	input [0:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [0:0]out1,
	output [0:0]out2
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_9182x18_dp /////////////////////////
/////////////////////////////////////////////////////
module mem_9182x18_dp (
	input [12:0]addr1,
	input [12:0]addr2,
	input [17:0]data1,
	input [17:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [17:0]out1,
	output [17:0]out2
);

////////child (0,0,0)////////
wire [12:0]addr1_memory_slice_0;//input to child
wire [12:0]addr2_memory_slice_0;//input to child
wire [0:0]data1_memory_slice_0;//input to child
wire [0:0]data2_memory_slice_0;//input to child
wire [0:0]we1_memory_slice_0;//input to child
wire [0:0]we2_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out1_memory_slice_0;//output from child
wire [0:0]out2_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [12:0]addr1_memory_slice_1;//input to child
wire [12:0]addr2_memory_slice_1;//input to child
wire [0:0]data1_memory_slice_1;//input to child
wire [0:0]data2_memory_slice_1;//input to child
wire [0:0]we1_memory_slice_1;//input to child
wire [0:0]we2_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out1_memory_slice_1;//output from child
wire [0:0]out2_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [12:0]addr1_memory_slice_2;//input to child
wire [12:0]addr2_memory_slice_2;//input to child
wire [0:0]data1_memory_slice_2;//input to child
wire [0:0]data2_memory_slice_2;//input to child
wire [0:0]we1_memory_slice_2;//input to child
wire [0:0]we2_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out1_memory_slice_2;//output from child
wire [0:0]out2_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [12:0]addr1_memory_slice_3;//input to child
wire [12:0]addr2_memory_slice_3;//input to child
wire [0:0]data1_memory_slice_3;//input to child
wire [0:0]data2_memory_slice_3;//input to child
wire [0:0]we1_memory_slice_3;//input to child
wire [0:0]we2_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out1_memory_slice_3;//output from child
wire [0:0]out2_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [12:0]addr1_memory_slice_4;//input to child
wire [12:0]addr2_memory_slice_4;//input to child
wire [0:0]data1_memory_slice_4;//input to child
wire [0:0]data2_memory_slice_4;//input to child
wire [0:0]we1_memory_slice_4;//input to child
wire [0:0]we2_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out1_memory_slice_4;//output from child
wire [0:0]out2_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [12:0]addr1_memory_slice_5;//input to child
wire [12:0]addr2_memory_slice_5;//input to child
wire [0:0]data1_memory_slice_5;//input to child
wire [0:0]data2_memory_slice_5;//input to child
wire [0:0]we1_memory_slice_5;//input to child
wire [0:0]we2_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out1_memory_slice_5;//output from child
wire [0:0]out2_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [12:0]addr1_memory_slice_6;//input to child
wire [12:0]addr2_memory_slice_6;//input to child
wire [0:0]data1_memory_slice_6;//input to child
wire [0:0]data2_memory_slice_6;//input to child
wire [0:0]we1_memory_slice_6;//input to child
wire [0:0]we2_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out1_memory_slice_6;//output from child
wire [0:0]out2_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [12:0]addr1_memory_slice_7;//input to child
wire [12:0]addr2_memory_slice_7;//input to child
wire [0:0]data1_memory_slice_7;//input to child
wire [0:0]data2_memory_slice_7;//input to child
wire [0:0]we1_memory_slice_7;//input to child
wire [0:0]we2_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out1_memory_slice_7;//output from child
wire [0:0]out2_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [12:0]addr1_memory_slice_8;//input to child
wire [12:0]addr2_memory_slice_8;//input to child
wire [0:0]data1_memory_slice_8;//input to child
wire [0:0]data2_memory_slice_8;//input to child
wire [0:0]we1_memory_slice_8;//input to child
wire [0:0]we2_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out1_memory_slice_8;//output from child
wire [0:0]out2_memory_slice_8;//output from child
 
////////child (0,0,9)////////
wire [12:0]addr1_memory_slice_9;//input to child
wire [12:0]addr2_memory_slice_9;//input to child
wire [0:0]data1_memory_slice_9;//input to child
wire [0:0]data2_memory_slice_9;//input to child
wire [0:0]we1_memory_slice_9;//input to child
wire [0:0]we2_memory_slice_9;//input to child
wire [0:0]clk_memory_slice_9;//clock to child
wire [0:0]out1_memory_slice_9;//output from child
wire [0:0]out2_memory_slice_9;//output from child
 
////////child (0,0,10)////////
wire [12:0]addr1_memory_slice_10;//input to child
wire [12:0]addr2_memory_slice_10;//input to child
wire [0:0]data1_memory_slice_10;//input to child
wire [0:0]data2_memory_slice_10;//input to child
wire [0:0]we1_memory_slice_10;//input to child
wire [0:0]we2_memory_slice_10;//input to child
wire [0:0]clk_memory_slice_10;//clock to child
wire [0:0]out1_memory_slice_10;//output from child
wire [0:0]out2_memory_slice_10;//output from child
 
////////child (0,0,11)////////
wire [12:0]addr1_memory_slice_11;//input to child
wire [12:0]addr2_memory_slice_11;//input to child
wire [0:0]data1_memory_slice_11;//input to child
wire [0:0]data2_memory_slice_11;//input to child
wire [0:0]we1_memory_slice_11;//input to child
wire [0:0]we2_memory_slice_11;//input to child
wire [0:0]clk_memory_slice_11;//clock to child
wire [0:0]out1_memory_slice_11;//output from child
wire [0:0]out2_memory_slice_11;//output from child
 
////////child (0,0,12)////////
wire [12:0]addr1_memory_slice_12;//input to child
wire [12:0]addr2_memory_slice_12;//input to child
wire [0:0]data1_memory_slice_12;//input to child
wire [0:0]data2_memory_slice_12;//input to child
wire [0:0]we1_memory_slice_12;//input to child
wire [0:0]we2_memory_slice_12;//input to child
wire [0:0]clk_memory_slice_12;//clock to child
wire [0:0]out1_memory_slice_12;//output from child
wire [0:0]out2_memory_slice_12;//output from child
 
////////child (0,0,13)////////
wire [12:0]addr1_memory_slice_13;//input to child
wire [12:0]addr2_memory_slice_13;//input to child
wire [0:0]data1_memory_slice_13;//input to child
wire [0:0]data2_memory_slice_13;//input to child
wire [0:0]we1_memory_slice_13;//input to child
wire [0:0]we2_memory_slice_13;//input to child
wire [0:0]clk_memory_slice_13;//clock to child
wire [0:0]out1_memory_slice_13;//output from child
wire [0:0]out2_memory_slice_13;//output from child
 
////////child (0,0,14)////////
wire [12:0]addr1_memory_slice_14;//input to child
wire [12:0]addr2_memory_slice_14;//input to child
wire [0:0]data1_memory_slice_14;//input to child
wire [0:0]data2_memory_slice_14;//input to child
wire [0:0]we1_memory_slice_14;//input to child
wire [0:0]we2_memory_slice_14;//input to child
wire [0:0]clk_memory_slice_14;//clock to child
wire [0:0]out1_memory_slice_14;//output from child
wire [0:0]out2_memory_slice_14;//output from child
 
////////child (0,0,15)////////
wire [12:0]addr1_memory_slice_15;//input to child
wire [12:0]addr2_memory_slice_15;//input to child
wire [0:0]data1_memory_slice_15;//input to child
wire [0:0]data2_memory_slice_15;//input to child
wire [0:0]we1_memory_slice_15;//input to child
wire [0:0]we2_memory_slice_15;//input to child
wire [0:0]clk_memory_slice_15;//clock to child
wire [0:0]out1_memory_slice_15;//output from child
wire [0:0]out2_memory_slice_15;//output from child
 
////////child (0,0,16)////////
wire [12:0]addr1_memory_slice_16;//input to child
wire [12:0]addr2_memory_slice_16;//input to child
wire [0:0]data1_memory_slice_16;//input to child
wire [0:0]data2_memory_slice_16;//input to child
wire [0:0]we1_memory_slice_16;//input to child
wire [0:0]we2_memory_slice_16;//input to child
wire [0:0]clk_memory_slice_16;//clock to child
wire [0:0]out1_memory_slice_16;//output from child
wire [0:0]out2_memory_slice_16;//output from child
 
////////child (0,0,17)////////
wire [12:0]addr1_memory_slice_17;//input to child
wire [12:0]addr2_memory_slice_17;//input to child
wire [0:0]data1_memory_slice_17;//input to child
wire [0:0]data2_memory_slice_17;//input to child
wire [0:0]we1_memory_slice_17;//input to child
wire [0:0]we2_memory_slice_17;//input to child
wire [0:0]clk_memory_slice_17;//clock to child
wire [0:0]out1_memory_slice_17;//output from child
wire [0:0]out2_memory_slice_17;//output from child
 
wire ground;

assign addr1_memory_slice_0[0] = addr1[0];
assign addr1_memory_slice_0[1] = addr1[1];
assign addr1_memory_slice_0[2] = addr1[2];
assign addr1_memory_slice_0[3] = addr1[3];
assign addr1_memory_slice_0[4] = addr1[4];
assign addr1_memory_slice_0[5] = addr1[5];
assign addr1_memory_slice_0[6] = addr1[6];
assign addr1_memory_slice_0[7] = addr1[7];
assign addr1_memory_slice_0[8] = addr1[8];
assign addr1_memory_slice_0[9] = addr1[9];
assign addr1_memory_slice_0[10] = addr1[10];
assign addr1_memory_slice_0[11] = addr1[11];
assign addr1_memory_slice_0[12] = addr1[12];
assign addr2_memory_slice_0[0] = addr2[0];
assign addr2_memory_slice_0[1] = addr2[1];
assign addr2_memory_slice_0[2] = addr2[2];
assign addr2_memory_slice_0[3] = addr2[3];
assign addr2_memory_slice_0[4] = addr2[4];
assign addr2_memory_slice_0[5] = addr2[5];
assign addr2_memory_slice_0[6] = addr2[6];
assign addr2_memory_slice_0[7] = addr2[7];
assign addr2_memory_slice_0[8] = addr2[8];
assign addr2_memory_slice_0[9] = addr2[9];
assign addr2_memory_slice_0[10] = addr2[10];
assign addr2_memory_slice_0[11] = addr2[11];
assign addr2_memory_slice_0[12] = addr2[12];
assign data1_memory_slice_0[0] = data1[0];
assign data2_memory_slice_0[0] = data2[0];
assign we1_memory_slice_0[0] = we1[0];
assign we2_memory_slice_0[0] = we2[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr1(addr1_memory_slice_0), .addr2(addr2_memory_slice_0), .data1(data1_memory_slice_0), .data2(data2_memory_slice_0), .we1(we1_memory_slice_0), .we2(we2_memory_slice_0), .out1(out1_memory_slice_0), .out2(out2_memory_slice_0) );

assign addr1_memory_slice_1[0] = addr1[0];
assign addr1_memory_slice_1[1] = addr1[1];
assign addr1_memory_slice_1[2] = addr1[2];
assign addr1_memory_slice_1[3] = addr1[3];
assign addr1_memory_slice_1[4] = addr1[4];
assign addr1_memory_slice_1[5] = addr1[5];
assign addr1_memory_slice_1[6] = addr1[6];
assign addr1_memory_slice_1[7] = addr1[7];
assign addr1_memory_slice_1[8] = addr1[8];
assign addr1_memory_slice_1[9] = addr1[9];
assign addr1_memory_slice_1[10] = addr1[10];
assign addr1_memory_slice_1[11] = addr1[11];
assign addr1_memory_slice_1[12] = addr1[12];
assign addr2_memory_slice_1[0] = addr2[0];
assign addr2_memory_slice_1[1] = addr2[1];
assign addr2_memory_slice_1[2] = addr2[2];
assign addr2_memory_slice_1[3] = addr2[3];
assign addr2_memory_slice_1[4] = addr2[4];
assign addr2_memory_slice_1[5] = addr2[5];
assign addr2_memory_slice_1[6] = addr2[6];
assign addr2_memory_slice_1[7] = addr2[7];
assign addr2_memory_slice_1[8] = addr2[8];
assign addr2_memory_slice_1[9] = addr2[9];
assign addr2_memory_slice_1[10] = addr2[10];
assign addr2_memory_slice_1[11] = addr2[11];
assign addr2_memory_slice_1[12] = addr2[12];
assign data1_memory_slice_1[0] = data1[1];
assign data2_memory_slice_1[0] = data2[1];
assign we1_memory_slice_1[0] = we1[0];
assign we2_memory_slice_1[0] = we2[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr1(addr1_memory_slice_1), .addr2(addr2_memory_slice_1), .data1(data1_memory_slice_1), .data2(data2_memory_slice_1), .we1(we1_memory_slice_1), .we2(we2_memory_slice_1), .out1(out1_memory_slice_1), .out2(out2_memory_slice_1) );

assign addr1_memory_slice_2[0] = addr1[0];
assign addr1_memory_slice_2[1] = addr1[1];
assign addr1_memory_slice_2[2] = addr1[2];
assign addr1_memory_slice_2[3] = addr1[3];
assign addr1_memory_slice_2[4] = addr1[4];
assign addr1_memory_slice_2[5] = addr1[5];
assign addr1_memory_slice_2[6] = addr1[6];
assign addr1_memory_slice_2[7] = addr1[7];
assign addr1_memory_slice_2[8] = addr1[8];
assign addr1_memory_slice_2[9] = addr1[9];
assign addr1_memory_slice_2[10] = addr1[10];
assign addr1_memory_slice_2[11] = addr1[11];
assign addr1_memory_slice_2[12] = addr1[12];
assign addr2_memory_slice_2[0] = addr2[0];
assign addr2_memory_slice_2[1] = addr2[1];
assign addr2_memory_slice_2[2] = addr2[2];
assign addr2_memory_slice_2[3] = addr2[3];
assign addr2_memory_slice_2[4] = addr2[4];
assign addr2_memory_slice_2[5] = addr2[5];
assign addr2_memory_slice_2[6] = addr2[6];
assign addr2_memory_slice_2[7] = addr2[7];
assign addr2_memory_slice_2[8] = addr2[8];
assign addr2_memory_slice_2[9] = addr2[9];
assign addr2_memory_slice_2[10] = addr2[10];
assign addr2_memory_slice_2[11] = addr2[11];
assign addr2_memory_slice_2[12] = addr2[12];
assign data1_memory_slice_2[0] = data1[2];
assign data2_memory_slice_2[0] = data2[2];
assign we1_memory_slice_2[0] = we1[0];
assign we2_memory_slice_2[0] = we2[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr1(addr1_memory_slice_2), .addr2(addr2_memory_slice_2), .data1(data1_memory_slice_2), .data2(data2_memory_slice_2), .we1(we1_memory_slice_2), .we2(we2_memory_slice_2), .out1(out1_memory_slice_2), .out2(out2_memory_slice_2) );

assign addr1_memory_slice_3[0] = addr1[0];
assign addr1_memory_slice_3[1] = addr1[1];
assign addr1_memory_slice_3[2] = addr1[2];
assign addr1_memory_slice_3[3] = addr1[3];
assign addr1_memory_slice_3[4] = addr1[4];
assign addr1_memory_slice_3[5] = addr1[5];
assign addr1_memory_slice_3[6] = addr1[6];
assign addr1_memory_slice_3[7] = addr1[7];
assign addr1_memory_slice_3[8] = addr1[8];
assign addr1_memory_slice_3[9] = addr1[9];
assign addr1_memory_slice_3[10] = addr1[10];
assign addr1_memory_slice_3[11] = addr1[11];
assign addr1_memory_slice_3[12] = addr1[12];
assign addr2_memory_slice_3[0] = addr2[0];
assign addr2_memory_slice_3[1] = addr2[1];
assign addr2_memory_slice_3[2] = addr2[2];
assign addr2_memory_slice_3[3] = addr2[3];
assign addr2_memory_slice_3[4] = addr2[4];
assign addr2_memory_slice_3[5] = addr2[5];
assign addr2_memory_slice_3[6] = addr2[6];
assign addr2_memory_slice_3[7] = addr2[7];
assign addr2_memory_slice_3[8] = addr2[8];
assign addr2_memory_slice_3[9] = addr2[9];
assign addr2_memory_slice_3[10] = addr2[10];
assign addr2_memory_slice_3[11] = addr2[11];
assign addr2_memory_slice_3[12] = addr2[12];
assign data1_memory_slice_3[0] = data1[3];
assign data2_memory_slice_3[0] = data2[3];
assign we1_memory_slice_3[0] = we1[0];
assign we2_memory_slice_3[0] = we2[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr1(addr1_memory_slice_3), .addr2(addr2_memory_slice_3), .data1(data1_memory_slice_3), .data2(data2_memory_slice_3), .we1(we1_memory_slice_3), .we2(we2_memory_slice_3), .out1(out1_memory_slice_3), .out2(out2_memory_slice_3) );

assign addr1_memory_slice_4[0] = addr1[0];
assign addr1_memory_slice_4[1] = addr1[1];
assign addr1_memory_slice_4[2] = addr1[2];
assign addr1_memory_slice_4[3] = addr1[3];
assign addr1_memory_slice_4[4] = addr1[4];
assign addr1_memory_slice_4[5] = addr1[5];
assign addr1_memory_slice_4[6] = addr1[6];
assign addr1_memory_slice_4[7] = addr1[7];
assign addr1_memory_slice_4[8] = addr1[8];
assign addr1_memory_slice_4[9] = addr1[9];
assign addr1_memory_slice_4[10] = addr1[10];
assign addr1_memory_slice_4[11] = addr1[11];
assign addr1_memory_slice_4[12] = addr1[12];
assign addr2_memory_slice_4[0] = addr2[0];
assign addr2_memory_slice_4[1] = addr2[1];
assign addr2_memory_slice_4[2] = addr2[2];
assign addr2_memory_slice_4[3] = addr2[3];
assign addr2_memory_slice_4[4] = addr2[4];
assign addr2_memory_slice_4[5] = addr2[5];
assign addr2_memory_slice_4[6] = addr2[6];
assign addr2_memory_slice_4[7] = addr2[7];
assign addr2_memory_slice_4[8] = addr2[8];
assign addr2_memory_slice_4[9] = addr2[9];
assign addr2_memory_slice_4[10] = addr2[10];
assign addr2_memory_slice_4[11] = addr2[11];
assign addr2_memory_slice_4[12] = addr2[12];
assign data1_memory_slice_4[0] = data1[4];
assign data2_memory_slice_4[0] = data2[4];
assign we1_memory_slice_4[0] = we1[0];
assign we2_memory_slice_4[0] = we2[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr1(addr1_memory_slice_4), .addr2(addr2_memory_slice_4), .data1(data1_memory_slice_4), .data2(data2_memory_slice_4), .we1(we1_memory_slice_4), .we2(we2_memory_slice_4), .out1(out1_memory_slice_4), .out2(out2_memory_slice_4) );

assign addr1_memory_slice_5[0] = addr1[0];
assign addr1_memory_slice_5[1] = addr1[1];
assign addr1_memory_slice_5[2] = addr1[2];
assign addr1_memory_slice_5[3] = addr1[3];
assign addr1_memory_slice_5[4] = addr1[4];
assign addr1_memory_slice_5[5] = addr1[5];
assign addr1_memory_slice_5[6] = addr1[6];
assign addr1_memory_slice_5[7] = addr1[7];
assign addr1_memory_slice_5[8] = addr1[8];
assign addr1_memory_slice_5[9] = addr1[9];
assign addr1_memory_slice_5[10] = addr1[10];
assign addr1_memory_slice_5[11] = addr1[11];
assign addr1_memory_slice_5[12] = addr1[12];
assign addr2_memory_slice_5[0] = addr2[0];
assign addr2_memory_slice_5[1] = addr2[1];
assign addr2_memory_slice_5[2] = addr2[2];
assign addr2_memory_slice_5[3] = addr2[3];
assign addr2_memory_slice_5[4] = addr2[4];
assign addr2_memory_slice_5[5] = addr2[5];
assign addr2_memory_slice_5[6] = addr2[6];
assign addr2_memory_slice_5[7] = addr2[7];
assign addr2_memory_slice_5[8] = addr2[8];
assign addr2_memory_slice_5[9] = addr2[9];
assign addr2_memory_slice_5[10] = addr2[10];
assign addr2_memory_slice_5[11] = addr2[11];
assign addr2_memory_slice_5[12] = addr2[12];
assign data1_memory_slice_5[0] = data1[5];
assign data2_memory_slice_5[0] = data2[5];
assign we1_memory_slice_5[0] = we1[0];
assign we2_memory_slice_5[0] = we2[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr1(addr1_memory_slice_5), .addr2(addr2_memory_slice_5), .data1(data1_memory_slice_5), .data2(data2_memory_slice_5), .we1(we1_memory_slice_5), .we2(we2_memory_slice_5), .out1(out1_memory_slice_5), .out2(out2_memory_slice_5) );

assign addr1_memory_slice_6[0] = addr1[0];
assign addr1_memory_slice_6[1] = addr1[1];
assign addr1_memory_slice_6[2] = addr1[2];
assign addr1_memory_slice_6[3] = addr1[3];
assign addr1_memory_slice_6[4] = addr1[4];
assign addr1_memory_slice_6[5] = addr1[5];
assign addr1_memory_slice_6[6] = addr1[6];
assign addr1_memory_slice_6[7] = addr1[7];
assign addr1_memory_slice_6[8] = addr1[8];
assign addr1_memory_slice_6[9] = addr1[9];
assign addr1_memory_slice_6[10] = addr1[10];
assign addr1_memory_slice_6[11] = addr1[11];
assign addr1_memory_slice_6[12] = addr1[12];
assign addr2_memory_slice_6[0] = addr2[0];
assign addr2_memory_slice_6[1] = addr2[1];
assign addr2_memory_slice_6[2] = addr2[2];
assign addr2_memory_slice_6[3] = addr2[3];
assign addr2_memory_slice_6[4] = addr2[4];
assign addr2_memory_slice_6[5] = addr2[5];
assign addr2_memory_slice_6[6] = addr2[6];
assign addr2_memory_slice_6[7] = addr2[7];
assign addr2_memory_slice_6[8] = addr2[8];
assign addr2_memory_slice_6[9] = addr2[9];
assign addr2_memory_slice_6[10] = addr2[10];
assign addr2_memory_slice_6[11] = addr2[11];
assign addr2_memory_slice_6[12] = addr2[12];
assign data1_memory_slice_6[0] = data1[6];
assign data2_memory_slice_6[0] = data2[6];
assign we1_memory_slice_6[0] = we1[0];
assign we2_memory_slice_6[0] = we2[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr1(addr1_memory_slice_6), .addr2(addr2_memory_slice_6), .data1(data1_memory_slice_6), .data2(data2_memory_slice_6), .we1(we1_memory_slice_6), .we2(we2_memory_slice_6), .out1(out1_memory_slice_6), .out2(out2_memory_slice_6) );

assign addr1_memory_slice_7[0] = addr1[0];
assign addr1_memory_slice_7[1] = addr1[1];
assign addr1_memory_slice_7[2] = addr1[2];
assign addr1_memory_slice_7[3] = addr1[3];
assign addr1_memory_slice_7[4] = addr1[4];
assign addr1_memory_slice_7[5] = addr1[5];
assign addr1_memory_slice_7[6] = addr1[6];
assign addr1_memory_slice_7[7] = addr1[7];
assign addr1_memory_slice_7[8] = addr1[8];
assign addr1_memory_slice_7[9] = addr1[9];
assign addr1_memory_slice_7[10] = addr1[10];
assign addr1_memory_slice_7[11] = addr1[11];
assign addr1_memory_slice_7[12] = addr1[12];
assign addr2_memory_slice_7[0] = addr2[0];
assign addr2_memory_slice_7[1] = addr2[1];
assign addr2_memory_slice_7[2] = addr2[2];
assign addr2_memory_slice_7[3] = addr2[3];
assign addr2_memory_slice_7[4] = addr2[4];
assign addr2_memory_slice_7[5] = addr2[5];
assign addr2_memory_slice_7[6] = addr2[6];
assign addr2_memory_slice_7[7] = addr2[7];
assign addr2_memory_slice_7[8] = addr2[8];
assign addr2_memory_slice_7[9] = addr2[9];
assign addr2_memory_slice_7[10] = addr2[10];
assign addr2_memory_slice_7[11] = addr2[11];
assign addr2_memory_slice_7[12] = addr2[12];
assign data1_memory_slice_7[0] = data1[7];
assign data2_memory_slice_7[0] = data2[7];
assign we1_memory_slice_7[0] = we1[0];
assign we2_memory_slice_7[0] = we2[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr1(addr1_memory_slice_7), .addr2(addr2_memory_slice_7), .data1(data1_memory_slice_7), .data2(data2_memory_slice_7), .we1(we1_memory_slice_7), .we2(we2_memory_slice_7), .out1(out1_memory_slice_7), .out2(out2_memory_slice_7) );

assign addr1_memory_slice_8[0] = addr1[0];
assign addr1_memory_slice_8[1] = addr1[1];
assign addr1_memory_slice_8[2] = addr1[2];
assign addr1_memory_slice_8[3] = addr1[3];
assign addr1_memory_slice_8[4] = addr1[4];
assign addr1_memory_slice_8[5] = addr1[5];
assign addr1_memory_slice_8[6] = addr1[6];
assign addr1_memory_slice_8[7] = addr1[7];
assign addr1_memory_slice_8[8] = addr1[8];
assign addr1_memory_slice_8[9] = addr1[9];
assign addr1_memory_slice_8[10] = addr1[10];
assign addr1_memory_slice_8[11] = addr1[11];
assign addr1_memory_slice_8[12] = addr1[12];
assign addr2_memory_slice_8[0] = addr2[0];
assign addr2_memory_slice_8[1] = addr2[1];
assign addr2_memory_slice_8[2] = addr2[2];
assign addr2_memory_slice_8[3] = addr2[3];
assign addr2_memory_slice_8[4] = addr2[4];
assign addr2_memory_slice_8[5] = addr2[5];
assign addr2_memory_slice_8[6] = addr2[6];
assign addr2_memory_slice_8[7] = addr2[7];
assign addr2_memory_slice_8[8] = addr2[8];
assign addr2_memory_slice_8[9] = addr2[9];
assign addr2_memory_slice_8[10] = addr2[10];
assign addr2_memory_slice_8[11] = addr2[11];
assign addr2_memory_slice_8[12] = addr2[12];
assign data1_memory_slice_8[0] = data1[8];
assign data2_memory_slice_8[0] = data2[8];
assign we1_memory_slice_8[0] = we1[0];
assign we2_memory_slice_8[0] = we2[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr1(addr1_memory_slice_8), .addr2(addr2_memory_slice_8), .data1(data1_memory_slice_8), .data2(data2_memory_slice_8), .we1(we1_memory_slice_8), .we2(we2_memory_slice_8), .out1(out1_memory_slice_8), .out2(out2_memory_slice_8) );

assign addr1_memory_slice_9[0] = addr1[0];
assign addr1_memory_slice_9[1] = addr1[1];
assign addr1_memory_slice_9[2] = addr1[2];
assign addr1_memory_slice_9[3] = addr1[3];
assign addr1_memory_slice_9[4] = addr1[4];
assign addr1_memory_slice_9[5] = addr1[5];
assign addr1_memory_slice_9[6] = addr1[6];
assign addr1_memory_slice_9[7] = addr1[7];
assign addr1_memory_slice_9[8] = addr1[8];
assign addr1_memory_slice_9[9] = addr1[9];
assign addr1_memory_slice_9[10] = addr1[10];
assign addr1_memory_slice_9[11] = addr1[11];
assign addr1_memory_slice_9[12] = addr1[12];
assign addr2_memory_slice_9[0] = addr2[0];
assign addr2_memory_slice_9[1] = addr2[1];
assign addr2_memory_slice_9[2] = addr2[2];
assign addr2_memory_slice_9[3] = addr2[3];
assign addr2_memory_slice_9[4] = addr2[4];
assign addr2_memory_slice_9[5] = addr2[5];
assign addr2_memory_slice_9[6] = addr2[6];
assign addr2_memory_slice_9[7] = addr2[7];
assign addr2_memory_slice_9[8] = addr2[8];
assign addr2_memory_slice_9[9] = addr2[9];
assign addr2_memory_slice_9[10] = addr2[10];
assign addr2_memory_slice_9[11] = addr2[11];
assign addr2_memory_slice_9[12] = addr2[12];
assign data1_memory_slice_9[0] = data1[9];
assign data2_memory_slice_9[0] = data2[9];
assign we1_memory_slice_9[0] = we1[0];
assign we2_memory_slice_9[0] = we2[0];
assign clk_memory_slice_9[0] = clk[0];
 
memory_slice memory_slice_9 ( .clk(clk_memory_slice_9), .addr1(addr1_memory_slice_9), .addr2(addr2_memory_slice_9), .data1(data1_memory_slice_9), .data2(data2_memory_slice_9), .we1(we1_memory_slice_9), .we2(we2_memory_slice_9), .out1(out1_memory_slice_9), .out2(out2_memory_slice_9) );

assign addr1_memory_slice_10[0] = addr1[0];
assign addr1_memory_slice_10[1] = addr1[1];
assign addr1_memory_slice_10[2] = addr1[2];
assign addr1_memory_slice_10[3] = addr1[3];
assign addr1_memory_slice_10[4] = addr1[4];
assign addr1_memory_slice_10[5] = addr1[5];
assign addr1_memory_slice_10[6] = addr1[6];
assign addr1_memory_slice_10[7] = addr1[7];
assign addr1_memory_slice_10[8] = addr1[8];
assign addr1_memory_slice_10[9] = addr1[9];
assign addr1_memory_slice_10[10] = addr1[10];
assign addr1_memory_slice_10[11] = addr1[11];
assign addr1_memory_slice_10[12] = addr1[12];
assign addr2_memory_slice_10[0] = addr2[0];
assign addr2_memory_slice_10[1] = addr2[1];
assign addr2_memory_slice_10[2] = addr2[2];
assign addr2_memory_slice_10[3] = addr2[3];
assign addr2_memory_slice_10[4] = addr2[4];
assign addr2_memory_slice_10[5] = addr2[5];
assign addr2_memory_slice_10[6] = addr2[6];
assign addr2_memory_slice_10[7] = addr2[7];
assign addr2_memory_slice_10[8] = addr2[8];
assign addr2_memory_slice_10[9] = addr2[9];
assign addr2_memory_slice_10[10] = addr2[10];
assign addr2_memory_slice_10[11] = addr2[11];
assign addr2_memory_slice_10[12] = addr2[12];
assign data1_memory_slice_10[0] = data1[10];
assign data2_memory_slice_10[0] = data2[10];
assign we1_memory_slice_10[0] = we1[0];
assign we2_memory_slice_10[0] = we2[0];
assign clk_memory_slice_10[0] = clk[0];
 
memory_slice memory_slice_10 ( .clk(clk_memory_slice_10), .addr1(addr1_memory_slice_10), .addr2(addr2_memory_slice_10), .data1(data1_memory_slice_10), .data2(data2_memory_slice_10), .we1(we1_memory_slice_10), .we2(we2_memory_slice_10), .out1(out1_memory_slice_10), .out2(out2_memory_slice_10) );

assign addr1_memory_slice_11[0] = addr1[0];
assign addr1_memory_slice_11[1] = addr1[1];
assign addr1_memory_slice_11[2] = addr1[2];
assign addr1_memory_slice_11[3] = addr1[3];
assign addr1_memory_slice_11[4] = addr1[4];
assign addr1_memory_slice_11[5] = addr1[5];
assign addr1_memory_slice_11[6] = addr1[6];
assign addr1_memory_slice_11[7] = addr1[7];
assign addr1_memory_slice_11[8] = addr1[8];
assign addr1_memory_slice_11[9] = addr1[9];
assign addr1_memory_slice_11[10] = addr1[10];
assign addr1_memory_slice_11[11] = addr1[11];
assign addr1_memory_slice_11[12] = addr1[12];
assign addr2_memory_slice_11[0] = addr2[0];
assign addr2_memory_slice_11[1] = addr2[1];
assign addr2_memory_slice_11[2] = addr2[2];
assign addr2_memory_slice_11[3] = addr2[3];
assign addr2_memory_slice_11[4] = addr2[4];
assign addr2_memory_slice_11[5] = addr2[5];
assign addr2_memory_slice_11[6] = addr2[6];
assign addr2_memory_slice_11[7] = addr2[7];
assign addr2_memory_slice_11[8] = addr2[8];
assign addr2_memory_slice_11[9] = addr2[9];
assign addr2_memory_slice_11[10] = addr2[10];
assign addr2_memory_slice_11[11] = addr2[11];
assign addr2_memory_slice_11[12] = addr2[12];
assign data1_memory_slice_11[0] = data1[11];
assign data2_memory_slice_11[0] = data2[11];
assign we1_memory_slice_11[0] = we1[0];
assign we2_memory_slice_11[0] = we2[0];
assign clk_memory_slice_11[0] = clk[0];
 
memory_slice memory_slice_11 ( .clk(clk_memory_slice_11), .addr1(addr1_memory_slice_11), .addr2(addr2_memory_slice_11), .data1(data1_memory_slice_11), .data2(data2_memory_slice_11), .we1(we1_memory_slice_11), .we2(we2_memory_slice_11), .out1(out1_memory_slice_11), .out2(out2_memory_slice_11) );

assign addr1_memory_slice_12[0] = addr1[0];
assign addr1_memory_slice_12[1] = addr1[1];
assign addr1_memory_slice_12[2] = addr1[2];
assign addr1_memory_slice_12[3] = addr1[3];
assign addr1_memory_slice_12[4] = addr1[4];
assign addr1_memory_slice_12[5] = addr1[5];
assign addr1_memory_slice_12[6] = addr1[6];
assign addr1_memory_slice_12[7] = addr1[7];
assign addr1_memory_slice_12[8] = addr1[8];
assign addr1_memory_slice_12[9] = addr1[9];
assign addr1_memory_slice_12[10] = addr1[10];
assign addr1_memory_slice_12[11] = addr1[11];
assign addr1_memory_slice_12[12] = addr1[12];
assign addr2_memory_slice_12[0] = addr2[0];
assign addr2_memory_slice_12[1] = addr2[1];
assign addr2_memory_slice_12[2] = addr2[2];
assign addr2_memory_slice_12[3] = addr2[3];
assign addr2_memory_slice_12[4] = addr2[4];
assign addr2_memory_slice_12[5] = addr2[5];
assign addr2_memory_slice_12[6] = addr2[6];
assign addr2_memory_slice_12[7] = addr2[7];
assign addr2_memory_slice_12[8] = addr2[8];
assign addr2_memory_slice_12[9] = addr2[9];
assign addr2_memory_slice_12[10] = addr2[10];
assign addr2_memory_slice_12[11] = addr2[11];
assign addr2_memory_slice_12[12] = addr2[12];
assign data1_memory_slice_12[0] = data1[12];
assign data2_memory_slice_12[0] = data2[12];
assign we1_memory_slice_12[0] = we1[0];
assign we2_memory_slice_12[0] = we2[0];
assign clk_memory_slice_12[0] = clk[0];
 
memory_slice memory_slice_12 ( .clk(clk_memory_slice_12), .addr1(addr1_memory_slice_12), .addr2(addr2_memory_slice_12), .data1(data1_memory_slice_12), .data2(data2_memory_slice_12), .we1(we1_memory_slice_12), .we2(we2_memory_slice_12), .out1(out1_memory_slice_12), .out2(out2_memory_slice_12) );

assign addr1_memory_slice_13[0] = addr1[0];
assign addr1_memory_slice_13[1] = addr1[1];
assign addr1_memory_slice_13[2] = addr1[2];
assign addr1_memory_slice_13[3] = addr1[3];
assign addr1_memory_slice_13[4] = addr1[4];
assign addr1_memory_slice_13[5] = addr1[5];
assign addr1_memory_slice_13[6] = addr1[6];
assign addr1_memory_slice_13[7] = addr1[7];
assign addr1_memory_slice_13[8] = addr1[8];
assign addr1_memory_slice_13[9] = addr1[9];
assign addr1_memory_slice_13[10] = addr1[10];
assign addr1_memory_slice_13[11] = addr1[11];
assign addr1_memory_slice_13[12] = addr1[12];
assign addr2_memory_slice_13[0] = addr2[0];
assign addr2_memory_slice_13[1] = addr2[1];
assign addr2_memory_slice_13[2] = addr2[2];
assign addr2_memory_slice_13[3] = addr2[3];
assign addr2_memory_slice_13[4] = addr2[4];
assign addr2_memory_slice_13[5] = addr2[5];
assign addr2_memory_slice_13[6] = addr2[6];
assign addr2_memory_slice_13[7] = addr2[7];
assign addr2_memory_slice_13[8] = addr2[8];
assign addr2_memory_slice_13[9] = addr2[9];
assign addr2_memory_slice_13[10] = addr2[10];
assign addr2_memory_slice_13[11] = addr2[11];
assign addr2_memory_slice_13[12] = addr2[12];
assign data1_memory_slice_13[0] = data1[13];
assign data2_memory_slice_13[0] = data2[13];
assign we1_memory_slice_13[0] = we1[0];
assign we2_memory_slice_13[0] = we2[0];
assign clk_memory_slice_13[0] = clk[0];
 
memory_slice memory_slice_13 ( .clk(clk_memory_slice_13), .addr1(addr1_memory_slice_13), .addr2(addr2_memory_slice_13), .data1(data1_memory_slice_13), .data2(data2_memory_slice_13), .we1(we1_memory_slice_13), .we2(we2_memory_slice_13), .out1(out1_memory_slice_13), .out2(out2_memory_slice_13) );

assign addr1_memory_slice_14[0] = addr1[0];
assign addr1_memory_slice_14[1] = addr1[1];
assign addr1_memory_slice_14[2] = addr1[2];
assign addr1_memory_slice_14[3] = addr1[3];
assign addr1_memory_slice_14[4] = addr1[4];
assign addr1_memory_slice_14[5] = addr1[5];
assign addr1_memory_slice_14[6] = addr1[6];
assign addr1_memory_slice_14[7] = addr1[7];
assign addr1_memory_slice_14[8] = addr1[8];
assign addr1_memory_slice_14[9] = addr1[9];
assign addr1_memory_slice_14[10] = addr1[10];
assign addr1_memory_slice_14[11] = addr1[11];
assign addr1_memory_slice_14[12] = addr1[12];
assign addr2_memory_slice_14[0] = addr2[0];
assign addr2_memory_slice_14[1] = addr2[1];
assign addr2_memory_slice_14[2] = addr2[2];
assign addr2_memory_slice_14[3] = addr2[3];
assign addr2_memory_slice_14[4] = addr2[4];
assign addr2_memory_slice_14[5] = addr2[5];
assign addr2_memory_slice_14[6] = addr2[6];
assign addr2_memory_slice_14[7] = addr2[7];
assign addr2_memory_slice_14[8] = addr2[8];
assign addr2_memory_slice_14[9] = addr2[9];
assign addr2_memory_slice_14[10] = addr2[10];
assign addr2_memory_slice_14[11] = addr2[11];
assign addr2_memory_slice_14[12] = addr2[12];
assign data1_memory_slice_14[0] = data1[14];
assign data2_memory_slice_14[0] = data2[14];
assign we1_memory_slice_14[0] = we1[0];
assign we2_memory_slice_14[0] = we2[0];
assign clk_memory_slice_14[0] = clk[0];
 
memory_slice memory_slice_14 ( .clk(clk_memory_slice_14), .addr1(addr1_memory_slice_14), .addr2(addr2_memory_slice_14), .data1(data1_memory_slice_14), .data2(data2_memory_slice_14), .we1(we1_memory_slice_14), .we2(we2_memory_slice_14), .out1(out1_memory_slice_14), .out2(out2_memory_slice_14) );

assign addr1_memory_slice_15[0] = addr1[0];
assign addr1_memory_slice_15[1] = addr1[1];
assign addr1_memory_slice_15[2] = addr1[2];
assign addr1_memory_slice_15[3] = addr1[3];
assign addr1_memory_slice_15[4] = addr1[4];
assign addr1_memory_slice_15[5] = addr1[5];
assign addr1_memory_slice_15[6] = addr1[6];
assign addr1_memory_slice_15[7] = addr1[7];
assign addr1_memory_slice_15[8] = addr1[8];
assign addr1_memory_slice_15[9] = addr1[9];
assign addr1_memory_slice_15[10] = addr1[10];
assign addr1_memory_slice_15[11] = addr1[11];
assign addr1_memory_slice_15[12] = addr1[12];
assign addr2_memory_slice_15[0] = addr2[0];
assign addr2_memory_slice_15[1] = addr2[1];
assign addr2_memory_slice_15[2] = addr2[2];
assign addr2_memory_slice_15[3] = addr2[3];
assign addr2_memory_slice_15[4] = addr2[4];
assign addr2_memory_slice_15[5] = addr2[5];
assign addr2_memory_slice_15[6] = addr2[6];
assign addr2_memory_slice_15[7] = addr2[7];
assign addr2_memory_slice_15[8] = addr2[8];
assign addr2_memory_slice_15[9] = addr2[9];
assign addr2_memory_slice_15[10] = addr2[10];
assign addr2_memory_slice_15[11] = addr2[11];
assign addr2_memory_slice_15[12] = addr2[12];
assign data1_memory_slice_15[0] = data1[15];
assign data2_memory_slice_15[0] = data2[15];
assign we1_memory_slice_15[0] = we1[0];
assign we2_memory_slice_15[0] = we2[0];
assign clk_memory_slice_15[0] = clk[0];
 
memory_slice memory_slice_15 ( .clk(clk_memory_slice_15), .addr1(addr1_memory_slice_15), .addr2(addr2_memory_slice_15), .data1(data1_memory_slice_15), .data2(data2_memory_slice_15), .we1(we1_memory_slice_15), .we2(we2_memory_slice_15), .out1(out1_memory_slice_15), .out2(out2_memory_slice_15) );

assign addr1_memory_slice_16[0] = addr1[0];
assign addr1_memory_slice_16[1] = addr1[1];
assign addr1_memory_slice_16[2] = addr1[2];
assign addr1_memory_slice_16[3] = addr1[3];
assign addr1_memory_slice_16[4] = addr1[4];
assign addr1_memory_slice_16[5] = addr1[5];
assign addr1_memory_slice_16[6] = addr1[6];
assign addr1_memory_slice_16[7] = addr1[7];
assign addr1_memory_slice_16[8] = addr1[8];
assign addr1_memory_slice_16[9] = addr1[9];
assign addr1_memory_slice_16[10] = addr1[10];
assign addr1_memory_slice_16[11] = addr1[11];
assign addr1_memory_slice_16[12] = addr1[12];
assign addr2_memory_slice_16[0] = addr2[0];
assign addr2_memory_slice_16[1] = addr2[1];
assign addr2_memory_slice_16[2] = addr2[2];
assign addr2_memory_slice_16[3] = addr2[3];
assign addr2_memory_slice_16[4] = addr2[4];
assign addr2_memory_slice_16[5] = addr2[5];
assign addr2_memory_slice_16[6] = addr2[6];
assign addr2_memory_slice_16[7] = addr2[7];
assign addr2_memory_slice_16[8] = addr2[8];
assign addr2_memory_slice_16[9] = addr2[9];
assign addr2_memory_slice_16[10] = addr2[10];
assign addr2_memory_slice_16[11] = addr2[11];
assign addr2_memory_slice_16[12] = addr2[12];
assign data1_memory_slice_16[0] = data1[16];
assign data2_memory_slice_16[0] = data2[16];
assign we1_memory_slice_16[0] = we1[0];
assign we2_memory_slice_16[0] = we2[0];
assign clk_memory_slice_16[0] = clk[0];
 
memory_slice memory_slice_16 ( .clk(clk_memory_slice_16), .addr1(addr1_memory_slice_16), .addr2(addr2_memory_slice_16), .data1(data1_memory_slice_16), .data2(data2_memory_slice_16), .we1(we1_memory_slice_16), .we2(we2_memory_slice_16), .out1(out1_memory_slice_16), .out2(out2_memory_slice_16) );

assign addr1_memory_slice_17[0] = addr1[0];
assign addr1_memory_slice_17[1] = addr1[1];
assign addr1_memory_slice_17[2] = addr1[2];
assign addr1_memory_slice_17[3] = addr1[3];
assign addr1_memory_slice_17[4] = addr1[4];
assign addr1_memory_slice_17[5] = addr1[5];
assign addr1_memory_slice_17[6] = addr1[6];
assign addr1_memory_slice_17[7] = addr1[7];
assign addr1_memory_slice_17[8] = addr1[8];
assign addr1_memory_slice_17[9] = addr1[9];
assign addr1_memory_slice_17[10] = addr1[10];
assign addr1_memory_slice_17[11] = addr1[11];
assign addr1_memory_slice_17[12] = addr1[12];
assign addr2_memory_slice_17[0] = addr2[0];
assign addr2_memory_slice_17[1] = addr2[1];
assign addr2_memory_slice_17[2] = addr2[2];
assign addr2_memory_slice_17[3] = addr2[3];
assign addr2_memory_slice_17[4] = addr2[4];
assign addr2_memory_slice_17[5] = addr2[5];
assign addr2_memory_slice_17[6] = addr2[6];
assign addr2_memory_slice_17[7] = addr2[7];
assign addr2_memory_slice_17[8] = addr2[8];
assign addr2_memory_slice_17[9] = addr2[9];
assign addr2_memory_slice_17[10] = addr2[10];
assign addr2_memory_slice_17[11] = addr2[11];
assign addr2_memory_slice_17[12] = addr2[12];
assign data1_memory_slice_17[0] = data1[17];
assign data2_memory_slice_17[0] = data2[17];
assign we1_memory_slice_17[0] = we1[0];
assign we2_memory_slice_17[0] = we2[0];
assign clk_memory_slice_17[0] = clk[0];
 
memory_slice memory_slice_17 ( .clk(clk_memory_slice_17), .addr1(addr1_memory_slice_17), .addr2(addr2_memory_slice_17), .data1(data1_memory_slice_17), .data2(data2_memory_slice_17), .we1(we1_memory_slice_17), .we2(we2_memory_slice_17), .out1(out1_memory_slice_17), .out2(out2_memory_slice_17) );

//child output to block output
assign out1[0] = out1_memory_slice_0[0];
assign out1[1] = out1_memory_slice_1[0];
assign out1[2] = out1_memory_slice_2[0];
assign out1[3] = out1_memory_slice_3[0];
assign out1[4] = out1_memory_slice_4[0];
assign out1[5] = out1_memory_slice_5[0];
assign out1[6] = out1_memory_slice_6[0];
assign out1[7] = out1_memory_slice_7[0];
assign out1[8] = out1_memory_slice_8[0];
assign out1[9] = out1_memory_slice_9[0];
assign out1[10] = out1_memory_slice_10[0];
assign out1[11] = out1_memory_slice_11[0];
assign out1[12] = out1_memory_slice_12[0];
assign out1[13] = out1_memory_slice_13[0];
assign out1[14] = out1_memory_slice_14[0];
assign out1[15] = out1_memory_slice_15[0];
assign out1[16] = out1_memory_slice_16[0];
assign out1[17] = out1_memory_slice_17[0];
assign out2[0] = out2_memory_slice_0[0];
assign out2[1] = out2_memory_slice_1[0];
assign out2[2] = out2_memory_slice_2[0];
assign out2[3] = out2_memory_slice_3[0];
assign out2[4] = out2_memory_slice_4[0];
assign out2[5] = out2_memory_slice_5[0];
assign out2[6] = out2_memory_slice_6[0];
assign out2[7] = out2_memory_slice_7[0];
assign out2[8] = out2_memory_slice_8[0];
assign out2[9] = out2_memory_slice_9[0];
assign out2[10] = out2_memory_slice_10[0];
assign out2[11] = out2_memory_slice_11[0];
assign out2[12] = out2_memory_slice_12[0];
assign out2[13] = out2_memory_slice_13[0];
assign out2[14] = out2_memory_slice_14[0];
assign out2[15] = out2_memory_slice_15[0];
assign out2[16] = out2_memory_slice_16[0];
assign out2[17] = out2_memory_slice_17[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [12:0]addr,
	input [0:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [0:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_9182x18_sp /////////////////////////
/////////////////////////////////////////////////////
module mem_9182x18_sp (
	input [12:0]addr,
	input [17:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [17:0]out
);

////////child (0,0,0)////////
wire [12:0]addr_memory_slice_0;//input to child
wire [0:0]data_memory_slice_0;//input to child
wire [0:0]we_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [12:0]addr_memory_slice_1;//input to child
wire [0:0]data_memory_slice_1;//input to child
wire [0:0]we_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [12:0]addr_memory_slice_2;//input to child
wire [0:0]data_memory_slice_2;//input to child
wire [0:0]we_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [12:0]addr_memory_slice_3;//input to child
wire [0:0]data_memory_slice_3;//input to child
wire [0:0]we_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [12:0]addr_memory_slice_4;//input to child
wire [0:0]data_memory_slice_4;//input to child
wire [0:0]we_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [12:0]addr_memory_slice_5;//input to child
wire [0:0]data_memory_slice_5;//input to child
wire [0:0]we_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [12:0]addr_memory_slice_6;//input to child
wire [0:0]data_memory_slice_6;//input to child
wire [0:0]we_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [12:0]addr_memory_slice_7;//input to child
wire [0:0]data_memory_slice_7;//input to child
wire [0:0]we_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [12:0]addr_memory_slice_8;//input to child
wire [0:0]data_memory_slice_8;//input to child
wire [0:0]we_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out_memory_slice_8;//output from child
 
////////child (0,0,9)////////
wire [12:0]addr_memory_slice_9;//input to child
wire [0:0]data_memory_slice_9;//input to child
wire [0:0]we_memory_slice_9;//input to child
wire [0:0]clk_memory_slice_9;//clock to child
wire [0:0]out_memory_slice_9;//output from child
 
////////child (0,0,10)////////
wire [12:0]addr_memory_slice_10;//input to child
wire [0:0]data_memory_slice_10;//input to child
wire [0:0]we_memory_slice_10;//input to child
wire [0:0]clk_memory_slice_10;//clock to child
wire [0:0]out_memory_slice_10;//output from child
 
////////child (0,0,11)////////
wire [12:0]addr_memory_slice_11;//input to child
wire [0:0]data_memory_slice_11;//input to child
wire [0:0]we_memory_slice_11;//input to child
wire [0:0]clk_memory_slice_11;//clock to child
wire [0:0]out_memory_slice_11;//output from child
 
////////child (0,0,12)////////
wire [12:0]addr_memory_slice_12;//input to child
wire [0:0]data_memory_slice_12;//input to child
wire [0:0]we_memory_slice_12;//input to child
wire [0:0]clk_memory_slice_12;//clock to child
wire [0:0]out_memory_slice_12;//output from child
 
////////child (0,0,13)////////
wire [12:0]addr_memory_slice_13;//input to child
wire [0:0]data_memory_slice_13;//input to child
wire [0:0]we_memory_slice_13;//input to child
wire [0:0]clk_memory_slice_13;//clock to child
wire [0:0]out_memory_slice_13;//output from child
 
////////child (0,0,14)////////
wire [12:0]addr_memory_slice_14;//input to child
wire [0:0]data_memory_slice_14;//input to child
wire [0:0]we_memory_slice_14;//input to child
wire [0:0]clk_memory_slice_14;//clock to child
wire [0:0]out_memory_slice_14;//output from child
 
////////child (0,0,15)////////
wire [12:0]addr_memory_slice_15;//input to child
wire [0:0]data_memory_slice_15;//input to child
wire [0:0]we_memory_slice_15;//input to child
wire [0:0]clk_memory_slice_15;//clock to child
wire [0:0]out_memory_slice_15;//output from child
 
////////child (0,0,16)////////
wire [12:0]addr_memory_slice_16;//input to child
wire [0:0]data_memory_slice_16;//input to child
wire [0:0]we_memory_slice_16;//input to child
wire [0:0]clk_memory_slice_16;//clock to child
wire [0:0]out_memory_slice_16;//output from child
 
////////child (0,0,17)////////
wire [12:0]addr_memory_slice_17;//input to child
wire [0:0]data_memory_slice_17;//input to child
wire [0:0]we_memory_slice_17;//input to child
wire [0:0]clk_memory_slice_17;//clock to child
wire [0:0]out_memory_slice_17;//output from child
 
wire ground;

assign addr_memory_slice_0[0] = addr[0];
assign addr_memory_slice_0[1] = addr[1];
assign addr_memory_slice_0[2] = addr[2];
assign addr_memory_slice_0[3] = addr[3];
assign addr_memory_slice_0[4] = addr[4];
assign addr_memory_slice_0[5] = addr[5];
assign addr_memory_slice_0[6] = addr[6];
assign addr_memory_slice_0[7] = addr[7];
assign addr_memory_slice_0[8] = addr[8];
assign addr_memory_slice_0[9] = addr[9];
assign addr_memory_slice_0[10] = addr[10];
assign addr_memory_slice_0[11] = addr[11];
assign addr_memory_slice_0[12] = addr[12];
assign data_memory_slice_0[0] = data[0];
assign we_memory_slice_0[0] = we[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr(addr_memory_slice_0), .data(data_memory_slice_0), .we(we_memory_slice_0), .out(out_memory_slice_0) );

assign addr_memory_slice_1[0] = addr[0];
assign addr_memory_slice_1[1] = addr[1];
assign addr_memory_slice_1[2] = addr[2];
assign addr_memory_slice_1[3] = addr[3];
assign addr_memory_slice_1[4] = addr[4];
assign addr_memory_slice_1[5] = addr[5];
assign addr_memory_slice_1[6] = addr[6];
assign addr_memory_slice_1[7] = addr[7];
assign addr_memory_slice_1[8] = addr[8];
assign addr_memory_slice_1[9] = addr[9];
assign addr_memory_slice_1[10] = addr[10];
assign addr_memory_slice_1[11] = addr[11];
assign addr_memory_slice_1[12] = addr[12];
assign data_memory_slice_1[0] = data[1];
assign we_memory_slice_1[0] = we[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr(addr_memory_slice_1), .data(data_memory_slice_1), .we(we_memory_slice_1), .out(out_memory_slice_1) );

assign addr_memory_slice_2[0] = addr[0];
assign addr_memory_slice_2[1] = addr[1];
assign addr_memory_slice_2[2] = addr[2];
assign addr_memory_slice_2[3] = addr[3];
assign addr_memory_slice_2[4] = addr[4];
assign addr_memory_slice_2[5] = addr[5];
assign addr_memory_slice_2[6] = addr[6];
assign addr_memory_slice_2[7] = addr[7];
assign addr_memory_slice_2[8] = addr[8];
assign addr_memory_slice_2[9] = addr[9];
assign addr_memory_slice_2[10] = addr[10];
assign addr_memory_slice_2[11] = addr[11];
assign addr_memory_slice_2[12] = addr[12];
assign data_memory_slice_2[0] = data[2];
assign we_memory_slice_2[0] = we[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr(addr_memory_slice_2), .data(data_memory_slice_2), .we(we_memory_slice_2), .out(out_memory_slice_2) );

assign addr_memory_slice_3[0] = addr[0];
assign addr_memory_slice_3[1] = addr[1];
assign addr_memory_slice_3[2] = addr[2];
assign addr_memory_slice_3[3] = addr[3];
assign addr_memory_slice_3[4] = addr[4];
assign addr_memory_slice_3[5] = addr[5];
assign addr_memory_slice_3[6] = addr[6];
assign addr_memory_slice_3[7] = addr[7];
assign addr_memory_slice_3[8] = addr[8];
assign addr_memory_slice_3[9] = addr[9];
assign addr_memory_slice_3[10] = addr[10];
assign addr_memory_slice_3[11] = addr[11];
assign addr_memory_slice_3[12] = addr[12];
assign data_memory_slice_3[0] = data[3];
assign we_memory_slice_3[0] = we[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr(addr_memory_slice_3), .data(data_memory_slice_3), .we(we_memory_slice_3), .out(out_memory_slice_3) );

assign addr_memory_slice_4[0] = addr[0];
assign addr_memory_slice_4[1] = addr[1];
assign addr_memory_slice_4[2] = addr[2];
assign addr_memory_slice_4[3] = addr[3];
assign addr_memory_slice_4[4] = addr[4];
assign addr_memory_slice_4[5] = addr[5];
assign addr_memory_slice_4[6] = addr[6];
assign addr_memory_slice_4[7] = addr[7];
assign addr_memory_slice_4[8] = addr[8];
assign addr_memory_slice_4[9] = addr[9];
assign addr_memory_slice_4[10] = addr[10];
assign addr_memory_slice_4[11] = addr[11];
assign addr_memory_slice_4[12] = addr[12];
assign data_memory_slice_4[0] = data[4];
assign we_memory_slice_4[0] = we[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr(addr_memory_slice_4), .data(data_memory_slice_4), .we(we_memory_slice_4), .out(out_memory_slice_4) );

assign addr_memory_slice_5[0] = addr[0];
assign addr_memory_slice_5[1] = addr[1];
assign addr_memory_slice_5[2] = addr[2];
assign addr_memory_slice_5[3] = addr[3];
assign addr_memory_slice_5[4] = addr[4];
assign addr_memory_slice_5[5] = addr[5];
assign addr_memory_slice_5[6] = addr[6];
assign addr_memory_slice_5[7] = addr[7];
assign addr_memory_slice_5[8] = addr[8];
assign addr_memory_slice_5[9] = addr[9];
assign addr_memory_slice_5[10] = addr[10];
assign addr_memory_slice_5[11] = addr[11];
assign addr_memory_slice_5[12] = addr[12];
assign data_memory_slice_5[0] = data[5];
assign we_memory_slice_5[0] = we[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr(addr_memory_slice_5), .data(data_memory_slice_5), .we(we_memory_slice_5), .out(out_memory_slice_5) );

assign addr_memory_slice_6[0] = addr[0];
assign addr_memory_slice_6[1] = addr[1];
assign addr_memory_slice_6[2] = addr[2];
assign addr_memory_slice_6[3] = addr[3];
assign addr_memory_slice_6[4] = addr[4];
assign addr_memory_slice_6[5] = addr[5];
assign addr_memory_slice_6[6] = addr[6];
assign addr_memory_slice_6[7] = addr[7];
assign addr_memory_slice_6[8] = addr[8];
assign addr_memory_slice_6[9] = addr[9];
assign addr_memory_slice_6[10] = addr[10];
assign addr_memory_slice_6[11] = addr[11];
assign addr_memory_slice_6[12] = addr[12];
assign data_memory_slice_6[0] = data[6];
assign we_memory_slice_6[0] = we[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr(addr_memory_slice_6), .data(data_memory_slice_6), .we(we_memory_slice_6), .out(out_memory_slice_6) );

assign addr_memory_slice_7[0] = addr[0];
assign addr_memory_slice_7[1] = addr[1];
assign addr_memory_slice_7[2] = addr[2];
assign addr_memory_slice_7[3] = addr[3];
assign addr_memory_slice_7[4] = addr[4];
assign addr_memory_slice_7[5] = addr[5];
assign addr_memory_slice_7[6] = addr[6];
assign addr_memory_slice_7[7] = addr[7];
assign addr_memory_slice_7[8] = addr[8];
assign addr_memory_slice_7[9] = addr[9];
assign addr_memory_slice_7[10] = addr[10];
assign addr_memory_slice_7[11] = addr[11];
assign addr_memory_slice_7[12] = addr[12];
assign data_memory_slice_7[0] = data[7];
assign we_memory_slice_7[0] = we[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr(addr_memory_slice_7), .data(data_memory_slice_7), .we(we_memory_slice_7), .out(out_memory_slice_7) );

assign addr_memory_slice_8[0] = addr[0];
assign addr_memory_slice_8[1] = addr[1];
assign addr_memory_slice_8[2] = addr[2];
assign addr_memory_slice_8[3] = addr[3];
assign addr_memory_slice_8[4] = addr[4];
assign addr_memory_slice_8[5] = addr[5];
assign addr_memory_slice_8[6] = addr[6];
assign addr_memory_slice_8[7] = addr[7];
assign addr_memory_slice_8[8] = addr[8];
assign addr_memory_slice_8[9] = addr[9];
assign addr_memory_slice_8[10] = addr[10];
assign addr_memory_slice_8[11] = addr[11];
assign addr_memory_slice_8[12] = addr[12];
assign data_memory_slice_8[0] = data[8];
assign we_memory_slice_8[0] = we[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr(addr_memory_slice_8), .data(data_memory_slice_8), .we(we_memory_slice_8), .out(out_memory_slice_8) );

assign addr_memory_slice_9[0] = addr[0];
assign addr_memory_slice_9[1] = addr[1];
assign addr_memory_slice_9[2] = addr[2];
assign addr_memory_slice_9[3] = addr[3];
assign addr_memory_slice_9[4] = addr[4];
assign addr_memory_slice_9[5] = addr[5];
assign addr_memory_slice_9[6] = addr[6];
assign addr_memory_slice_9[7] = addr[7];
assign addr_memory_slice_9[8] = addr[8];
assign addr_memory_slice_9[9] = addr[9];
assign addr_memory_slice_9[10] = addr[10];
assign addr_memory_slice_9[11] = addr[11];
assign addr_memory_slice_9[12] = addr[12];
assign data_memory_slice_9[0] = data[9];
assign we_memory_slice_9[0] = we[0];
assign clk_memory_slice_9[0] = clk[0];
 
memory_slice memory_slice_9 ( .clk(clk_memory_slice_9), .addr(addr_memory_slice_9), .data(data_memory_slice_9), .we(we_memory_slice_9), .out(out_memory_slice_9) );

assign addr_memory_slice_10[0] = addr[0];
assign addr_memory_slice_10[1] = addr[1];
assign addr_memory_slice_10[2] = addr[2];
assign addr_memory_slice_10[3] = addr[3];
assign addr_memory_slice_10[4] = addr[4];
assign addr_memory_slice_10[5] = addr[5];
assign addr_memory_slice_10[6] = addr[6];
assign addr_memory_slice_10[7] = addr[7];
assign addr_memory_slice_10[8] = addr[8];
assign addr_memory_slice_10[9] = addr[9];
assign addr_memory_slice_10[10] = addr[10];
assign addr_memory_slice_10[11] = addr[11];
assign addr_memory_slice_10[12] = addr[12];
assign data_memory_slice_10[0] = data[10];
assign we_memory_slice_10[0] = we[0];
assign clk_memory_slice_10[0] = clk[0];
 
memory_slice memory_slice_10 ( .clk(clk_memory_slice_10), .addr(addr_memory_slice_10), .data(data_memory_slice_10), .we(we_memory_slice_10), .out(out_memory_slice_10) );

assign addr_memory_slice_11[0] = addr[0];
assign addr_memory_slice_11[1] = addr[1];
assign addr_memory_slice_11[2] = addr[2];
assign addr_memory_slice_11[3] = addr[3];
assign addr_memory_slice_11[4] = addr[4];
assign addr_memory_slice_11[5] = addr[5];
assign addr_memory_slice_11[6] = addr[6];
assign addr_memory_slice_11[7] = addr[7];
assign addr_memory_slice_11[8] = addr[8];
assign addr_memory_slice_11[9] = addr[9];
assign addr_memory_slice_11[10] = addr[10];
assign addr_memory_slice_11[11] = addr[11];
assign addr_memory_slice_11[12] = addr[12];
assign data_memory_slice_11[0] = data[11];
assign we_memory_slice_11[0] = we[0];
assign clk_memory_slice_11[0] = clk[0];
 
memory_slice memory_slice_11 ( .clk(clk_memory_slice_11), .addr(addr_memory_slice_11), .data(data_memory_slice_11), .we(we_memory_slice_11), .out(out_memory_slice_11) );

assign addr_memory_slice_12[0] = addr[0];
assign addr_memory_slice_12[1] = addr[1];
assign addr_memory_slice_12[2] = addr[2];
assign addr_memory_slice_12[3] = addr[3];
assign addr_memory_slice_12[4] = addr[4];
assign addr_memory_slice_12[5] = addr[5];
assign addr_memory_slice_12[6] = addr[6];
assign addr_memory_slice_12[7] = addr[7];
assign addr_memory_slice_12[8] = addr[8];
assign addr_memory_slice_12[9] = addr[9];
assign addr_memory_slice_12[10] = addr[10];
assign addr_memory_slice_12[11] = addr[11];
assign addr_memory_slice_12[12] = addr[12];
assign data_memory_slice_12[0] = data[12];
assign we_memory_slice_12[0] = we[0];
assign clk_memory_slice_12[0] = clk[0];
 
memory_slice memory_slice_12 ( .clk(clk_memory_slice_12), .addr(addr_memory_slice_12), .data(data_memory_slice_12), .we(we_memory_slice_12), .out(out_memory_slice_12) );

assign addr_memory_slice_13[0] = addr[0];
assign addr_memory_slice_13[1] = addr[1];
assign addr_memory_slice_13[2] = addr[2];
assign addr_memory_slice_13[3] = addr[3];
assign addr_memory_slice_13[4] = addr[4];
assign addr_memory_slice_13[5] = addr[5];
assign addr_memory_slice_13[6] = addr[6];
assign addr_memory_slice_13[7] = addr[7];
assign addr_memory_slice_13[8] = addr[8];
assign addr_memory_slice_13[9] = addr[9];
assign addr_memory_slice_13[10] = addr[10];
assign addr_memory_slice_13[11] = addr[11];
assign addr_memory_slice_13[12] = addr[12];
assign data_memory_slice_13[0] = data[13];
assign we_memory_slice_13[0] = we[0];
assign clk_memory_slice_13[0] = clk[0];
 
memory_slice memory_slice_13 ( .clk(clk_memory_slice_13), .addr(addr_memory_slice_13), .data(data_memory_slice_13), .we(we_memory_slice_13), .out(out_memory_slice_13) );

assign addr_memory_slice_14[0] = addr[0];
assign addr_memory_slice_14[1] = addr[1];
assign addr_memory_slice_14[2] = addr[2];
assign addr_memory_slice_14[3] = addr[3];
assign addr_memory_slice_14[4] = addr[4];
assign addr_memory_slice_14[5] = addr[5];
assign addr_memory_slice_14[6] = addr[6];
assign addr_memory_slice_14[7] = addr[7];
assign addr_memory_slice_14[8] = addr[8];
assign addr_memory_slice_14[9] = addr[9];
assign addr_memory_slice_14[10] = addr[10];
assign addr_memory_slice_14[11] = addr[11];
assign addr_memory_slice_14[12] = addr[12];
assign data_memory_slice_14[0] = data[14];
assign we_memory_slice_14[0] = we[0];
assign clk_memory_slice_14[0] = clk[0];
 
memory_slice memory_slice_14 ( .clk(clk_memory_slice_14), .addr(addr_memory_slice_14), .data(data_memory_slice_14), .we(we_memory_slice_14), .out(out_memory_slice_14) );

assign addr_memory_slice_15[0] = addr[0];
assign addr_memory_slice_15[1] = addr[1];
assign addr_memory_slice_15[2] = addr[2];
assign addr_memory_slice_15[3] = addr[3];
assign addr_memory_slice_15[4] = addr[4];
assign addr_memory_slice_15[5] = addr[5];
assign addr_memory_slice_15[6] = addr[6];
assign addr_memory_slice_15[7] = addr[7];
assign addr_memory_slice_15[8] = addr[8];
assign addr_memory_slice_15[9] = addr[9];
assign addr_memory_slice_15[10] = addr[10];
assign addr_memory_slice_15[11] = addr[11];
assign addr_memory_slice_15[12] = addr[12];
assign data_memory_slice_15[0] = data[15];
assign we_memory_slice_15[0] = we[0];
assign clk_memory_slice_15[0] = clk[0];
 
memory_slice memory_slice_15 ( .clk(clk_memory_slice_15), .addr(addr_memory_slice_15), .data(data_memory_slice_15), .we(we_memory_slice_15), .out(out_memory_slice_15) );

assign addr_memory_slice_16[0] = addr[0];
assign addr_memory_slice_16[1] = addr[1];
assign addr_memory_slice_16[2] = addr[2];
assign addr_memory_slice_16[3] = addr[3];
assign addr_memory_slice_16[4] = addr[4];
assign addr_memory_slice_16[5] = addr[5];
assign addr_memory_slice_16[6] = addr[6];
assign addr_memory_slice_16[7] = addr[7];
assign addr_memory_slice_16[8] = addr[8];
assign addr_memory_slice_16[9] = addr[9];
assign addr_memory_slice_16[10] = addr[10];
assign addr_memory_slice_16[11] = addr[11];
assign addr_memory_slice_16[12] = addr[12];
assign data_memory_slice_16[0] = data[16];
assign we_memory_slice_16[0] = we[0];
assign clk_memory_slice_16[0] = clk[0];
 
memory_slice memory_slice_16 ( .clk(clk_memory_slice_16), .addr(addr_memory_slice_16), .data(data_memory_slice_16), .we(we_memory_slice_16), .out(out_memory_slice_16) );

assign addr_memory_slice_17[0] = addr[0];
assign addr_memory_slice_17[1] = addr[1];
assign addr_memory_slice_17[2] = addr[2];
assign addr_memory_slice_17[3] = addr[3];
assign addr_memory_slice_17[4] = addr[4];
assign addr_memory_slice_17[5] = addr[5];
assign addr_memory_slice_17[6] = addr[6];
assign addr_memory_slice_17[7] = addr[7];
assign addr_memory_slice_17[8] = addr[8];
assign addr_memory_slice_17[9] = addr[9];
assign addr_memory_slice_17[10] = addr[10];
assign addr_memory_slice_17[11] = addr[11];
assign addr_memory_slice_17[12] = addr[12];
assign data_memory_slice_17[0] = data[17];
assign we_memory_slice_17[0] = we[0];
assign clk_memory_slice_17[0] = clk[0];
 
memory_slice memory_slice_17 ( .clk(clk_memory_slice_17), .addr(addr_memory_slice_17), .data(data_memory_slice_17), .we(we_memory_slice_17), .out(out_memory_slice_17) );

//child output to block output
assign out[0] = out_memory_slice_0[0];
assign out[1] = out_memory_slice_1[0];
assign out[2] = out_memory_slice_2[0];
assign out[3] = out_memory_slice_3[0];
assign out[4] = out_memory_slice_4[0];
assign out[5] = out_memory_slice_5[0];
assign out[6] = out_memory_slice_6[0];
assign out[7] = out_memory_slice_7[0];
assign out[8] = out_memory_slice_8[0];
assign out[9] = out_memory_slice_9[0];
assign out[10] = out_memory_slice_10[0];
assign out[11] = out_memory_slice_11[0];
assign out[12] = out_memory_slice_12[0];
assign out[13] = out_memory_slice_13[0];
assign out[14] = out_memory_slice_14[0];
assign out[15] = out_memory_slice_15[0];
assign out[16] = out_memory_slice_16[0];
assign out[17] = out_memory_slice_17[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [13:0]addr1,
	input [13:0]addr2,
	input [0:0]data1,
	input [0:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [0:0]out1,
	output [0:0]out2
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_18194x9_dp /////////////////////////
/////////////////////////////////////////////////////
module mem_18194x9_dp (
	input [13:0]addr1,
	input [13:0]addr2,
	input [8:0]data1,
	input [8:0]data2,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [8:0]out1,
	output [8:0]out2
);

////////child (0,0,0)////////
wire [13:0]addr1_memory_slice_0;//input to child
wire [13:0]addr2_memory_slice_0;//input to child
wire [0:0]data1_memory_slice_0;//input to child
wire [0:0]data2_memory_slice_0;//input to child
wire [0:0]we1_memory_slice_0;//input to child
wire [0:0]we2_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out1_memory_slice_0;//output from child
wire [0:0]out2_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [13:0]addr1_memory_slice_1;//input to child
wire [13:0]addr2_memory_slice_1;//input to child
wire [0:0]data1_memory_slice_1;//input to child
wire [0:0]data2_memory_slice_1;//input to child
wire [0:0]we1_memory_slice_1;//input to child
wire [0:0]we2_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out1_memory_slice_1;//output from child
wire [0:0]out2_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [13:0]addr1_memory_slice_2;//input to child
wire [13:0]addr2_memory_slice_2;//input to child
wire [0:0]data1_memory_slice_2;//input to child
wire [0:0]data2_memory_slice_2;//input to child
wire [0:0]we1_memory_slice_2;//input to child
wire [0:0]we2_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out1_memory_slice_2;//output from child
wire [0:0]out2_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [13:0]addr1_memory_slice_3;//input to child
wire [13:0]addr2_memory_slice_3;//input to child
wire [0:0]data1_memory_slice_3;//input to child
wire [0:0]data2_memory_slice_3;//input to child
wire [0:0]we1_memory_slice_3;//input to child
wire [0:0]we2_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out1_memory_slice_3;//output from child
wire [0:0]out2_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [13:0]addr1_memory_slice_4;//input to child
wire [13:0]addr2_memory_slice_4;//input to child
wire [0:0]data1_memory_slice_4;//input to child
wire [0:0]data2_memory_slice_4;//input to child
wire [0:0]we1_memory_slice_4;//input to child
wire [0:0]we2_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out1_memory_slice_4;//output from child
wire [0:0]out2_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [13:0]addr1_memory_slice_5;//input to child
wire [13:0]addr2_memory_slice_5;//input to child
wire [0:0]data1_memory_slice_5;//input to child
wire [0:0]data2_memory_slice_5;//input to child
wire [0:0]we1_memory_slice_5;//input to child
wire [0:0]we2_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out1_memory_slice_5;//output from child
wire [0:0]out2_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [13:0]addr1_memory_slice_6;//input to child
wire [13:0]addr2_memory_slice_6;//input to child
wire [0:0]data1_memory_slice_6;//input to child
wire [0:0]data2_memory_slice_6;//input to child
wire [0:0]we1_memory_slice_6;//input to child
wire [0:0]we2_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out1_memory_slice_6;//output from child
wire [0:0]out2_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [13:0]addr1_memory_slice_7;//input to child
wire [13:0]addr2_memory_slice_7;//input to child
wire [0:0]data1_memory_slice_7;//input to child
wire [0:0]data2_memory_slice_7;//input to child
wire [0:0]we1_memory_slice_7;//input to child
wire [0:0]we2_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out1_memory_slice_7;//output from child
wire [0:0]out2_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [13:0]addr1_memory_slice_8;//input to child
wire [13:0]addr2_memory_slice_8;//input to child
wire [0:0]data1_memory_slice_8;//input to child
wire [0:0]data2_memory_slice_8;//input to child
wire [0:0]we1_memory_slice_8;//input to child
wire [0:0]we2_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out1_memory_slice_8;//output from child
wire [0:0]out2_memory_slice_8;//output from child
 
wire ground;

assign addr1_memory_slice_0[0] = addr1[0];
assign addr1_memory_slice_0[1] = addr1[1];
assign addr1_memory_slice_0[2] = addr1[2];
assign addr1_memory_slice_0[3] = addr1[3];
assign addr1_memory_slice_0[4] = addr1[4];
assign addr1_memory_slice_0[5] = addr1[5];
assign addr1_memory_slice_0[6] = addr1[6];
assign addr1_memory_slice_0[7] = addr1[7];
assign addr1_memory_slice_0[8] = addr1[8];
assign addr1_memory_slice_0[9] = addr1[9];
assign addr1_memory_slice_0[10] = addr1[10];
assign addr1_memory_slice_0[11] = addr1[11];
assign addr1_memory_slice_0[12] = addr1[12];
assign addr1_memory_slice_0[13] = addr1[13];
assign addr2_memory_slice_0[0] = addr2[0];
assign addr2_memory_slice_0[1] = addr2[1];
assign addr2_memory_slice_0[2] = addr2[2];
assign addr2_memory_slice_0[3] = addr2[3];
assign addr2_memory_slice_0[4] = addr2[4];
assign addr2_memory_slice_0[5] = addr2[5];
assign addr2_memory_slice_0[6] = addr2[6];
assign addr2_memory_slice_0[7] = addr2[7];
assign addr2_memory_slice_0[8] = addr2[8];
assign addr2_memory_slice_0[9] = addr2[9];
assign addr2_memory_slice_0[10] = addr2[10];
assign addr2_memory_slice_0[11] = addr2[11];
assign addr2_memory_slice_0[12] = addr2[12];
assign addr2_memory_slice_0[13] = addr2[13];
assign data1_memory_slice_0[0] = data1[0];
assign data2_memory_slice_0[0] = data2[0];
assign we1_memory_slice_0[0] = we1[0];
assign we2_memory_slice_0[0] = we2[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr1(addr1_memory_slice_0), .addr2(addr2_memory_slice_0), .data1(data1_memory_slice_0), .data2(data2_memory_slice_0), .we1(we1_memory_slice_0), .we2(we2_memory_slice_0), .out1(out1_memory_slice_0), .out2(out2_memory_slice_0) );

assign addr1_memory_slice_1[0] = addr1[0];
assign addr1_memory_slice_1[1] = addr1[1];
assign addr1_memory_slice_1[2] = addr1[2];
assign addr1_memory_slice_1[3] = addr1[3];
assign addr1_memory_slice_1[4] = addr1[4];
assign addr1_memory_slice_1[5] = addr1[5];
assign addr1_memory_slice_1[6] = addr1[6];
assign addr1_memory_slice_1[7] = addr1[7];
assign addr1_memory_slice_1[8] = addr1[8];
assign addr1_memory_slice_1[9] = addr1[9];
assign addr1_memory_slice_1[10] = addr1[10];
assign addr1_memory_slice_1[11] = addr1[11];
assign addr1_memory_slice_1[12] = addr1[12];
assign addr1_memory_slice_1[13] = addr1[13];
assign addr2_memory_slice_1[0] = addr2[0];
assign addr2_memory_slice_1[1] = addr2[1];
assign addr2_memory_slice_1[2] = addr2[2];
assign addr2_memory_slice_1[3] = addr2[3];
assign addr2_memory_slice_1[4] = addr2[4];
assign addr2_memory_slice_1[5] = addr2[5];
assign addr2_memory_slice_1[6] = addr2[6];
assign addr2_memory_slice_1[7] = addr2[7];
assign addr2_memory_slice_1[8] = addr2[8];
assign addr2_memory_slice_1[9] = addr2[9];
assign addr2_memory_slice_1[10] = addr2[10];
assign addr2_memory_slice_1[11] = addr2[11];
assign addr2_memory_slice_1[12] = addr2[12];
assign addr2_memory_slice_1[13] = addr2[13];
assign data1_memory_slice_1[0] = data1[1];
assign data2_memory_slice_1[0] = data2[1];
assign we1_memory_slice_1[0] = we1[0];
assign we2_memory_slice_1[0] = we2[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr1(addr1_memory_slice_1), .addr2(addr2_memory_slice_1), .data1(data1_memory_slice_1), .data2(data2_memory_slice_1), .we1(we1_memory_slice_1), .we2(we2_memory_slice_1), .out1(out1_memory_slice_1), .out2(out2_memory_slice_1) );

assign addr1_memory_slice_2[0] = addr1[0];
assign addr1_memory_slice_2[1] = addr1[1];
assign addr1_memory_slice_2[2] = addr1[2];
assign addr1_memory_slice_2[3] = addr1[3];
assign addr1_memory_slice_2[4] = addr1[4];
assign addr1_memory_slice_2[5] = addr1[5];
assign addr1_memory_slice_2[6] = addr1[6];
assign addr1_memory_slice_2[7] = addr1[7];
assign addr1_memory_slice_2[8] = addr1[8];
assign addr1_memory_slice_2[9] = addr1[9];
assign addr1_memory_slice_2[10] = addr1[10];
assign addr1_memory_slice_2[11] = addr1[11];
assign addr1_memory_slice_2[12] = addr1[12];
assign addr1_memory_slice_2[13] = addr1[13];
assign addr2_memory_slice_2[0] = addr2[0];
assign addr2_memory_slice_2[1] = addr2[1];
assign addr2_memory_slice_2[2] = addr2[2];
assign addr2_memory_slice_2[3] = addr2[3];
assign addr2_memory_slice_2[4] = addr2[4];
assign addr2_memory_slice_2[5] = addr2[5];
assign addr2_memory_slice_2[6] = addr2[6];
assign addr2_memory_slice_2[7] = addr2[7];
assign addr2_memory_slice_2[8] = addr2[8];
assign addr2_memory_slice_2[9] = addr2[9];
assign addr2_memory_slice_2[10] = addr2[10];
assign addr2_memory_slice_2[11] = addr2[11];
assign addr2_memory_slice_2[12] = addr2[12];
assign addr2_memory_slice_2[13] = addr2[13];
assign data1_memory_slice_2[0] = data1[2];
assign data2_memory_slice_2[0] = data2[2];
assign we1_memory_slice_2[0] = we1[0];
assign we2_memory_slice_2[0] = we2[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr1(addr1_memory_slice_2), .addr2(addr2_memory_slice_2), .data1(data1_memory_slice_2), .data2(data2_memory_slice_2), .we1(we1_memory_slice_2), .we2(we2_memory_slice_2), .out1(out1_memory_slice_2), .out2(out2_memory_slice_2) );

assign addr1_memory_slice_3[0] = addr1[0];
assign addr1_memory_slice_3[1] = addr1[1];
assign addr1_memory_slice_3[2] = addr1[2];
assign addr1_memory_slice_3[3] = addr1[3];
assign addr1_memory_slice_3[4] = addr1[4];
assign addr1_memory_slice_3[5] = addr1[5];
assign addr1_memory_slice_3[6] = addr1[6];
assign addr1_memory_slice_3[7] = addr1[7];
assign addr1_memory_slice_3[8] = addr1[8];
assign addr1_memory_slice_3[9] = addr1[9];
assign addr1_memory_slice_3[10] = addr1[10];
assign addr1_memory_slice_3[11] = addr1[11];
assign addr1_memory_slice_3[12] = addr1[12];
assign addr1_memory_slice_3[13] = addr1[13];
assign addr2_memory_slice_3[0] = addr2[0];
assign addr2_memory_slice_3[1] = addr2[1];
assign addr2_memory_slice_3[2] = addr2[2];
assign addr2_memory_slice_3[3] = addr2[3];
assign addr2_memory_slice_3[4] = addr2[4];
assign addr2_memory_slice_3[5] = addr2[5];
assign addr2_memory_slice_3[6] = addr2[6];
assign addr2_memory_slice_3[7] = addr2[7];
assign addr2_memory_slice_3[8] = addr2[8];
assign addr2_memory_slice_3[9] = addr2[9];
assign addr2_memory_slice_3[10] = addr2[10];
assign addr2_memory_slice_3[11] = addr2[11];
assign addr2_memory_slice_3[12] = addr2[12];
assign addr2_memory_slice_3[13] = addr2[13];
assign data1_memory_slice_3[0] = data1[3];
assign data2_memory_slice_3[0] = data2[3];
assign we1_memory_slice_3[0] = we1[0];
assign we2_memory_slice_3[0] = we2[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr1(addr1_memory_slice_3), .addr2(addr2_memory_slice_3), .data1(data1_memory_slice_3), .data2(data2_memory_slice_3), .we1(we1_memory_slice_3), .we2(we2_memory_slice_3), .out1(out1_memory_slice_3), .out2(out2_memory_slice_3) );

assign addr1_memory_slice_4[0] = addr1[0];
assign addr1_memory_slice_4[1] = addr1[1];
assign addr1_memory_slice_4[2] = addr1[2];
assign addr1_memory_slice_4[3] = addr1[3];
assign addr1_memory_slice_4[4] = addr1[4];
assign addr1_memory_slice_4[5] = addr1[5];
assign addr1_memory_slice_4[6] = addr1[6];
assign addr1_memory_slice_4[7] = addr1[7];
assign addr1_memory_slice_4[8] = addr1[8];
assign addr1_memory_slice_4[9] = addr1[9];
assign addr1_memory_slice_4[10] = addr1[10];
assign addr1_memory_slice_4[11] = addr1[11];
assign addr1_memory_slice_4[12] = addr1[12];
assign addr1_memory_slice_4[13] = addr1[13];
assign addr2_memory_slice_4[0] = addr2[0];
assign addr2_memory_slice_4[1] = addr2[1];
assign addr2_memory_slice_4[2] = addr2[2];
assign addr2_memory_slice_4[3] = addr2[3];
assign addr2_memory_slice_4[4] = addr2[4];
assign addr2_memory_slice_4[5] = addr2[5];
assign addr2_memory_slice_4[6] = addr2[6];
assign addr2_memory_slice_4[7] = addr2[7];
assign addr2_memory_slice_4[8] = addr2[8];
assign addr2_memory_slice_4[9] = addr2[9];
assign addr2_memory_slice_4[10] = addr2[10];
assign addr2_memory_slice_4[11] = addr2[11];
assign addr2_memory_slice_4[12] = addr2[12];
assign addr2_memory_slice_4[13] = addr2[13];
assign data1_memory_slice_4[0] = data1[4];
assign data2_memory_slice_4[0] = data2[4];
assign we1_memory_slice_4[0] = we1[0];
assign we2_memory_slice_4[0] = we2[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr1(addr1_memory_slice_4), .addr2(addr2_memory_slice_4), .data1(data1_memory_slice_4), .data2(data2_memory_slice_4), .we1(we1_memory_slice_4), .we2(we2_memory_slice_4), .out1(out1_memory_slice_4), .out2(out2_memory_slice_4) );

assign addr1_memory_slice_5[0] = addr1[0];
assign addr1_memory_slice_5[1] = addr1[1];
assign addr1_memory_slice_5[2] = addr1[2];
assign addr1_memory_slice_5[3] = addr1[3];
assign addr1_memory_slice_5[4] = addr1[4];
assign addr1_memory_slice_5[5] = addr1[5];
assign addr1_memory_slice_5[6] = addr1[6];
assign addr1_memory_slice_5[7] = addr1[7];
assign addr1_memory_slice_5[8] = addr1[8];
assign addr1_memory_slice_5[9] = addr1[9];
assign addr1_memory_slice_5[10] = addr1[10];
assign addr1_memory_slice_5[11] = addr1[11];
assign addr1_memory_slice_5[12] = addr1[12];
assign addr1_memory_slice_5[13] = addr1[13];
assign addr2_memory_slice_5[0] = addr2[0];
assign addr2_memory_slice_5[1] = addr2[1];
assign addr2_memory_slice_5[2] = addr2[2];
assign addr2_memory_slice_5[3] = addr2[3];
assign addr2_memory_slice_5[4] = addr2[4];
assign addr2_memory_slice_5[5] = addr2[5];
assign addr2_memory_slice_5[6] = addr2[6];
assign addr2_memory_slice_5[7] = addr2[7];
assign addr2_memory_slice_5[8] = addr2[8];
assign addr2_memory_slice_5[9] = addr2[9];
assign addr2_memory_slice_5[10] = addr2[10];
assign addr2_memory_slice_5[11] = addr2[11];
assign addr2_memory_slice_5[12] = addr2[12];
assign addr2_memory_slice_5[13] = addr2[13];
assign data1_memory_slice_5[0] = data1[5];
assign data2_memory_slice_5[0] = data2[5];
assign we1_memory_slice_5[0] = we1[0];
assign we2_memory_slice_5[0] = we2[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr1(addr1_memory_slice_5), .addr2(addr2_memory_slice_5), .data1(data1_memory_slice_5), .data2(data2_memory_slice_5), .we1(we1_memory_slice_5), .we2(we2_memory_slice_5), .out1(out1_memory_slice_5), .out2(out2_memory_slice_5) );

assign addr1_memory_slice_6[0] = addr1[0];
assign addr1_memory_slice_6[1] = addr1[1];
assign addr1_memory_slice_6[2] = addr1[2];
assign addr1_memory_slice_6[3] = addr1[3];
assign addr1_memory_slice_6[4] = addr1[4];
assign addr1_memory_slice_6[5] = addr1[5];
assign addr1_memory_slice_6[6] = addr1[6];
assign addr1_memory_slice_6[7] = addr1[7];
assign addr1_memory_slice_6[8] = addr1[8];
assign addr1_memory_slice_6[9] = addr1[9];
assign addr1_memory_slice_6[10] = addr1[10];
assign addr1_memory_slice_6[11] = addr1[11];
assign addr1_memory_slice_6[12] = addr1[12];
assign addr1_memory_slice_6[13] = addr1[13];
assign addr2_memory_slice_6[0] = addr2[0];
assign addr2_memory_slice_6[1] = addr2[1];
assign addr2_memory_slice_6[2] = addr2[2];
assign addr2_memory_slice_6[3] = addr2[3];
assign addr2_memory_slice_6[4] = addr2[4];
assign addr2_memory_slice_6[5] = addr2[5];
assign addr2_memory_slice_6[6] = addr2[6];
assign addr2_memory_slice_6[7] = addr2[7];
assign addr2_memory_slice_6[8] = addr2[8];
assign addr2_memory_slice_6[9] = addr2[9];
assign addr2_memory_slice_6[10] = addr2[10];
assign addr2_memory_slice_6[11] = addr2[11];
assign addr2_memory_slice_6[12] = addr2[12];
assign addr2_memory_slice_6[13] = addr2[13];
assign data1_memory_slice_6[0] = data1[6];
assign data2_memory_slice_6[0] = data2[6];
assign we1_memory_slice_6[0] = we1[0];
assign we2_memory_slice_6[0] = we2[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr1(addr1_memory_slice_6), .addr2(addr2_memory_slice_6), .data1(data1_memory_slice_6), .data2(data2_memory_slice_6), .we1(we1_memory_slice_6), .we2(we2_memory_slice_6), .out1(out1_memory_slice_6), .out2(out2_memory_slice_6) );

assign addr1_memory_slice_7[0] = addr1[0];
assign addr1_memory_slice_7[1] = addr1[1];
assign addr1_memory_slice_7[2] = addr1[2];
assign addr1_memory_slice_7[3] = addr1[3];
assign addr1_memory_slice_7[4] = addr1[4];
assign addr1_memory_slice_7[5] = addr1[5];
assign addr1_memory_slice_7[6] = addr1[6];
assign addr1_memory_slice_7[7] = addr1[7];
assign addr1_memory_slice_7[8] = addr1[8];
assign addr1_memory_slice_7[9] = addr1[9];
assign addr1_memory_slice_7[10] = addr1[10];
assign addr1_memory_slice_7[11] = addr1[11];
assign addr1_memory_slice_7[12] = addr1[12];
assign addr1_memory_slice_7[13] = addr1[13];
assign addr2_memory_slice_7[0] = addr2[0];
assign addr2_memory_slice_7[1] = addr2[1];
assign addr2_memory_slice_7[2] = addr2[2];
assign addr2_memory_slice_7[3] = addr2[3];
assign addr2_memory_slice_7[4] = addr2[4];
assign addr2_memory_slice_7[5] = addr2[5];
assign addr2_memory_slice_7[6] = addr2[6];
assign addr2_memory_slice_7[7] = addr2[7];
assign addr2_memory_slice_7[8] = addr2[8];
assign addr2_memory_slice_7[9] = addr2[9];
assign addr2_memory_slice_7[10] = addr2[10];
assign addr2_memory_slice_7[11] = addr2[11];
assign addr2_memory_slice_7[12] = addr2[12];
assign addr2_memory_slice_7[13] = addr2[13];
assign data1_memory_slice_7[0] = data1[7];
assign data2_memory_slice_7[0] = data2[7];
assign we1_memory_slice_7[0] = we1[0];
assign we2_memory_slice_7[0] = we2[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr1(addr1_memory_slice_7), .addr2(addr2_memory_slice_7), .data1(data1_memory_slice_7), .data2(data2_memory_slice_7), .we1(we1_memory_slice_7), .we2(we2_memory_slice_7), .out1(out1_memory_slice_7), .out2(out2_memory_slice_7) );

assign addr1_memory_slice_8[0] = addr1[0];
assign addr1_memory_slice_8[1] = addr1[1];
assign addr1_memory_slice_8[2] = addr1[2];
assign addr1_memory_slice_8[3] = addr1[3];
assign addr1_memory_slice_8[4] = addr1[4];
assign addr1_memory_slice_8[5] = addr1[5];
assign addr1_memory_slice_8[6] = addr1[6];
assign addr1_memory_slice_8[7] = addr1[7];
assign addr1_memory_slice_8[8] = addr1[8];
assign addr1_memory_slice_8[9] = addr1[9];
assign addr1_memory_slice_8[10] = addr1[10];
assign addr1_memory_slice_8[11] = addr1[11];
assign addr1_memory_slice_8[12] = addr1[12];
assign addr1_memory_slice_8[13] = addr1[13];
assign addr2_memory_slice_8[0] = addr2[0];
assign addr2_memory_slice_8[1] = addr2[1];
assign addr2_memory_slice_8[2] = addr2[2];
assign addr2_memory_slice_8[3] = addr2[3];
assign addr2_memory_slice_8[4] = addr2[4];
assign addr2_memory_slice_8[5] = addr2[5];
assign addr2_memory_slice_8[6] = addr2[6];
assign addr2_memory_slice_8[7] = addr2[7];
assign addr2_memory_slice_8[8] = addr2[8];
assign addr2_memory_slice_8[9] = addr2[9];
assign addr2_memory_slice_8[10] = addr2[10];
assign addr2_memory_slice_8[11] = addr2[11];
assign addr2_memory_slice_8[12] = addr2[12];
assign addr2_memory_slice_8[13] = addr2[13];
assign data1_memory_slice_8[0] = data1[8];
assign data2_memory_slice_8[0] = data2[8];
assign we1_memory_slice_8[0] = we1[0];
assign we2_memory_slice_8[0] = we2[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr1(addr1_memory_slice_8), .addr2(addr2_memory_slice_8), .data1(data1_memory_slice_8), .data2(data2_memory_slice_8), .we1(we1_memory_slice_8), .we2(we2_memory_slice_8), .out1(out1_memory_slice_8), .out2(out2_memory_slice_8) );

//child output to block output
assign out1[0] = out1_memory_slice_0[0];
assign out1[1] = out1_memory_slice_1[0];
assign out1[2] = out1_memory_slice_2[0];
assign out1[3] = out1_memory_slice_3[0];
assign out1[4] = out1_memory_slice_4[0];
assign out1[5] = out1_memory_slice_5[0];
assign out1[6] = out1_memory_slice_6[0];
assign out1[7] = out1_memory_slice_7[0];
assign out1[8] = out1_memory_slice_8[0];
assign out2[0] = out2_memory_slice_0[0];
assign out2[1] = out2_memory_slice_1[0];
assign out2[2] = out2_memory_slice_2[0];
assign out2[3] = out2_memory_slice_3[0];
assign out2[4] = out2_memory_slice_4[0];
assign out2[5] = out2_memory_slice_5[0];
assign out2[6] = out2_memory_slice_6[0];
assign out2[7] = out2_memory_slice_7[0];
assign out2[8] = out2_memory_slice_8[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory_slice /////////////////////////
/////////////////////////////////////////////////////
module memory_slice (
	input [13:0]addr,
	input [0:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [0:0]out
);

wire ground;

//child output to block output

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// mem_18194x9_sp /////////////////////////
/////////////////////////////////////////////////////
module mem_18194x9_sp (
	input [13:0]addr,
	input [8:0]data,
	input [0:0]we,
	input [0:0]clk,
	output [8:0]out
);

////////child (0,0,0)////////
wire [13:0]addr_memory_slice_0;//input to child
wire [0:0]data_memory_slice_0;//input to child
wire [0:0]we_memory_slice_0;//input to child
wire [0:0]clk_memory_slice_0;//clock to child
wire [0:0]out_memory_slice_0;//output from child
 
////////child (0,0,1)////////
wire [13:0]addr_memory_slice_1;//input to child
wire [0:0]data_memory_slice_1;//input to child
wire [0:0]we_memory_slice_1;//input to child
wire [0:0]clk_memory_slice_1;//clock to child
wire [0:0]out_memory_slice_1;//output from child
 
////////child (0,0,2)////////
wire [13:0]addr_memory_slice_2;//input to child
wire [0:0]data_memory_slice_2;//input to child
wire [0:0]we_memory_slice_2;//input to child
wire [0:0]clk_memory_slice_2;//clock to child
wire [0:0]out_memory_slice_2;//output from child
 
////////child (0,0,3)////////
wire [13:0]addr_memory_slice_3;//input to child
wire [0:0]data_memory_slice_3;//input to child
wire [0:0]we_memory_slice_3;//input to child
wire [0:0]clk_memory_slice_3;//clock to child
wire [0:0]out_memory_slice_3;//output from child
 
////////child (0,0,4)////////
wire [13:0]addr_memory_slice_4;//input to child
wire [0:0]data_memory_slice_4;//input to child
wire [0:0]we_memory_slice_4;//input to child
wire [0:0]clk_memory_slice_4;//clock to child
wire [0:0]out_memory_slice_4;//output from child
 
////////child (0,0,5)////////
wire [13:0]addr_memory_slice_5;//input to child
wire [0:0]data_memory_slice_5;//input to child
wire [0:0]we_memory_slice_5;//input to child
wire [0:0]clk_memory_slice_5;//clock to child
wire [0:0]out_memory_slice_5;//output from child
 
////////child (0,0,6)////////
wire [13:0]addr_memory_slice_6;//input to child
wire [0:0]data_memory_slice_6;//input to child
wire [0:0]we_memory_slice_6;//input to child
wire [0:0]clk_memory_slice_6;//clock to child
wire [0:0]out_memory_slice_6;//output from child
 
////////child (0,0,7)////////
wire [13:0]addr_memory_slice_7;//input to child
wire [0:0]data_memory_slice_7;//input to child
wire [0:0]we_memory_slice_7;//input to child
wire [0:0]clk_memory_slice_7;//clock to child
wire [0:0]out_memory_slice_7;//output from child
 
////////child (0,0,8)////////
wire [13:0]addr_memory_slice_8;//input to child
wire [0:0]data_memory_slice_8;//input to child
wire [0:0]we_memory_slice_8;//input to child
wire [0:0]clk_memory_slice_8;//clock to child
wire [0:0]out_memory_slice_8;//output from child
 
wire ground;

assign addr_memory_slice_0[0] = addr[0];
assign addr_memory_slice_0[1] = addr[1];
assign addr_memory_slice_0[2] = addr[2];
assign addr_memory_slice_0[3] = addr[3];
assign addr_memory_slice_0[4] = addr[4];
assign addr_memory_slice_0[5] = addr[5];
assign addr_memory_slice_0[6] = addr[6];
assign addr_memory_slice_0[7] = addr[7];
assign addr_memory_slice_0[8] = addr[8];
assign addr_memory_slice_0[9] = addr[9];
assign addr_memory_slice_0[10] = addr[10];
assign addr_memory_slice_0[11] = addr[11];
assign addr_memory_slice_0[12] = addr[12];
assign addr_memory_slice_0[13] = addr[13];
assign data_memory_slice_0[0] = data[0];
assign we_memory_slice_0[0] = we[0];
assign clk_memory_slice_0[0] = clk[0];
 
memory_slice memory_slice_0 ( .clk(clk_memory_slice_0), .addr(addr_memory_slice_0), .data(data_memory_slice_0), .we(we_memory_slice_0), .out(out_memory_slice_0) );

assign addr_memory_slice_1[0] = addr[0];
assign addr_memory_slice_1[1] = addr[1];
assign addr_memory_slice_1[2] = addr[2];
assign addr_memory_slice_1[3] = addr[3];
assign addr_memory_slice_1[4] = addr[4];
assign addr_memory_slice_1[5] = addr[5];
assign addr_memory_slice_1[6] = addr[6];
assign addr_memory_slice_1[7] = addr[7];
assign addr_memory_slice_1[8] = addr[8];
assign addr_memory_slice_1[9] = addr[9];
assign addr_memory_slice_1[10] = addr[10];
assign addr_memory_slice_1[11] = addr[11];
assign addr_memory_slice_1[12] = addr[12];
assign addr_memory_slice_1[13] = addr[13];
assign data_memory_slice_1[0] = data[1];
assign we_memory_slice_1[0] = we[0];
assign clk_memory_slice_1[0] = clk[0];
 
memory_slice memory_slice_1 ( .clk(clk_memory_slice_1), .addr(addr_memory_slice_1), .data(data_memory_slice_1), .we(we_memory_slice_1), .out(out_memory_slice_1) );

assign addr_memory_slice_2[0] = addr[0];
assign addr_memory_slice_2[1] = addr[1];
assign addr_memory_slice_2[2] = addr[2];
assign addr_memory_slice_2[3] = addr[3];
assign addr_memory_slice_2[4] = addr[4];
assign addr_memory_slice_2[5] = addr[5];
assign addr_memory_slice_2[6] = addr[6];
assign addr_memory_slice_2[7] = addr[7];
assign addr_memory_slice_2[8] = addr[8];
assign addr_memory_slice_2[9] = addr[9];
assign addr_memory_slice_2[10] = addr[10];
assign addr_memory_slice_2[11] = addr[11];
assign addr_memory_slice_2[12] = addr[12];
assign addr_memory_slice_2[13] = addr[13];
assign data_memory_slice_2[0] = data[2];
assign we_memory_slice_2[0] = we[0];
assign clk_memory_slice_2[0] = clk[0];
 
memory_slice memory_slice_2 ( .clk(clk_memory_slice_2), .addr(addr_memory_slice_2), .data(data_memory_slice_2), .we(we_memory_slice_2), .out(out_memory_slice_2) );

assign addr_memory_slice_3[0] = addr[0];
assign addr_memory_slice_3[1] = addr[1];
assign addr_memory_slice_3[2] = addr[2];
assign addr_memory_slice_3[3] = addr[3];
assign addr_memory_slice_3[4] = addr[4];
assign addr_memory_slice_3[5] = addr[5];
assign addr_memory_slice_3[6] = addr[6];
assign addr_memory_slice_3[7] = addr[7];
assign addr_memory_slice_3[8] = addr[8];
assign addr_memory_slice_3[9] = addr[9];
assign addr_memory_slice_3[10] = addr[10];
assign addr_memory_slice_3[11] = addr[11];
assign addr_memory_slice_3[12] = addr[12];
assign addr_memory_slice_3[13] = addr[13];
assign data_memory_slice_3[0] = data[3];
assign we_memory_slice_3[0] = we[0];
assign clk_memory_slice_3[0] = clk[0];
 
memory_slice memory_slice_3 ( .clk(clk_memory_slice_3), .addr(addr_memory_slice_3), .data(data_memory_slice_3), .we(we_memory_slice_3), .out(out_memory_slice_3) );

assign addr_memory_slice_4[0] = addr[0];
assign addr_memory_slice_4[1] = addr[1];
assign addr_memory_slice_4[2] = addr[2];
assign addr_memory_slice_4[3] = addr[3];
assign addr_memory_slice_4[4] = addr[4];
assign addr_memory_slice_4[5] = addr[5];
assign addr_memory_slice_4[6] = addr[6];
assign addr_memory_slice_4[7] = addr[7];
assign addr_memory_slice_4[8] = addr[8];
assign addr_memory_slice_4[9] = addr[9];
assign addr_memory_slice_4[10] = addr[10];
assign addr_memory_slice_4[11] = addr[11];
assign addr_memory_slice_4[12] = addr[12];
assign addr_memory_slice_4[13] = addr[13];
assign data_memory_slice_4[0] = data[4];
assign we_memory_slice_4[0] = we[0];
assign clk_memory_slice_4[0] = clk[0];
 
memory_slice memory_slice_4 ( .clk(clk_memory_slice_4), .addr(addr_memory_slice_4), .data(data_memory_slice_4), .we(we_memory_slice_4), .out(out_memory_slice_4) );

assign addr_memory_slice_5[0] = addr[0];
assign addr_memory_slice_5[1] = addr[1];
assign addr_memory_slice_5[2] = addr[2];
assign addr_memory_slice_5[3] = addr[3];
assign addr_memory_slice_5[4] = addr[4];
assign addr_memory_slice_5[5] = addr[5];
assign addr_memory_slice_5[6] = addr[6];
assign addr_memory_slice_5[7] = addr[7];
assign addr_memory_slice_5[8] = addr[8];
assign addr_memory_slice_5[9] = addr[9];
assign addr_memory_slice_5[10] = addr[10];
assign addr_memory_slice_5[11] = addr[11];
assign addr_memory_slice_5[12] = addr[12];
assign addr_memory_slice_5[13] = addr[13];
assign data_memory_slice_5[0] = data[5];
assign we_memory_slice_5[0] = we[0];
assign clk_memory_slice_5[0] = clk[0];
 
memory_slice memory_slice_5 ( .clk(clk_memory_slice_5), .addr(addr_memory_slice_5), .data(data_memory_slice_5), .we(we_memory_slice_5), .out(out_memory_slice_5) );

assign addr_memory_slice_6[0] = addr[0];
assign addr_memory_slice_6[1] = addr[1];
assign addr_memory_slice_6[2] = addr[2];
assign addr_memory_slice_6[3] = addr[3];
assign addr_memory_slice_6[4] = addr[4];
assign addr_memory_slice_6[5] = addr[5];
assign addr_memory_slice_6[6] = addr[6];
assign addr_memory_slice_6[7] = addr[7];
assign addr_memory_slice_6[8] = addr[8];
assign addr_memory_slice_6[9] = addr[9];
assign addr_memory_slice_6[10] = addr[10];
assign addr_memory_slice_6[11] = addr[11];
assign addr_memory_slice_6[12] = addr[12];
assign addr_memory_slice_6[13] = addr[13];
assign data_memory_slice_6[0] = data[6];
assign we_memory_slice_6[0] = we[0];
assign clk_memory_slice_6[0] = clk[0];
 
memory_slice memory_slice_6 ( .clk(clk_memory_slice_6), .addr(addr_memory_slice_6), .data(data_memory_slice_6), .we(we_memory_slice_6), .out(out_memory_slice_6) );

assign addr_memory_slice_7[0] = addr[0];
assign addr_memory_slice_7[1] = addr[1];
assign addr_memory_slice_7[2] = addr[2];
assign addr_memory_slice_7[3] = addr[3];
assign addr_memory_slice_7[4] = addr[4];
assign addr_memory_slice_7[5] = addr[5];
assign addr_memory_slice_7[6] = addr[6];
assign addr_memory_slice_7[7] = addr[7];
assign addr_memory_slice_7[8] = addr[8];
assign addr_memory_slice_7[9] = addr[9];
assign addr_memory_slice_7[10] = addr[10];
assign addr_memory_slice_7[11] = addr[11];
assign addr_memory_slice_7[12] = addr[12];
assign addr_memory_slice_7[13] = addr[13];
assign data_memory_slice_7[0] = data[7];
assign we_memory_slice_7[0] = we[0];
assign clk_memory_slice_7[0] = clk[0];
 
memory_slice memory_slice_7 ( .clk(clk_memory_slice_7), .addr(addr_memory_slice_7), .data(data_memory_slice_7), .we(we_memory_slice_7), .out(out_memory_slice_7) );

assign addr_memory_slice_8[0] = addr[0];
assign addr_memory_slice_8[1] = addr[1];
assign addr_memory_slice_8[2] = addr[2];
assign addr_memory_slice_8[3] = addr[3];
assign addr_memory_slice_8[4] = addr[4];
assign addr_memory_slice_8[5] = addr[5];
assign addr_memory_slice_8[6] = addr[6];
assign addr_memory_slice_8[7] = addr[7];
assign addr_memory_slice_8[8] = addr[8];
assign addr_memory_slice_8[9] = addr[9];
assign addr_memory_slice_8[10] = addr[10];
assign addr_memory_slice_8[11] = addr[11];
assign addr_memory_slice_8[12] = addr[12];
assign addr_memory_slice_8[13] = addr[13];
assign data_memory_slice_8[0] = data[8];
assign we_memory_slice_8[0] = we[0];
assign clk_memory_slice_8[0] = clk[0];
 
memory_slice memory_slice_8 ( .clk(clk_memory_slice_8), .addr(addr_memory_slice_8), .data(data_memory_slice_8), .we(we_memory_slice_8), .out(out_memory_slice_8) );

//child output to block output
assign out[0] = out_memory_slice_0[0];
assign out[1] = out_memory_slice_1[0];
assign out[2] = out_memory_slice_2[0];
assign out[3] = out_memory_slice_3[0];
assign out[4] = out_memory_slice_4[0];
assign out[5] = out_memory_slice_5[0];
assign out[6] = out_memory_slice_6[0];
assign out[7] = out_memory_slice_7[0];
assign out[8] = out_memory_slice_8[0];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// memory /////////////////////////
/////////////////////////////////////////////////////
module memory (
	input [16:0]addr1,
	input [16:0]addr2,
	input [71:0]data,
	input [0:0]we1,
	input [0:0]we2,
	input [0:0]clk,
	output [71:0]out,
	input [125:0]config_in
);

////////child (0,0,0)////////
wire [10:0]addr_mem_2048x72_sp_0;//input to child
wire [71:0]data_mem_2048x72_sp_0;//input to child
wire [0:0]we_mem_2048x72_sp_0;//input to child
wire [0:0]clk_mem_2048x72_sp_0;//clock to child
wire [71:0]out_mem_2048x72_sp_0;//output from child
 
////////child (1,0,0)////////
wire [11:0]addr1_mem_4096x36_dp_0;//input to child
wire [11:0]addr2_mem_4096x36_dp_0;//input to child
wire [35:0]data1_mem_4096x36_dp_0;//input to child
wire [35:0]data2_mem_4096x36_dp_0;//input to child
wire [0:0]we1_mem_4096x36_dp_0;//input to child
wire [0:0]we2_mem_4096x36_dp_0;//input to child
wire [0:0]clk_mem_4096x36_dp_0;//clock to child
wire [35:0]out1_mem_4096x36_dp_0;//output from child
wire [35:0]out2_mem_4096x36_dp_0;//output from child
 
////////child (2,0,0)////////
wire [11:0]addr_mem_4096x36_sp_0;//input to child
wire [35:0]data_mem_4096x36_sp_0;//input to child
wire [0:0]we_mem_4096x36_sp_0;//input to child
wire [0:0]clk_mem_4096x36_sp_0;//clock to child
wire [35:0]out_mem_4096x36_sp_0;//output from child
 
////////child (3,0,0)////////
wire [12:0]addr1_mem_9182x18_dp_0;//input to child
wire [12:0]addr2_mem_9182x18_dp_0;//input to child
wire [17:0]data1_mem_9182x18_dp_0;//input to child
wire [17:0]data2_mem_9182x18_dp_0;//input to child
wire [0:0]we1_mem_9182x18_dp_0;//input to child
wire [0:0]we2_mem_9182x18_dp_0;//input to child
wire [0:0]clk_mem_9182x18_dp_0;//clock to child
wire [17:0]out1_mem_9182x18_dp_0;//output from child
wire [17:0]out2_mem_9182x18_dp_0;//output from child
 
////////child (4,0,0)////////
wire [12:0]addr_mem_9182x18_sp_0;//input to child
wire [17:0]data_mem_9182x18_sp_0;//input to child
wire [0:0]we_mem_9182x18_sp_0;//input to child
wire [0:0]clk_mem_9182x18_sp_0;//clock to child
wire [17:0]out_mem_9182x18_sp_0;//output from child
 
////////child (5,0,0)////////
wire [13:0]addr1_mem_18194x9_dp_0;//input to child
wire [13:0]addr2_mem_18194x9_dp_0;//input to child
wire [8:0]data1_mem_18194x9_dp_0;//input to child
wire [8:0]data2_mem_18194x9_dp_0;//input to child
wire [0:0]we1_mem_18194x9_dp_0;//input to child
wire [0:0]we2_mem_18194x9_dp_0;//input to child
wire [0:0]clk_mem_18194x9_dp_0;//clock to child
wire [8:0]out1_mem_18194x9_dp_0;//output from child
wire [8:0]out2_mem_18194x9_dp_0;//output from child
 
////////child (6,0,0)////////
wire [13:0]addr_mem_18194x9_sp_0;//input to child
wire [8:0]data_mem_18194x9_sp_0;//input to child
wire [0:0]we_mem_18194x9_sp_0;//input to child
wire [0:0]clk_mem_18194x9_sp_0;//clock to child
wire [8:0]out_mem_18194x9_sp_0;//output from child
 
wire ground;

assign addr_mem_2048x72_sp_0[0] = addr1[0];
assign addr_mem_2048x72_sp_0[1] = addr1[1];
assign addr_mem_2048x72_sp_0[2] = addr1[2];
assign addr_mem_2048x72_sp_0[3] = addr1[3];
assign addr_mem_2048x72_sp_0[4] = addr1[4];
assign addr_mem_2048x72_sp_0[5] = addr1[5];
assign addr_mem_2048x72_sp_0[6] = addr1[6];
assign addr_mem_2048x72_sp_0[7] = addr1[7];
assign addr_mem_2048x72_sp_0[8] = addr1[8];
assign addr_mem_2048x72_sp_0[9] = addr1[9];
assign addr_mem_2048x72_sp_0[10] = addr1[10];
assign data_mem_2048x72_sp_0[0] = data[0];
assign data_mem_2048x72_sp_0[1] = data[1];
assign data_mem_2048x72_sp_0[2] = data[2];
assign data_mem_2048x72_sp_0[3] = data[3];
assign data_mem_2048x72_sp_0[4] = data[4];
assign data_mem_2048x72_sp_0[5] = data[5];
assign data_mem_2048x72_sp_0[6] = data[6];
assign data_mem_2048x72_sp_0[7] = data[7];
assign data_mem_2048x72_sp_0[8] = data[8];
assign data_mem_2048x72_sp_0[9] = data[9];
assign data_mem_2048x72_sp_0[10] = data[10];
assign data_mem_2048x72_sp_0[11] = data[11];
assign data_mem_2048x72_sp_0[12] = data[12];
assign data_mem_2048x72_sp_0[13] = data[13];
assign data_mem_2048x72_sp_0[14] = data[14];
assign data_mem_2048x72_sp_0[15] = data[15];
assign data_mem_2048x72_sp_0[16] = data[16];
assign data_mem_2048x72_sp_0[17] = data[17];
assign data_mem_2048x72_sp_0[18] = data[18];
assign data_mem_2048x72_sp_0[19] = data[19];
assign data_mem_2048x72_sp_0[20] = data[20];
assign data_mem_2048x72_sp_0[21] = data[21];
assign data_mem_2048x72_sp_0[22] = data[22];
assign data_mem_2048x72_sp_0[23] = data[23];
assign data_mem_2048x72_sp_0[24] = data[24];
assign data_mem_2048x72_sp_0[25] = data[25];
assign data_mem_2048x72_sp_0[26] = data[26];
assign data_mem_2048x72_sp_0[27] = data[27];
assign data_mem_2048x72_sp_0[28] = data[28];
assign data_mem_2048x72_sp_0[29] = data[29];
assign data_mem_2048x72_sp_0[30] = data[30];
assign data_mem_2048x72_sp_0[31] = data[31];
assign data_mem_2048x72_sp_0[32] = data[32];
assign data_mem_2048x72_sp_0[33] = data[33];
assign data_mem_2048x72_sp_0[34] = data[34];
assign data_mem_2048x72_sp_0[35] = data[35];
assign data_mem_2048x72_sp_0[36] = data[36];
assign data_mem_2048x72_sp_0[37] = data[37];
assign data_mem_2048x72_sp_0[38] = data[38];
assign data_mem_2048x72_sp_0[39] = data[39];
assign data_mem_2048x72_sp_0[40] = data[40];
assign data_mem_2048x72_sp_0[41] = data[41];
assign data_mem_2048x72_sp_0[42] = data[42];
assign data_mem_2048x72_sp_0[43] = data[43];
assign data_mem_2048x72_sp_0[44] = data[44];
assign data_mem_2048x72_sp_0[45] = data[45];
assign data_mem_2048x72_sp_0[46] = data[46];
assign data_mem_2048x72_sp_0[47] = data[47];
assign data_mem_2048x72_sp_0[48] = data[48];
assign data_mem_2048x72_sp_0[49] = data[49];
assign data_mem_2048x72_sp_0[50] = data[50];
assign data_mem_2048x72_sp_0[51] = data[51];
assign data_mem_2048x72_sp_0[52] = data[52];
assign data_mem_2048x72_sp_0[53] = data[53];
assign data_mem_2048x72_sp_0[54] = data[54];
assign data_mem_2048x72_sp_0[55] = data[55];
assign data_mem_2048x72_sp_0[56] = data[56];
assign data_mem_2048x72_sp_0[57] = data[57];
assign data_mem_2048x72_sp_0[58] = data[58];
assign data_mem_2048x72_sp_0[59] = data[59];
assign data_mem_2048x72_sp_0[60] = data[60];
assign data_mem_2048x72_sp_0[61] = data[61];
assign data_mem_2048x72_sp_0[62] = data[62];
assign data_mem_2048x72_sp_0[63] = data[63];
assign data_mem_2048x72_sp_0[64] = data[64];
assign data_mem_2048x72_sp_0[65] = data[65];
assign data_mem_2048x72_sp_0[66] = data[66];
assign data_mem_2048x72_sp_0[67] = data[67];
assign data_mem_2048x72_sp_0[68] = data[68];
assign data_mem_2048x72_sp_0[69] = data[69];
assign data_mem_2048x72_sp_0[70] = data[70];
assign data_mem_2048x72_sp_0[71] = data[71];
assign we_mem_2048x72_sp_0[0] = we1[0];
assign clk_mem_2048x72_sp_0[0] = clk[0];
 
mem_2048x72_sp mem_2048x72_sp_0 ( .clk(clk_mem_2048x72_sp_0), .addr(addr_mem_2048x72_sp_0), .data(data_mem_2048x72_sp_0), .we(we_mem_2048x72_sp_0), .out(out_mem_2048x72_sp_0) );

assign addr1_mem_4096x36_dp_0[0] = addr1[0];
assign addr1_mem_4096x36_dp_0[1] = addr1[1];
assign addr1_mem_4096x36_dp_0[2] = addr1[2];
assign addr1_mem_4096x36_dp_0[3] = addr1[3];
assign addr1_mem_4096x36_dp_0[4] = addr1[4];
assign addr1_mem_4096x36_dp_0[5] = addr1[5];
assign addr1_mem_4096x36_dp_0[6] = addr1[6];
assign addr1_mem_4096x36_dp_0[7] = addr1[7];
assign addr1_mem_4096x36_dp_0[8] = addr1[8];
assign addr1_mem_4096x36_dp_0[9] = addr1[9];
assign addr1_mem_4096x36_dp_0[10] = addr1[10];
assign addr1_mem_4096x36_dp_0[11] = addr1[11];
assign addr2_mem_4096x36_dp_0[0] = addr2[0];
assign addr2_mem_4096x36_dp_0[1] = addr2[1];
assign addr2_mem_4096x36_dp_0[2] = addr2[2];
assign addr2_mem_4096x36_dp_0[3] = addr2[3];
assign addr2_mem_4096x36_dp_0[4] = addr2[4];
assign addr2_mem_4096x36_dp_0[5] = addr2[5];
assign addr2_mem_4096x36_dp_0[6] = addr2[6];
assign addr2_mem_4096x36_dp_0[7] = addr2[7];
assign addr2_mem_4096x36_dp_0[8] = addr2[8];
assign addr2_mem_4096x36_dp_0[9] = addr2[9];
assign addr2_mem_4096x36_dp_0[10] = addr2[10];
assign addr2_mem_4096x36_dp_0[11] = addr2[11];
assign data1_mem_4096x36_dp_0[0] = data[0];
assign data1_mem_4096x36_dp_0[1] = data[1];
assign data1_mem_4096x36_dp_0[2] = data[2];
assign data1_mem_4096x36_dp_0[3] = data[3];
assign data1_mem_4096x36_dp_0[4] = data[4];
assign data1_mem_4096x36_dp_0[5] = data[5];
assign data1_mem_4096x36_dp_0[6] = data[6];
assign data1_mem_4096x36_dp_0[7] = data[7];
assign data1_mem_4096x36_dp_0[8] = data[8];
assign data1_mem_4096x36_dp_0[9] = data[9];
assign data1_mem_4096x36_dp_0[10] = data[10];
assign data1_mem_4096x36_dp_0[11] = data[11];
assign data1_mem_4096x36_dp_0[12] = data[12];
assign data1_mem_4096x36_dp_0[13] = data[13];
assign data1_mem_4096x36_dp_0[14] = data[14];
assign data1_mem_4096x36_dp_0[15] = data[15];
assign data1_mem_4096x36_dp_0[16] = data[16];
assign data1_mem_4096x36_dp_0[17] = data[17];
assign data1_mem_4096x36_dp_0[18] = data[18];
assign data1_mem_4096x36_dp_0[19] = data[19];
assign data1_mem_4096x36_dp_0[20] = data[20];
assign data1_mem_4096x36_dp_0[21] = data[21];
assign data1_mem_4096x36_dp_0[22] = data[22];
assign data1_mem_4096x36_dp_0[23] = data[23];
assign data1_mem_4096x36_dp_0[24] = data[24];
assign data1_mem_4096x36_dp_0[25] = data[25];
assign data1_mem_4096x36_dp_0[26] = data[26];
assign data1_mem_4096x36_dp_0[27] = data[27];
assign data1_mem_4096x36_dp_0[28] = data[28];
assign data1_mem_4096x36_dp_0[29] = data[29];
assign data1_mem_4096x36_dp_0[30] = data[30];
assign data1_mem_4096x36_dp_0[31] = data[31];
assign data1_mem_4096x36_dp_0[32] = data[32];
assign data1_mem_4096x36_dp_0[33] = data[33];
assign data1_mem_4096x36_dp_0[34] = data[34];
assign data1_mem_4096x36_dp_0[35] = data[35];
assign data2_mem_4096x36_dp_0[0] = data[36];
assign data2_mem_4096x36_dp_0[1] = data[37];
assign data2_mem_4096x36_dp_0[2] = data[38];
assign data2_mem_4096x36_dp_0[3] = data[39];
assign data2_mem_4096x36_dp_0[4] = data[40];
assign data2_mem_4096x36_dp_0[5] = data[41];
assign data2_mem_4096x36_dp_0[6] = data[42];
assign data2_mem_4096x36_dp_0[7] = data[43];
assign data2_mem_4096x36_dp_0[8] = data[44];
assign data2_mem_4096x36_dp_0[9] = data[45];
assign data2_mem_4096x36_dp_0[10] = data[46];
assign data2_mem_4096x36_dp_0[11] = data[47];
assign data2_mem_4096x36_dp_0[12] = data[48];
assign data2_mem_4096x36_dp_0[13] = data[49];
assign data2_mem_4096x36_dp_0[14] = data[50];
assign data2_mem_4096x36_dp_0[15] = data[51];
assign data2_mem_4096x36_dp_0[16] = data[52];
assign data2_mem_4096x36_dp_0[17] = data[53];
assign data2_mem_4096x36_dp_0[18] = data[54];
assign data2_mem_4096x36_dp_0[19] = data[55];
assign data2_mem_4096x36_dp_0[20] = data[56];
assign data2_mem_4096x36_dp_0[21] = data[57];
assign data2_mem_4096x36_dp_0[22] = data[58];
assign data2_mem_4096x36_dp_0[23] = data[59];
assign data2_mem_4096x36_dp_0[24] = data[60];
assign data2_mem_4096x36_dp_0[25] = data[61];
assign data2_mem_4096x36_dp_0[26] = data[62];
assign data2_mem_4096x36_dp_0[27] = data[63];
assign data2_mem_4096x36_dp_0[28] = data[64];
assign data2_mem_4096x36_dp_0[29] = data[65];
assign data2_mem_4096x36_dp_0[30] = data[66];
assign data2_mem_4096x36_dp_0[31] = data[67];
assign data2_mem_4096x36_dp_0[32] = data[68];
assign data2_mem_4096x36_dp_0[33] = data[69];
assign data2_mem_4096x36_dp_0[34] = data[70];
assign data2_mem_4096x36_dp_0[35] = data[71];
assign we1_mem_4096x36_dp_0[0] = we1[0];
assign we2_mem_4096x36_dp_0[0] = we2[0];
assign clk_mem_4096x36_dp_0[0] = clk[0];
 
mem_4096x36_dp mem_4096x36_dp_0 ( .clk(clk_mem_4096x36_dp_0), .addr1(addr1_mem_4096x36_dp_0), .addr2(addr2_mem_4096x36_dp_0), .data1(data1_mem_4096x36_dp_0), .data2(data2_mem_4096x36_dp_0), .we1(we1_mem_4096x36_dp_0), .we2(we2_mem_4096x36_dp_0), .out1(out1_mem_4096x36_dp_0), .out2(out2_mem_4096x36_dp_0) );

assign addr_mem_4096x36_sp_0[0] = addr1[0];
assign addr_mem_4096x36_sp_0[1] = addr1[1];
assign addr_mem_4096x36_sp_0[2] = addr1[2];
assign addr_mem_4096x36_sp_0[3] = addr1[3];
assign addr_mem_4096x36_sp_0[4] = addr1[4];
assign addr_mem_4096x36_sp_0[5] = addr1[5];
assign addr_mem_4096x36_sp_0[6] = addr1[6];
assign addr_mem_4096x36_sp_0[7] = addr1[7];
assign addr_mem_4096x36_sp_0[8] = addr1[8];
assign addr_mem_4096x36_sp_0[9] = addr1[9];
assign addr_mem_4096x36_sp_0[10] = addr1[10];
assign addr_mem_4096x36_sp_0[11] = addr1[11];
assign data_mem_4096x36_sp_0[0] = data[0];
assign data_mem_4096x36_sp_0[1] = data[1];
assign data_mem_4096x36_sp_0[2] = data[2];
assign data_mem_4096x36_sp_0[3] = data[3];
assign data_mem_4096x36_sp_0[4] = data[4];
assign data_mem_4096x36_sp_0[5] = data[5];
assign data_mem_4096x36_sp_0[6] = data[6];
assign data_mem_4096x36_sp_0[7] = data[7];
assign data_mem_4096x36_sp_0[8] = data[8];
assign data_mem_4096x36_sp_0[9] = data[9];
assign data_mem_4096x36_sp_0[10] = data[10];
assign data_mem_4096x36_sp_0[11] = data[11];
assign data_mem_4096x36_sp_0[12] = data[12];
assign data_mem_4096x36_sp_0[13] = data[13];
assign data_mem_4096x36_sp_0[14] = data[14];
assign data_mem_4096x36_sp_0[15] = data[15];
assign data_mem_4096x36_sp_0[16] = data[16];
assign data_mem_4096x36_sp_0[17] = data[17];
assign data_mem_4096x36_sp_0[18] = data[18];
assign data_mem_4096x36_sp_0[19] = data[19];
assign data_mem_4096x36_sp_0[20] = data[20];
assign data_mem_4096x36_sp_0[21] = data[21];
assign data_mem_4096x36_sp_0[22] = data[22];
assign data_mem_4096x36_sp_0[23] = data[23];
assign data_mem_4096x36_sp_0[24] = data[24];
assign data_mem_4096x36_sp_0[25] = data[25];
assign data_mem_4096x36_sp_0[26] = data[26];
assign data_mem_4096x36_sp_0[27] = data[27];
assign data_mem_4096x36_sp_0[28] = data[28];
assign data_mem_4096x36_sp_0[29] = data[29];
assign data_mem_4096x36_sp_0[30] = data[30];
assign data_mem_4096x36_sp_0[31] = data[31];
assign data_mem_4096x36_sp_0[32] = data[32];
assign data_mem_4096x36_sp_0[33] = data[33];
assign data_mem_4096x36_sp_0[34] = data[34];
assign data_mem_4096x36_sp_0[35] = data[35];
assign we_mem_4096x36_sp_0[0] = we1[0];
assign clk_mem_4096x36_sp_0[0] = clk[0];
 
mem_4096x36_sp mem_4096x36_sp_0 ( .clk(clk_mem_4096x36_sp_0), .addr(addr_mem_4096x36_sp_0), .data(data_mem_4096x36_sp_0), .we(we_mem_4096x36_sp_0), .out(out_mem_4096x36_sp_0) );

assign addr1_mem_9182x18_dp_0[0] = addr1[0];
assign addr1_mem_9182x18_dp_0[1] = addr1[1];
assign addr1_mem_9182x18_dp_0[2] = addr1[2];
assign addr1_mem_9182x18_dp_0[3] = addr1[3];
assign addr1_mem_9182x18_dp_0[4] = addr1[4];
assign addr1_mem_9182x18_dp_0[5] = addr1[5];
assign addr1_mem_9182x18_dp_0[6] = addr1[6];
assign addr1_mem_9182x18_dp_0[7] = addr1[7];
assign addr1_mem_9182x18_dp_0[8] = addr1[8];
assign addr1_mem_9182x18_dp_0[9] = addr1[9];
assign addr1_mem_9182x18_dp_0[10] = addr1[10];
assign addr1_mem_9182x18_dp_0[11] = addr1[11];
assign addr1_mem_9182x18_dp_0[12] = addr1[12];
assign addr2_mem_9182x18_dp_0[0] = addr2[0];
assign addr2_mem_9182x18_dp_0[1] = addr2[1];
assign addr2_mem_9182x18_dp_0[2] = addr2[2];
assign addr2_mem_9182x18_dp_0[3] = addr2[3];
assign addr2_mem_9182x18_dp_0[4] = addr2[4];
assign addr2_mem_9182x18_dp_0[5] = addr2[5];
assign addr2_mem_9182x18_dp_0[6] = addr2[6];
assign addr2_mem_9182x18_dp_0[7] = addr2[7];
assign addr2_mem_9182x18_dp_0[8] = addr2[8];
assign addr2_mem_9182x18_dp_0[9] = addr2[9];
assign addr2_mem_9182x18_dp_0[10] = addr2[10];
assign addr2_mem_9182x18_dp_0[11] = addr2[11];
assign addr2_mem_9182x18_dp_0[12] = addr2[12];
assign data1_mem_9182x18_dp_0[0] = data[0];
assign data1_mem_9182x18_dp_0[1] = data[1];
assign data1_mem_9182x18_dp_0[2] = data[2];
assign data1_mem_9182x18_dp_0[3] = data[3];
assign data1_mem_9182x18_dp_0[4] = data[4];
assign data1_mem_9182x18_dp_0[5] = data[5];
assign data1_mem_9182x18_dp_0[6] = data[6];
assign data1_mem_9182x18_dp_0[7] = data[7];
assign data1_mem_9182x18_dp_0[8] = data[8];
assign data1_mem_9182x18_dp_0[9] = data[9];
assign data1_mem_9182x18_dp_0[10] = data[10];
assign data1_mem_9182x18_dp_0[11] = data[11];
assign data1_mem_9182x18_dp_0[12] = data[12];
assign data1_mem_9182x18_dp_0[13] = data[13];
assign data1_mem_9182x18_dp_0[14] = data[14];
assign data1_mem_9182x18_dp_0[15] = data[15];
assign data1_mem_9182x18_dp_0[16] = data[16];
assign data1_mem_9182x18_dp_0[17] = data[17];
assign data2_mem_9182x18_dp_0[0] = data[18];
assign data2_mem_9182x18_dp_0[1] = data[19];
assign data2_mem_9182x18_dp_0[2] = data[20];
assign data2_mem_9182x18_dp_0[3] = data[21];
assign data2_mem_9182x18_dp_0[4] = data[22];
assign data2_mem_9182x18_dp_0[5] = data[23];
assign data2_mem_9182x18_dp_0[6] = data[24];
assign data2_mem_9182x18_dp_0[7] = data[25];
assign data2_mem_9182x18_dp_0[8] = data[26];
assign data2_mem_9182x18_dp_0[9] = data[27];
assign data2_mem_9182x18_dp_0[10] = data[28];
assign data2_mem_9182x18_dp_0[11] = data[29];
assign data2_mem_9182x18_dp_0[12] = data[30];
assign data2_mem_9182x18_dp_0[13] = data[31];
assign data2_mem_9182x18_dp_0[14] = data[32];
assign data2_mem_9182x18_dp_0[15] = data[33];
assign data2_mem_9182x18_dp_0[16] = data[34];
assign data2_mem_9182x18_dp_0[17] = data[35];
assign we1_mem_9182x18_dp_0[0] = we1[0];
assign we2_mem_9182x18_dp_0[0] = we2[0];
assign clk_mem_9182x18_dp_0[0] = clk[0];
 
mem_9182x18_dp mem_9182x18_dp_0 ( .clk(clk_mem_9182x18_dp_0), .addr1(addr1_mem_9182x18_dp_0), .addr2(addr2_mem_9182x18_dp_0), .data1(data1_mem_9182x18_dp_0), .data2(data2_mem_9182x18_dp_0), .we1(we1_mem_9182x18_dp_0), .we2(we2_mem_9182x18_dp_0), .out1(out1_mem_9182x18_dp_0), .out2(out2_mem_9182x18_dp_0) );

assign addr_mem_9182x18_sp_0[0] = addr1[0];
assign addr_mem_9182x18_sp_0[1] = addr1[1];
assign addr_mem_9182x18_sp_0[2] = addr1[2];
assign addr_mem_9182x18_sp_0[3] = addr1[3];
assign addr_mem_9182x18_sp_0[4] = addr1[4];
assign addr_mem_9182x18_sp_0[5] = addr1[5];
assign addr_mem_9182x18_sp_0[6] = addr1[6];
assign addr_mem_9182x18_sp_0[7] = addr1[7];
assign addr_mem_9182x18_sp_0[8] = addr1[8];
assign addr_mem_9182x18_sp_0[9] = addr1[9];
assign addr_mem_9182x18_sp_0[10] = addr1[10];
assign addr_mem_9182x18_sp_0[11] = addr1[11];
assign addr_mem_9182x18_sp_0[12] = addr1[12];
assign data_mem_9182x18_sp_0[0] = data[0];
assign data_mem_9182x18_sp_0[1] = data[1];
assign data_mem_9182x18_sp_0[2] = data[2];
assign data_mem_9182x18_sp_0[3] = data[3];
assign data_mem_9182x18_sp_0[4] = data[4];
assign data_mem_9182x18_sp_0[5] = data[5];
assign data_mem_9182x18_sp_0[6] = data[6];
assign data_mem_9182x18_sp_0[7] = data[7];
assign data_mem_9182x18_sp_0[8] = data[8];
assign data_mem_9182x18_sp_0[9] = data[9];
assign data_mem_9182x18_sp_0[10] = data[10];
assign data_mem_9182x18_sp_0[11] = data[11];
assign data_mem_9182x18_sp_0[12] = data[12];
assign data_mem_9182x18_sp_0[13] = data[13];
assign data_mem_9182x18_sp_0[14] = data[14];
assign data_mem_9182x18_sp_0[15] = data[15];
assign data_mem_9182x18_sp_0[16] = data[16];
assign data_mem_9182x18_sp_0[17] = data[17];
assign we_mem_9182x18_sp_0[0] = we1[0];
assign clk_mem_9182x18_sp_0[0] = clk[0];
 
mem_9182x18_sp mem_9182x18_sp_0 ( .clk(clk_mem_9182x18_sp_0), .addr(addr_mem_9182x18_sp_0), .data(data_mem_9182x18_sp_0), .we(we_mem_9182x18_sp_0), .out(out_mem_9182x18_sp_0) );

assign addr1_mem_18194x9_dp_0[0] = addr1[0];
assign addr1_mem_18194x9_dp_0[1] = addr1[1];
assign addr1_mem_18194x9_dp_0[2] = addr1[2];
assign addr1_mem_18194x9_dp_0[3] = addr1[3];
assign addr1_mem_18194x9_dp_0[4] = addr1[4];
assign addr1_mem_18194x9_dp_0[5] = addr1[5];
assign addr1_mem_18194x9_dp_0[6] = addr1[6];
assign addr1_mem_18194x9_dp_0[7] = addr1[7];
assign addr1_mem_18194x9_dp_0[8] = addr1[8];
assign addr1_mem_18194x9_dp_0[9] = addr1[9];
assign addr1_mem_18194x9_dp_0[10] = addr1[10];
assign addr1_mem_18194x9_dp_0[11] = addr1[11];
assign addr1_mem_18194x9_dp_0[12] = addr1[12];
assign addr1_mem_18194x9_dp_0[13] = addr1[13];
assign addr2_mem_18194x9_dp_0[0] = addr2[0];
assign addr2_mem_18194x9_dp_0[1] = addr2[1];
assign addr2_mem_18194x9_dp_0[2] = addr2[2];
assign addr2_mem_18194x9_dp_0[3] = addr2[3];
assign addr2_mem_18194x9_dp_0[4] = addr2[4];
assign addr2_mem_18194x9_dp_0[5] = addr2[5];
assign addr2_mem_18194x9_dp_0[6] = addr2[6];
assign addr2_mem_18194x9_dp_0[7] = addr2[7];
assign addr2_mem_18194x9_dp_0[8] = addr2[8];
assign addr2_mem_18194x9_dp_0[9] = addr2[9];
assign addr2_mem_18194x9_dp_0[10] = addr2[10];
assign addr2_mem_18194x9_dp_0[11] = addr2[11];
assign addr2_mem_18194x9_dp_0[12] = addr2[12];
assign addr2_mem_18194x9_dp_0[13] = addr2[13];
assign data1_mem_18194x9_dp_0[0] = data[0];
assign data1_mem_18194x9_dp_0[1] = data[1];
assign data1_mem_18194x9_dp_0[2] = data[2];
assign data1_mem_18194x9_dp_0[3] = data[3];
assign data1_mem_18194x9_dp_0[4] = data[4];
assign data1_mem_18194x9_dp_0[5] = data[5];
assign data1_mem_18194x9_dp_0[6] = data[6];
assign data1_mem_18194x9_dp_0[7] = data[7];
assign data1_mem_18194x9_dp_0[8] = data[8];
assign data2_mem_18194x9_dp_0[0] = data[9];
assign data2_mem_18194x9_dp_0[1] = data[10];
assign data2_mem_18194x9_dp_0[2] = data[11];
assign data2_mem_18194x9_dp_0[3] = data[12];
assign data2_mem_18194x9_dp_0[4] = data[13];
assign data2_mem_18194x9_dp_0[5] = data[14];
assign data2_mem_18194x9_dp_0[6] = data[15];
assign data2_mem_18194x9_dp_0[7] = data[16];
assign data2_mem_18194x9_dp_0[8] = data[17];
assign we1_mem_18194x9_dp_0[0] = we1[0];
assign we2_mem_18194x9_dp_0[0] = we2[0];
assign clk_mem_18194x9_dp_0[0] = clk[0];
 
mem_18194x9_dp mem_18194x9_dp_0 ( .clk(clk_mem_18194x9_dp_0), .addr1(addr1_mem_18194x9_dp_0), .addr2(addr2_mem_18194x9_dp_0), .data1(data1_mem_18194x9_dp_0), .data2(data2_mem_18194x9_dp_0), .we1(we1_mem_18194x9_dp_0), .we2(we2_mem_18194x9_dp_0), .out1(out1_mem_18194x9_dp_0), .out2(out2_mem_18194x9_dp_0) );

assign addr_mem_18194x9_sp_0[0] = addr1[0];
assign addr_mem_18194x9_sp_0[1] = addr1[1];
assign addr_mem_18194x9_sp_0[2] = addr1[2];
assign addr_mem_18194x9_sp_0[3] = addr1[3];
assign addr_mem_18194x9_sp_0[4] = addr1[4];
assign addr_mem_18194x9_sp_0[5] = addr1[5];
assign addr_mem_18194x9_sp_0[6] = addr1[6];
assign addr_mem_18194x9_sp_0[7] = addr1[7];
assign addr_mem_18194x9_sp_0[8] = addr1[8];
assign addr_mem_18194x9_sp_0[9] = addr1[9];
assign addr_mem_18194x9_sp_0[10] = addr1[10];
assign addr_mem_18194x9_sp_0[11] = addr1[11];
assign addr_mem_18194x9_sp_0[12] = addr1[12];
assign addr_mem_18194x9_sp_0[13] = addr1[13];
assign data_mem_18194x9_sp_0[0] = data[0];
assign data_mem_18194x9_sp_0[1] = data[1];
assign data_mem_18194x9_sp_0[2] = data[2];
assign data_mem_18194x9_sp_0[3] = data[3];
assign data_mem_18194x9_sp_0[4] = data[4];
assign data_mem_18194x9_sp_0[5] = data[5];
assign data_mem_18194x9_sp_0[6] = data[6];
assign data_mem_18194x9_sp_0[7] = data[7];
assign data_mem_18194x9_sp_0[8] = data[8];
assign we_mem_18194x9_sp_0[0] = we1[0];
assign clk_mem_18194x9_sp_0[0] = clk[0];
 
mem_18194x9_sp mem_18194x9_sp_0 ( .clk(clk_mem_18194x9_sp_0), .addr(addr_mem_18194x9_sp_0), .data(data_mem_18194x9_sp_0), .we(we_mem_18194x9_sp_0), .out(out_mem_18194x9_sp_0) );

//child output to block output
mux7 mux_0 ( .in({out_mem_2048x72_sp_0[0], out1_mem_4096x36_dp_0[0], out_mem_4096x36_sp_0[0], out1_mem_9182x18_dp_0[0], out_mem_9182x18_sp_0[0], out1_mem_18194x9_dp_0[0], out_mem_18194x9_sp_0[0]}), .config_in(config_in[2:0]), .out(out[0]) );
mux7 mux_3 ( .in({out_mem_2048x72_sp_0[1], out1_mem_4096x36_dp_0[1], out_mem_4096x36_sp_0[1], out1_mem_9182x18_dp_0[1], out_mem_9182x18_sp_0[1], out1_mem_18194x9_dp_0[1], out_mem_18194x9_sp_0[1]}), .config_in(config_in[5:3]), .out(out[1]) );
mux7 mux_6 ( .in({out_mem_2048x72_sp_0[2], out1_mem_4096x36_dp_0[2], out_mem_4096x36_sp_0[2], out1_mem_9182x18_dp_0[2], out_mem_9182x18_sp_0[2], out1_mem_18194x9_dp_0[2], out_mem_18194x9_sp_0[2]}), .config_in(config_in[8:6]), .out(out[2]) );
mux7 mux_9 ( .in({out_mem_2048x72_sp_0[3], out1_mem_4096x36_dp_0[3], out_mem_4096x36_sp_0[3], out1_mem_9182x18_dp_0[3], out_mem_9182x18_sp_0[3], out1_mem_18194x9_dp_0[3], out_mem_18194x9_sp_0[3]}), .config_in(config_in[11:9]), .out(out[3]) );
mux7 mux_12 ( .in({out_mem_2048x72_sp_0[4], out1_mem_4096x36_dp_0[4], out_mem_4096x36_sp_0[4], out1_mem_9182x18_dp_0[4], out_mem_9182x18_sp_0[4], out1_mem_18194x9_dp_0[4], out_mem_18194x9_sp_0[4]}), .config_in(config_in[14:12]), .out(out[4]) );
mux7 mux_15 ( .in({out_mem_2048x72_sp_0[5], out1_mem_4096x36_dp_0[5], out_mem_4096x36_sp_0[5], out1_mem_9182x18_dp_0[5], out_mem_9182x18_sp_0[5], out1_mem_18194x9_dp_0[5], out_mem_18194x9_sp_0[5]}), .config_in(config_in[17:15]), .out(out[5]) );
mux7 mux_18 ( .in({out_mem_2048x72_sp_0[6], out1_mem_4096x36_dp_0[6], out_mem_4096x36_sp_0[6], out1_mem_9182x18_dp_0[6], out_mem_9182x18_sp_0[6], out1_mem_18194x9_dp_0[6], out_mem_18194x9_sp_0[6]}), .config_in(config_in[20:18]), .out(out[6]) );
mux7 mux_21 ( .in({out_mem_2048x72_sp_0[7], out1_mem_4096x36_dp_0[7], out_mem_4096x36_sp_0[7], out1_mem_9182x18_dp_0[7], out_mem_9182x18_sp_0[7], out1_mem_18194x9_dp_0[7], out_mem_18194x9_sp_0[7]}), .config_in(config_in[23:21]), .out(out[7]) );
mux7 mux_24 ( .in({out_mem_2048x72_sp_0[8], out1_mem_4096x36_dp_0[8], out_mem_4096x36_sp_0[8], out1_mem_9182x18_dp_0[8], out_mem_9182x18_sp_0[8], out1_mem_18194x9_dp_0[8], out_mem_18194x9_sp_0[8]}), .config_in(config_in[26:24]), .out(out[8]) );
mux6 mux_27 ( .in({out_mem_2048x72_sp_0[9], out1_mem_4096x36_dp_0[9], out_mem_4096x36_sp_0[9], out1_mem_9182x18_dp_0[9], out_mem_9182x18_sp_0[9], out2_mem_18194x9_dp_0[0]}), .config_in(config_in[29:27]), .out(out[9]) );
mux6 mux_30 ( .in({out_mem_2048x72_sp_0[10], out1_mem_4096x36_dp_0[10], out_mem_4096x36_sp_0[10], out1_mem_9182x18_dp_0[10], out_mem_9182x18_sp_0[10], out2_mem_18194x9_dp_0[1]}), .config_in(config_in[32:30]), .out(out[10]) );
mux6 mux_33 ( .in({out_mem_2048x72_sp_0[11], out1_mem_4096x36_dp_0[11], out_mem_4096x36_sp_0[11], out1_mem_9182x18_dp_0[11], out_mem_9182x18_sp_0[11], out2_mem_18194x9_dp_0[2]}), .config_in(config_in[35:33]), .out(out[11]) );
mux6 mux_36 ( .in({out_mem_2048x72_sp_0[12], out1_mem_4096x36_dp_0[12], out_mem_4096x36_sp_0[12], out1_mem_9182x18_dp_0[12], out_mem_9182x18_sp_0[12], out2_mem_18194x9_dp_0[3]}), .config_in(config_in[38:36]), .out(out[12]) );
mux6 mux_39 ( .in({out_mem_2048x72_sp_0[13], out1_mem_4096x36_dp_0[13], out_mem_4096x36_sp_0[13], out1_mem_9182x18_dp_0[13], out_mem_9182x18_sp_0[13], out2_mem_18194x9_dp_0[4]}), .config_in(config_in[41:39]), .out(out[13]) );
mux6 mux_42 ( .in({out_mem_2048x72_sp_0[14], out1_mem_4096x36_dp_0[14], out_mem_4096x36_sp_0[14], out1_mem_9182x18_dp_0[14], out_mem_9182x18_sp_0[14], out2_mem_18194x9_dp_0[5]}), .config_in(config_in[44:42]), .out(out[14]) );
mux6 mux_45 ( .in({out_mem_2048x72_sp_0[15], out1_mem_4096x36_dp_0[15], out_mem_4096x36_sp_0[15], out1_mem_9182x18_dp_0[15], out_mem_9182x18_sp_0[15], out2_mem_18194x9_dp_0[6]}), .config_in(config_in[47:45]), .out(out[15]) );
mux6 mux_48 ( .in({out_mem_2048x72_sp_0[16], out1_mem_4096x36_dp_0[16], out_mem_4096x36_sp_0[16], out1_mem_9182x18_dp_0[16], out_mem_9182x18_sp_0[16], out2_mem_18194x9_dp_0[7]}), .config_in(config_in[50:48]), .out(out[16]) );
mux6 mux_51 ( .in({out_mem_2048x72_sp_0[17], out1_mem_4096x36_dp_0[17], out_mem_4096x36_sp_0[17], out1_mem_9182x18_dp_0[17], out_mem_9182x18_sp_0[17], out2_mem_18194x9_dp_0[8]}), .config_in(config_in[53:51]), .out(out[17]) );
mux4 mux_54 ( .in({out_mem_2048x72_sp_0[18], out1_mem_4096x36_dp_0[18], out_mem_4096x36_sp_0[18], out2_mem_9182x18_dp_0[0]}), .config_in(config_in[55:54]), .out(out[18]) );
mux4 mux_56 ( .in({out_mem_2048x72_sp_0[19], out1_mem_4096x36_dp_0[19], out_mem_4096x36_sp_0[19], out2_mem_9182x18_dp_0[1]}), .config_in(config_in[57:56]), .out(out[19]) );
mux4 mux_58 ( .in({out_mem_2048x72_sp_0[20], out1_mem_4096x36_dp_0[20], out_mem_4096x36_sp_0[20], out2_mem_9182x18_dp_0[2]}), .config_in(config_in[59:58]), .out(out[20]) );
mux4 mux_60 ( .in({out_mem_2048x72_sp_0[21], out1_mem_4096x36_dp_0[21], out_mem_4096x36_sp_0[21], out2_mem_9182x18_dp_0[3]}), .config_in(config_in[61:60]), .out(out[21]) );
mux4 mux_62 ( .in({out_mem_2048x72_sp_0[22], out1_mem_4096x36_dp_0[22], out_mem_4096x36_sp_0[22], out2_mem_9182x18_dp_0[4]}), .config_in(config_in[63:62]), .out(out[22]) );
mux4 mux_64 ( .in({out_mem_2048x72_sp_0[23], out1_mem_4096x36_dp_0[23], out_mem_4096x36_sp_0[23], out2_mem_9182x18_dp_0[5]}), .config_in(config_in[65:64]), .out(out[23]) );
mux4 mux_66 ( .in({out_mem_2048x72_sp_0[24], out1_mem_4096x36_dp_0[24], out_mem_4096x36_sp_0[24], out2_mem_9182x18_dp_0[6]}), .config_in(config_in[67:66]), .out(out[24]) );
mux4 mux_68 ( .in({out_mem_2048x72_sp_0[25], out1_mem_4096x36_dp_0[25], out_mem_4096x36_sp_0[25], out2_mem_9182x18_dp_0[7]}), .config_in(config_in[69:68]), .out(out[25]) );
mux4 mux_70 ( .in({out_mem_2048x72_sp_0[26], out1_mem_4096x36_dp_0[26], out_mem_4096x36_sp_0[26], out2_mem_9182x18_dp_0[8]}), .config_in(config_in[71:70]), .out(out[26]) );
mux4 mux_72 ( .in({out_mem_2048x72_sp_0[27], out1_mem_4096x36_dp_0[27], out_mem_4096x36_sp_0[27], out2_mem_9182x18_dp_0[9]}), .config_in(config_in[73:72]), .out(out[27]) );
mux4 mux_74 ( .in({out_mem_2048x72_sp_0[28], out1_mem_4096x36_dp_0[28], out_mem_4096x36_sp_0[28], out2_mem_9182x18_dp_0[10]}), .config_in(config_in[75:74]), .out(out[28]) );
mux4 mux_76 ( .in({out_mem_2048x72_sp_0[29], out1_mem_4096x36_dp_0[29], out_mem_4096x36_sp_0[29], out2_mem_9182x18_dp_0[11]}), .config_in(config_in[77:76]), .out(out[29]) );
mux4 mux_78 ( .in({out_mem_2048x72_sp_0[30], out1_mem_4096x36_dp_0[30], out_mem_4096x36_sp_0[30], out2_mem_9182x18_dp_0[12]}), .config_in(config_in[79:78]), .out(out[30]) );
mux4 mux_80 ( .in({out_mem_2048x72_sp_0[31], out1_mem_4096x36_dp_0[31], out_mem_4096x36_sp_0[31], out2_mem_9182x18_dp_0[13]}), .config_in(config_in[81:80]), .out(out[31]) );
mux4 mux_82 ( .in({out_mem_2048x72_sp_0[32], out1_mem_4096x36_dp_0[32], out_mem_4096x36_sp_0[32], out2_mem_9182x18_dp_0[14]}), .config_in(config_in[83:82]), .out(out[32]) );
mux4 mux_84 ( .in({out_mem_2048x72_sp_0[33], out1_mem_4096x36_dp_0[33], out_mem_4096x36_sp_0[33], out2_mem_9182x18_dp_0[15]}), .config_in(config_in[85:84]), .out(out[33]) );
mux4 mux_86 ( .in({out_mem_2048x72_sp_0[34], out1_mem_4096x36_dp_0[34], out_mem_4096x36_sp_0[34], out2_mem_9182x18_dp_0[16]}), .config_in(config_in[87:86]), .out(out[34]) );
mux4 mux_88 ( .in({out_mem_2048x72_sp_0[35], out1_mem_4096x36_dp_0[35], out_mem_4096x36_sp_0[35], out2_mem_9182x18_dp_0[17]}), .config_in(config_in[89:88]), .out(out[35]) );
mux2 mux_90 ( .in({out_mem_2048x72_sp_0[36], out2_mem_4096x36_dp_0[0]}), .config_in(config_in[90:90]), .out(out[36]) );
mux2 mux_91 ( .in({out_mem_2048x72_sp_0[37], out2_mem_4096x36_dp_0[1]}), .config_in(config_in[91:91]), .out(out[37]) );
mux2 mux_92 ( .in({out_mem_2048x72_sp_0[38], out2_mem_4096x36_dp_0[2]}), .config_in(config_in[92:92]), .out(out[38]) );
mux2 mux_93 ( .in({out_mem_2048x72_sp_0[39], out2_mem_4096x36_dp_0[3]}), .config_in(config_in[93:93]), .out(out[39]) );
mux2 mux_94 ( .in({out_mem_2048x72_sp_0[40], out2_mem_4096x36_dp_0[4]}), .config_in(config_in[94:94]), .out(out[40]) );
mux2 mux_95 ( .in({out_mem_2048x72_sp_0[41], out2_mem_4096x36_dp_0[5]}), .config_in(config_in[95:95]), .out(out[41]) );
mux2 mux_96 ( .in({out_mem_2048x72_sp_0[42], out2_mem_4096x36_dp_0[6]}), .config_in(config_in[96:96]), .out(out[42]) );
mux2 mux_97 ( .in({out_mem_2048x72_sp_0[43], out2_mem_4096x36_dp_0[7]}), .config_in(config_in[97:97]), .out(out[43]) );
mux2 mux_98 ( .in({out_mem_2048x72_sp_0[44], out2_mem_4096x36_dp_0[8]}), .config_in(config_in[98:98]), .out(out[44]) );
mux2 mux_99 ( .in({out_mem_2048x72_sp_0[45], out2_mem_4096x36_dp_0[9]}), .config_in(config_in[99:99]), .out(out[45]) );
mux2 mux_100 ( .in({out_mem_2048x72_sp_0[46], out2_mem_4096x36_dp_0[10]}), .config_in(config_in[100:100]), .out(out[46]) );
mux2 mux_101 ( .in({out_mem_2048x72_sp_0[47], out2_mem_4096x36_dp_0[11]}), .config_in(config_in[101:101]), .out(out[47]) );
mux2 mux_102 ( .in({out_mem_2048x72_sp_0[48], out2_mem_4096x36_dp_0[12]}), .config_in(config_in[102:102]), .out(out[48]) );
mux2 mux_103 ( .in({out_mem_2048x72_sp_0[49], out2_mem_4096x36_dp_0[13]}), .config_in(config_in[103:103]), .out(out[49]) );
mux2 mux_104 ( .in({out_mem_2048x72_sp_0[50], out2_mem_4096x36_dp_0[14]}), .config_in(config_in[104:104]), .out(out[50]) );
mux2 mux_105 ( .in({out_mem_2048x72_sp_0[51], out2_mem_4096x36_dp_0[15]}), .config_in(config_in[105:105]), .out(out[51]) );
mux2 mux_106 ( .in({out_mem_2048x72_sp_0[52], out2_mem_4096x36_dp_0[16]}), .config_in(config_in[106:106]), .out(out[52]) );
mux2 mux_107 ( .in({out_mem_2048x72_sp_0[53], out2_mem_4096x36_dp_0[17]}), .config_in(config_in[107:107]), .out(out[53]) );
mux2 mux_108 ( .in({out_mem_2048x72_sp_0[54], out2_mem_4096x36_dp_0[18]}), .config_in(config_in[108:108]), .out(out[54]) );
mux2 mux_109 ( .in({out_mem_2048x72_sp_0[55], out2_mem_4096x36_dp_0[19]}), .config_in(config_in[109:109]), .out(out[55]) );
mux2 mux_110 ( .in({out_mem_2048x72_sp_0[56], out2_mem_4096x36_dp_0[20]}), .config_in(config_in[110:110]), .out(out[56]) );
mux2 mux_111 ( .in({out_mem_2048x72_sp_0[57], out2_mem_4096x36_dp_0[21]}), .config_in(config_in[111:111]), .out(out[57]) );
mux2 mux_112 ( .in({out_mem_2048x72_sp_0[58], out2_mem_4096x36_dp_0[22]}), .config_in(config_in[112:112]), .out(out[58]) );
mux2 mux_113 ( .in({out_mem_2048x72_sp_0[59], out2_mem_4096x36_dp_0[23]}), .config_in(config_in[113:113]), .out(out[59]) );
mux2 mux_114 ( .in({out_mem_2048x72_sp_0[60], out2_mem_4096x36_dp_0[24]}), .config_in(config_in[114:114]), .out(out[60]) );
mux2 mux_115 ( .in({out_mem_2048x72_sp_0[61], out2_mem_4096x36_dp_0[25]}), .config_in(config_in[115:115]), .out(out[61]) );
mux2 mux_116 ( .in({out_mem_2048x72_sp_0[62], out2_mem_4096x36_dp_0[26]}), .config_in(config_in[116:116]), .out(out[62]) );
mux2 mux_117 ( .in({out_mem_2048x72_sp_0[63], out2_mem_4096x36_dp_0[27]}), .config_in(config_in[117:117]), .out(out[63]) );
mux2 mux_118 ( .in({out_mem_2048x72_sp_0[64], out2_mem_4096x36_dp_0[28]}), .config_in(config_in[118:118]), .out(out[64]) );
mux2 mux_119 ( .in({out_mem_2048x72_sp_0[65], out2_mem_4096x36_dp_0[29]}), .config_in(config_in[119:119]), .out(out[65]) );
mux2 mux_120 ( .in({out_mem_2048x72_sp_0[66], out2_mem_4096x36_dp_0[30]}), .config_in(config_in[120:120]), .out(out[66]) );
mux2 mux_121 ( .in({out_mem_2048x72_sp_0[67], out2_mem_4096x36_dp_0[31]}), .config_in(config_in[121:121]), .out(out[67]) );
mux2 mux_122 ( .in({out_mem_2048x72_sp_0[68], out2_mem_4096x36_dp_0[32]}), .config_in(config_in[122:122]), .out(out[68]) );
mux2 mux_123 ( .in({out_mem_2048x72_sp_0[69], out2_mem_4096x36_dp_0[33]}), .config_in(config_in[123:123]), .out(out[69]) );
mux2 mux_124 ( .in({out_mem_2048x72_sp_0[70], out2_mem_4096x36_dp_0[34]}), .config_in(config_in[124:124]), .out(out[70]) );
mux2 mux_125 ( .in({out_mem_2048x72_sp_0[71], out2_mem_4096x36_dp_0[35]}), .config_in(config_in[125:125]), .out(out[71]) );

assign ground = 1'b0;

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
