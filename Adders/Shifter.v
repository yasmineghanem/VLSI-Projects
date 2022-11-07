module RightShifter (In, Amount, Out);
    input [23:0] In;
    input [7:0] Amount;
    output [23:0] Out;

    assign Out = In>>Amount;
endmodule

module LeftShifter (In, Amount, Out);
    input [23:0] In;
    input [4:0] Amount;
    output [23:0] Out;

    assign Out = In<<Amount;
endmodule

module CoutShift (In, Cout, Out);
    input [23:0] In;
    input Cout;
    output [23:0] Out;

    assign Out = In>>Cout;
endmodule

