`timescale 1ns / 1ps
module gpu(
				dp_clk,nums,cats,anodes
);
	 input dp_clk;
	 input [15:0] nums;
	 output reg [6:0] cats = 7'b1111111;
     output reg [3:0] anodes = 7; //4'b0111;

     reg [3:0] val = 0;
     reg [1:0] index = 0;
	 wire [3:0] split_nums[0:3];
	 wire [6:0] decoded;
	 
	 assign split_nums[0] = nums[3:0];
	 assign split_nums[1] = nums[7:4];
	 assign split_nums[2] = nums[11:8];
	 assign split_nums[3] = nums[15:12];
	 
	 
	 always @(negedge dp_clk) cats[6:0] <= ~decoded[6:0]; //negedge to desync it from when the numbers are changing so we dont get inconsistencies
	 always @(negedge dp_clk) begin
			if(~anodes[0])  begin
            anodes[0] <= 1;
            anodes[1] <= 0;
        end else if(~anodes[1]) begin
            anodes[1] <= 1;
            anodes[2] <= 0;
        end else if(~anodes[2]) begin
            anodes[2] <= 1;
            anodes[3] <= 0;
        end else begin
            anodes[3] <= 1;
            anodes[0] <= 0;
        end
		  index <= index + 1'b1;
	 end
	 
	 
    always @(posedge dp_clk) begin
        val <= split_nums[index]; 
    end

    decode_7seg decoder(
        .val(val),
        .num_disable(1'b0),
        .cats(decoded[6:0])
    );
	 
	  
 endmodule