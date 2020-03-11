`timescale 1ns / 1ps

module counter_4bit(
	 input i_clk,
	 input i_rst,
	 input [3:0] i_max,
	 input i_inc,
	 output reg [3:0] o_val,
	 output reg o_carry,
	);

	reg carry_last; 

	//counting logic
	always @(posedge i_clk)
	begin
		if(i_rst) begin
			o_val[3:0] <= 4'b0000;
			o_carry <= 1'b0; 
			carry_last <= 1'b0;
		end
		else begin
			if (carry_last == 1'b1) begin
				o_carry <= 1'b0;
				carry_last <= 1'b0;
			end

			if (i_inc) begin //If I have to increment...
				if(o_val < i_max) begin //Normal counting 
					o_val <= o_val + 1'b1;	
				end
				else begin  
					o_carry <= 1'b1;
					carry_last <= 1'b1;
					o_val <= 4'b0;
				end
			end
		end //End of else begin 
	end //End of always begin 
endmodule
