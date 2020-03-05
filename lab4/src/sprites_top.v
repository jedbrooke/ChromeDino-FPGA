// FPGA VGA Graphics Part 1: Top Module
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none

module top(
      input wire i_clk,             // board clock: 100 MHz on Arty/Basys3/Nexys
      input wire RST_BTN,           // reset button
      output wire VGA_HS_O,         // horizontal sync output
      output wire VGA_VS_O,         // vertical sync output
      output wire [2:0] VGA_R_O,
      output wire [2:0] VGA_G_O,
      output wire [1:0] VGA_B_O,
   );
`include "parameters.v"
   // wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
   wire rst = RST_BTN;  // reset is active high on Basys3 (BTNC)

   wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
   wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
   wire animate;  // high when we're ready to animate at end of drawing

   // generate a 25 MHz pixel strobe
   reg [15:0] cnt = 0;
   reg pix_stb = 0;
	
   wire [7:0] px_color;
   wire [7:0] sprite_color;
   wire [SPRITE_ADDR_WIDTH-1:0] sprite_addr;


   always @(posedge i_clk)
      {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000


   vga640x480 display (
        .i_clk(i_clk),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y),
        .o_animate(animate)
   );

   sprites sprites (
      .i_clk(i_clk),
      .i_sel(2'b0),
      .i_addr(sprite_addr),
      .pixel_color(sprite_color)
   );

   assign sprite_addr = (x < DINO_IMG_WIDTH) & (y < DINO_IMG_HEIGHT) ? DINO_IMG_WIDTH * x + y : DINO_IMG_SIZE - 1;

   assign pixel_color = (x < DINO_IMG_WIDTH) & (y < DINO_IMG_HEIGHT) ? sprite_color : BG_COLOR;

	assign VGA_R_O = px_color[7:5];
	assign VGA_G_O = px_color[4:2];
	assign VGA_B_O = px_color[1:0];
	 
endmodule
