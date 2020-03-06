`timescale 10ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:04:59 02/26/2020
// Design Name:   top
// Module Name:   C:/group1/lab4_g02/vga_test.v
// Project Name:  lab4_g02
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_test;

	// Inputs
	reg CLK;
	reg RST_BTN;

	// Outputs
	wire VGA_HS_O;
	wire VGA_VS_O;
	wire [2:0] VGA_R_O;
	wire [2:0] VGA_G_O;
	wire [1:0] VGA_B_O;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.i_clk(CLK), 
		.RST_BTN(RST_BTN), 
		.game_state(2'b10),
		.VGA_HS_O(VGA_HS_O), 
		.VGA_VS_O(VGA_VS_O), 
		.VGA_R_O(VGA_R_O), 
		.VGA_G_O(VGA_G_O), 
		.VGA_B_O(VGA_B_O)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST_BTN = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		#100 RST_BTN = 1'b1;
		#1000 RST_BTN = 1'b0;
        
		// Add stimulus here
		#100000000 $finish;

	end
	
always #0.5 CLK = ~CLK;
      
endmodule

