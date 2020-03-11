// Adapted from:
// "FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01"

`default_nettype none

module dinosaur #(
		DINO_X = 80,
		DINO_HEIGHT = 30,
		DINO_DUCK_HEIGHT = 20,
		DINO_WIDTH = 20,
		DINO_REG_JUMP_STRENGTH = 16'd17,
		DINO_ULTRA_JUMP_STRENGTH = 16'd23,
		DINO_GRAVITY = 1, //positive is down
		DINO_FASTFALL = 1,
		FLOOR_HEIGHT = 400
	)
	
	(
	    input wire i_clk,         // base clock
	    input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
	    input wire i_rst,         // reset: returns animation to starting position
	    input wire i_animate,     // animate when input is high
	    input wire i_jump,        // jump button is pressed
	    input wire i_duck,        // duck button is pressed
		input wire i_sss,		  // SUPER SECRET SWITCH
	    output wire [11:0] o_x1,  // square left edge: 12-bit value: 0-4095
	    output wire [11:0] o_x2,  // square right edge
	    output wire [11:0] o_y1,  // square top edge
	    output wire [11:0] o_y2   // square bottom edge
    );

    reg [11:0] x = DINO_X;   // horizontal position of square centre
    reg signed [11:0] y = FLOOR_HEIGHT - DINO_HEIGHT;   // vertical position of square centre
    reg [7:0] current_height;
    reg signed [15:0] y_vel;  // vertical animation direction
    reg is_jumping;
	wire [3:0] dino_fastfall;
	wire [15:0] dino_jump_strength;

    assign o_x1 = x - DINO_WIDTH;  // left: centre minus half horizontal size
    assign o_x2 = x + DINO_WIDTH;  // right
    assign o_y1 = y - current_height;  // top
    assign o_y2 = y + current_height;  // bottom
	 
	assign dino_fastfall = i_duck ? DINO_FASTFALL : 4'b0;
	assign dino_jump_strength = i_sss ? DINO_ULTRA_JUMP_STRENGTH : DINO_REG_JUMP_STRENGTH;

    always @ (posedge i_clk) begin
        if (i_rst) begin // on reset return to starting position        
            x <= DINO_X;
            y <= FLOOR_HEIGHT - DINO_HEIGHT; //Start at top of floor and move up half of dino height
            y_vel <= 0; 
			is_jumping <= 0;
        end //End of reset
        else if (i_animate && i_ani_stb) begin
			if(is_jumping) begin
				y_vel <= y_vel + DINO_GRAVITY + dino_fastfall;
				y <= y + y_vel;

				if (i_duck) begin
					current_height <= DINO_DUCK_HEIGHT;
				end //End of duck

				else begin
					current_height <= DINO_HEIGHT;
				end	//End of duck else 

				//If we go through the floor...
				if(y >= FLOOR_HEIGHT - current_height) begin
					y <= FLOOR_HEIGHT - current_height;
					y_vel <= 0;
					is_jumping <= 1'b0;
				end //End of floor collision checker 

			end //End of is_jumping 
			else if(i_jump) begin
				is_jumping <= 1'b1;
				y_vel <= -dino_jump_strength;
				y <= y - dino_jump_strength;
			end //End of i_jump

			else if(i_duck) begin
				//If we duck, first maintain our current center point. 
				//Let's reduce our vertical height by subtracting off some pixels from top and bottom
				 current_height <= DINO_DUCK_HEIGHT; 

				 //This will make it look like we just jumped in the air 
				 //So,we only want to keep the top pixels decremented 
				 //Let's bring our center y point down so that it's aligned with the floor
				 if (y != FLOOR_HEIGHT - DINO_DUCK_HEIGHT)
					y <= FLOOR_HEIGHT - DINO_DUCK_HEIGHT;
			end //End of i_duck

			else begin
				//If we're not ducking or jumping anymore
				//Make sure that we're back to our normal height
				current_height <= DINO_HEIGHT;

				//Also let's make sure that we're back to our standing height and center point.
				if (y >= FLOOR_HEIGHT - DINO_HEIGHT)
					y <= FLOOR_HEIGHT - DINO_HEIGHT;
			end //End of final else 
		end //End of animate
    end //End of i_clk
endmodule
