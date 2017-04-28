module sixbit (a, b, clk, c);
	input [5:0] a;
	input [5:0] b;
	input clk;
	output[11:0] c;
	
	reg [11:0]c;

always @ (posedge clk) begin
	c <= a*b;
end

endmodule
