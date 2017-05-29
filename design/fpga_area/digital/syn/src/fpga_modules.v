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
	input config_reset
);

assign io_ext[0] = config_reset?1'bz:(config_in[0]?1'bz:outpad[0]);
assign io_ext[1] = config_reset?1'bz:(config_in[1]?1'bz:outpad[1]);
assign io_ext[2] = config_reset?1'bz:(config_in[2]?1'bz:outpad[2]);
assign io_ext[3] = config_reset?1'bz:(config_in[3]?1'bz:outpad[3]);
assign io_ext[4] = config_reset?1'bz:(config_in[4]?1'bz:outpad[4]);
assign io_ext[5] = config_reset?1'bz:(config_in[5]?1'bz:outpad[5]);
assign io_ext[6] = config_reset?1'bz:(config_in[6]?1'bz:outpad[6]);
assign io_ext[7] = config_reset?1'bz:(config_in[7]?1'bz:outpad[7]);

assign inpad[0] = config_reset?1'bz:(config_in[0]?io_ext[0]:1'bz);
assign inpad[1] = config_reset?1'bz:(config_in[1]?io_ext[1]:1'bz);
assign inpad[2] = config_reset?1'bz:(config_in[2]?io_ext[2]:1'bz);
assign inpad[3] = config_reset?1'bz:(config_in[3]?io_ext[3]:1'bz);
assign inpad[4] = config_reset?1'bz:(config_in[4]?io_ext[4]:1'bz);
assign inpad[5] = config_reset?1'bz:(config_in[5]?io_ext[5]:1'bz);
assign inpad[6] = config_reset?1'bz:(config_in[6]?io_ext[6]:1'bz);
assign inpad[7] = config_reset?1'bz:(config_in[7]?io_ext[7]:1'bz);

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
	output [19:0]O,
	input [1149:0]config_in,
	input config_reset

);

wire ground;
////////child (0,0,0)////////
wire [7:0]in_fle_0;//input to child
wire [0:0]clk_fle_0;//clock to child
wire [1:0]out_fle_0;//output from child
////////child (0,0,1)////////
wire [7:0]in_fle_1;//input to child
wire [0:0]clk_fle_1;//clock to child
wire [1:0]out_fle_1;//output from child
////////child (0,0,2)////////
wire [7:0]in_fle_2;//input to child
wire [0:0]clk_fle_2;//clock to child
wire [1:0]out_fle_2;//output from child
////////child (0,0,3)////////
wire [7:0]in_fle_3;//input to child
wire [0:0]clk_fle_3;//clock to child
wire [1:0]out_fle_3;//output from child
////////child (0,0,4)////////
wire [7:0]in_fle_4;//input to child
wire [0:0]clk_fle_4;//clock to child
wire [1:0]out_fle_4;//output from child
////////child (0,0,5)////////
wire [7:0]in_fle_5;//input to child
wire [0:0]clk_fle_5;//clock to child
wire [1:0]out_fle_5;//output from child
////////child (0,0,6)////////
wire [7:0]in_fle_6;//input to child
wire [0:0]clk_fle_6;//clock to child
wire [1:0]out_fle_6;//output from child
////////child (0,0,7)////////
wire [7:0]in_fle_7;//input to child
wire [0:0]clk_fle_7;//clock to child
wire [1:0]out_fle_7;//output from child
////////child (0,0,8)////////
wire [7:0]in_fle_8;//input to child
wire [0:0]clk_fle_8;//clock to child
wire [1:0]out_fle_8;//output from child
////////child (0,0,9)////////
wire [7:0]in_fle_9;//input to child
wire [0:0]clk_fle_9;//clock to child
wire [1:0]out_fle_9;//output from child
 
