`timescale 1ns / 1ps

module clk_div(
	input wire clk,
	input wire rst,
	output reg score_clk,
	output reg dp_clk,
	output reg blink_clk,
	output reg fast_score_clk
	);

	reg [22:0] score_reg = 0; 
	reg [22:0] fast_score_reg = 0; 
	reg [19:0] dp_reg = 0;
	reg [25:0] blink_reg = 0;

	parameter score_clk_max = 5000000; //20 Hz
	parameter fast_score_clk_max = 100000; //1000 Hz
	parameter dp_clk_max = 200000; //500 Hz
	parameter blink_clk_max = 50000000; //2 Hz
	 
	always @(posedge clk) begin
		if(rst) begin
			score_reg <= 0; 
			score_clk <= 0; 
			
			dp_reg <= 0;
			dp_clk <= 0;
			
			fast_score_reg <= 0;
			fast_score_clk <= 0;
			
			blink_reg <= 0;
			blink_clk <= 0;
		end

		else begin
			if (score_reg == score_clk_max) begin
				score_reg <= 0;
				score_clk <= 1'b1;
			end
			else begin
				score_reg <= score_reg + 1'b1;

				if (score_clk == 1'b1) begin
					score_clk <= 1'b0;
				end

			end
			if (dp_reg == dp_clk_max) begin
				dp_reg <= 0;
				dp_clk <= 1'b1;
			end
			else begin
				dp_reg <= dp_reg + 1'b1;

				if (dp_clk == 1'b1) begin
					dp_clk <= 1'b0;
				end
			end
			if (blink_reg == blink_clk_max) begin
				blink_reg <= 0;
				blink_clk <= 1'b1;
			end
			else begin
				blink_reg <= blink_reg + 1'b1;

				if (blink_clk == 1'b1) begin
					blink_clk <= 1'b0;
				end
			end 
			
			if (fast_score_reg == fast_score_clk_max) begin
				fast_score_reg <= 0;
				fast_score_clk <= 1'b1;
			end
			else begin
				fast_score_reg <= fast_score_reg + 1'b1;

				if (fast_score_clk == 1'b1) begin
					fast_score_clk <= 1'b0;
				end

			end
		end //End of outer else
	end //End of always 
endmodule
