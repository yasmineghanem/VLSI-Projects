`include "RippleCarryAdder.v"
`include "MUXs.v"

// Carry Select Adder - 32 bits
module CarrySelectAdder #(parameter N = 32)(A,B,Sum,Cin,Cout,Overflow);
  input signed [N-1:0] A, B;
  output signed [N-1:0] Sum;
  output Cout;
  input Cin,Overflow;
  wire [N-1:0] Sum_0, Sum_1;
  wire [(N/4)-1:0] Cout_0, Cout_1, overflow;
  
  
  assign Cout_0[0] = 1'b0;
  assign Cout_1[0] = 1'b1;
  assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

  genvar i;
  generate for(i = 0; i < N; i = i + 4) begin
	  RippleCarryAdder #(4) RCA_0(A[i+3:i], B[i+3:i],Sum_0[i+3:i], Cout_0[(i/4)], Cout_0[(i/4)+1] , overflow[(i/4)]);
  	RippleCarryAdder #(4) RCA_1(A[i+3:i], B[i+3:i],Sum_1[i+3:i], Cout_1[(i/4)], Cout_1[(i/4)+1] , overflow[(i/4)]);
  end
  for(i = 0; i < N; i = i + 1) begin
	MUX21 MUX_Sum( Sum_0[i], Sum_1[i], Cin, Sum[i]);
  end
  endgenerate

  MUX21 MUX_Cout(Cout_0[(N/4)-1], Cout_1[(N/4)-1], Cin, Cout);


endmodule
