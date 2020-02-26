// FPGA VGA Graphics Part 1: Square Animation
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none
`include "parameters.v"

endinterface

module square #(
    WIDTH=40,       // half rect width (for ease of co-ordinate calculations)
    HEIGHT=60,      // half rect height 
    IX=D_WIDTH,     // initial horizontal position of square centre
    IY=FLOOR_HEIGHT,// initial vertical position of square centre
    IX_DIR=0,       // initial horizontal direction: 1 is right, 0 is left
    IY_DIR=0,       // initial vertical direction: 1 is down, 0 is up
    TYPE=0          // 0 is cactus =, 1 is bird
    IX_VEL=1,
    IY_VEL=0,
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

    reg [11:0] x = IX;   // horizontal position of square centre
    reg [11:0] y = IY;   // vertical position of square centre
    reg x_dir = IX_DIR;  // horizontal animation direction
    reg y_dir = IY_DIR;  // vertical animation direction

    assign o_x1 = x - WIDTH;  // left: centre minus half horizontal size
    assign o_x2 = x + WIDTH;  // right
    assign o_y1 = y - HEIGHT;  // top
    assign o_y2 = y + HEIGHT;  // bottom

    always @ (posedge i_clk)
    begin
        if (i_rst)  // on reset return to starting position
        begin
            x <= IX;
            y <= IY;
            x_dir <= IX_DIR;
            y_dir <= IY_DIR;
        end
        if (i_animate && i_ani_stb)
        begin
            x <= (x_dir) ? x + IX_VEL : x - IX_VEL;  // move left if positive x_dir
            y <= (y_dir) ? y + IY_VEL : y - IY_VEL;  // move down if positive y_dir

            if (x <= H_SIZE + 1)  // edge of square is at left of screen
                x <= D_WIDTH + WIDTH;  // move back to the right of the screen
            /*if (x >= (D_WIDTH - H_SIZE - 1))  // edge of square at right
                x_dir <= 0;  // change direction to left         
            if (y <= H_SIZE + 1)  // edge of square at top of screen
                y_dir <= 1;  // change direction to down
            if (y >= (D_HEIGHT - H_SIZE - 1))  // edge of square at bottom
                y_dir <= 0;  // change direction to up     
            */         
        end
    end
endmodule
