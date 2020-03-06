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
module clk_div(clk, rst, score_clk);
	input clk;
	input rst;
	output reg score_clk;

	reg [22:0] score_reg = 0; 
	
	/*
	parameter dp_clk_max = 0;
	parameter main_clk_max = 0;
	parameter adj_clk_max = 0;
	*/

	parameter score_clk_max = 5000000; //20 Hz
	 
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
		end //End of outer else
	end //End of always 
endmodule