mux37 mux_0 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[5:0]), .config_reset(config_reset), .out(in_fle_0[0]) );
mux37 mux_6 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[11:6]), .config_reset(config_reset), .out(in_fle_0[1]) );
mux37 mux_12 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[17:12]), .config_reset(config_reset), .out(in_fle_0[2]) );
mux37 mux_18 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[23:18]), .config_reset(config_reset), .out(in_fle_0[3]) );
mux37 mux_24 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[29:24]), .config_reset(config_reset), .out(in_fle_0[4]) );
mux37 mux_30 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[35:30]), .config_reset(config_reset), .out(in_fle_0[5]) );
mux37 mux_36 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[41:36]), .config_reset(config_reset), .out(in_fle_0[6]) );
mux37 mux_42 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[47:42]), .config_reset(config_reset), .out(in_fle_0[7]) );
assign clk_fle_0[0] = clk[0];
 
fle fle_0 ( .clk(clk_fle_0), .in(in_fle_0), .out(out_fle_0), .config_in(config_in[114:48]), .config_reset(config_reset) ); //block instantiation

mux37 mux_115 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[120:115]), .config_reset(config_reset), .out(in_fle_1[0]) );
mux37 mux_121 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[126:121]), .config_reset(config_reset), .out(in_fle_1[1]) );
mux37 mux_127 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[132:127]), .config_reset(config_reset), .out(in_fle_1[2]) );
mux37 mux_133 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[138:133]), .config_reset(config_reset), .out(in_fle_1[3]) );
mux37 mux_139 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[144:139]), .config_reset(config_reset), .out(in_fle_1[4]) );
mux37 mux_145 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[150:145]), .config_reset(config_reset), .out(in_fle_1[5]) );
mux37 mux_151 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[156:151]), .config_reset(config_reset), .out(in_fle_1[6]) );
mux37 mux_157 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[162:157]), .config_reset(config_reset), .out(in_fle_1[7]) );
assign clk_fle_1[0] = clk[0];
 
fle fle_1 ( .clk(clk_fle_1), .in(in_fle_1), .out(out_fle_1), .config_in(config_in[229:163]), .config_reset(config_reset) ); //block instantiation

mux37 mux_230 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[235:230]), .config_reset(config_reset), .out(in_fle_2[0]) );
mux37 mux_236 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[241:236]), .config_reset(config_reset), .out(in_fle_2[1]) );
mux37 mux_242 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[247:242]), .config_reset(config_reset), .out(in_fle_2[2]) );
mux37 mux_248 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[253:248]), .config_reset(config_reset), .out(in_fle_2[3]) );
mux37 mux_254 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[259:254]), .config_reset(config_reset), .out(in_fle_2[4]) );
mux37 mux_260 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[265:260]), .config_reset(config_reset), .out(in_fle_2[5]) );
mux37 mux_266 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[271:266]), .config_reset(config_reset), .out(in_fle_2[6]) );
mux37 mux_272 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[277:272]), .config_reset(config_reset), .out(in_fle_2[7]) );
assign clk_fle_2[0] = clk[0];
 
fle fle_2 ( .clk(clk_fle_2), .in(in_fle_2), .out(out_fle_2), .config_in(config_in[344:278]), .config_reset(config_reset) ); //block instantiation

mux37 mux_345 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[350:345]), .config_reset(config_reset), .out(in_fle_3[0]) );
mux37 mux_351 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[356:351]), .config_reset(config_reset), .out(in_fle_3[1]) );
mux37 mux_357 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[362:357]), .config_reset(config_reset), .out(in_fle_3[2]) );
mux37 mux_363 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[368:363]), .config_reset(config_reset), .out(in_fle_3[3]) );
mux37 mux_369 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[374:369]), .config_reset(config_reset), .out(in_fle_3[4]) );
mux37 mux_375 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[380:375]), .config_reset(config_reset), .out(in_fle_3[5]) );
mux37 mux_381 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[386:381]), .config_reset(config_reset), .out(in_fle_3[6]) );
mux37 mux_387 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[392:387]), .config_reset(config_reset), .out(in_fle_3[7]) );
assign clk_fle_3[0] = clk[0];
 
