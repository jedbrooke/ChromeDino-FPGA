module Arithmetic (A, B, Y1, Y2, Y3, Y4, Y5);
  input [2:0] A, B;
  output [3:0] Y1;
  output [4:0] Y3;
  output [2:0] Y2, Y4, Y5;
  reg [3:0] Y1;
  reg [4:0] Y3;
  reg [2:0] Y2, Y4, Y5;

  always @(A or B)
  begin
    Y1=A+B;//addition
    Y2=A-B;//subtraction
    Y3=A*B;//multiplication
    Y4=A/B;//division
    Y5=A%B;//modulus of A divided by B
  end
endmodule