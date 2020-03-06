`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:56 03/04/2020 
// Design Name: 
// Module Name:    score_handling 
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
module score_handling( clk, score_clk, rst, state, nums
    );
	
	input clk;
	input score_clk;
	input rst;
	input [1:0] state;
	//output wire [15:0] nums;
	
	wire [3:0] num_arr[0:3]; //to hold num outputs from individual counters
	output wire [15:0] nums; 
	reg en[0:3]; //to inc individual counters
	wire [3:0] carry; //to hold carry outputs from individual counters
	
	parameter play = 2;

	always @* begin 
		en[3] <= (carry[2] && (state == play));
		en[2] <= (carry[1] && (state == play));
		en[1] <= (carry[0] && (state == play));
		en[0] <= (score_clk && (state == play));
	end
	
	parameter digit3_max = 4'b1001;
	parameter digit2_max = 4'b1001; 
	parameter digit1_max = 4'b1001; 
	parameter digit0_max = 4'b1001; 
	
	assign nums = {num_arr[3],num_arr[2],num_arr[1],num_arr[0]};
	
	//instantiate 4 counters
	counter_4bit digit3 (
			.i_clk(clk), .i_rst(rst), .i_max(digit3_max), .i_inc(en[3]), .o_val(num_arr[3]), .o_carry(carry[3])
		);
		
	counter_4bit digit2(
			.i_clk(clk), .i_rst(rst), .i_max(digit2_max), .i_inc(en[2]), .o_val(num_arr[2]), .o_carry(carry[2])
		);
		
	counter_4bit digit1(
			.i_clk(clk), .i_rst(rst), .i_max(digit1_max), .i_inc(en[1]), .o_val(num_arr[1]), .o_carry(carry[1])
		);
		
	counter_4bit digit0(
			.i_clk(clk), .i_rst(rst), .i_max(digit0_max), .i_inc(en[0]), .o_val(num_arr[0]), .o_carry(carry[0])
		);

endmodule

/*
module stopwatch_logic(
	i_adj,rst,i_num,i_sel,i_btnP,i_adj_pulse,clk_1hz,clk_m,o_val
	);
	
`include "stopwatch_definitions.v"
	
	input [3:0] i_num;
	input [1:0] i_sel;
	input i_adj;
	input i_adj_pulse;
	
	input i_btnP;
	
	input clk_1hz;
	input clk_m; //main base 100MHz clk
	input rst;
	
	output wire [15:0] o_val;

	wire [3:0] o_num_arr[0:3];
	
	assign nums = {o_val_arr[3],o_val_arr[2],o_val_arr[1],o_val_arr[0]};
	
	reg en[0:3];
	
	wire [3:0] carry;
	
	always @* begin 
		en[3] <= (carry[2]);
		en[2] <= (carry[1]);
		en[1] <= (carry[0]);
		en[0] <= (clk_1hz);
	end
	
	counter_4bit digit3 (
			.i_clk(clk_m), .i_rst(rst), .i_max(max_digit3), .i_num(i_num), .i_set(set[3]), .i_inc(en[3]), .i_paused(pauseState), .o_val(o_val_arr[3]), .o_carry(carry[3])
		);
		
	counter_4bit digit2(
			.i_clk(clk_m), .i_rst(rst), .i_max(max_digit2), .i_num(i_num), .i_set(set[2]), .i_inc(en[2]), .i_paused(pauseState), .o_val(o_val_arr[2]), .o_carry(carry[2])
		);
		
	counter_4bit digit1(
			.i_clk(clk_m), .i_rst(rst), .i_max(max_digit1), .i_num(i_num), .i_set(set[1]), .i_inc(en[1]), .i_paused(pauseState), .o_val(o_val_arr[1]), .o_carry(carry[1])
		);
		
	counter_4bit digit0(
			.i_clk(clk_m), .i_rst(rst), .i_max(max_digit0), .i_num(i_num), .i_set(set[0]), .i_inc(en[0]), .i_paused(pauseState), .o_val(o_val_arr[0]), .o_carry(carry[0])
		);

endmodule

*/
