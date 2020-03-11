`timescale 1ns / 1ps

module gamestate #(
		stDead = 0,
		stGrace = 1,
		stPlay = 2,
		grace_period = 150000000 //3000 ms, 3 seconds
	)

	(
    input clk,
	input rst,
	input i_collided,
	input wire score_clk,
	input wire fast_score_clk,
	input wire i_sss2,
	output [15:0] o_nums,
	output reg [1:0] o_state,
    );

	/*
	Basic Psuedocode for understanding State Management:

		if rst, set state = grace period
	
		otherwise, wait in grace period state for x time (parameter)
			then move to "play" state, which activates obstacles to begin moving
		
		if collide, move to "dead" state
			dinosaurs and obstacles should NOT be moving; counter should be STOPPED/BLINKING
	*/
	
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

endmodule
