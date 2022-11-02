`include "FullAdder.v"
module RippleCarryAdder #(parameter N = 32)(A,B,Sum,Cin,Cout,Overflow);
    input signed [N-1:0] A, B;
    output signed [N-1:0] Sum;
    input Cin;
    output Cout, Overflow;
    wire [N:0] Carry;
    
    assign Carry[0] = Cin;
    assign Cout = Carry[N];
    assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

    genvar i;
    generate for (i = 0; i < N ; i=i+1) begin
        FullAdder F(A[i],B[i],Carry[i],Sum[i], Carry[i+1]);
    end
    endgenerate
endmodule
