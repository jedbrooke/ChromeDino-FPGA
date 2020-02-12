`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:02:13 02/11/2020
// Design Name:   fourbitcounter
// Module Name:   /home/ise/Desktop/projects/lab3/fourbitcounterTB.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fourbitcounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fourbitcounterTB;

	// Inputs
	reg [3:0] max10;
	reg [3:0] max6;
	reg [3:0] num;
	reg set;
	reg inc;

	// Outputs
	wire [3:0] state10;
	wire carry10;
	wire [3:0] state6;
	wire carry6;
	
	reg inc6;

	// Instantiate the Unit Under Test (UUT)
	fourbitcounter count10 (
		.max(max10), 
		.num(num), 
		.set(set), 
		.inc(inc), 
		.state(state10), 
		.carry(carry10)
	);
	
	fourbitcounter count6 (
		.max(max6),
		.num(num),
		.set(set),
		.inc(inc6),
		.state(state6),
		.carry(carry6)
	);
		
	initial begin
		// Initialize Inputs
		max10 = 9;
		max6 = 6;
		num = 0;
		set = 1;
		inc = 0;
		inc6 = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		#20 inc6 = 1;
		#5 inc6 = 0;
		#5 set = 0;
		#3000 $finish;
	end
	
	always begin
		inc6 = carry10;
		#10 inc = ~inc;
   end
endmodule

