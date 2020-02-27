// FPGA VGA Graphics Part 1: Top Module
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none

module top(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         // reset button
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [2:0] VGA_R_O,
    output wire [2:0] VGA_G_O,
	output wire [1:0] VGA_B_O
    );
`include "parameters.v"
    // wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    wire rst = RST_BTN;  // reset is active high on Basys3 (BTNC)

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
    wire animate;  // high when we're ready to animate at end of drawing

    wire [7:0] px_color;

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt = 0;
    reg pix_stb = 0;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y),
        .o_animate(animate)
    );
    wire [11:0] obstacle_data [0:NUM_OBSTACLES-1][0:3]; // 12-bit values: 0-4095, x1,x2,y1,y2
    wire [NUM_OBSTACLES-1:0] pixel_in_obstacle;
	
    obstacle cactus (
        .i_clk(CLK), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
        .o_x1(obstacle_data[0][0]),
        .o_x2(obstacle_data[0][1]),
        .o_y1(obstacle_data[0][2]),
        .o_y2(obstacle_data[0][3])
    );

    obstacle #(.IY(BIRD_HEIGHT)) bird (
        .i_clk(CLK), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
        .o_x1(obstacle_data[1][0]),
        .o_x2(obstacle_data[1][1]),
        .o_y1(obstacle_data[1][2]),
        .o_y2(obstacle_data[1][3])
    );
	 genvar i;
	 generate
		 for (i = 0; i < NUM_OBSTACLES; i=i+1) begin
			  assign pixel_in_obstacle[i] = ((x > obstacle_data[i][0]) & (y > obstacle_data[i][2]) &
			  (x < obstacle_data[i][1]) & (y < obstacle_data[i][3])) ? 1'b1 : 1'b0;
		 end
	 endgenerate

    // assign catc_1 = ((x > catc_1_x1) & (y > catc_1_y1) &
    //     (x < catc_1_x2) & (y < catc_1_y2)) ? 1 : 0;
    // assign bird_1 = ((x > bird_1_x1) & (y > bird_1_y1) &
    //     (x < bird_1_x2) & (y < bird_1_y2)) ? 1 : 0;

    assign px_color = (| pixel_in_obstacle) ? (pixel_in_obstacle[0] ? CACTUS_COLOR : BIRD_COLOR) : 8'b0;

    assign VGA_R_O = px_color[7:5];
    assign VGA_G_O = px_color[4:2];
    assign VGA_B_O = px_color[1:0];
endmodule
