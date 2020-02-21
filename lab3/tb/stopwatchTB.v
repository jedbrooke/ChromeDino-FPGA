`timescale 1ms / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:46:18 02/20/2020
// Design Name:   stopwatch
// Module Name:   /home/ise/Desktop/projects/lab3/stopwatchTB.v
// Project Name:  lab3
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

module stopwatchTB;

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
		#200000 $finish;
		
	end

always #0.000005 clk <= ~clk;
      

endmodule

