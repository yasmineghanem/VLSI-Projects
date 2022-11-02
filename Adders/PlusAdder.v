module PlusAdder #(parameter N=32) (A,B,Sum,Cout,Overflow);
input signed [N-1:0] A,B;
output signed [N-1:0] Sum;
output Cout;

assign {Cout,Sum}  = A + B;
assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

endmodule
