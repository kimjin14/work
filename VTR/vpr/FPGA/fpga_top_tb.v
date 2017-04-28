//testbench for FPGA/fpga_top.v
`timescale 1 ns / 1 ps


module fpga_top_tb ();

localparam N_INPUTS = 1000;
localparam SEED = 32'hBAADF00D;
localparam CONFIG_BITS = 
		1530'b000000100000100010100001010000010100000101000001010010000000100000001000000010000000000000100000001000000010100000100000001000001000000001000000010111000010100000101000001010000010100000110000001100000011000000110000000001000000010000000101000001000000010100000101100010000001000010000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000010000000100000001000000010000000100100000000000000000000000000000000000000000000000000000000000000000000000100000001000000010000000100000001000000010000000100000001001000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000001000000010000000100000001000000010010000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000010000000100000001000000010000000100100000000000000000000000000000000000000000000000000000000000000000000000100000001000000010000000100000001000000010000000100000001001000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000001000000010000000100000001000000010010000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000010000000100000001000000010000000100100000000000000000000000000000000000000000000000000000000000000000000000100000001000000010000000100000001000000010000000100000001000000010000000011111111011111110111111011111111111111111111101011111111011111111111111110111111111111111111111111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111;

localparam CONFIG_SIZE = 1530;
	reg [1529:0]bitstream = CONFIG_BITS;
	reg top_clk;
	reg top_reset;
	reg top_in;

	wire top_out;

	reg 	fpga_clk;
	reg 	fpga_rst;
	reg 	config_rst;
	reg 	config_clk;
	reg 	config_in;
	reg 	[7:0]io_0_1_wire_reg;
	wire 	[7:0]io_0_1_wire;
	reg 	[7:0]io_1_0_wire_reg;
	wire 	[7:0]io_1_0_wire;
	reg 	[7:0]io_1_2_wire_reg;
	wire 	[7:0]io_1_2_wire;
	reg 	[7:0]io_2_1_wire_reg;
	wire 	[7:0]io_2_1_wire;

	fpga_top dut (
		.fpga_clk(fpga_clk),
		.fpga_rst(fpga_rst),
		.config_rst(config_rst),
		.config_clk(config_clk),
		.config_in(config_in),
		.io_0_1_wire(io_0_1_wire),
		.io_1_0_wire(io_1_0_wire),
		.io_1_2_wire(io_1_2_wire),
		.io_2_1_wire(io_2_1_wire)
	);

	assign io_1_0_wire[0] = io_1_0_wire_reg[0];
	assign io_1_2_wire[3] = io_1_2_wire_reg[3];
	assign io_2_1_wire[1] = io_2_1_wire_reg[1];

	assign top_out = io_1_0_wire[3];
	always begin
		#0.5
		fpga_clk = ~fpga_clk;
		//config_clk = ~config_clk;
	end

	reg [31:0] prod_rand = SEED;
	reg start_cns;
	reg [31:0] count_ovalid;
	reg ovalid;
	integer prod_n;

	initial begin
		start_cns = 0;
		config_rst = 1;
		fpga_clk = 0;
		fpga_rst = 0;
		config_clk = 0;
		count_ovalid = 32'd0;
		#10;

		config_rst = 0;
		fpga_rst = 1;
		for (prod_n = 0; prod_n < N_INPUTS; prod_n = prod_n + 1) begin
			@(negedge fpga_clk);
			start_cns = 1; //start cns when this starts
		count_ovalid = count_ovalid+1;
			if (count_ovalid > 10) begin
				ovalid = 1;
			end
			prod_rand = $random(prod_rand);
			//top_clk
			io_1_0_wire_reg[0] = prod_rand;
			prod_rand = $random(prod_rand);
			//top_reset
			io_1_2_wire_reg[3] = prod_rand;
			prod_rand = $random(prod_rand);
			//top_in
			io_2_1_wire_reg[1] = prod_rand;
		end

	end

	wire 	 out;
	reg 	 out_cns;
	reg 	 out_prod;

	wire 	 clk;
	wire 	 in;
	wire 	 reset;

	fsm cns (
		.clk(fpga_clk),
		.in(in),
		.reset(reset),
		.out(out)
	);

	reg [31:0] cns_rand = SEED;
	reg fail = 1'b0;
	integer cns_n;

		assign clk = fpga_clk;
		assign in = top_in;
		assign reset = top_reset;

	initial begin
		top_clk = 1'b1;
		top_reset = 1'b1;
		top_in = 1'b1;
		for (cns_n = 0; cns_n < N_INPUTS; cns_n = cns_n + 1) begin
			@(negedge fpga_clk);
			while (!start_cns) begin
				@(negedge fpga_clk);
			end
			$display("cycle %d", cns_n);
			cns_rand = $random(cns_rand);
			top_clk = cns_rand;
			cns_rand = $random(cns_rand);
			top_reset = cns_rand;
			cns_rand = $random(cns_rand);
			top_in = cns_rand;

			out_cns = out;
			out_prod = top_out;

			if (ovalid == 1'b1) begin
			if (out_cns != out_prod) begin
				$display("FAIL: Expected %d, Got %d", out_cns, out_prod);
				fail = 1'b1;
			end
			else begin
				$display("SUCCESS: Expected %d, Got %d", out_cns, out_prod);
			end
			end

		end
		$display("%s", fail? "SOME TESTS FAILED" : "ALL TESTS PASSED");
		$stop(0);
	end

endmodule

