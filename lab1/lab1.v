`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:	 10:19:43 01/15/2020 
// Design Name: 
// Module Name:	 lab1 
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
module lab1(
	 D, E, F, S
	 );
	 
	input [11:0] D; //input data
	output [2:0] E; //output exponent
	output [3:0] F; //output fractional component
	output S;		 //ouput sign
	wire [10:0] mag; //magnitude of the number
	wire [3:0] Fin;
	wire Fifth;
	wire [2:0] exp;
	
	//convert 2's comp into sign magnitude
	lab1_2comp_SM_encoder uut1 (
		.D(D),
		.sign(S),
		.mag(mag)
	);
	
	lab1_middleman uut2 (
		.mag(mag),
		.E(exp),
		.F(Fin),
		.Fifth(Fifth)
	);
		
	lab1_round uut3 (
		.E(exp),
		.F(Fin),
		.Fifth(Fifth),
		.Eout(E),
		.Fout(F)
	); 
	
endmodule
