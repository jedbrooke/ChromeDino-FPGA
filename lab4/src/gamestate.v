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
module gamestate( clk, rst, i_collided, i_sss2, score_clk, fast_score_clk, o_nums, o_state,
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
	input wire score_clk;
	input wire fast_score_clk;
	input wire i_sss2;
	output [15:0] o_nums;
	output reg [1:0] o_state;
	
	parameter stDead = 0;
	parameter stGrace = 1;
	parameter stPlay = 2;
	
	parameter grace_period = 150000000; //3000 ms, 3 seconds
	
	reg [27:0] grace_counter;
	
	wire used_score_clk;
	
	assign used_score_clk = i_sss2 ? fast_score_clk : score_clk;
	
	//state driver
	always @(posedge clk) begin
		if (rst) begin 
			o_state <= stGrace;
			grace_counter <= 14'b0;
		end else
			case (o_state)
				//stDead <-- stay in dead state
				stGrace: //You can move around for 3 seconds but no obstacles will spawn
					begin
						if (grace_counter == grace_period)
						begin
							grace_counter <= 28'b0;
							o_state <= stPlay;
						end
						else begin
							grace_counter <= grace_counter + 1'b1;
						end
					end
				stPlay: //Check for collision 
					begin
						if (i_collided)
							o_state <= stDead;
					end
				endcase
	end //End of always
	
	
	
	
	score_handling #(.play(stPlay)) score (
		.clk(clk),
		.score_clk(used_score_clk),
		.rst(rst),
		.state(o_state),
		.nums(o_nums)
	);
		
	// //score handling
	// always @(posedge clk) begin
	// 	case (o_state)
	// 		stPlay:
	// 			begin
	// 				//keep counting 
	// 				pause_state <= 0;
	// 			end
	// 		stDead: 
	// 			begin
	// 				//stop counting
	// 				pause_state <= 1;  
	// 			end
	// 	endcase 
	// end

endmodule
