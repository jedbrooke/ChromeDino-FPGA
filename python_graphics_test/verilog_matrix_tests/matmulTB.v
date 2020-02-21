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
        A = {8'd1,8'd2,8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9,8'd10,8'd11,8'd12,8'd13,8'd14,8'd15,8'd16};
        B = {8'd17,8'd18,8'd19,8'd20,8'd21,8'd22,8'd23,8'd34,8'd25,8'd26,8'd27,8'd28,8'd29,8'd30,8'd31,8'd32};
    end
      
endmodule