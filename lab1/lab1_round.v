`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    lab1_round.v 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lab1_round(E,F,Fifth,Eout,Fout);
  input [2:0] E; //Exponent 
  input [3:0] F; //Significand 
  input Fifth; //Fifth bit following last leading 0
  output reg [2:0] Eout; 
  output reg [3:0] Fout; 
  
  always @* begin 
    //Check if fifth bit is 0, just use four bits of F
	 if(Fifth == 0)
      begin 
        Fout = F;
        Eout = E; 
      end 
    else //Otherwise...proceed to rounding 
      begin 
        //Check for overflow in significand 
        if(F == 4'b1111) 
          begin 
            //Also check for exponent overflow...
            if(E == 3'b111)
              begin 
                Fout = 4'b1111;
				    Eout = E;
              end 
            else //If no overflow, shift significand right and add one to exponent
              begin
                Fout = 4'b1000; 
                Eout = E + 1; 
              end 
          end 
        else //Otherwise...proceed to add 1 to Signifcand for normal rounding
          begin
            Fout = F + 1; 
            Eout = E;
          end 
      end 
  end 
  
endmodule