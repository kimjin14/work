module multaccum32 (clk, a, b, c, d, z);
	input clk;
	input [31:0] a;
	input [31:0] b;
	input [31:0] c;
	input [31:0] d;
	output [63:0] z;

	wire [63:0] z1;
	wire [63:0] z2;
	
	reg [63:0] z1_1;
	reg [63:0] z2_1;
	
	always @ (posedge clk) begin

			z1_1 <= z1;
			z2_1 <= z2;

	end
	
	assign z = z1_1 + z2_1;
	assign z1 = a * b;
	assign z2 = c * d;
	
endmodule
