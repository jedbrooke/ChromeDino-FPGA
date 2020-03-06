
module decode_7seg(
	val,num_disable,cats
	);

    input [3:0] val;
	 input num_disable;
	 output reg [6:0] cats;

    
	
	 always @(val or num_disable) begin
			if(num_disable) begin
				cats <= 7'b000000;
			end else begin
				case(val)
					4'b0000 : cats <= 7'b0111111;
					4'b0001 : cats <= 7'b0000110;
					4'b0010 : cats <= 7'b1011011;
					4'b0011 : cats <= 7'b1001111;
					4'b0100 : cats <= 7'b1100110;
					4'b0101 : cats <= 7'b1101101;
					4'b0110 : cats <= 7'b1111101;
					4'b0111 : cats <= 7'b0000111;
					4'b1000 : cats <= 7'b1111111;
					4'b1001 : cats <= 7'b1101111;
					default : cats <= 7'b0000000;
				endcase
			end
	 end
endmodule 
	 /*
	 reg a,b,c,d,e,f,g;
    reg w,x,y,z;
    w <= val[0];
    x <= val[1];
    y <= val[2];
    z <= val[3];

    a <= ~num_disable & ((z | ~y | x) & (~z | y | w));
    b <= ~num_disable & ((~x | ~y | z) & (~x | y | ~z));
    c <= ~num_disable & ((z | ~y | x));
    d <= ~num_disable & (w | (y & ~z & x) | (x & ~y & z) | (y & z & ~x) | (~z & ~y & ~x));
    e <= ~num_disable & (w | (~y & x) | (x & ~z) | (~y & ~z & ~w));
    f <= ~num_disable & (w | (x & ~z) | (x & ~y & z) | (~z & ~y & ~w));
    g <= ~num_disable & (w | (y & ~z) | (~x & y) | (x & ~y));

    cats[6:0] <= {g,f,e,d,c,b,a};*/
	 
    // assign cats[0] = ~num_disable & (val == 1'd0 | val == 1'd3 | val >= 1'd5);
    // assign cats[1] = ~num_disable & (val <= 1'd4 | val >= 1'd7);
    // assign cats[2] = ~num_disable & (val != 1'd2);
    // assign cats[3] = ~num_disable & (val == 1'd0 | val == 1'd3 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    // assign cats[4] = ~num_disable & (val == 1'd0 | val == 1'd2 | val == 1'd6 | val == 1'd8);
    // assign cats[5] = ~num_disable & (val == 1'd0 | val == 1'd4 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    // assign cats[6] = ~num_disable & ((val > 1'd1 & val < 1'd7) | val > 7);

