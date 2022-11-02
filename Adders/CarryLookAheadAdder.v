///////////////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
 `include "FullAdder.v"
 
module CarryLookAheadAdder #(parameter N=32)(A,B,Sum,Cout,Overflow);

  input signed [N-1:0] A,B;
  output signed [N-1:0]  Sum;
  output Cout, Overflow;
     
  wire [N:0] Carry;
  wire [N-1:0] GenerateWire, PropagateWire;
   
  assign Carry[0] = 1'b0; // no carry input on first adder
  assign Cout = Carry[N];
  assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

  // Create the Full Adders
  genvar i;
  generate
    for (i=0; i<N; i=i+1) 
      begin
         FullAdder F(A[i], B[i],Carry[i],Sum[i],Carry[i+1]);
      end
  endgenerate
 
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  // Create the Propagate Terms: Pi=Ai+Bi
  // Create the Carry Terms:
  genvar j;
  generate
    for (j=0; j<N; j=j+1) 
      begin
        assign GenerateWire[j]   = A[j] & B[j];
        assign PropagateWire[j]   = A[j] | B[j];
        assign Carry[j+1] = GenerateWire[j] | (PropagateWire[j] & Carry[j]);
      end
  endgenerate
   
endmodule // carry_lookahead_adder
