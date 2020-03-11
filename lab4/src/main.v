`timescale 1ns / 1ps

module main(
	input wire i_clk,			// Board Clock: 100 MHz on Arty/Basys3/Nexys
	input wire RST_BTN,		// Reset Button
	input wire dino_jump,		// Jump Button 
	input wire dino_duck,		// Duck Button 
	input wire super_secret_switch,   // super secret switch
	input wire super_secret_switch2,	// super secret switch 2
	output wire VGA_HS_O,             // Horizontal Sync Output
	output wire VGA_VS_O,             // vertical Sync Output
	output wire [2:0] VGA_R_O,     // Red Output
	output wire [2:0] VGA_G_O,      // Green Output
	output wire [1:0] VGA_B_O,      // Blue Output
	output wire [6:0] seg,          // 7-Segment Output
	output wire [3:0] an            // 4-bit Anode Output
	);
	 
`include "parameters.v"

	wire collided; //State of whether dino has collided with an obstacle 
	wire [15:0] nums; //This will keep track of our score
	wire [1:0] state; //The game will have three possible states 
	wire score_clk; //Score Clock
	wire dp_clk;	//Display Clock
	wire blink_clk; //Blink Clock for when we're in dead state 
	wire fast_score_clk; //Fast Score Clock for sss2 
	 
	//This will manage the state transitions 
	gamestate gs (
		.clk(i_clk),
		.rst(RST_BTN),
		.i_collided(collided),
		.i_sss2(super_secret_switch2),
		.score_clk(score_clk),
		.fast_score_clk(fast_score_clk),
		.o_nums(nums),
		.o_state(state)
	);
	
	//Based on user inputs and gamestate, the appropriate frames will be drawn
	game_management gm (
		.i_clk(i_clk),
		.RST_BTN(RST_BTN),
		.dino_jump(dino_jump),
		.dino_duck(dino_duck),
		.game_state(state),
		.super_secret_switch(super_secret_switch),
		.VGA_HS_O(VGA_HS_O),
		.VGA_VS_O(VGA_VS_O),
		.VGA_R_O(VGA_R_O),
		.VGA_G_O(VGA_G_O),
		.VGA_B_O(VGA_B_O),
		.collision(collided)
	);
	
	//This produces the four clocks we need
	clk_div clkdiv (
		.clk(i_clk),
		.rst(RST_BTN),
		.score_clk(score_clk),
		.dp_clk(dp_clk),
		.blink_clk(blink_clk),
		.fast_score_clk(fast_score_clk)
	);
	
	//This handles the actual output of the 7-segment display for score
	gpu gpu(
		.dp_clk(dp_clk),
		.blink_clk(blink_clk),
		.game_state(state),
		.nums(nums),
		.cats(seg),
		.anodes(an)
	);
	  
endmodule
