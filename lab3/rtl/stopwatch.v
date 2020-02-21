`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:33 02/19/2020 
// Design Name: 
// Module Name:    stopwatch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stopwatch(clk, sw, btnP, btnR, seg, an
    );
	 
	 input clk;
	 input [7:0] sw;
	 input btnP;
	 input btnR;
	 output [6:0] seg;
	 output [3:0] an;
	 
	 wire pause_pulse;
	 wire adj_pulse;
	 wire rst;
	 
	 wire dp_clk;
	 wire main_clk;
	 wire adj_clk;
	 
	 wire [15:0] nums;
	 
	 input_handling ih (
		.clk(clk),
		.btnR(btnR),
		.btnP(btnP),
		.adj(sw[2]),
		.o_rst(rst),
		.o_pause(pause_pulse),
		.o_adj_pulse(adj_pulse)
		);
	 
	 clk_div cd (
		.clk(clk),
		.rst(rst),
		.dp_clk(dp_clk),
		.main_clk(main_clk),
		.adj_clk(adj_clk)
	 );
	 
	 stopwatch_logic sl (
		.i_adj(sw[2]),
		.rst(rst),
		.i_num(sw[7:4]),
		.i_sel(sw[1:0]),
		.i_btnP(pause_pulse),
		.i_adj_pulse(adj_pulse),
		.clk_1hz(main_clk),
		.clk_m(clk),
		.o_val(nums)
	 );
	 
	 gpu gpu (
		.sel(sw[1:0]),
		.dp_clk(dp_clk),
		.blink_clk(adj_clk),
		.nums(nums),
		.adj(sw[2]),
		.cats(seg),
		.anodes(an)
	);
	 
endmodule
