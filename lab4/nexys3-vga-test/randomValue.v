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
			tempBit = i_b; 
	end

	assign o_bit = tempBit; 
endmodule 

module randomValue(i_clk,i_rst,i_seed,i_load,o_randomBit); 
	input i_clk; 
	input i_rst; 
	input[3:0] i_seed; 
	input i_load; 
	wire tempBit; 
	output o_randomBit; 

	//wire [3:0] current_state; 
	reg [3:0] next_state = 0; 

	/*Dff Dff[3:0] (next_state,i_clk,i_rst,current_state); 
	MUX MUX[3:0] (i_load,i_seed,current_state,{next_state[2],
											   next_state[1], 
											   next_state[0],
											   tempBit});*/
	always @(posedge i_clk) begin
		if(i_rst) begin
			 next_state = 4'b0;
		end else begin
			 next_state[0] <= (i_load) ? o_randomBit : i_seed[0];
			 next_state[1] <= (i_load) ? next_state[0] : i_seed[1];
			 next_state[2] <= (i_load) ? next_state[1] : i_seed[2];
			 next_state[3] <= (i_load) ? next_state[2] : i_seed[3];
	   end
	end

	assign o_randomBit = next_state[2]^next_state[3]; ; 
endmodule 
