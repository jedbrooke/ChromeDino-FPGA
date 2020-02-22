//Module for calculating Res = A*B
//Where A,B and C are 4 by 4 matrices.
module Mat_mult(A,B,Res);

    //input and output ports.
    //The size 128 bits which is 4*4=16 elements,each of which is 8 bits wide.    
    input [127:0] A;
    input [127:0] B;
    output [127:0] Res;
    //internal variables    
    reg [127:0] Res;
    reg [7:0] A1 [0:3][0:3];
    reg [7:0] B1 [0:3][0:3];
    reg [7:0] Res1 [0:3][0:3]; 
    integer i,j,k;

    always@ (A or B)
    begin
    //Initialize the matrices-convert 1 D to 3D arrays
        {A1[0][0],A1[0][1],A1[0][2],A1[0][3],A1[1][0],A1[1][1],A1[1][2],A1[1][3],A1[2][0],A1[2][1],A1[2][2],A1[2][3],A1[3][0],A1[3][1],A1[3][2],A1[3][3]} = A;
        {B1[0][0],B1[0][1],B1[0][2],B1[0][3],B1[1][0],B1[1][1],B1[1][2],B1[1][3],B1[2][0],B1[2][1],B1[2][2],B1[2][3],B1[3][0],B1[3][1],B1[3][2],B1[3][3]} = B;
        i = 0;
        j = 0;
        k = 0;
        {Res1[0][0],Res1[0][1],Res1[0][2],Res1[0][3],Res1[1][0],Res1[1][1],Res1[1][2],Res1[1][3],Res1[2][0],Res1[2][1],Res1[2][2],Res1[2][3],Res1[3][0],Res1[3][1],Res1[3][2],Res1[3][3]} = 128'd0; //initiBlize to zeros.
        //MRestrix multiplication
        for(i=0;i < 4;i=i+1)
            for(j=0;j < 4;j=j+1)
                for(k=0;k < 4;k=k+1)
                    Res1[i][j] = Res1[i][j] + (A1[i][k] * B1[k][j]);
        //final output assignment - 3D array to 1D array conversion.            
        Res = {Res1[0][0],Res1[0][1],Res1[0][2],Res1[0][3],Res1[1][0],Res1[1][1],Res1[1][2],Res1[1][3],Res1[2][0],Res1[2][1],Res1[2][2],Res1[2][3],Res1[3][0],Res1[3][1],Res1[3][2],Res1[3][3]};            
    end 

endmodule