fle fle_3 ( .clk(clk_fle_3), .in(in_fle_3), .out(out_fle_3), .config_in(config_in[459:393]), .config_reset(config_reset) ); //block instantiation

mux37 mux_460 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[465:460]), .config_reset(config_reset), .out(in_fle_4[0]) );
mux37 mux_466 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[471:466]), .config_reset(config_reset), .out(in_fle_4[1]) );
mux37 mux_472 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[477:472]), .config_reset(config_reset), .out(in_fle_4[2]) );
mux37 mux_478 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[483:478]), .config_reset(config_reset), .out(in_fle_4[3]) );
mux37 mux_484 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[489:484]), .config_reset(config_reset), .out(in_fle_4[4]) );
mux37 mux_490 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[495:490]), .config_reset(config_reset), .out(in_fle_4[5]) );
mux37 mux_496 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[501:496]), .config_reset(config_reset), .out(in_fle_4[6]) );
mux37 mux_502 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[507:502]), .config_reset(config_reset), .out(in_fle_4[7]) );
assign clk_fle_4[0] = clk[0];
 
fle fle_4 ( .clk(clk_fle_4), .in(in_fle_4), .out(out_fle_4), .config_in(config_in[574:508]), .config_reset(config_reset) ); //block instantiation

mux37 mux_575 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[580:575]), .config_reset(config_reset), .out(in_fle_5[0]) );
mux37 mux_581 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[586:581]), .config_reset(config_reset), .out(in_fle_5[1]) );
mux37 mux_587 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[592:587]), .config_reset(config_reset), .out(in_fle_5[2]) );
mux37 mux_593 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[598:593]), .config_reset(config_reset), .out(in_fle_5[3]) );
mux37 mux_599 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[604:599]), .config_reset(config_reset), .out(in_fle_5[4]) );
mux37 mux_605 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[610:605]), .config_reset(config_reset), .out(in_fle_5[5]) );
mux37 mux_611 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[616:611]), .config_reset(config_reset), .out(in_fle_5[6]) );
mux37 mux_617 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[622:617]), .config_reset(config_reset), .out(in_fle_5[7]) );
assign clk_fle_5[0] = clk[0];
 
fle fle_5 ( .clk(clk_fle_5), .in(in_fle_5), .out(out_fle_5), .config_in(config_in[689:623]), .config_reset(config_reset) ); //block instantiation

mux37 mux_690 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[695:690]), .config_reset(config_reset), .out(in_fle_6[0]) );
mux37 mux_696 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[701:696]), .config_reset(config_reset), .out(in_fle_6[1]) );
mux37 mux_702 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[707:702]), .config_reset(config_reset), .out(in_fle_6[2]) );
mux37 mux_708 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[713:708]), .config_reset(config_reset), .out(in_fle_6[3]) );
mux37 mux_714 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[719:714]), .config_reset(config_reset), .out(in_fle_6[4]) );
mux37 mux_720 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[725:720]), .config_reset(config_reset), .out(in_fle_6[5]) );
mux37 mux_726 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[731:726]), .config_reset(config_reset), .out(in_fle_6[6]) );
mux37 mux_732 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[737:732]), .config_reset(config_reset), .out(in_fle_6[7]) );
assign clk_fle_6[0] = clk[0];
 
fle fle_6 ( .clk(clk_fle_6), .in(in_fle_6), .out(out_fle_6), .config_in(config_in[804:738]), .config_reset(config_reset) ); //block instantiation

