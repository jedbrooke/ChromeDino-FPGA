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
module clk_div(clk, rst, dp_clk, main_clk, adj_clk);

	input clk;
	input rst;
	output reg dp_clk = 0;
	output reg main_clk = 0;
	output reg adj_clk = 0;
	
	reg [16:0] dp_reg = 0;
	reg [25:0] main_reg = 0;
	reg [25:0] adj_reg = 0;
	
	/*
	parameter dp_clk_max = 0;
	parameter main_clk_max = 0;
	parameter adj_clk_max = 0;
	*/

`include "stopwatch_definitions.v"
	 
	always @(posedge clk) begin
	if(rst) begin
		//dp_reg <= 0;
		main_reg <= 0;
		adj_reg <= 0;
		//dp_clk <= 0;
		main_clk <= 0;
		adj_clk <= 0;
	end

	else begin
		if (dp_reg == dp_clk_max) begin
			dp_reg <= 0;
			dp_clk <= ~dp_clk;
		end
		else begin
			dp_reg <= dp_reg + 1'b1;
		end
		
		if (main_reg == main_clk_max) begin
			main_reg <= 0;
			main_clk <= ~main_clk;
		end
		else begin
			main_reg <= main_reg + 1'b1;
		end

		if (adj_reg == adj_clk_max) begin
			adj_reg <= 0;
			adj_clk <= ~adj_clk;
		end
		else begin
			adj_reg <= adj_reg + 1'b1;
		end
	end

endmodule