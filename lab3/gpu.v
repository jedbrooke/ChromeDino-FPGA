`timescale 1ns / 1ps
module gpu(dp_clk,blink_clk,nums,adj){
    input dp_clk;
    input blink_clk;
    input [3:0] nums[0:3];
    input adj;

    reg [3:0] val;
    reg [1:0] index;
    reg num_disable;

    output [3:0] cats;
    output [3:0] anodes;

    for(integer i = 0; i < 4; i = i + 1) begin
        assign anodes[i] = ~(i == index);
    end
    always @(posedge dp_clk) begin
        index <= index + 1'b1;
    end

    always @(blink_clk, adj) begin
        if (adj) begin
            num_disable <= ~num_disable; 
        end else begin
            num_disable <= 0;
        end
    end

    decode_7seg decoder(
        .val(val[index]),
        .disable(num_disable),
        .cats(cats)
    );
    

}