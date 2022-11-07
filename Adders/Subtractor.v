`include "TwosComplement.v"

module HalfSubtractor(A,B,D,Bout);
    input A, B;
    output D, Bout;
    
    assign D = A ^ B;
    assign Bout = (~A) & B;

endmodule

module FullSubtractor(A,B,Bin,D,Bout);
	input A, B, Bin; 
    output D, Bout;

    assign D = (A ^ B) ^ Bin;
    assign Bout = ((~A) & Bin) | (B & Bin)|| ((~A) & B);
endmodule

module Subtractor #(parameter N = 8) (A,B,D,Bout);
	input [N-1:0] A,B; 
    output [N-1:0] D;
    output Bout;
    wire [N-1:0] Borrows;

    assign Bout = Borrows[7];

    HalfSubtractor HS(A[0],B[0],D[0],Borrows[0]);

    genvar i;
    generate
        for(i = 1; i < N; i = i + 1)begin
            FullSubtractor FS(A[i], B[i], Borrows[i-1], D[i], Borrows[i]);
        end
    endgenerate

endmodule

module SubtractionResult #(parameter N = 32)(A,B,D,Borrow);
	input [N-1:0] A,B;
    output [N-1:0] D;
    output Borrow;  
    
    wire [N-1:0] D1;
    wire [N-1:0] D2;

    assign D = (Borrow == 1'b1) ? D1 : D2;

    Subtractor #(8) S(A,B,D1,Borrow);
    TwosComplement Complement(D1, D2);
endmodule
