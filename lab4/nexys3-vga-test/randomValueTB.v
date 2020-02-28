`timescale 1ns / 100ps

module randomValueTB();
reg clk_tb; 
reg rst_tb; 
wire[3:0] out_tb; 

initial 
begin 
	clk_tb = 0; 
	rst_tb = 1; 
	#15; 
	
	rst_tb = 0; 
	#200; 
end 

always
begin 
	#5
	clk_tb = ~clk_tb; 
end 

randomValue rV(out_tb,clk_tb,rst_tb); 
endmodule 

