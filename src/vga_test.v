`timescale 10ns / 1ns

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
	gmae_management uut (
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

