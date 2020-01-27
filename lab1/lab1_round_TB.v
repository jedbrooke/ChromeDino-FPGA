`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:27:19 01/22/2020
// Design Name:   lab1_round
// Module Name:   C:/Users/152/Downloads/lab1/lab1_round_TB.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lab1_round
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab1_round_TB;

	// Inputs
	reg [2:0] E;
	reg [3:0] F;
	reg Fifth;
	
	reg [7:0] val;

	// Outputs
	wire [2:0] Eout;
	wire [3:0] Fout;

	// Instantiate the Unit Under Test (UUT)
	lab1_round uut (
		.E(E), 
		.F(F), 
		.Fifth(Fifth), 
		.Eout(Eout), 
		.Fout(Fout)
	);

	initial begin
		// Initialize Inputs
		E = 0;
		F = 0;
		Fifth = 0;
		
		val = 0;
		
		//REMEMBER TO TEST FOR OVERFLOW

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		#1280 $finish;
	end
	
	always begin
		#5 val <= val + 1'b1;
		E <= val[7:5];
		F <= val[4:1];
		Fifth <= val[0];
	end
      
endmodule

