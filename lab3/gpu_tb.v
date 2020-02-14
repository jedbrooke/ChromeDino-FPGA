`timescale 1ms / 1us


module gpu_tb(
    
);

    reg [6:0] seg;
    reg [3:0] an;
    reg dp_clk;
    reg blink_clk;
    reg [3:0] nums [0:3];
	 reg [15:0] nums_flatten;
    reg adj;

    gpu gpu(
        .dp_clk(dp_clk),
        .blink_clk(blink_clk),
        .nums(nums_flatten),
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
        nums[0] = 0;
        nums[1] = 0;
        nums[2] = 0;
        nums[3] = 0;
        nums_flatten = 0;
        adj = 0;
		assign nums_flatten = {nums[0],nums[1],nums[2],nums[3]};

        // Wait 100 ns for global reset to finish
		#100;

        // Add stimulus here
        #100 nums[0] = 0;
        #100 nums[1] = 1;
        #100 nums[2] = 2;
        #100 nums[3] = 3;
        #2000
        #100 nums[0] = 4;
        #100 nums[1] = 5;
        #100 nums[2] = 6;
        #100 nums[3] = 7;
        #2000
        #100 nums[0] = 8;
        #100 nums[1] = 9;
        #100 nums[2] = 8;
        #100 nums[3] = 9;
		  
        #200 $finish;
        
    end

	always #2 dp_clk = ~dp_clk;
	always #1000 blink_clk = ~blink_clk;



endmodule // gpu_tb