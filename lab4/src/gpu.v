`timescale 1ns / 1ps
module gpu #(
		DEAD_STATE = 2'b00
	)
	
	(
	input wire dp_clk,
	input wire blink_clk,
	input wire [1:0] game_state,
	input wire [15:0] nums,
	output reg [6:0] cats = 7'b1111111,
   output reg [3:0] anodes = 7
    );

    reg [3:0] val = 0;
    reg [1:0] index = 0;
	wire [3:0] split_nums[0:3];
	wire [6:0] decoded;
	 
	reg blink_enable = 0;
	 
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

	always @(posedge blink_clk) begin
		if(game_state == DEAD_STATE) begin
			blink_enable <= ~blink_enable;
		end else begin
		    blink_enable <= 0;
		end
	end

    decode_7seg decoder(
        .val(val),
        .num_disable(blink_enable),
        .cats(decoded[6:0])
    );
	 
endmodule