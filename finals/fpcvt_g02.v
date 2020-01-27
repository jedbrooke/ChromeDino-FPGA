`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jasper Edbrooke, Harrison Cassar, Eldon Ngo
// 
// Create Date:	 10:19:43 01/15/2020 
// Design Name: 
// Module Name:	 fpcvt 
// Project Name: Lab1
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


module lab1_2comp_SM_encoder(D ,sign , mag
    );
	input [11:0] D;
	output reg sign;
	output reg [10:0] mag;
	
	always @* begin
		sign = D[11];
		if (sign)
			mag <= ~D + 1'b1;
		else
			mag <= D[10:0];
			
		if (D == 2048)
			mag <= 11'b11111111111;
	end	
			
endmodule

module lab1_priority_encoder( mag, index
    );
	input [10:0] mag;
	output reg [3:0] index;
	
	always @* begin
	
		index[0] <= (~mag[10] & mag[9]) |
						(~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & mag[5]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & mag[3]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & ~mag[3] & ~mag[2] & mag[1]);
					
		index[1] <= (mag[10]) |
						(~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & mag[6]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & mag[3]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & ~mag[4] & ~mag[3] & mag[2]);
						
		index[2] <= (~mag[10] & ~mag[9] & ~mag[8] & mag[7]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & mag[6]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & mag[5]) |
						(~mag[10] & ~mag[9] & ~mag[8] & ~mag[7] & ~mag[6] & ~mag[5] & mag[4]);
					
		index[3] <= (mag[10]) |
						(~mag[10] & mag[9]) |
						(~mag[10] & ~mag[9] & mag[8]);

	end
endmodule

module lab1_middleman(mag,E,F,Fifth
    );

	input [10:0] mag;
	output reg [2:0] E;
	output reg [3:0] F;
	output reg Fifth;

	reg [2:0] exp;

	wire [3:0] index;
	reg [3:0] num_zeros; //number of zeros for calculating exponent
	reg [10:0] calc_shift;

	lab1_priority_encoder uut (
		.mag(mag),
		.index(index)
	);



	always @* begin
		//count number of zeros for exponent

		num_zeros = 11 - index;
		exp = 8 - num_zeros;
		if (exp < 0) begin
			E <= 0;
			F <= mag[3:0];
			Fifth <= 0;
		end
		else if (mag == 0) begin
			E <= 0;
			F <= 0;
			Fifth <= 0;
		end
		else if (index < 4) begin
			F <= mag[3:0];
			Fifth <= 0;
			E <= 0;
		end
		else begin
			calc_shift <= mag >> (index-4);
			F <= calc_shift[5:1];
			Fifth <= calc_shift[0];
			E <= exp; 
		end
	end

endmodule



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

module fpcvt (
	 D, E, F, S
	 );
	 
	input [11:0] D; //input data
	output [2:0] E; //output exponent
	output [3:0] F; //output fractional component
	output S;		 //ouput sign
	wire [10:0] mag; //magnitude of the number
	wire [3:0] Fin;
	wire Fifth;
	wire [2:0] exp;
	
	//convert 2's comp into sign magnitude
	lab1_2comp_SM_encoder uut1 (
		.D(D),
		.sign(S),
		.mag(mag)
	);
	
	lab1_middleman uut2 (
		.mag(mag),
		.E(exp),
		.F(Fin),
		.Fifth(Fifth)
	);
		
	lab1_round uut3 (
		.E(exp),
		.F(Fin),
		.Fifth(Fifth),
		.Eout(E),
		.Fout(F)
	); 
	
endmodule





