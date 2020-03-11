//display parameters
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
parameter BIRD_HEIGHT_MAX = 350;
parameter FLOOR_HEIGHT = 400;

//dino data
parameter DINO_X = 80;
parameter DINO_HEIGHT = 30;
parameter DINO_DUCK_HEIGHT = 20;
parameter DINO_WIDTH = 20;
parameter DINO_REG_JUMP_STRENGTH = 16'd17;
parameter DINO_ULTRA_JUMP_STRENGTH = 16'd23;
parameter DINO_GRAVITY = 1; //positive is down
parameter DINO_FASTFALL = 1;

//game data
parameter NUM_BIRDS = 4;
parameter NUM_CACTI = 4;
parameter OBSTACLE_VEL = 7;
parameter OBSTACLE_WAIT_TIME = 2500;
parameter CACTUS_HEIGHT_MIN = 15;
parameter CACTUS_HEIGHT_MAX = 30;
parameter DEAD_STATE = 2'b00;
parameter GRACE_STATE = 2'b01;
parameter PLAY_STATE = 2'b10;


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