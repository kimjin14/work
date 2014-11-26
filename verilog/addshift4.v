module addshift4 (clk, a, b, z);
	input clk;
	input [3:0] a;
	input [3:0] b;
	output [4:0] z;

	reg [4:0] z;
	
	reg [4:0] z_1;
	reg [4:0] z_2;
	reg [4:0] z_3;
	reg [4:0] z_4;
	
	wire [4:0] aplusb;
	
	always @ (posedge clk) begin

			z_1 <= aplusb;
			z_2 <= z_1;
			z_3 <= z_2;
			z_4 <= z_3;
			z <= z_4;
	end
	
	assign aplusb = a+b;
	
endmodule
