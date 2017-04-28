module addshift16 (clk, a, b, z);
	input clk;
	input [15:0] a;
	input [15:0] b;
	output [16:0] z;

	reg [16:0] z;
	
	reg [16:0] z_1;
	reg [16:0] z_2;
	reg [16:0] z_3;
	reg [16:0] z_4;
	
	wire [16:0] aplusb;
	
	always @ (posedge clk) begin

			z_1 <= aplusb;
			z_2 <= z_1;
			z_3 <= z_2;
			z_4 <= z_3;
			z <= z_4;
	end
	
	assign aplusb = a+b;
	
endmodule
