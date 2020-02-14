
module decode_7seg(
    val, num_disable, cats
);

    input [3:0] val;
	input num_disable;
    output [6:0] cats;

    wire a,b,c,d,e,f,g;
    wire w,x,y,z;

    assign w = val[0];
    assign x = val[1];
    assign y = val[2];
    assign z = val[3];

    assign a = ~num_disable & ((z | ~y | x) & (~z | y | w))
    assign b = ~num_disable & ((~x | ~y | z) & (~x | y | ~z))
    assign c = ~num_disable & ((z | ~y | x))
    assign d = ~num_disable & (w | (y & ~z & x) | (x & ~y & z) | (y & z & ~x) | (~z & ~y & ~x))
    assign e = ~num_disable & (w | (~y & x) | (x & ~z) | (~y & ~z & ~w))
    assign f = ~num_disable & (w | (x & ~z) | (x & ~y & z) | (~z & ~y & ~w))
    assign g = ~num_disable & (w | (y & ~z) | (~x & y) | (x & ~y))

    cats = {g,f,e,d,c,b,a};
    // assign cats[0] = ~num_disable & (val == 1'd0 | val == 1'd3 | val >= 1'd5);
    // assign cats[1] = ~num_disable & (val <= 1'd4 | val >= 1'd7);
    // assign cats[2] = ~num_disable & (val != 1'd2);
    // assign cats[3] = ~num_disable & (val == 1'd0 | val == 1'd3 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    // assign cats[4] = ~num_disable & (val == 1'd0 | val == 1'd2 | val == 1'd6 | val == 1'd8);
    // assign cats[5] = ~num_disable & (val == 1'd0 | val == 1'd4 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    // assign cats[6] = ~num_disable & ((val > 1'd1 & val < 1'd7) | val > 7);

endmodule