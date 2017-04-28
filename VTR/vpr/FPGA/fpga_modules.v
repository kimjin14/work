//////////////////////////////////
//physical block modules
//////////////////////////////////

/////////////////////////////////////////////////////
///////////////////// io /////////////////////////
/////////////////////////////////////////////////////
module io (
	input [7:0]outpad,
	output [7:0]inpad,
	inout [7:0]io_ext,
	input [7:0]config_in,
	input config_rst
);

assign io_ext[0] = config_rst?1'bz:(config_in[0]?1'bz:outpad[0]);
assign io_ext[1] = config_rst?1'bz:(config_in[1]?1'bz:outpad[1]);
assign io_ext[2] = config_rst?1'bz:(config_in[2]?1'bz:outpad[2]);
assign io_ext[3] = config_rst?1'bz:(config_in[3]?1'bz:outpad[3]);
assign io_ext[4] = config_rst?1'bz:(config_in[4]?1'bz:outpad[4]);
assign io_ext[5] = config_rst?1'bz:(config_in[5]?1'bz:outpad[5]);
assign io_ext[6] = config_rst?1'bz:(config_in[6]?1'bz:outpad[6]);
assign io_ext[7] = config_rst?1'bz:(config_in[7]?1'bz:outpad[7]);

assign inpad[0] = config_rst?1'bz:(config_in[0]?io_ext[0]:1'bz);
assign inpad[1] = config_rst?1'bz:(config_in[1]?io_ext[1]:1'bz);
assign inpad[2] = config_rst?1'bz:(config_in[2]?io_ext[2]:1'bz);
assign inpad[3] = config_rst?1'bz:(config_in[3]?io_ext[3]:1'bz);
assign inpad[4] = config_rst?1'bz:(config_in[4]?io_ext[4]:1'bz);
assign inpad[5] = config_rst?1'bz:(config_in[5]?io_ext[5]:1'bz);
assign inpad[6] = config_rst?1'bz:(config_in[6]?io_ext[6]:1'bz);
assign inpad[7] = config_rst?1'bz:(config_in[7]?io_ext[7]:1'bz);

endmodule

/////////////////////////////////////////////////////
///////////////////// ble6 /////////////////////////
/////////////////////////////////////////////////////
module ble6 (
	input [5:0]in,
	input [0:0]clk,
	input reset,
	output [1:0]out,
	input [65:0]config_in,
	input config_rst

);

wire ground;
////////child (0,0,0)////////
wire [5:0]in_lut6_0;//input to child
wire [0:0]out_lut6_0;//output from child
 
////////child (0,1,0)////////
wire [0:0]D_ff_0;//input to child
wire [0:0]clk_ff_0;//clock to child
wire [0:0]Q_ff_0;//output from child
 
assign in_lut6_0[0] = in[0];
assign in_lut6_0[1] = in[1];
assign in_lut6_0[2] = in[2];
assign in_lut6_0[3] = in[3];
assign in_lut6_0[4] = in[4];
assign in_lut6_0[5] = in[5];
 
lut6 lut6_0 ( .in(in_lut6_0), .out(out_lut6_0), .config_in(config_in[63:0]), .config_rst(config_rst) ); //block instantiation

assign D_ff_0[0] = out_lut6_0[0];
assign clk_ff_0[0] = clk[0];
 
ff ff_0 ( .clk(clk_ff_0), .reset(reset), .D(D_ff_0), .Q(Q_ff_0) );

//child output to block output
mux2 mux_64 ( .in({Q_ff_0[0], out_lut6_0[0]}), .config_in(config_in[64:64]), .config_rst(config_rst), .out(out[0]) );
mux2 mux_65 ( .in({Q_ff_0[0], out_lut6_0[0]}), .config_in(config_in[65:65]), .config_rst(config_rst), .out(out[1]) );

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// nfle /////////////////////////
/////////////////////////////////////////////////////
module nfle (
	input [7:0]in,
	input [0:0]clk,
	input reset,
	output [3:0]out,
	input [131:0]config_in,
	input config_rst

);

