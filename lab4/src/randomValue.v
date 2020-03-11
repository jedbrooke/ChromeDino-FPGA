`timescale 1ns / 1ps 

//CHANGE: i_out should be o_out  
module randomValue #(SEED=4'b0001)(i_out,i_clk,i_rst); 
output reg [3:0] i_out = SEED; 
input i_clk,i_rst; 

wire randomBit; 

//Randomizing by XOR-ing the leftmost two bits  
assign randomBit = (i_out[3]^i_out[2]); 

always @(posedge i_clk,posedge i_rst)
begin 
	if(i_rst) 
		i_out = SEED; //Simply output our seed if we reset 
	else
		i_out = {i_out[2:0],randomBit}; //Shift left by one bit and replace LSB with random bit
end 
endmodule 
