`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:28:30 02/20/2020
// Design Name:   input_handling
// Module Name:   C:/Users/152/Desktop/lab3_g02.1/input_handlingTB.v
// Project Name:  lab3_g02.1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: input_handling
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module input_handlingTB;

	// Inputs
	reg clk;
	reg btnR;
	reg btnP;
	reg adj;

	// Outputs
	wire o_rst;
	wire o_pause;
	wire o_pause_state;

	// Instantiate the Unit Under Test (UUT)
	input_handling uut (
		.clk(clk), 
		.btnR(btnR), 
		.btnP(btnP), 
		.adj(adj), 
		.o_rst(o_rst), 
		.o_pause(o_pause), 
		.o_pause_state(o_pause_state)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btnR = 0;
		btnP = 0;
		adj = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		btnP = 1'b1;
		#100000000 btnP = 1'b0;
		#1000000 $finish;

	end
	
always #5 clk = ~clk;
      
endmodule