wire ground;
////////child (0,0,0)////////
wire [5:0]in_ble6_0;//input to child
wire [0:0]clk_ble6_0;//clock to child
wire [1:0]out_ble6_0;//output from child
////////child (0,0,1)////////
wire [5:0]in_ble6_1;//input to child
wire [0:0]clk_ble6_1;//clock to child
wire [1:0]out_ble6_1;//output from child
 
assign in_ble6_0[0] = in[0];
assign in_ble6_0[1] = in[1];
assign in_ble6_0[2] = in[2];
assign in_ble6_0[3] = in[3];
assign in_ble6_0[4] = in[6];
assign in_ble6_0[5] = in[7];
assign clk_ble6_0[0] = clk[0];
 
ble6 ble6_0 ( .clk(clk_ble6_0), .reset(reset), .in(in_ble6_0), .out(out_ble6_0), .config_in(config_in[65:0]), .config_rst(config_rst) ); //block instantiation

assign in_ble6_1[0] = in[0];
assign in_ble6_1[1] = in[1];
assign in_ble6_1[2] = in[2];
assign in_ble6_1[3] = in[3];
assign in_ble6_1[4] = in[6];
assign in_ble6_1[5] = in[7];
assign clk_ble6_1[0] = clk[0];
 
ble6 ble6_1 ( .clk(clk_ble6_1), .reset(reset), .in(in_ble6_1), .out(out_ble6_1), .config_in(config_in[131:66]), .config_rst(config_rst) ); //block instantiation

//child output to block output
assign out[0] = out_ble6_0[0];
assign out[1] = out_ble6_1[0];
assign out[2] = out_ble6_0[1];
assign out[3] = out_ble6_1[1];

assign ground = 1'b0;

endmodule


/////////////////////////////////////////////////////
///////////////////// clb /////////////////////////
/////////////////////////////////////////////////////
module clb (
	input [12:0]I1,
	input [12:0]I2,
	input [12:0]I3,
	input [12:0]I4,
	input [0:0]clk,
	input reset,
	output [19:0]O,
	input [1959:0]config_in,
	input config_rst

);

wire ground;
////////child (0,0,0)////////
wire [7:0]in_nfle_0;//input to child
wire [0:0]clk_nfle_0;//clock to child
wire [3:0]out_nfle_0;//output from child
////////child (0,0,1)////////
wire [7:0]in_nfle_1;//input to child
wire [0:0]clk_nfle_1;//clock to child
wire [3:0]out_nfle_1;//output from child
////////child (0,0,2)////////
wire [7:0]in_nfle_2;//input to child
wire [0:0]clk_nfle_2;//clock to child
wire [3:0]out_nfle_2;//output from child
////////child (0,0,3)////////
wire [7:0]in_nfle_3;//input to child
wire [0:0]clk_nfle_3;//clock to child
wire [3:0]out_nfle_3;//output from child
////////child (0,0,4)////////
wire [7:0]in_nfle_4;//input to child
wire [0:0]clk_nfle_4;//clock to child
wire [3:0]out_nfle_4;//output from child
////////child (0,0,5)////////
wire [7:0]in_nfle_5;//input to child
wire [0:0]clk_nfle_5;//clock to child
wire [3:0]out_nfle_5;//output from child
////////child (0,0,6)////////
wire [7:0]in_nfle_6;//input to child
wire [0:0]clk_nfle_6;//clock to child
wire [3:0]out_nfle_6;//output from child
////////child (0,0,7)////////
wire [7:0]in_nfle_7;//input to child
wire [0:0]clk_nfle_7;//clock to child
wire [3:0]out_nfle_7;//output from child
////////child (0,0,8)////////
wire [7:0]in_nfle_8;//input to child
wire [0:0]clk_nfle_8;//clock to child
wire [3:0]out_nfle_8;//output from child
////////child (0,0,9)////////
wire [7:0]in_nfle_9;//input to child
wire [0:0]clk_nfle_9;//clock to child
wire [3:0]out_nfle_9;//output from child
 
