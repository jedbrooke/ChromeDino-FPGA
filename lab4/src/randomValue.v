`timescale 1ns / 1ps 

module randomValue #(SEED=4'b0001)(i_out,i_clk,i_rst); 
output reg [3:0] i_out; 
input i_clk,i_rst; 

wire randomBit; 

assign randomBit = (i_out[3]^i_out[2]); 

always @(posedge i_clk,posedge i_rst)
begin 
	if(i_rst) 
		i_out = SEED; 
	else
		i_out = {i_out[2:0],randomBit};
end 
endmodule 
