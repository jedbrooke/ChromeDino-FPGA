// Adapted from:
// "FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01"

`default_nettype none

module obstacle #(
      IWIDTH=12,       // half obstacle width (for ease of coordinate calculations)
      IHEIGHT=CACTUS_HEIGHT_MIN,      // half obstacle height 
      IX=D_WIDTH,     // initial horizontal position of square center
      IY=FLOOR_HEIGHT,// initial vertical position of square center
      IX_DIR=0,       // initial horizontal direction: 1 is right, 0 is left
      IY_DIR=0,       // initial vertical direction: 1 is down, 0 is up
      IX_VEL=1,	      // initial horizontal velocity 	
      IY_VEL=0,       // initial vertical velocity 
      IWAIT=OBSTACLE_WAIT_TIME,
      SEED=4'b0001,  // This is for the randomizer 
      TYPE=0         // 0 for cactus, 1 for anything else 
   )

   (
      input wire i_clk,          // base clock
      input wire i_ani_stb,      // animation clock: pixel clock is 1 pix/frame
      input wire i_rst,          // reset: returns animation to starting position
      input wire i_animate,      // animate when input is high
      input wire i_grace,        // game is in the grace period     
      output wire [11:0] o_x1,   // obstacle left edge: 12-bit value: 0-4095
      output wire [11:0] o_x2,   // obstacle right edge
      output wire [11:0] o_y1,   // obstacle top edge
      output wire [11:0] o_y2    // obstacle bottom edge
   );

`include "parameters.v"

   reg signed [11:0] x = IX;   // horizontal position of square centre
   reg [11:0] y = IY;   // vertical position of square centre
   reg x_dir = IX_DIR;  // horizontal animation direction
   reg y_dir = IY_DIR;  // vertical animation direction
	wire [3:0] rnd;	// Result of randomizer 
   reg rnd_clk;		// Randomizer Clock 
   wire waiting_state;
   reg [15:0] wait_timer = IWAIT;
   reg [7:0] height = IHEIGHT; //Size height of object (half of it)
   
   //Generate our random values 
   randomValue #(.SEED(SEED)) rand(.o_out(rnd),.i_clk(rnd_clk),.i_rst(1'b0));
   
   assign waiting_state = wait_timer > 30;
	
   //Update position of object
   assign o_x1 = x - IWIDTH;  // left: centre minus half horizontal size
   assign o_x2 = x + IWIDTH;  // right
   assign o_y1 = y - height;  // top
   assign o_y2 = y + height;  // bottom

   always @ (posedge i_clk) begin
      if (i_rst) begin // on reset return to starting position
         x <= IX;
         y <= IY;
         x_dir <= IX_DIR;
         y_dir <= IY_DIR;
         wait_timer <= IWAIT;
	     rnd_clk <= 0;
      end
	 
      /*
      	If we are animating: 
		If we're not waiting, check if we've reached left side of screen: 
		   - Move back to our waiting area and randomize what's needed for object 
		Otherwise if we're not waiting, keep moving to the left. 
		NOTE: Since the floor has no velocity, it'll always maintain its position 	
      Otherwise, if we aren't animating: 
		As long as we're not in grace period, keep running the randomizer and add in object delays
      */

      if (i_animate && i_ani_stb) begin
         if(~waiting_state) begin 
            if (x <= -(2*IWIDTH) - 1) begin  // obstacle is all the way off of the left of screen
               x <= IX + IWIDTH;  // move back to the right of the screen (waiting area)       
               wait_timer <= (wait_timer > OBSTACLE_WAIT_TIME) ? wait_timer : OBSTACLE_WAIT_TIME; //reset the wait timer
               //re-randomize height
               rnd_clk <= ~rnd_clk;
			      //Randomize size heights of cacti
			      height <=  (TYPE) ? height : CACTUS_HEIGHT_MIN + rnd;
			      //Randomize positional heights of birds
			      y <= (TYPE) ? BIRD_HEIGHT_MAX - {rnd[3:0],2'b0} : y;
            end //End of if not in waiting state 
            else begin
               x <= (x_dir) ? x + IX_VEL : x - (IX_VEL*OBSTACLE_VEL);  // move left if positive x_dir - jasper
               y <= (TYPE) ? y : FLOOR_HEIGHT - height;  // move down if positive y_dir - jasper
            end //End of movement block 
         end //End of if-else waiting_state block 
         else begin //*** Else statement for if we're not animating 
            if (~i_grace) begin
               rnd_clk <= ~rnd_clk;
               wait_timer <= wait_timer - {rnd[3:0],1'b0}; 
            end //End of if not in grace period 
         end //End of else statement indicated by *** 
      end //End of if-else animate block 
   end //End of always i_clk block 
	
endmodule
