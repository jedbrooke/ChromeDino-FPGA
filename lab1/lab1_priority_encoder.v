`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:48 01/15/2020 
// Design Name: 
// Module Name:    lab1_priority_encoder 
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
module lab1_priority_encoder( mag, index
    );
	input [10:0] mag;
	output reg [3:0] index;
	
	always @* begin
	
		index[0] <= (~mag[10] & mag[9]) |
						(~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & mag[5]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & mag[3]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & ~mag[3] & ~mag[2] & mag[1]);
					
		index[1] <= (mag[10]) |
						(~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & mag[6]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & mag[3]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & ~mag[3] & mag[2]);
						
		index[2] <= (~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & mag[6]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & mag[5]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & mag[4]);
					
		index[3] <= (mag[10]) |
						(~mag[10] & mag[9]) |
						(~mag[10] & ~mag[9] & mag[8]);

	end
endmodule
