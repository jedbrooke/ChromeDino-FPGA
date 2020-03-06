`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:19 03/06/2020 
// Design Name: 
// Module Name:    main 
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
module main(
	  input wire i_clk,             // board clock: 100 MHz on Arty/Basys3/Nexys
      input wire RST_BTN,           // reset button
      input wire dino_jump,
      input wire dino_duck,
	  output wire VGA_HS_O,         // horizontal sync output
      output wire VGA_VS_O,         // vertical sync output
      output wire [2:0] VGA_R_O,
      output wire [2:0] VGA_G_O,
      output wire [1:0] VGA_B_O,
	  output wire [6:0] seg,
	  output wire [3:0] an
    );
	
	wire collided;
	wire [15:0] nums;
	wire [1:0] state;
	wire score_clk;
	wire dp_clk;
	
	gamestate gs (
		.clk(i_clk),
		.rst(RST_BTN),
		.i_collided(collided),
		.score_clk(score_clk),
		.o_nums(nums),
		.o_state(state)
	);
	
	top top (
		.i_clk(i_clk),
		.RST_BTN(RST_BTN),
		.dino_jump(dino_jump),
		.dino_duck(dino_duck),
		.game_state(state),
		.VGA_HS_O(VGA_HS_O),
		.VGA_VS_O(VGA_VS_O),
		.VGA_R_O(VGA_R_O),
		.VGA_G_O(VGA_G_O),
		.VGA_B_O(VGA_B_O),
		.collision(collided)
	);
	
	//clk divider
	clk_div clkdiv (
		.clk(i_clk),
		.rst(RST_BTN),
		.score_clk(score_clk),
		.dp_clk(dp_clk)
	);
	
	gpu gpu(
		.dp_clk(dp_clk),
		.nums(nums),
		.cats(seg),
		.anodes(an)
	);
	
	

	  

endmodule
