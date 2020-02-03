`timescale 1ns / 1ps

module model_uart(/*AUTOARG*/
   // Outputs
   TX,
   // Inputs
   RX
   );

   output TX;
   input  RX;

   parameter baud    = 115200;
   parameter bittime = 1000000000/baud;
   parameter name    = "UART0";
   
   reg [7:0] rxData;
   reg [31:0] buffer;
   event     evBit;
   event     evByte;
   event     evTxBit;
   event     evTxByte;
   reg       TX;
	reg		 FL_displayed; 
   initial
     begin
		  FL_displayed = 1'b0; 
        TX = 1'b1;
     end
   
   always @ (negedge RX)
     begin
        rxData[7:0] = 8'h0;
        #(0.5*bittime);
        repeat (8)
          begin
             #bittime ->evBit;
             //rxData[7:0] = {rxData[6:0],RX};
             rxData[7:0] = {RX,rxData[7:1]};
          end
        ->evByte;
        //$display ("%d %s Received byte %02x (%s)", $stime, name, rxData, rxData);
     end

  //Once we receive a byte, trigger this always block
  
  always @(evByte) 
    begin  
       if (rxData == "\r" || rxData == "\n") //Display will convert buffer to HEX and append newline before outputting 
			begin
				if(~FL_displayed) 
					begin 
						$display ("%d %s Received byte %02x (%s)", $stime, name, buffer, buffer);
						FL_displayed = 1'b1; 
					end
				else
					FL_displayed = 1'b0;
			end
      	else //Left shift by 8 bits and add received data to last 8 bits
          buffer[31:0] = {buffer[23:0],rxData[7:0]};
    end 
	 
  
   task tskRxData;
      output [7:0] data;
      begin
         @(evByte);
         data = rxData;
      end
   endtask // for
      
   task tskTxData;
      input [7:0] data;
      reg [9:0]   tmp;
      integer     i;
      begin
         tmp = {1'b1, data[7:0], 1'b0};
         for (i=0;i<10;i=i+1)
           begin
              TX = tmp[i];
              #bittime;
              ->evTxBit;
           end
         ->evTxByte;
      end
   endtask // tskTxData
   
endmodule // model_uart
