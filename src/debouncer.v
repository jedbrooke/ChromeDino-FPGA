`timescale 1ns/1ps 

//DEPRECATED, as unneeded for this implementation of button input handling

module debouncer(i_clk,i_btn,o_btn_state); 

	input i_btn, i_clk;
	output reg o_btn_state;

	wire [17:0] incrementer;
	reg [16:0] clk_div = 0;
	reg clk_en;
	reg clk_en_d;
	
	reg [2:0] states = 0;    

	assign incrementer = clk_div + 1;
	
	always @(posedge i_clk) begin
		clk_div <= incrementer[16:0];
		clk_en <= incrementer[17];
		clk_en_d <= clk_en;
	end
	
	always @(posedge i_clk) begin
		if (clk_en) begin
			states[2:0] <= {i_btn,states[2:1]};
		end
	end

	wire is_btn_posedge;
	assign is_btn_posedge = ~states[0] & states[1];
	
	always@(posedge i_clk) begin
		if(clk_en_d) begin
			o_btn_state <= is_btn_posedge;
		end else begin
			o_btn_state <= 0;
		end
	end

endmodule 
