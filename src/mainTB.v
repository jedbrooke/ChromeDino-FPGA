`timescale 10ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:11:23 03/09/2020
// Design Name:   main
// Module Name:   C:/Users/152/Downloads/lastday_dinosaur/mainTB.v
// Project Name:  lastday_dinosaur
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mainTB;

	// Inputs
	reg i_clk;
	reg RST_BTN;
	reg dino_jump;
	reg dino_duck;
	reg super_secret_switch;

	// Outputs
	wire VGA_HS_O;
	wire VGA_VS_O;
	wire [2:0] VGA_R_O;
	wire [2:0] VGA_G_O;
	wire [1:0] VGA_B_O;
	wire [6:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.i_clk(i_clk), 
		.rst_btn(RST_BTN), 
		.dino_jump(dino_jump), 
		.dino_duck(dino_duck), 
		.super_secret_switch(super_secret_switch), 
		.VGA_HS_O(VGA_HS_O), 
		.VGA_VS_O(VGA_VS_O), 
		.VGA_R_O(VGA_R_O), 
		.VGA_G_O(VGA_G_O), 
		.VGA_B_O(VGA_B_O), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		RST_BTN = 0;
		dino_jump = 0;
		dino_duck = 0;
		super_secret_switch = 0;

		// Wait 100 ns for global reset to finish
		#10;
		#100 dino_jump = 1'b1;
      #500000000 $finish;
		// Add stimulus here

	end
	
always #0.5 i_clk = ~i_clk;
      
endmodule

