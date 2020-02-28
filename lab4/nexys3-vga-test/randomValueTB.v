`timescale 1ns/100ps

module randomValueTB; 
	reg clk;
	reg rst;
	reg [3:0] seed; 
	reg load; 
	wire q; 
	randomValue rV(q,clk,rst,seed,load); 

	initial 
		begin
			clk = 0; 
			load = 0; 
			seed = 0; 
			rst = 0; 
			#10 rst = 1; 
			#300 rst = 0;
			#1200 $finish;
		end 

	always 
	#50 clk = ~clk;
	initial begin
		#100 seed = 4'b0001;
		load = 1; 
		#100 load = 0;
	end 
	
endmodule  
