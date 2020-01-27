`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:33:48 01/15/2020
// Design Name:   lab1_priority_encoder
// Module Name:   C:/Users/152/Desktop/lab1/lab1_priority_encoder_TB.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lab1_priority_encoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab1_priority_encoder_TB;

	// Inputs
	reg [10:0] mag;
	wire [3:0]  index;	

	// Instantiate the Unit Under Test (UUT)
	lab1_priority_encoder uut (
		.mag(mag),
		.index(index)
	);

	initial begin
		// Initialize Inputs
		mag = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#10500 $finish;
	end
	// Add stimulus here
	
	always begin
		#5 mag <= mag + 1'b1;
	end
	 
endmodule

