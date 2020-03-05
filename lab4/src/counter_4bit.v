`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:16 03/04/2020 
// Design Name: 
// Module Name:    counter_4bit 
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
    i_clk, i_rst, i_max, i_inc, o_val, o_carry
    );
	 input i_clk;
	 input i_rst;
	 input [3:0] i_max;
	 input i_inc;
	 
	 output reg [3:0] o_val;
	 output reg o_carry;
	 
	 
	 //HAVE LAST STATE OF LAST INC STATE; FLIP CARRY WHEN LAST STATE IS GOOD
	 
	 
	 //counting logic
	 always @(posedge i_clk)
	 begin
		if(i_rst) begin
			o_val[3:0] <= 4'b0000;
		end
		else begin
			if (i_inc) begin
				if(o_val < i_max) begin
					o_carry <= 1'b0;
					o_val <= o_val + 1'b1;	
				end
				else begin
					o_carry <= 1'b1;
					o_val <= 4'b0;
				end
			end
		end
	end
	
endmodule
