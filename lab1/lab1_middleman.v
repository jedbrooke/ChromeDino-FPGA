`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:53 01/22/2020 
// Design Name: 
// Module Name:    lab1_middleman 
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
module lab1_middleman(mag,E,F,Fifth
    );

	input [10:0] mag;
	output reg [2:0] E;
	output reg [3:0] F;
	output reg Fifth;

	reg [2:0] exp;

	wire [3:0] index;
	reg [3:0] num_zeros; //number of zeros for calculating exponent
	reg [10:0] calc_shift;

	lab1_priority_encoder uut (
		.mag(mag),
		.index(index)
	);



	always @* begin
		//count number of zeros for exponent

		num_zeros = 11 - index;
		exp = 8 - num_zeros;
		if (exp < 0) begin
			E <= 0;
			F <= mag[3:0];
			Fifth <= 0;
		end
		else if (mag == 0) begin
			E <= 0;
			F <= 0;
			Fifth <= 0;
		end
		else if (index < 4) begin
			F <= mag[3:0];
			Fifth <= 0;
			E <= exp;
		end
		else begin
			calc_shift <= mag >> (index-4);
			F <= calc_shift[5:1];
			Fifth <= calc_shift[0];
			E <= exp; 
		end
	end

endmodule
