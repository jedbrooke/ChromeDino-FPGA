// FPGA VGA Graphics Part 1: Top Module
// (C)2017-2018 Will Green - Licensed under the MIT License
// Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

`default_nettype none
`include "parameters.v"
module srom #(parameter ADDR_WIDTH=SPRITE_ADDR_WIDTH, DATA_WIDTH=3, DEPTH=256, MEMFILE="") (
      input wire i_clk,
      input wire [ADDR_WIDTH-1:0] i_addr, 
      output reg [DATA_WIDTH-1:0] o_data 
   );

   reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1]; 

   initial begin
      if (MEMFILE > 0) begin
         $readmemb(MEMFILE, memory_array);
      end
   end

   always @ (posedge i_clk) begin
      o_data <= memory_array[i_addr];
   end
endmodule

module sprites (
      input wire i_clk,
      input wire [1:0] i_sel,       //00 is dino, 01 is dino_duck, 10 is cactus, 11 is bird
      input wire [15:0] i_addr,     //address of memory to read
      output reg [7:0] pixel_color
   ); 
      reg [7:0] dino_meta_raw [0:5];
      reg [7:0] dino_duck_meta_raw [0:5];
      reg [7:0] cactus_meta_raw [0:5];
      reg [7:0] bird_meta_raw [0:5];

      initial begin 
         $readmemb("dino_meta.mem", dino_meta_raw);
         $readmemb("dino_duck_meta.mem", dino_duck_meta_raw);
         $readmemb("cactus_meta.mem", cactus_meta_raw);
         $readmemb("bird_meta.mem", bird_meta_raw);
      end

      wire [7:0] color_tables [0:3][0:3];

      genvar i;
      generate
         for (i = 0; i < 4; i=i+1) begin
            assign color_tables[0][i] = dino_meta_raw[i+2];
            assign color_tables[1][i] = dino_duck_meta_raw[i+2];
            assign color_tables[2][i] = cactus_meta_raw[i+2];
            assign color_tables[3][i] = bird_meta_raw[i+2];
         end
      endgenerate

      wire [7:0] dino_data;
      wire [7:0] dino_duck_data;
      wire [7:0] cactus_data;
      wire [7:0] bird_data;

      wire [7:0] data_arr [0:3];

      srom #(.DEPTH(DINO_IMG_SIZE)) dino (
         .i_clk(i_clk),
         .i_addr(i_addr),
         .o_data(dino_data)
      );
      srom #(.DEPTH(DINO_DUCK_IMG_SIZE)) dino_duck (
         .i_clk(i_clk),
         .i_addr(i_addr),
         .o_data(dino_duck_data)
      );
      srom #(.DEPTH(CACTUS_IMG_SIZE)) cactus (
         .i_clk(i_clk),
         .i_addr(i_addr),
         .o_data(cactus_data)
      );
      srom #(.DEPTH(BIRD_IMG_SIZE)) bird (
         .i_clk(i_clk),
         .i_addr(i_addr),
         .o_data(bird_data)
      );
		
		assign data_arr[0] = dino_data;
      assign data_arr[1] = dino_duck_data;
      assign data_arr[2] = cactus_data;
      assign data_arr[3] = bird_data;

      reg [2:0] data;

      always @(posedge i_clk) begin
         data <= data_arr[i_sel];
         pixel_color <= data[0] ? BG_COLOR : color_tables[i_sel][data[2:1]];
      end
	 
endmodule
