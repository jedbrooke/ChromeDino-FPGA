// FPGA VGA Graphics Part 1: Top Module
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none
module top(
      input wire i_clk,             // board clock: 100 MHz on Arty/Basys3/Nexys
      input wire RST_BTN,           // reset button
      input wire dino_jump,
      input wire dino_duck,
      input wire [1:0] game_state,
      output wire VGA_HS_O,         // horizontal sync output
      output wire VGA_VS_O,         // vertical sync output
      output wire [2:0] VGA_R_O,
      output wire [2:0] VGA_G_O,
      output wire [1:0] VGA_B_O,
      output wire collision
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

   wire signed [11:0] cactus_data [0:NUM_CACTI-1][0:3]; // 12-bit values: 0-4095, x1,x2,y1,y2
   wire signed [11:0] bird_data [0:NUM_BIRDS-1][0:3];
   wire [NUM_CACTI-1:0] pixel_in_cactus;
   wire [NUM_BIRDS-1:0] pixel_in_bird;
   wire signed [11:0] floor_data [0:3];
   wire signed [11:0] dino_data [0:3];
   wire pixel_in_floor;
   wire pixel_in_dino;
	wire dead; 
	wire grace;
	wire play;

	parameter dp_offset = 20; 
	assign dead = (game_state == DEAD_STATE) ? 1'b1 : 1'b0;
	assign grace = (game_state == GRACE_STATE) ? 1'b1 : 1'b0;
	assign play = (game_state == PLAY_STATE) ? 1'b1 : 1'b0;


   always @(posedge i_clk)
      {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

   wire game_clock;
   assign game_clock = i_clk & ~dead;

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

   genvar i;
   generate
      for (i = 0; i < NUM_CACTI; i=i+1) begin
         obstacle #(.IX(D_WIDTH+dp_offset), .SEED(i + 1),.IWAIT((i+1)*OBSTACLE_WAIT_TIME),.TYPE(0)) cactus (
               .i_clk(game_clock), 
               .i_ani_stb(pix_stb),
               .i_rst(rst),
               .i_animate(animate),
               .i_grace(grace),
               .o_x1(cactus_data[i][0]),
               .o_x2(cactus_data[i][1]),
               .o_y1(cactus_data[i][2]),
               .o_y2(cactus_data[i][3])
         );
   end
   endgenerate
	
	genvar h;
   generate
   	for (h = 0; h < NUM_BIRDS; h=h+1) begin
   		obstacle #(.IX(D_WIDTH+dp_offset),.IY(BIRD_HEIGHT_MAX),.IHEIGHT(10),.IWIDTH(15),.TYPE(1'b1),.SEED(h+1),.IWAIT((h+1)*OBSTACLE_WAIT_TIME + (OBSTACLE_WAIT_TIME / 2))) bird (
   		     .i_clk(game_clock), 
   		     .i_ani_stb(pix_stb),
   		     .i_rst(rst),
   		     .i_animate(animate),
   		     .i_grace(grace),
   		     .o_x1(bird_data[h][0]),
   		     .o_x2(bird_data[h][1]),
   		     .o_y1(bird_data[h][2]),
   		     .o_y2(bird_data[h][3])
   		);
   	end
   endgenerate
	 
   obstacle #(.IX(D_WIDTH/2),.IY(D_HEIGHT-((D_HEIGHT - FLOOR_HEIGHT)/2)),.IX_VEL(0),.IY_VEL(0),.IWIDTH(D_WIDTH/2),.IHEIGHT((D_HEIGHT - FLOOR_HEIGHT)/2),.IWAIT(0),.TYPE(1)) floor (
	    .i_clk(i_clk), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
		.i_grace(1'b0),
        .o_x1(floor_data[0]),
        .o_x2(floor_data[1]),
        .o_y1(floor_data[2]),
        .o_y2(floor_data[3])
   );


   dinosaur dino(
        .i_clk(game_clock), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
		  .i_jump(dino_jump),
		  .i_duck(dino_duck),
		  .o_x1(dino_data[0]),
        .o_x2(dino_data[1]),
        .o_y1(dino_data[2]),
        .o_y2(dino_data[3])
   );

	genvar j;
	generate
		for (j = 0; j < NUM_CACTI; j=j+1) begin
			assign pixel_in_cactus[j] = ((x > cactus_data[j][0]) & (y > cactus_data[j][2]) &
			      (x < cactus_data[j][1]) & (y < cactus_data[j][3])) ? 1'b1 : 1'b0;
		end
	 endgenerate
	 
	 genvar k;
	 generate
		for (k = 0; k < NUM_BIRDS; k=k+1) begin
			assign pixel_in_bird[k] = ((x > bird_data[k][0]) & (y > bird_data[k][2]) &
				(x < bird_data[k][1]) & (y < bird_data[k][3])) ? 1'b1 : 1'b0;
		end
	endgenerate
	 
	assign pixel_in_floor = ((x > floor_data[0]) & (y > floor_data[2]) & (x < floor_data[1]) & (y < floor_data[3])) ? 1'b1 : 1'b0;
   assign pixel_in_dino = ((x > dino_data[0]) & (y > dino_data[2]) & (x < dino_data[1]) & (y < dino_data[3])) ? 1'b1 : 1'b0;

   assign px_color = ((|pixel_in_cactus) | (|pixel_in_bird) | pixel_in_floor | pixel_in_dino) ? 
	({8{|pixel_in_cactus}} & CACTUS_COLOR) | ( {8{|pixel_in_bird}} & BIRD_COLOR) | ({8{pixel_in_floor}} & FLOOR_COLOR) | ({8{pixel_in_dino}} & DINO_COLOR) 
	: BG_COLOR;

	assign collision = pixel_in_dino & (|pixel_in_bird | (|pixel_in_cactus));

	assign VGA_R_O = px_color[7:5];
	assign VGA_G_O = px_color[4:2];
	assign VGA_B_O = px_color[1:0];
	 
endmodule
