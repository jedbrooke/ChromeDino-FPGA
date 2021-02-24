`timescale 10ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:28:25 03/06/2020 
// Design Name: 
// Module Name:    gamestateTB 
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
module gamestateTB; 
	//Inputs
	reg clk; 
	reg rst; 
	reg i_collided; 
	wire score_clk; 
	wire fast_score_clk; 
	reg i_sss2; 
	wire [15:0] o_nums; 
	wire [1:0] o_state; 
	
	gamestate gs (
		.clk(clk), 
		.rst(rst), 
		.i_collided(i_collided),
		.score_clk(score_clk), 
		.fast_score_clk(fast_score_clk),
		.i_sss2(i_sss2),
		.o_nums(o_nums), 
		.o_state(o_state)
	);
	
	//This produces the four clocks we need
	clk_div clkdiv (
		.clk(clk),
		.rst(rst),
		.score_clk(score_clk),
		.fast_score_clk(fast_score_clk)
	);
	
	initial begin 
		clk = 0;  
		i_collided = 0; 
		rst = 0;
		i_sss2 = 0;
		#100		
		#1 rst = 0;
		#3000000000
		#1000000000 i_collided = 1; 
		#1000000000 rst = 0; 
		#1000000000 $finish; 
	end 
always #5 clk = ~clk; 
endmodule
