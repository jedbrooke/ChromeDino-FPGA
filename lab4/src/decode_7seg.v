
module decode_7seg(
   input wire [3:0] val,
	input wire num_disable,
	output reg [6:0] cats
	);
	
	always @(*) begin
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
