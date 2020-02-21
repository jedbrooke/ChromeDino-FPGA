`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:37 02/19/2020 
// Design Name: 
// Module Name:    input_handling 
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
module input_handling(clk,btnR,btnP,adj,o_rst,o_pause,o_adj_pulse
    );
		input clk;
		input btnR;
		input btnP;
		input adj;
		output o_rst;
		output o_pause;
		output reg o_adj_pulse;
		
		reg [1:0] adj_states;
		
		debouncer dbP (
		 .i_clk(clk),
		 .i_btn(btnP),
		 .o_btn_state(o_pause)
		);
		 
		debouncer dbR (
		 .i_clk(clk),
		 .i_btn(btnR),
		 .o_btn_state(o_rst)
		);
		
		always @(posedge clk) begin
			adj_states <= {adj_states[0],adj};
			if (adj_states[1] != adj_states[0]) begin
				o_adj_pulse <= 1'b1;
			end else begin
				o_adj_pulse <= 1'b0;
			end
		end
		
		//o_pause either pause_pressed or adj changes
		
		
endmodule
