`timescale 1ms / 1us


module gpu_tb(
    
);

    reg [6:0] seg;
    reg [3:0] an;
    reg dp_clk;
    reg blink_clk;
    reg [3:0] nums [0:3];
    reg adj;

    gpu gpu(
        .dp_clk(dp_clk),
        .blink_clk(blink_clk),
        .nums(nums),
        .adj(adj),
        .cats(seg),
        .anodes(an)
    );

    initial begin
        //initialize inputs
        seg = 0;
        an = 0;
        dp_clk = 0;
        blink_clk = 0;
        nums = 0;
        adj = 0;

        // Wait 100 ns for global reset to finish
		#100;

        // Add stimulus here
        for(integer i = 0; i < 4; i = i+1) begin
            nums[i] = i;
        end
        #2000
        for(integer i = 0; i < 4; i = i+1) begin
            nums[i] = i*2;
        end
        #2000
        for(integer i = 0; i < 4; i = i+1) begin
            nums[i] = i + 4;
        end
        #2000
        for(integer i = 0; i < 4; i = i+1) begin
            nums[i] = 8;
        end
        #2000
        for(integer i = 0; i < 4; i = i+1) begin
            nums[i] = 9;
        end
        #2000 $finish;
        
    end

always begin
    #2 dp_clk = ~dp_clk;
end
always begin
    #1000 blink_clk = ~blink_clk;
end



endmodule // gpu_tb