// FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none

module obstacle #(
      WIDTH=30,       // half rect width (for ease of co-ordinate calculations)
      HEIGHT=20,      // half rect height 
      IX=D_WIDTH,     // initial horizontal position of square centre
      IY=FLOOR_HEIGHT,// initial vertical position of square centre
      IX_DIR=0,       // initial horizontal direction: 1 is right, 0 is left
      IY_DIR=0,       // initial vertical direction: 1 is down, 0 is up
      IX_VEL=1,
      IY_VEL=0,
      IWAIT=500
   )
   (
      input wire i_clk,         // base clock
      input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
      input wire i_rst,         // reset: returns animation to starting position
      input wire i_animate,     // animate when input is high
      output wire [11:0] o_x1,  // square left edge: 12-bit value: 0-4095
      output wire [11:0] o_x2,  // square right edge
      output wire [11:0] o_y1,  // square top edge
      output wire [11:0] o_y2   // square bottom edge
   );
`include "parameters.v"
   reg signed [11:0] x = IX;   // horizontal position of square centre
   reg [11:0] y = IY;   // vertical position of square centre
   reg x_dir = IX_DIR;  // horizontal animation direction
   reg y_dir = IY_DIR;  // vertical animation direction
   reg rnd_bit = 1;
   wire waiting_state;
   reg [8:0] wait_timer = IWAIT;
		
   assign waiting_state = wait_timer > 0;

   assign o_x1 = x - WIDTH;  // left: centre minus half horizontal size
   assign o_x2 = x + WIDTH;  // right
   assign o_y1 = y - HEIGHT;  // top
   assign o_y2 = y + HEIGHT;  // bottom
	 

   always @ (posedge i_clk) begin
      if (i_rst) begin // on reset return to starting position
         x <= IX;
         y <= IY;
         x_dir <= IX_DIR;
         y_dir <= IY_DIR;
      end
      if (i_animate && i_ani_stb) begin
         if(~waiting_state) begin
            x <= (x_dir) ? x + IX_VEL : x - (IX_VEL*OBSTACLE_VEL);  // move left if positive x_dir
            y <= (y_dir) ? y + IY_VEL : y - (IY_VEL*OBSTACLE_VEL);  // move down if positive y_dir
         end else begin
            //get a new rnd_bit
            wait_timer <= wait_timer - rnd_bit;
         end
      end
      if (x <= -(2*WIDTH) - 1) begin  // sqaure is all the way off of the left of screen
         x <= D_WIDTH + WIDTH;  // move back to the right of the screen       
         wait_timer <= 511;
      end
   end
endmodule
