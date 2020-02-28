module Dff(i_clk,i_rst,i_d,o_bit);
	input i_clk; 
	input i_rst; 
	input i_d; 
	output o_bit; 
	reg tempBit; 

	always@(posedge i_clk or posedge i_rst)
		begin 
			if(i_rst) 
				tempBit <= 0; 
			else 
				tempBit <= i_d;
		end 

	assign o_bit = tempBit; 
endmodule 

module MUX(i_a,i_b,i_sel,o_bit); 
	input i_sel; 
	input i_a; 
	input i_b; 
	output o_bit; 
	reg tempBit; 

	always @(i_a,i_b,i_sel)
	begin 
		if(i_sel == 0) 
			tempBit = i_a; 
		else 
			tempBit = i_B; 
	end

	assign o_bit = tempBit; 
endmodule 

module randomValue(i_clk,i_rst,i_seed,i_load,o_randomBit); 
	input i_clk; 
	input i_rst; 
	input i_seed; 
	input i_load; 
	reg tempBit; 
	output o_randomBit; 

	wire [3:0] current_state; 
	wire [3:0] next_state; 

	Dff Dff[3:0] (next_state,i_clk,i_rst,current_state); 
	MUX MUX[3:0] (i_load,i_seed,current_state,{next_state[2],
											   next_state[1], 
											   next_state[0],
											   tempBit});
	always@(next_state[2],next_state[3])
	begin
		tempBit <= next_state[2]^next_state[3];
	end 

	assign o_randomBit = tempBit; 
endmodule 
