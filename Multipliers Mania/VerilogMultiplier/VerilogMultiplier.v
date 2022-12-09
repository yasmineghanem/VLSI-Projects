module Multiplier #(parameter N = 32) (A,B,Out);
    input [N-1:0] A,B;
    input [(2*N)-1:0] Out;
      
    assign Out = A * B;
endmodule