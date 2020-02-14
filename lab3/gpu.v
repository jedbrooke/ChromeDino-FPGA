`timescale 1ns / 1ps
module gpu(
				dp_clk,blink_clk,nums,adj,cats,anodes
);
    input dp_clk;
    input blink_clk;
	 input [15:0] nums;
    input adj;

    reg [3:0] val = 0;
    reg [1:0] index = 0;
	 wire [3:0] split_nums[0:3];
    reg num_disable = 0;

    output [6:0] cats;
    output reg [3:0] anodes = 7;
	 
	 assign split_nums[0] = nums[3:0];
	 assign split_nums[1] = nums[7:4];
	 assign split_nums[2] = nums[11:8];
	 assign split_nums[3] = nums[15:12];
	 
	 
	 
    always @(posedge dp_clk) begin
        index <= index + 1'b1;
        val <= split_nums[index];
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

    always @(posedge blink_clk or adj) begin
        if (adj) begin
            num_disable <= ~num_disable; 
        end else begin
            num_disable <= 0;
        end
    end

    decode_7seg decoder(
        .val(val),
        .num_disable(num_disable),
        .cats(cats)
    );
	 
	 
 endmodule