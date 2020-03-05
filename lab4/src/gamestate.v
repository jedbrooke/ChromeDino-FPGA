`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:40:14 03/04/2020 
// Design Name: 
// Module Name:    gamestate 
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
module gamestate( clk, rst, i_collided, o_nums, o_state)
    );

	/*
	if rst, set state = grace period
	
	otherwise, wait in grace period state for x time (parameter)
		then move to "play" state, which activates obstacles to begin moving
		
	if collide, move to "dead" state
		dinosaurs and obstacles should NOT be moving; counter should be STOPPED
	
	*/
	
	input clk;
	input rst;
	input i_collided;
	output [15:0] o_nums;
	output reg [1:0] o_state;
	
	parameter stDead = 0;
	parameter stGrace = 1;
	parameter stPlay = 2;
	
	parameter grace_period = 150000000; //3000 ms, 3 seconds
	
	reg [13:0] grace_counter;
	wire score_clk;
	
	//state driver
	always @(posedge clk) begin
		if (rst)
			o_state <= stGrace;
			grace_counter <= 14'b0;
		else
			case (o_state)
				//stDead <-- stay in dead state
				stGrace:
					begin
						grace_counter <= grace_counter + 1'b1;
					
						if (grace_counter == grace_period)
						begin
							grace_counter <= 14'b0;
							o_state <= stPlay;
						end
					end
				stPlay:
					begin
						if (i_collided)
							o_state <= stDead;
					end
	end
	
	//clk divider
	clk_div clkdiv (
		.clk(clk),
		.rst(rst),
		.score_clk(score_clk)
	);
	
	
	score_handling score (
		.clk(score_clk),
		.nums(o_nums)
	);
		
	//score handling
	always @(posedge clk) begin
		case (o_state)
			stPlay:
				begin
					//keep counting
				end
	end

endmodule
