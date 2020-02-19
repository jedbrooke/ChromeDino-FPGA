`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:54 02/12/2020 
// Design Name: 
// Module Name:    stopwatch_logic 
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
module stopwatch_logic(
	i_adj,rst,i_num,i_sel,i_paused,i_btnP,clk_1hz,clk_m,o_val
	);
	
`include "stopwatch_definitions.v"
	
	input [3:0] i_num;
	input [1:0] i_sel;
	input i_adj;
	input i_paused;
	input i_btnP;
	
	input clk_1hz;
	input clk_m; //main base 100MHz clk
	input rst;
	
	output wire [15:0] o_val;
	
	wire [3:0] o_val_arr[0:3];
	
	assign o_val = {o_val_arr[3],o_val_arr[2],o_val_arr[1],o_val_arr[0]};
	
	wire set[0:3];
	reg en[0:3];
	
	wire [3:0] carry;
	
	assign set[0] = (i_adj & ~i_sel[1] & ~i_sel[0]) | rst;
	assign set[1] = (i_adj & ~i_sel[1] & i_sel[0]) | rst;
	assign set[2] = (i_adj & i_sel[1] & ~i_sel[0]) | rst;
	assign set[3] = (i_adj & i_sel[1] & i_sel[0]) | rst;
	
	/*
	assign set[3] = (i_adj && i_sel == 3) || rst;
	assign set[2] = (i_adj && i_sel == 2) || rst;
	assign set[1] = (i_adj && i_sel == 1) || rst;
	assign set[0] = (i_adj && i_sel == 0) || rst;
	*/
	
	always @* begin 
		en[3] <= (carry[2] & ~i_paused) || (i_paused && i_btnP && i_sel == 3) || rst;
		en[2] <= (carry[1] & ~i_paused) || (i_paused && i_btnP && i_sel == 3) || rst;
		en[1] <= (carry[0] & ~i_paused) || (i_paused && i_btnP && i_sel == 3) || rst;
		en[0] <= (clk_1hz & ~i_paused) || (i_paused && i_btnP && i_sel == 3) || rst;
	end
	
	counter_4bit digit3 (
			.i_clk(clk_m), .i_max(max_digit3), .i_num(i_num), .i_set(set[3]), .i_inc(en[3]), .o_val(o_val_arr[3]), .o_carry(carry[3])
		);
		
	counter_4bit digit2(
			.i_clk(clk_m), .i_max(max_digit2), .i_num(i_num), .i_set(set[2]), .i_inc(en[2]), .o_val(o_val_arr[2]), .o_carry(carry[2])
		);
		
	counter_4bit digit1(
			.i_clk(clk_m), .i_max(max_digit1), .i_num(i_num), .i_set(set[1]), .i_inc(en[1]), .o_val(o_val_arr[1]), .o_carry(carry[1])
		);
		
	counter_4bit digit0(
			.i_clk(clk_m), .i_max(max_digit0), .i_num(i_num), .i_set(set[0]), .i_inc(en[0]), .o_val(o_val_arr[0]), .o_carry(carry[0])
		);

endmodule
