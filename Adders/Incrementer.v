module Increment (In,Cout,Out);
    input [7:0] In;
    input Cout;
    output [7:0] Out;

    assign Out = In + Cout;
    
endmodule

module Decrement (In,Amount,Out);
    input [7:0] In;
    input [4:0] Amount;
    output [7:0] Out;
    
    assign Out = In - Amount;
endmodule