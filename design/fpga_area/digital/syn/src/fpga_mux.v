module mux2 (
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

module mux2_long (
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

module mux3 (
	input [2:0]in,
	input [1:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			2'd0: out = in[0];
			2'd1: out = in[1];
			2'd2: out = in[2];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux3_long (
	input [2:0]in,
	input [1:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			2'd0: out = in[0];
			2'd1: out = in[1];
			2'd2: out = in[2];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux4 (
	input [3:0]in,
	input [1:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			2'd0: out = in[0];
			2'd1: out = in[1];
			2'd2: out = in[2];
			2'd3: out = in[3];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux4_long (
	input [3:0]in,
	input [1:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			2'd0: out = in[0];
			2'd1: out = in[1];
			2'd2: out = in[2];
			2'd3: out = in[3];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux5 (
	input [4:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux5_long (
	input [4:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux6 (
	input [5:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux6_long (
	input [5:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux7 (
	input [6:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			3'd6: out = in[6];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux7_long (
	input [6:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			3'd6: out = in[6];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux8 (
	input [7:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			3'd6: out = in[6];
			3'd7: out = in[7];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux8_long (
	input [7:0]in,
	input [2:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			3'd0: out = in[0];
			3'd1: out = in[1];
			3'd2: out = in[2];
			3'd3: out = in[3];
			3'd4: out = in[4];
			3'd5: out = in[5];
			3'd6: out = in[6];
			3'd7: out = in[7];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux9 (
	input [8:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux9_long (
	input [8:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux10 (
	input [9:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux10_long (
	input [9:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux11 (
	input [10:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux11_long (
	input [10:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux12 (
	input [11:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux12_long (
	input [11:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux13 (
	input [12:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux13_long (
	input [12:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux14 (
	input [13:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux14_long (
	input [13:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux15 (
	input [14:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			4'd14: out = in[14];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux15_long (
	input [14:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			4'd14: out = in[14];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux16 (
	input [15:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			4'd14: out = in[14];
			4'd15: out = in[15];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux16_long (
	input [15:0]in,
	input [3:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			4'd0: out = in[0];
			4'd1: out = in[1];
			4'd2: out = in[2];
			4'd3: out = in[3];
			4'd4: out = in[4];
			4'd5: out = in[5];
			4'd6: out = in[6];
			4'd7: out = in[7];
			4'd8: out = in[8];
			4'd9: out = in[9];
			4'd10: out = in[10];
			4'd11: out = in[11];
			4'd12: out = in[12];
			4'd13: out = in[13];
			4'd14: out = in[14];
			4'd15: out = in[15];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux17 (
	input [16:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux17_long (
	input [16:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux18 (
	input [17:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux18_long (
	input [17:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux19 (
	input [18:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux19_long (
	input [18:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux20 (
	input [19:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux20_long (
	input [19:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux21 (
	input [20:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux21_long (
	input [20:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux22 (
	input [21:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux22_long (
	input [21:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux23 (
	input [22:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux23_long (
	input [22:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux24 (
	input [23:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux24_long (
	input [23:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux25 (
	input [24:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux25_long (
	input [24:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux26 (
	input [25:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux26_long (
	input [25:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux27 (
	input [26:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux27_long (
	input [26:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux28 (
	input [27:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux28_long (
	input [27:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux29 (
	input [28:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux29_long (
	input [28:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux30 (
	input [29:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux30_long (
	input [29:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux31 (
	input [30:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			5'd30: out = in[30];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux31_long (
	input [30:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			5'd30: out = in[30];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux32 (
	input [31:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			5'd30: out = in[30];
			5'd31: out = in[31];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux32_long (
	input [31:0]in,
	input [4:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			5'd0: out = in[0];
			5'd1: out = in[1];
			5'd2: out = in[2];
			5'd3: out = in[3];
			5'd4: out = in[4];
			5'd5: out = in[5];
			5'd6: out = in[6];
			5'd7: out = in[7];
			5'd8: out = in[8];
			5'd9: out = in[9];
			5'd10: out = in[10];
			5'd11: out = in[11];
			5'd12: out = in[12];
			5'd13: out = in[13];
			5'd14: out = in[14];
			5'd15: out = in[15];
			5'd16: out = in[16];
			5'd17: out = in[17];
			5'd18: out = in[18];
			5'd19: out = in[19];
			5'd20: out = in[20];
			5'd21: out = in[21];
			5'd22: out = in[22];
			5'd23: out = in[23];
			5'd24: out = in[24];
			5'd25: out = in[25];
			5'd26: out = in[26];
			5'd27: out = in[27];
			5'd28: out = in[28];
			5'd29: out = in[29];
			5'd30: out = in[30];
			5'd31: out = in[31];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux33 (
	input [32:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux33_long (
	input [32:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux34 (
	input [33:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux34_long (
	input [33:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux35 (
	input [34:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux35_long (
	input [34:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux36 (
	input [35:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			6'd35: out = in[35];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux36_long (
	input [35:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			6'd35: out = in[35];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux37 (
	input [36:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			6'd35: out = in[35];
			6'd36: out = in[36];
			default: out = 1'b1;
		endcase
	end
end

endmodule

module mux37_long (
	input [36:0]in,
	input [5:0]config_in,
	input config_reset,
	output reg out
);

always @ (*) begin
	if (config_reset) begin
		out = 1'b1;
	end else begin
		case(config_in)
			6'd0: out = in[0];
			6'd1: out = in[1];
			6'd2: out = in[2];
			6'd3: out = in[3];
			6'd4: out = in[4];
			6'd5: out = in[5];
			6'd6: out = in[6];
			6'd7: out = in[7];
			6'd8: out = in[8];
			6'd9: out = in[9];
			6'd10: out = in[10];
			6'd11: out = in[11];
			6'd12: out = in[12];
			6'd13: out = in[13];
			6'd14: out = in[14];
			6'd15: out = in[15];
			6'd16: out = in[16];
			6'd17: out = in[17];
			6'd18: out = in[18];
			6'd19: out = in[19];
			6'd20: out = in[20];
			6'd21: out = in[21];
			6'd22: out = in[22];
			6'd23: out = in[23];
			6'd24: out = in[24];
			6'd25: out = in[25];
			6'd26: out = in[26];
			6'd27: out = in[27];
			6'd28: out = in[28];
			6'd29: out = in[29];
			6'd30: out = in[30];
			6'd31: out = in[31];
			6'd32: out = in[32];
			6'd33: out = in[33];
			6'd34: out = in[34];
			6'd35: out = in[35];
			6'd36: out = in[36];
			default: out = 1'b1;
		endcase
	end
end

endmodule

