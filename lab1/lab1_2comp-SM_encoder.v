`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:36 01/15/2020 
// Design Name: 
// Module Name:    lab1_2comp-SM_encoder 
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
module lab1_2comp_SM_encoder(D ,sign , mag
    );
	input [11:0] D;
	output reg sign;
	output reg [10:0] mag;
	
	always @* begin
		sign = D[11];
		if (sign)
			mag <= ~D + 1'b1;
		else
			mag <= D[10:0];
			
		if (D == 2048)
			mag <= 11'b11111111111;
	end	
			
endmodule