mux37 mux_805 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[810:805]), .config_reset(config_reset), .out(in_fle_7[0]) );
mux37 mux_811 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[816:811]), .config_reset(config_reset), .out(in_fle_7[1]) );
mux37 mux_817 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[822:817]), .config_reset(config_reset), .out(in_fle_7[2]) );
mux37 mux_823 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[828:823]), .config_reset(config_reset), .out(in_fle_7[3]) );
mux37 mux_829 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[834:829]), .config_reset(config_reset), .out(in_fle_7[4]) );
mux37 mux_835 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[840:835]), .config_reset(config_reset), .out(in_fle_7[5]) );
mux37 mux_841 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[846:841]), .config_reset(config_reset), .out(in_fle_7[6]) );
mux37 mux_847 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[852:847]), .config_reset(config_reset), .out(in_fle_7[7]) );
assign clk_fle_7[0] = clk[0];
 
fle fle_7 ( .clk(clk_fle_7), .in(in_fle_7), .out(out_fle_7), .config_in(config_in[919:853]), .config_reset(config_reset) ); //block instantiation

mux37 mux_920 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[925:920]), .config_reset(config_reset), .out(in_fle_8[0]) );
mux37 mux_926 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[931:926]), .config_reset(config_reset), .out(in_fle_8[1]) );
mux37 mux_932 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[937:932]), .config_reset(config_reset), .out(in_fle_8[2]) );
mux37 mux_938 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[943:938]), .config_reset(config_reset), .out(in_fle_8[3]) );
mux37 mux_944 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[949:944]), .config_reset(config_reset), .out(in_fle_8[4]) );
mux37 mux_950 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[955:950]), .config_reset(config_reset), .out(in_fle_8[5]) );
mux37 mux_956 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[961:956]), .config_reset(config_reset), .out(in_fle_8[6]) );
mux37 mux_962 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[967:962]), .config_reset(config_reset), .out(in_fle_8[7]) );
assign clk_fle_8[0] = clk[0];
 
fle fle_8 ( .clk(clk_fle_8), .in(in_fle_8), .out(out_fle_8), .config_in(config_in[1034:968]), .config_reset(config_reset) ); //block instantiation

mux37 mux_1035 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[1040:1035]), .config_reset(config_reset), .out(in_fle_9[0]) );
mux37 mux_1041 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[1046:1041]), .config_reset(config_reset), .out(in_fle_9[1]) );
mux37 mux_1047 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[1052:1047]), .config_reset(config_reset), .out(in_fle_9[2]) );
mux37 mux_1053 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[1058:1053]), .config_reset(config_reset), .out(in_fle_9[3]) );
mux37 mux_1059 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[1064:1059]), .config_reset(config_reset), .out(in_fle_9[4]) );
mux37 mux_1065 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[1070:1065]), .config_reset(config_reset), .out(in_fle_9[5]) );
mux37 mux_1071 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[1076:1071]), .config_reset(config_reset), .out(in_fle_9[6]) );
mux37 mux_1077 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[1082:1077]), .config_reset(config_reset), .out(in_fle_9[7]) );
assign clk_fle_9[0] = clk[0];
 
fle fle_9 ( .clk(clk_fle_9), .in(in_fle_9), .out(out_fle_9), .config_in(config_in[1149:1083]), .config_reset(config_reset) ); //block instantiation

//child output to block output
assign O[0] = out_fle_0[0];
assign O[1] = out_fle_1[0];
assign O[2] = out_fle_2[0];
assign O[3] = out_fle_3[0];
assign O[4] = out_fle_4[0];
assign O[5] = out_fle_5[0];
assign O[6] = out_fle_6[0];
assign O[7] = out_fle_7[0];
assign O[8] = out_fle_8[0];
assign O[9] = out_fle_9[0];
assign O[10] = out_fle_0[1];
assign O[11] = out_fle_1[1];
assign O[12] = out_fle_2[1];
assign O[13] = out_fle_3[1];
assign O[14] = out_fle_4[1];
assign O[15] = out_fle_5[1];
assign O[16] = out_fle_6[1];
assign O[17] = out_fle_7[1];
assign O[18] = out_fle_8[1];
assign O[19] = out_fle_9[1];

assign ground = 1'b0;

endmodule


