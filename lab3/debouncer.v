`timescale 1ns/1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:     
// Design Name: 
// Module Name: debouncer 
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
module debouncer(i_clk,i_btn,o_btn_state); 
input i_btn,i_clk;
output o_btn_state;

reg temp_state = 0; 
reg [17:0] incrementer;    

always @(posedge i_clk)
begin 
	//Simply reset if given no btn signal 
	if(i_btn == 0) 
	begin 
		incrementer <= 1'b0; 
		temp_state <= 1'b0;
	end 
	else 
	begin 
		incrementer <= incrementer + 1'b1;
		//Cycle through 2^17 pulses before checking for btn signal
		if(incrementer[17] == 1'b1) 
		begin
			temp_state <= 1'b1; 
			incrementer <= 1'b0; 
		end
	end

end

//Occurs once temp_state has changed 
assign o_btn_state = temp_state; 

endmodule 