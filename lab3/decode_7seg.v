
module decode_7seg(
    val, num_disable, cats
);

    input [3:0] val;
	 input num_disable;
    output [6:0] cats;

    assign cats[0] = ~num_disable & (val == 1'd0 | val == 1'd3 | val >= 1'd5);
    assign cats[1] = ~num_disable & (val <= 1'd4 | val >= 1'd7);
    assign cats[2] = ~num_disable & (val != 1'd2);
    assign cats[3] = ~num_disable & (val == 1'd0 | val == 1'd3 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    assign cats[4] = ~num_disable & (val == 1'd0 | val == 1'd2 | val == 1'd6 | val == 1'd8);
    assign cats[5] = ~num_disable & (val == 1'd0 | val == 1'd4 | val == 1'd5 | val == 1'd6 | val == 1'd8 | val == 1'd9);
    assign cats[6] = ~num_disable & ((val > 1'd1 & val < 1'd7) | val > 7);

endmodule