mux37 mux_0 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[7:0]), .config_rst(config_rst), .out(in_nfle_0[0]) );
mux37 mux_8 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[15:8]), .config_rst(config_rst), .out(in_nfle_0[1]) );
mux37 mux_16 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[23:16]), .config_rst(config_rst), .out(in_nfle_0[2]) );
mux37 mux_24 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[31:24]), .config_rst(config_rst), .out(in_nfle_0[3]) );
mux37 mux_32 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[39:32]), .config_rst(config_rst), .out(in_nfle_0[4]) );
mux37 mux_40 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[47:40]), .config_rst(config_rst), .out(in_nfle_0[5]) );
mux37 mux_48 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[55:48]), .config_rst(config_rst), .out(in_nfle_0[6]) );
mux37 mux_56 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[63:56]), .config_rst(config_rst), .out(in_nfle_0[7]) );
assign clk_nfle_0[0] = clk[0];
 
nfle nfle_0 ( .clk(clk_nfle_0), .reset(reset), .in(in_nfle_0), .out(out_nfle_0), .config_in(config_in[195:64]), .config_rst(config_rst) ); //block instantiation

mux37 mux_196 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[203:196]), .config_rst(config_rst), .out(in_nfle_1[0]) );
mux37 mux_204 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[211:204]), .config_rst(config_rst), .out(in_nfle_1[1]) );
mux37 mux_212 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[219:212]), .config_rst(config_rst), .out(in_nfle_1[2]) );
mux37 mux_220 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[227:220]), .config_rst(config_rst), .out(in_nfle_1[3]) );
mux37 mux_228 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[235:228]), .config_rst(config_rst), .out(in_nfle_1[4]) );
mux37 mux_236 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[243:236]), .config_rst(config_rst), .out(in_nfle_1[5]) );
mux37 mux_244 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[251:244]), .config_rst(config_rst), .out(in_nfle_1[6]) );
mux37 mux_252 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[259:252]), .config_rst(config_rst), .out(in_nfle_1[7]) );
assign clk_nfle_1[0] = clk[0];
 
nfle nfle_1 ( .clk(clk_nfle_1), .reset(reset), .in(in_nfle_1), .out(out_nfle_1), .config_in(config_in[391:260]), .config_rst(config_rst) ); //block instantiation

mux37 mux_392 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[399:392]), .config_rst(config_rst), .out(in_nfle_2[0]) );
mux37 mux_400 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[407:400]), .config_rst(config_rst), .out(in_nfle_2[1]) );
mux37 mux_408 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[415:408]), .config_rst(config_rst), .out(in_nfle_2[2]) );
mux37 mux_416 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[423:416]), .config_rst(config_rst), .out(in_nfle_2[3]) );
mux37 mux_424 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[431:424]), .config_rst(config_rst), .out(in_nfle_2[4]) );
mux37 mux_432 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[439:432]), .config_rst(config_rst), .out(in_nfle_2[5]) );
mux37 mux_440 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[447:440]), .config_rst(config_rst), .out(in_nfle_2[6]) );
mux37 mux_448 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[455:448]), .config_rst(config_rst), .out(in_nfle_2[7]) );
assign clk_nfle_2[0] = clk[0];
 
nfle nfle_2 ( .clk(clk_nfle_2), .reset(reset), .in(in_nfle_2), .out(out_nfle_2), .config_in(config_in[587:456]), .config_rst(config_rst) ); //block instantiation

mux37 mux_588 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[595:588]), .config_rst(config_rst), .out(in_nfle_3[0]) );
mux37 mux_596 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[603:596]), .config_rst(config_rst), .out(in_nfle_3[1]) );
mux37 mux_604 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[611:604]), .config_rst(config_rst), .out(in_nfle_3[2]) );
mux37 mux_612 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[619:612]), .config_rst(config_rst), .out(in_nfle_3[3]) );
mux37 mux_620 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[627:620]), .config_rst(config_rst), .out(in_nfle_3[4]) );
mux37 mux_628 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[635:628]), .config_rst(config_rst), .out(in_nfle_3[5]) );
mux37 mux_636 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[643:636]), .config_rst(config_rst), .out(in_nfle_3[6]) );
mux37 mux_644 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[651:644]), .config_rst(config_rst), .out(in_nfle_3[7]) );
assign clk_nfle_3[0] = clk[0];
 
nfle nfle_3 ( .clk(clk_nfle_3), .reset(reset), .in(in_nfle_3), .out(out_nfle_3), .config_in(config_in[783:652]), .config_rst(config_rst) ); //block instantiation

