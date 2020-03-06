// FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none

module obstacle #(
      IWIDTH=12,       // half obstacle width (for ease of co-ordinate calculations)
      IHEIGHT=CACTUS_HEIGHT_MIN,      // half obstacle height 
      IX=D_WIDTH,     // initial horizontal position of square centre
      IY=FLOOR_HEIGHT,// initial vertical position of square centre
      IX_DIR=0,       // initial horizontal direction: 1 is right, 0 is left
      IY_DIR=0,       // initial vertical direction: 1 is down, 0 is up
      IX_VEL=1,
      IY_VEL=0,
      IWAIT=OBSTACLE_WAIT_TIME,
      SEED=4'b0001,
      TYPE=0         // 0 for cactus 1 for bird 
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
   reg signed [11:0] x = 0;   // horizontal position of square centre
   reg [11:0] y = IY;   // vertical position of square centre
   reg x_dir = IX_DIR;  // horizontal animation direction
   reg y_dir = IY_DIR;  // vertical animation direction
   wire [3:0] rnd;
   reg rnd_clk;
   wire waiting_state;
   reg [15:0] wait_timer = IWAIT;
   reg [7:0] height = IHEIGHT;

   randomValue #(.SEED(SEED)) rand(.i_out(rnd),.i_clk(rnd_clk),.i_rst(1'b0));
		
   assign waiting_state = wait_timer > 0;

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
      end
      if (i_animate && i_ani_stb) begin
         if(~waiting_state) begin
            if (x <= -(2*IWIDTH) - 1) begin  // obstacle is all the way off of the left of screen
               x <= D_WIDTH + IWIDTH;  // move back to the right of the screen       
               wait_timer <= (wait_timer > OBSTACLE_WAIT_TIME) ? wait_timer : OBSTACLE_WAIT_TIME; //reset the wait timer
               //re-randomize height
               rnd_clk <= ~rnd_clk;
               if (TYPE) begin
                  height <= CACTUS_HEIGHT_MIN + rnd;
               end else begin
                  y <= BIRD_HEIGHT_MAX - rnd;
               end
            end else begin
               x <= (x_dir) ? x + IX_VEL : x - (IX_VEL*OBSTACLE_VEL);  // move left if positive x_dir
               y <= (TYPE) ? FLOOR_HEIGHT - height : y;  // move down if positive y_dir
            end
         end else begin
            if (~i_grace) begin
               rnd_clk <= ~rnd_clk;
               wait_timer <= wait_timer - rnd;
            end
         end
      end
   end
endmodule
