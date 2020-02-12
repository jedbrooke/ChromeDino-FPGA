
module decode_7seg(
    val,
    cats
)

    input [3:0] val;
    output [6:0] cats;

    assign cats[0] = (val == 0 | val == 3 | val >= 5);
    assign cats[1] = (val =< 4 | val >= 7);
    assign cats[2] = (val != 2);
    assign cats[3] = (val == 0 | val == 3 | val == 5 | val == 6 | val == 8 | val == 9);
    assign cats[4] = (val == 0 | val == 2 | val == 6 | val == 8);
    assign cats[5] = (val == 0 | val == 4 | val == 5 | val == 6 | val == 8 | val == 9);
    assign cats[6] = ((val > 1 & val < 7) | val > 7);

endmodule