`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:15:11 02/21/2020
// Design Name:   stopwatch
// Module Name:   C:/Users/152/Desktop/lab3_oh/pause_button_delay_investigationTB.v
// Project Name:  lab3_oh
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stopwatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pause_button_delay_investigationTB;

	// Inputs
	reg clk;
	reg [7:0] sw;
	reg btnP;
	reg btnR;

	// Outputs
	wire [6:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	stopwatch uut (
		.clk(clk), 
		.sw(sw), 
		.btnP(btnP), 
		.btnR(btnR), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sw = 0;
		btnP = 0;
		btnR = 0;

		// Wait 100 ns for global reset to finish
		#100;
	  
		// Add stimulus here
		#1320000 btnP = 1;
		#1320010 btnP = 0;
		#1320010 btnP = 1;
		#1320000 $finish;
		
	end

always #5 clk = ~clk;
      
endmodule

