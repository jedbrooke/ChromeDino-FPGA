module tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    // Outputs
    wire [31:0] Res;

    // Instantiate the Unit Under Test (UUT)
    Mat_mult uut (
        .A(A), 
        .B(B), 
        .Res(Res)
    );

    initial begin
        // Apply Inputs
        A = 0;  B = 0;  #100;
        A = {8'd1,8'd2,8'd3,8'd4};
        B = {8'd5,8'd6,8'd7,8'd8};
    end
      
endmodule