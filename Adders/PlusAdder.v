module PlusAdder #(parameter N=32) (A,B,Out);
input signed [N-1:0] A,B;
output signed [N:0] Out;

assign Out = A + B;
endmodule
