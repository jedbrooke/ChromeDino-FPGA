`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:40:02 02/19/2020 
// Design Name: 
// Module Name:    clk_div 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div(clk, rst, score_clk, dp_clk, blink_clk);
	input clk;
	input rst;
	output reg score_clk;
	output reg dp_clk;
	output reg blink_clk;

	reg [22:0] score_reg = 0; 
	reg [19:0] dp_reg = 0;
	reg [25:0] blink_reg = 0;
	
	/*
	parameter dp_clk_max = 0;
	parameter main_clk_max = 0;
	parameter adj_clk_max = 0;
	*/

	parameter score_clk_max = 5000000; //20 Hz
	parameter dp_clk_max = 200000; //100 Hz
	parameter blink_clk_max = 50000000; //2 Hz
	 
	always @(posedge clk) begin
		if(rst) begin
			score_reg <= 0; 
			score_clk <= 0; 
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
		end //End of outer else
	end //End of always 
endmodule