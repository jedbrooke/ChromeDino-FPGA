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
module counter_4bit(
    i_clk, i_rst, i_max, i_num, i_set, i_inc, i_paused, o_val, o_carry
    );
	 input i_clk;
	 input i_rst;
	 input [3:0] i_max;
	 input [3:0] i_num;
	 input i_set;
	 input i_inc;
	 input i_paused;
	 
	 output reg [3:0] o_val;
	 output reg o_carry;
	 
	 reg [3:0] last_state; 
	 
	 /*always @(posedge i_inc) begin
			if(o_carry) begin
				o_carry <= 1'b0;
			end else begin
				if (i_num == i_max) begin
					o_carry <= 1'b1;
				end else begin
					o_carry <= 1'b0;
				end
			end
	 end */
	 
	 always @(posedge i_inc or posedge i_rst or posedge i_set)
	 begin
		if(i_rst) begin
			o_val[3:0] <= 4'b0000;
		end
		else begin
			if (i_set) begin
				o_val[3:0] <= i_num[3:0];
			end else begin
				if (~i_paused) begin
					last_state <= o_val;
					if(o_val < i_max)
					begin
						o_carry <= 1'b0;
						o_val <= o_val + 1'b1;	
					end
					else
					begin
						o_carry <= 1'b1;
						o_val <= 4'b0;
					end
				end
			end
		end
	end
	
endmodule
