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
module input_handling(clk,btnR,btnJ,btnD,o_rst,o_jump, o_duck);

	input clk;
	input btnR;
	input btnJ;
	input btnD;

	output o_rst;
	output o_jump;
	output o_duck;
	
	debouncer dbR (
	 .i_clk(clk),
	 .i_btn(btnR),
	 .o_btn_state(o_rst)
	);
	 
	debouncer dbJ (
	 .i_clk(clk),
	 .i_btn(btnJ),
	 .o_btn_state(o_jump)
	);

	debouncer dbD (
	 .i_clk(clk),
	 .i_btn(btnD),
	 .o_btn_state(o_duck)
	);

endmodule
