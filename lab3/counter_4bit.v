`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:06:26 02/11/2020 
// Design Name: 
// Module Name:    fourbitcounter 
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
module fourbitcounter(
    max, num, set, inc, state, carry
    );
	 input [3:0] max;
	 input [3:0] num;
	 input set;
	 input inc;
	 output reg [3:0] state;
	 output wire carry;
	 reg [3:0] last_state;
	 
	 assign carry = (last_state == max);
	 
	 always @(posedge inc) begin
			if(set) begin
				state[3:0] <= num[3:0];
			end else begin
				last_state = state;
				if(state < max) begin
					state = state + 1'b1;
				end else begin
					state = 4'b0;
				end
			end
 	 end
	 
	 
	 
	 
	 


endmodule
