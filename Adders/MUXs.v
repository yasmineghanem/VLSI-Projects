
module MUX21(A, B, S, Out);

output Out;
input A, B, S;

assign Out = (S) ? B : A;
endmodule

module Mux24bits(A,B,S,Out);
	input [22:0] A,B;
  output [23:0] Out;
  input S;
	 
  genvar i;
  generate
  begin
    for(i = 0 ; i < 23;i = i + 1)
      MUX21 M(A[i],B[i],S,Out[i]);
    end
  endgenerate

  assign Out[23]=1'b1;
endmodule

module MUX8bits(A,B,S,Out);
	input [7:0] A,B;
  output [7:0] Out;
  input S;

  genvar j;
  generate 
    for ( j = 0; j <= 7; j = j + 1) begin
     MUX21 M(A[j],B[j],C,Out[j]);
    end
  endgenerate
endmodule