`timescale 1ms / 1us

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:52:37 02/20/2020
// Design Name:   stopwatch_logic
// Module Name:   C:/Users/152/Desktop/lab3_g02.1/stopwatch_logicTB.v
// Project Name:  lab3_g02.1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stopwatch_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stopwatch_logicTB;

	// Inputs
	reg i_adj;
	reg rst;
	reg [3:0] i_num;
	reg [1:0] i_sel;
	reg i_paused;
	reg i_btnP;
	reg clk_1hz;
	reg clk_m;

	// Outputs
	wire [15:0] o_val;

	// Instantiate the Unit Under Test (UUT)
	stopwatch_logic uut (
		.i_adj(i_adj), 
		.rst(rst), 
		.i_num(i_num), 
		.i_sel(i_sel), 
		.i_paused(i_paused), 
		.i_btnP(i_btnP), 
		.clk_1hz(clk_1hz), 
		.clk_m(clk_m), 
		.o_val(o_val)
	);

	initial begin
		// Initialize Inputs
		i_adj = 0;
		rst = 0;
		i_num = 0;
		i_sel = 0;
		i_paused = 0;
		i_btnP = 0;
		clk_1hz = 0;
		clk_m = 0;

		// Wait 100 ns for global reset to finish
		#0.0001;
        
		// Add stimulus here
		#100;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#1 i_paused = 1'b1;
		#1 i_paused = 1'b0;
		#50 i_paused = 1'b1;
		#20 i_paused = 1'b0;
		
	end

always #2000 $finish;
      
always #0.5 clk_m = ~clk_m;
always #5 clk_1hz = ~clk_1hz;

endmodule

