`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:25:01 01/15/2020
// Design Name:   lab1
// Module Name:   C:/Users/152/Desktop/lab1/lab1_TB.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lab1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab1_TB;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire [2:0] E;
	wire [3:0] F;
	wire S;

	// Instantiate the Unit Under Test (UUT)
	lab1 uut (
		.D(D), 
		.E(E), 
		.F(F), 
		.S(S)
	);

	initial begin
		// Initialize Inputs
		D = -16;
		/*E = 0;
		F = 0;
		S = 0;*/

		// Wait 100 ns for global reset to finish
		#5;
        
		// Add stimulus here
		
		#160 $finish;
	end
	
	always begin
		#5 D = D + 1;
	end
      
endmodule

