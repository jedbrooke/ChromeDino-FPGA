//diaply parameters
parameter D_WIDTH = 640;
parameter D_HEIGHT = 480;
//colors
parameter CACTUS_COLOR = 8'b00110100;
parameter BIRD_COLOR = 8'b11011011;
parameter FLOOR_COLOR = 8'b11111111;
parameter DINO_COLOR = 8'b11100000;
parameter BG_COLOR = 8'b0;
parameter COLOR_DEPTH = 8;
//positions
parameter BIRD_HEIGHT = 340;
parameter FLOOR_HEIGHT = 400;
//dino data
parameter DINO_X = 80;
parameter DINO_HEIGHT = 30;
parameter DINO_DUCK_HEIGHT = 20;
parameter DINO_WIDTH = 20;
parameter DINO_JUMP_STRENGTH = 16'd25;
parameter DINO_GRAVITY = 2; //positive is down

//game data
parameter NUM_BIRDS = 1;
parameter NUM_CACTI = 1;
parameter OBSTACLE_VEL = 5;

//paste sprite data here
parameter BIRD_IMG_SIZE = 4368;
parameter BIRD_IMG_WIDTH = 84;
parameter BIRD_IMG_HEIGHT = 52;
parameter CACTUS_IMG_SIZE = 4416;
parameter CACTUS_IMG_WIDTH = 46;
parameter CACTUS_IMG_HEIGHT = 96;
parameter DINO_IMG_SIZE = 6880;
parameter DINO_IMG_WIDTH = 80;
parameter DINO_IMG_HEIGHT = 86;
parameter DINO_DUCK_IMG_SIZE = 5720;
parameter DINO_DUCK_IMG_WIDTH = 110;
parameter DINO_DUCK_IMG_HEIGHT = 52;