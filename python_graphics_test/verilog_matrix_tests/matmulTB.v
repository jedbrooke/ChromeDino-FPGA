module tb;

    // Inputs
    reg [127:0] A;
    reg [127:0] B;
    // Outputs
    wire [127:0] Res;
	 //division test
	 reg[7:0] n;
	 reg[7:0] d;
	 reg[15:0] ni;
	 reg[15:0] di;
	 reg[15:0] intermed;
	 reg[7:0] quotient;

    // Instantiate the Unit Under Test (UUT)
    Mat_mult uut (
        .A(A), 
        .B(B), 
        .M(Res)
    );

    initial begin
        // Apply Inputs
        A = 0;  B = 0; 
		  n = 0;
		  d = 0;
		  ni = 0;
		  di = 0;
		  intermed = 0;
		  quotient = 0;
		  #100;
        A = {8'd1,8'd2,8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9,8'd10,8'd11,8'd12,8'd13,8'd14,8'd15,8'd16};
        B = {8'd17,8'd18,8'd19,8'd20,8'd21,8'd22,8'd23,8'd34,8'd25,8'd26,8'd27,8'd28,8'd29,8'd30,8'd31,8'd32};
		  #5 n = 8'b0111_1000;
		  #5 d = 8'b0011_0000;
		  #5 ni = {n,8'b0};
		  #5 di = {8'b0,d};
		  #5 intermed = ni / di;
		  #5 quotient = intermed[11:4];
		  #100 $finish;
    end
      
endmodule