mux37 mux_784 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[791:784]), .config_rst(config_rst), .out(in_nfle_4[0]) );
mux37 mux_792 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[799:792]), .config_rst(config_rst), .out(in_nfle_4[1]) );
mux37 mux_800 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[807:800]), .config_rst(config_rst), .out(in_nfle_4[2]) );
mux37 mux_808 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[815:808]), .config_rst(config_rst), .out(in_nfle_4[3]) );
mux37 mux_816 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[823:816]), .config_rst(config_rst), .out(in_nfle_4[4]) );
mux37 mux_824 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[831:824]), .config_rst(config_rst), .out(in_nfle_4[5]) );
mux37 mux_832 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[839:832]), .config_rst(config_rst), .out(in_nfle_4[6]) );
mux37 mux_840 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[847:840]), .config_rst(config_rst), .out(in_nfle_4[7]) );
assign clk_nfle_4[0] = clk[0];
 
nfle nfle_4 ( .clk(clk_nfle_4), .reset(reset), .in(in_nfle_4), .out(out_nfle_4), .config_in(config_in[979:848]), .config_rst(config_rst) ); //block instantiation

mux37 mux_980 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[987:980]), .config_rst(config_rst), .out(in_nfle_5[0]) );
mux37 mux_988 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[995:988]), .config_rst(config_rst), .out(in_nfle_5[1]) );
mux37 mux_996 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1003:996]), .config_rst(config_rst), .out(in_nfle_5[2]) );
mux37 mux_1004 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1011:1004]), .config_rst(config_rst), .out(in_nfle_5[3]) );
mux37 mux_1012 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1019:1012]), .config_rst(config_rst), .out(in_nfle_5[4]) );
mux37 mux_1020 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1027:1020]), .config_rst(config_rst), .out(in_nfle_5[5]) );
mux37 mux_1028 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1035:1028]), .config_rst(config_rst), .out(in_nfle_5[6]) );
mux37 mux_1036 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1043:1036]), .config_rst(config_rst), .out(in_nfle_5[7]) );
assign clk_nfle_5[0] = clk[0];
 
nfle nfle_5 ( .clk(clk_nfle_5), .reset(reset), .in(in_nfle_5), .out(out_nfle_5), .config_in(config_in[1175:1044]), .config_rst(config_rst) ); //block instantiation

mux37 mux_1176 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1183:1176]), .config_rst(config_rst), .out(in_nfle_6[0]) );
mux37 mux_1184 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1191:1184]), .config_rst(config_rst), .out(in_nfle_6[1]) );
mux37 mux_1192 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1199:1192]), .config_rst(config_rst), .out(in_nfle_6[2]) );
mux37 mux_1200 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1207:1200]), .config_rst(config_rst), .out(in_nfle_6[3]) );
mux37 mux_1208 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1215:1208]), .config_rst(config_rst), .out(in_nfle_6[4]) );
mux37 mux_1216 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1223:1216]), .config_rst(config_rst), .out(in_nfle_6[5]) );
mux37 mux_1224 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1231:1224]), .config_rst(config_rst), .out(in_nfle_6[6]) );
mux37 mux_1232 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1239:1232]), .config_rst(config_rst), .out(in_nfle_6[7]) );
assign clk_nfle_6[0] = clk[0];
 
nfle nfle_6 ( .clk(clk_nfle_6), .reset(reset), .in(in_nfle_6), .out(out_nfle_6), .config_in(config_in[1371:1240]), .config_rst(config_rst) ); //block instantiation

mux37 mux_1372 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1379:1372]), .config_rst(config_rst), .out(in_nfle_7[0]) );
mux37 mux_1380 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1387:1380]), .config_rst(config_rst), .out(in_nfle_7[1]) );
mux37 mux_1388 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1395:1388]), .config_rst(config_rst), .out(in_nfle_7[2]) );
mux37 mux_1396 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1403:1396]), .config_rst(config_rst), .out(in_nfle_7[3]) );
mux37 mux_1404 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1411:1404]), .config_rst(config_rst), .out(in_nfle_7[4]) );
mux37 mux_1412 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1419:1412]), .config_rst(config_rst), .out(in_nfle_7[5]) );
mux37 mux_1420 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1427:1420]), .config_rst(config_rst), .out(in_nfle_7[6]) );
mux37 mux_1428 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1435:1428]), .config_rst(config_rst), .out(in_nfle_7[7]) );
assign clk_nfle_7[0] = clk[0];
 
