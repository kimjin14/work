//find pattern 101
module fsm (clk, in, reset, out);
	input clk;
	input in;
	input reset;
	output out;

	reg out;

	reg [2:0] state;
	reg [2:0] state_next;
	
	always @ (*) begin
		case(state)
			3'b000: begin
				if (in == 1'b1) begin
					state_next = 3'b001;
				end else begin
					state_next = 3'b000;
				end
				out = 1'b0;
			end
			3'b001: begin
				if (in == 1'b1) begin
					state_next = 3'b011;
				end else begin
					state_next = 3'b010;
				end
				out = 1'b0;
			end
			3'b011: begin
				if (in == 1'b1) begin
					state_next = 3'b111;
				end else begin
					state_next = 3'b110;
				end
				out = 1'b0;
			end
			3'b010: begin
				if (in == 1'b1) begin
					state_next = 3'b101;
				end else begin
					state_next = 3'b100;
				end
				out = 1'b0;
			end
			3'b111: begin
				if (in == 1'b1) begin
					state_next = 3'b111;
				end else begin
					state_next = 3'b110;
				end
				out = 1'b0;
			end
			3'b110: begin
				if (in == 1'b1) begin
					state_next = 3'b101;
				end else begin
					state_next = 3'b100;
				end
				out = 1'b0;
			end
			3'b101: begin
				if (in == 1'b1) begin
					state_next = 3'b011;
				end else begin
					state_next = 3'b010;
				end
				out = 1'b1;
			end
			3'b100: begin
				if (in == 1'b1) begin
					state_next = 3'b001;
				end else begin
					state_next = 3'b000;
				end
				out = 1'b0;
			end			
			default: begin
				state_next = 3'b000;
			end
		endcase
	end
	
	always @ (posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end
		else begin
			state <= state_next;
		end
	end
	
endmodule
