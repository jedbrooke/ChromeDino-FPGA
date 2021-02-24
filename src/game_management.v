// This module is adapted from:
// "FPGA VGA Graphics Part 1: Top Module
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01"

`default_nettype none

module game_management (
  input wire i_clk,             // Board Clock: 100 MHz on Arty/Basys3/Nexys
  input wire rst,           // Reset Button
  input wire dino_jump,	    // Dino Jump Button 
  input wire dino_duck,	    // Dino Duck Button 
	input wire [1:0] game_state,  //Three possible game states 
  input wire super_secret_switch, //secret switch for secrets
  output wire VGA_HS_O,         // Horizontal Sync Output
  output wire VGA_VS_O,         // Vertical Sync Output
	output wire [2:0] VGA_R_O,  //Red Output 
	output wire [2:0] VGA_G_O,  //Green Output
	output wire [1:0] VGA_B_O,  //Blue Output
  output wire collision    	    //Collision State Output
  );

`include "parameters.v"
  
  wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
  wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
  wire animate;  // high when we're ready to animate at end of drawing

  // {3 bits of red, 3 bits of green, 2 bits of blue}
  wire [7:0] px_color;

  // generate a 25 MHz pixel strobe (This was given to us) 
  reg [15:0] cnt = 0;
  reg pix_stb = 0;
	
  always @(posedge i_clk)
    {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

  // This will keep track of the position of the cactus and bird
  // x1: left edge, x2: right edge, y1: top edge, y2: bottom edge 
  wire signed [11:0] cactus_data [0:NUM_CACTI-1][0:3]; // 12-bit values: 0-4095, x1,x2,y1,y2
  wire signed [11:0] bird_data [0:NUM_BIRDS-1][0:3];
	
  // These will indicate whether a cactus or bird model is in the current pixel being drawn 
  wire [NUM_CACTI-1:0] pixel_in_cactus;
  wire [NUM_BIRDS-1:0] pixel_in_bird;
	
  // Same as above but for the floor and data
  wire signed [11:0] floor_data [0:3];
  wire signed [11:0] dino_data [0:3];
  wire pixel_in_floor;
  wire pixel_in_dino;

  //Part of the bird and cactus models would show up on the right edge of the screen 
  //This offset will shift each model to the rigth 20 px to fix this visual issue
  parameter dp_offset = 20;

  // These are all the possible states 
  wire dead; 
  wire grace;
  wire play;

  //Make sure each state is updated accordingly 
  assign dead = (game_state == DEAD_STATE) ? 1'b1 : 1'b0;
  assign grace = (game_state == GRACE_STATE) ? 1'b1 : 1'b0;
  assign play = (game_state == PLAY_STATE) ? 1'b1 : 1'b0;

  wire game_clock;
	
  //Game clock will only run if we're not in the dead state 
  assign game_clock = i_clk & ~dead;

  //This display module was provided 
  vga640x480 display (
	 .i_clk(i_clk),	 //Base Clock
	 .i_pix_stb(pix_stb),	//Pixel Clock Strobe 
	 .i_rst(rst),		//Reset: Restarts Frame 
	 .o_hs(VGA_HS_O), 	//Horizontal sync
	 .o_vs(VGA_VS_O), 	//Vertical sync
	 .o_x(x), 		//x position of current pixel we're drawing 
	 .o_y(y),		//y position of current pixel we're drawing
	 .o_animate(animate)  //high for one tick at the end of active drawing
  );
	
  //NOTE: Every time x or y position is being referenced, it's the object's (x,y) midpoint coordinate 
	
  /*
   This is where we generate the cacti:  
   - Each cactus will start with an initial x-position of (display width + offset) 
     (Reference the comment concerning dp_offset to see why this is being added) 
   - Note that there are no cactus sizes being passed in - they're default values in obstacle
   - The seed being passed in will be used by a randomizer module 
   - The wait time is how long a cactus will wait off-screen 
     (We are varying the wait times by multiplying by (i+1) so that they don't all come in at the same time) 
   - A cactus is type 0. Any other object is just a 1. 
   */
  genvar i;
  generate
    for (i = 0; i < NUM_CACTI; i=i+1) begin
        obstacle #(.IX(D_WIDTH+dp_offset),.IY(FLOOR_HEIGHT),.SEED(i + 1),.IWAIT((i+1)*OBSTACLE_WAIT_TIME),.TYPE(0),.OBSTACLE_WAIT_TIME(OBSTACLE_WAIT_TIME),.OBSTACLE_VEL(OBSTACLE_VEL),.CACTUS_HEIGHT_MIN(CACTUS_HEIGHT_MIN),.CACTUS_HEIGHT_MAX(CACTUS_HEIGHT_MAX),.FLOOR_HEIGHT(FLOOR_HEIGHT),.BIRD_HEIGHT_MAX(BIRD_HEIGHT_MAX)) cactus (
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
	
  /* 
  This is where we generate the birds:  
   - Each bird will start with an initial x-position of (display width + offset) 
     (Reference the comment concerning dp_offset to see why this is being added) 
   - Each bird will start with an initial y-position of what we set as the maximum height
   - Each bird will be 20 pixels tall and 30 pixels wide (remember the passed in values are w.r.t. midpoint)
   - The seed being passed in will be used by a randomizer module 
   - The wait time is how long a bird will wait off-screen 
     (We are varying the wait times by multiplying by (i+1) so that they don't all come in at the same time.
      AND, we are also adding a half factor to minimize the birds coming in at the same time as a cactus) 
   - Bird type is 1 since it's not a cactus  
  */
	genvar h;
    generate
   	  for (h = 0; h < NUM_BIRDS; h=h+1) begin
        obstacle #(.IX(D_WIDTH+dp_offset),.IY(BIRD_HEIGHT_MAX),.IHEIGHT(10),.IWIDTH(15),.TYPE(1'b1),.SEED(h+1),.IWAIT((h+1)*OBSTACLE_WAIT_TIME + (OBSTACLE_WAIT_TIME / 2)),.OBSTACLE_WAIT_TIME(OBSTACLE_WAIT_TIME),.OBSTACLE_VEL(OBSTACLE_VEL),.CACTUS_HEIGHT_MIN(CACTUS_HEIGHT_MIN),.CACTUS_HEIGHT_MAX(CACTUS_HEIGHT_MAX),.FLOOR_HEIGHT(FLOOR_HEIGHT),.BIRD_HEIGHT_MAX(BIRD_HEIGHT_MAX)) bird (
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
	 
  /* 
  This is where we produce the floor:  
   - Floor will have a permanent x-position of half the display width 
   - Floor will have a permanent y-position of half the floor height pixels above the bottom of the display 
   - Floor will not be moving so x and y velocities are 0
   - Floor will be 80 pixels tall and its width is equal to display width 
   - Floor has no wait time since it's on screen at all times
   - Floor type is 1 since it's not a cactus   
  */
   obstacle #(.IX(D_WIDTH/2),.IY(D_HEIGHT-((D_HEIGHT - FLOOR_HEIGHT)/2)),.IX_VEL(0),.IY_VEL(0),.IWIDTH(D_WIDTH/2),.IHEIGHT((D_HEIGHT - FLOOR_HEIGHT)/2),.IWAIT(0),.TYPE(1),.OBSTACLE_WAIT_TIME(OBSTACLE_WAIT_TIME),.OBSTACLE_VEL(OBSTACLE_VEL),.CACTUS_HEIGHT_MIN(CACTUS_HEIGHT_MIN),.CACTUS_HEIGHT_MAX(CACTUS_HEIGHT_MAX),.FLOOR_HEIGHT(FLOOR_HEIGHT),.BIRD_HEIGHT_MAX(BIRD_HEIGHT_MAX)) floor (
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

  // This manages all the dino logic
  // Based on what the dino is doing, it'll output its position so we can draw
  dinosaur #(.DINO_X(DINO_X),.DINO_HEIGHT(DINO_HEIGHT),.DINO_DUCK_HEIGHT(DINO_DUCK_HEIGHT),.DINO_WIDTH(DINO_WIDTH),.DINO_REG_JUMP_STRENGTH(DINO_REG_JUMP_STRENGTH),.DINO_ULTRA_JUMP_STRENGTH(DINO_ULTRA_JUMP_STRENGTH),.DINO_GRAVITY(DINO_GRAVITY),.DINO_FASTFALL(DINO_FASTFALL),.FLOOR_HEIGHT(FLOOR_HEIGHT)) dino(
    .i_clk(game_clock), 
    .i_ani_stb(pix_stb),
    .i_rst(rst),
    .i_animate(animate),
    .i_jump(dino_jump),
    .i_duck(dino_duck),
    .i_sss(super_secret_switch),
    .o_x1(dino_data[0]),
    .o_x2(dino_data[1]),
    .o_y1(dino_data[2]),
    .o_y2(dino_data[3])
  );

	//With our current pixel (x,y), check if we are inside a cactus! If so, make sure we draw a green pixel
	genvar j;
	generate
		for (j = 0; j < NUM_CACTI; j=j+1) begin
			assign pixel_in_cactus[j] = ((x > cactus_data[j][0]) & (y > cactus_data[j][2]) &
			      (x < cactus_data[j][1]) & (y < cactus_data[j][3])) ? 1'b1 : 1'b0;
		end
	 endgenerate
	 
	//With our current pixel (x,y), check if we are inside a bird! If so, make sure we draw a gray pixel
	 genvar k;
	 generate
		for (k = 0; k < NUM_BIRDS; k=k+1) begin
			assign pixel_in_bird[k] = ((x > bird_data[k][0]) & (y > bird_data[k][2]) &
				(x < bird_data[k][1]) & (y < bird_data[k][3])) ? 1'b1 : 1'b0;
		end
	endgenerate

	//With our current pixel (x,y), check if we are inside the floor! If so, make sure we draw a blue pixel
   assign pixel_in_floor = ((x > floor_data[0]) & (y > floor_data[2]) & (x < floor_data[1]) & (y < floor_data[3])) ? 1'b1 : 1'b0;
	
	//With our current pixel (x,y), check if we are inside the dino! If so, make sure we draw a red pixel 
   assign pixel_in_dino = ((x > dino_data[0]) & (y > dino_data[2]) & (x < dino_data[1]) & (y < dino_data[3])) ? 1'b1 : 1'b0;
	
	/*
	  If our current pixel was inside any of the objects,
	  then check to see what object it was and make sure its color will be drawn! 
	  Otherwise, make sure black will be drawn since this current pixel must just be the background
	*/
   assign px_color = ((|pixel_in_cactus) | (|pixel_in_bird) | pixel_in_floor | pixel_in_dino) ? 
	({8{|pixel_in_cactus}} & CACTUS_COLOR) | ( {8{|pixel_in_bird}} & BIRD_COLOR) | ({8{pixel_in_floor}} & FLOOR_COLOR) | ({8{pixel_in_dino}} & DINO_COLOR) 
	: BG_COLOR;
	
	//If our current pixel reported back that it's inside a dino AND a (bird or cactus), we just collided! 
	assign collision = pixel_in_dino & (|pixel_in_bird | (|pixel_in_cactus));

	//Here's the final color that our current pixel should have 
	assign VGA_R_O = px_color[7:5];
	assign VGA_G_O = px_color[4:2];
	assign VGA_B_O = px_color[1:0];
	 
endmodule
