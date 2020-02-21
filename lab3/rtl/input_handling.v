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
module input_handling(clk,btnR,btnP,adj,o_rst,o_pause,o_pause_state
    );
		input clk;
		input btnR;
		input btnP;
		input adj;
		output o_rst;
		output o_pause;
		output reg o_pause_state = 0;
		
		wire pause_pulse;
		
		debouncer dbP (
		 .i_clk(clk),
		 .i_btn(btnP),
		 .o_btn_state(pause_pulse)
		);
		 
		debouncer dbR (
		 .i_clk(clk),
		 .i_btn(btnR),
		 .o_btn_state(o_rst)
		);
		
		
		always @(posedge pause_pulse) begin
			if(~adj) begin
				o_pause_state <= ~o_pause_state;
			end else begin
				o_pause_state <= 1'b1;
			end
		end
endmodule
