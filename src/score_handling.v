`timescale 1ns / 1ps

module score_handling #(
		play = 2
	)

	(
	input wire clk,
	input wire score_clk,
	input wire rst,
	input wire [1:0] state,
	output wire [15:0] nums
	);

	wire [3:0] num_arr[0:3]; //to hold num outputs from individual counters
	reg en[0:3]; //to inc individual counters
	wire [3:0] carry; //to hold carry outputs from individual counters

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
