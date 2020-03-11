`timescale 1ns / 1ps 

module randomValue #(SEED=4'b0001)(o_out,i_clk,i_rst); 

input i_clk,i_rst; 
output reg [3:0] o_out = SEED; 

wire randomBit; 

//Randomizing by XOR-ing the leftmost two bits  
assign randomBit = (o_out[3]^o_out[2]); 

always @(posedge i_clk,posedge i_rst)
begin 
	if(i_rst) 
		o_out = SEED; //Simply output our seed if we reset 
	else
		o_out = {o_out[2:0],randomBit}; //Shift left by one bit and replace LSB with random bit
end 
endmodule 
