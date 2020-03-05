//diaply parameters
parameter D_WIDTH = 640;
parameter D_HEIGHT = 480;
//colors
parameter CACTUS_COLOR = 8'b00110100;
parameter BIRD_COLOR = 8'b11011011;
parameter FLOOR_COLOR = 8'b00100101;
parameter DINO_COLOR = 8'b11100000;
parameter BG_COLOR = 8'b0;
parameter COLOR_DEPTH = 8;

//positions
parameter BIRD_HEIGHT_MAX = 340;
parameter FLOOR_HEIGHT = 400;

//dino data
parameter DINO_X = 80;
parameter DINO_HEIGHT = 30;
parameter DINO_DUCK_HEIGHT = 20;
parameter DINO_WIDTH = 20;
parameter DINO_JUMP_STRENGTH = 16'd15;
parameter DINO_GRAVITY = 1; //positive is down

//game data
parameter NUM_BIRDS = 1;
parameter NUM_CACTI = 1;
parameter OBSTACLE_VEL = 5;
parameter OBSTACLE_WAIT_TIME = 500;
parameter CACTUS_HEIGHT_MIN = 15;
parameter CACTUS_HEIGHT_MAX = 30;

parameter DEAD_STATE = 2'b00;
parameter GRACE_STATE = 2'b01;
parameter PLAY_STATE = 2'b10;


//paste sprite data here
parameter SPRITE_ADDR_WIDTH = 16;
parameter BIRD_IMG_SIZE = 2814;
parameter BIRD_IMG_WIDTH = 67;
parameter BIRD_IMG_HEIGHT = 42;
parameter CACTUS_IMG_SIZE = 2849;
parameter CACTUS_IMG_WIDTH = 37;
parameter CACTUS_IMG_HEIGHT = 77;
parameter DINO_IMG_SIZE = 2912;
parameter DINO_IMG_WIDTH = 52;
parameter DINO_IMG_HEIGHT = 56;
parameter DINO_DUCK_IMG_SIZE = 2772;
parameter DINO_DUCK_IMG_WIDTH = 77;
parameter DINO_DUCK_IMG_HEIGHT = 36;