nfle nfle_7 ( .clk(clk_nfle_7), .reset(reset), .in(in_nfle_7), .out(out_nfle_7), .config_in(config_in[1567:1436]), .config_rst(config_rst) ); //block instantiation

mux37 mux_1568 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1575:1568]), .config_rst(config_rst), .out(in_nfle_8[0]) );
mux37 mux_1576 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1583:1576]), .config_rst(config_rst), .out(in_nfle_8[1]) );
mux37 mux_1584 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1591:1584]), .config_rst(config_rst), .out(in_nfle_8[2]) );
mux37 mux_1592 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1599:1592]), .config_rst(config_rst), .out(in_nfle_8[3]) );
mux37 mux_1600 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1607:1600]), .config_rst(config_rst), .out(in_nfle_8[4]) );
mux37 mux_1608 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1615:1608]), .config_rst(config_rst), .out(in_nfle_8[5]) );
mux37 mux_1616 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1623:1616]), .config_rst(config_rst), .out(in_nfle_8[6]) );
mux37 mux_1624 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1631:1624]), .config_rst(config_rst), .out(in_nfle_8[7]) );
assign clk_nfle_8[0] = clk[0];
 
nfle nfle_8 ( .clk(clk_nfle_8), .reset(reset), .in(in_nfle_8), .out(out_nfle_8), .config_in(config_in[1763:1632]), .config_rst(config_rst) ); //block instantiation

mux37 mux_1764 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1771:1764]), .config_rst(config_rst), .out(in_nfle_9[0]) );
mux37 mux_1772 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1779:1772]), .config_rst(config_rst), .out(in_nfle_9[1]) );
mux37 mux_1780 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1787:1780]), .config_rst(config_rst), .out(in_nfle_9[2]) );
mux37 mux_1788 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1795:1788]), .config_rst(config_rst), .out(in_nfle_9[3]) );
mux37 mux_1796 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1803:1796]), .config_rst(config_rst), .out(in_nfle_9[4]) );
mux37 mux_1804 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_6[0], out_nfle_6[1], out_nfle_7[0], out_nfle_7[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1811:1804]), .config_rst(config_rst), .out(in_nfle_9[5]) );
mux37 mux_1812 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_nfle_0[0], out_nfle_0[1], out_nfle_1[0], out_nfle_1[1], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_8[0], out_nfle_8[1], ground}), .config_in(config_in[1819:1812]), .config_rst(config_rst), .out(in_nfle_9[6]) );
mux37 mux_1820 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_nfle_2[0], out_nfle_2[1], out_nfle_3[0], out_nfle_3[1], out_nfle_4[0], out_nfle_4[1], out_nfle_5[0], out_nfle_5[1], out_nfle_9[0], out_nfle_9[1], ground}), .config_in(config_in[1827:1820]), .config_rst(config_rst), .out(in_nfle_9[7]) );
assign clk_nfle_9[0] = clk[0];
 
nfle nfle_9 ( .clk(clk_nfle_9), .reset(reset), .in(in_nfle_9), .out(out_nfle_9), .config_in(config_in[1959:1828]), .config_rst(config_rst) ); //block instantiation

//child output to block output
assign O[0] = out_nfle_0[2];
assign O[1] = out_nfle_1[2];
assign O[2] = out_nfle_2[2];
assign O[3] = out_nfle_3[2];
assign O[4] = out_nfle_4[2];
assign O[5] = out_nfle_5[2];
assign O[6] = out_nfle_6[2];
assign O[7] = out_nfle_7[2];
assign O[8] = out_nfle_8[2];
assign O[9] = out_nfle_9[2];
assign O[10] = out_nfle_0[3];
assign O[11] = out_nfle_1[3];
assign O[12] = out_nfle_2[3];
assign O[13] = out_nfle_3[3];
assign O[14] = out_nfle_4[3];
assign O[15] = out_nfle_5[3];
assign O[16] = out_nfle_6[3];
assign O[17] = out_nfle_7[3];
assign O[18] = out_nfle_8[3];
assign O[19] = out_nfle_9[3];

assign ground = 1'b0;

endmodule


