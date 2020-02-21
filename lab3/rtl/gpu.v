`timescale 1ns / 1ps
module gpu(
				sel,dp_clk,blink_clk,nums,adj,cats,anodes
);
    input [1:0] sel;
	 input dp_clk;
    input blink_clk;
	 input [15:0] nums;
    input adj;

    reg [3:0] val = 0;
    reg [1:0] index = 0;
	 wire [3:0] split_nums[0:3];
    reg num_disable = 0;
	 wire this_disable;
	 wire [6:0] decoded;

    output reg [6:0] cats = 7'b1111111;
    output reg [3:0] anodes = 7; //4'b0111;
	 
	 assign split_nums[0] = nums[3:0];
	 assign split_nums[1] = nums[7:4];
	 assign split_nums[2] = nums[11:8];
	 assign split_nums[3] = nums[15:12];
	 
	 assign this_disable = (index == sel) & num_disable;
	 
	 
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
	 end
	 
	 
    always @(posedge dp_clk) begin
        index <= index + 1'b1;
        val <= split_nums[index]; 
    end

    always @(posedge blink_clk) begin
        if (adj) begin
            num_disable <= ~num_disable; 
        end else begin
            num_disable <= 0;
        end
    end

    decode_7seg decoder(
        .val(val),
        .num_disable(this_disable),
        .cats(decoded[6:0])
    );
	 
	  
 endmodule