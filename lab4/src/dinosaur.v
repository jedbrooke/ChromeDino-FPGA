// FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none

module dinosaur (
    input wire i_clk,         // base clock
    input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
    input wire i_rst,         // reset: returns animation to starting position
    input wire i_animate,     // animate when input is high
    input wire i_jump,        // jump button is pressed
    input wire i_duck,        // duck button is pressed
    output wire [11:0] o_x1,  // square left edge: 12-bit value: 0-4095
    output wire [11:0] o_x2,  // square right edge
    output wire [11:0] o_y1,  // square top edge
    output wire [11:0] o_y2   // square bottom edge
    );
`include "parameters.v"
    reg [11:0] x = DINO_X;   // horizontal position of square centre
    reg signed [11:0] y = FLOOR_HEIGHT - DINO_HEIGHT;   // vertical position of square centre
    reg [7:0] height;
    reg signed [15:0] y_vel;  // vertical animation direction
    reg is_jumping;

    assign o_x1 = x - DINO_WIDTH;  // left: centre minus half horizontal size
    assign o_x2 = x + DINO_WIDTH;  // right
    assign o_y1 = y - height;  // top
    assign o_y2 = y + height;  // bottom

    always @ (posedge i_clk) begin
        if (i_rst) begin // on reset return to starting position        
            x <= DINO_X;
            y <= FLOOR_HEIGHT - DINO_HEIGHT;
            y_vel <= 0;
			is_jumping <= 0;
        end else if (i_animate && i_ani_stb) begin
				if(is_jumping) begin
					y_vel <= y_vel + DINO_GRAVITY;
					y <= y + y_vel;		
					if(y > FLOOR_HEIGHT - height) begin
						y <= FLOOR_HEIGHT - height;
						y_vel <= 1'b0;
						is_jumping <= 1'b0;
					end
				end else if(i_jump) begin
					is_jumping <= 1'b1;
					y_vel <= -DINO_JUMP_STRENGTH;
					y <= y - DINO_JUMP_STRENGTH;
				end 
			end else if(i_duck) begin
				 height <= DINO_DUCK_HEIGHT;
				 if (y == FLOOR_HEIGHT - DINO_HEIGHT)
					y <= y + (DINO_HEIGHT - DINO_DUCK_HEIGHT);
			end else begin
				if (y == FLOOR_HEIGHT - DINO_DUCK_HEIGHT)
					y <= FLOOR_HEIGHT - DINO_HEIGHT;
				height <= DINO_HEIGHT;
			end
    end
endmodule
