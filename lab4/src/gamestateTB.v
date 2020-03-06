`timescale 1ns / 1ps
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
	wire [15:0] o_nums; 
	wire [1:0] o_state; 
	
	gamestate gs (
		.clk(clk), 
		.rst(rst), 
		.i_collided(i_collided),
		.o_nums(o_nums), 
		.o_state(o_state)
	);
	
	initial begin 
		clk = 0;  
		i_collided = 0; 
		rst = 1; 
		#10 rst = 0; 
		#50000100 i_collided = 1; 
		#10000 rst = 1; 
		#15000000 $finish; 
	end 
always #5 clk = ~clk; 
endmodule
