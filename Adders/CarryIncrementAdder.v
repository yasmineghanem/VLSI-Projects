//Implementation of carry increment adder(CIA)

`include "FullAdder.v"
`include "RippleCarryAdder.v"

// CIA 32bits
module CarryIncrementAdder #(parameter N = 32)(A,B,Sum,Cout,Overflow);

    input signed [N-1:0] A, B;
    output signed [N-1:0] Sum;
    output Cout,Overflow;
    wire signed [N-1:(N/2)] SumRCA2;
    wire [(N/2)+1:0] Couts;

    assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

    RippleCarryAdder #(16) RCAfirst(A[15:0],B[15:0],Sum[15:0],0,Couts[0]);
    RippleCarryAdder #(16) RCAsecond(A[31:16],B[31:16],SumRCA2[31:16],0,Couts[1]);
    HalfAdder hf0(SumRCA2[16],Couts[0],Sum[16],Couts[2]);
    HalfAdder hf[14:1](SumRCA2[30:17],Couts[15:2],Sum[30:17],Couts[16:3]);
    HalfAdder hf15(SumRCA2[31],Couts[16],Sum[31],Couts[17]);

    or (Cout,Couts[17],Couts[1]);

endmodule
















