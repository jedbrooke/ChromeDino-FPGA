//diaply parameters
parameter D_WIDTH = 640;
parameter D_HEIGHT = 480;
//colors
parameter CACTUS_COLOR = 8'b00110100;
parameter BIRD_COLOR = 8'b11011011;
parameter FLOOR_COLOR = 8'b11111111;
parameter DINO_COLOR = 8'b11100000;
parameter BG_COLOR = 8'b0;
//positions
parameter BIRD_HEIGHT = 120;
parameter FLOOR_HEIGHT = 400;
//dino data
parameter DINO_X = 80;
parameter DINO_HEIGHT = 30;
parameter DINO_DUCK_HEIGHT = 20;
parameter DINO_WIDTH = 20;
parameter DINO_JUMP_STRENGTH = 15;
parameter DINO_GRAVITY = 10; //positive is down

//game data
parameter NUM_BIRDS = 1;
parameter NUM_CACTI = 1;
parameter OBSTACLE_VEL = 5;