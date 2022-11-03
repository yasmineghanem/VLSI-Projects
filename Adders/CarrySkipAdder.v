`include "RippleCarryAdder.v"

module SkipLogic #(parameter N = 4) (A,B,Cin,Cout,Next_Cin);

  input [N-1:0] A,B;
  input Cin, Cout;
  output Next_Cin;

  wire [3:0] Xors;
  wire [1:0] Ands; 
    
  //assign Xors[0] = A[0] ^ B[0];
  //assign Xors[1] = A[1] ^ B[1];
  //assign Xors[2] = A[2] ^ B[2];
  //assign Xors[3] = A[3] ^ B[3];
  xor (Xors[0], A[0], B[0]);
  xor (Xors[0], A[1], B[1]);
  xor (Xors[0], A[2], B[2]);
  xor (Xors[0], A[3], B[3]);
  
  //assign Ands[0] = Xors[0] & Xors[1] & Xors[2] & Xors[3];
  and(Ands[0], Xors[0],  Xors[1],  Xors[2],  Xors[3]);
  and(Ands[1], Ands[0], Cin);
  //assign Ands[1] = Ands[0] & Cin;
  
  assign Next_Cin = Ands[1] | Cout;
  //or(Next_Cin, Ands[1], Cout);

endmodule

module CarrySkipAdder #(parameter N = 32) (A,B,Sum,Cout,Overflow);

  input signed [N-1:0] A,B;
  output signed [N-1:0] Sum;
  output Cout, Overflow;
  
  wire [(N/4)-1:0] Carryin, CarryOut, overflow;

  assign Carryin[0] = 0;
  assign Cout = CarryOut[(N/4)-1];
  assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;

  genvar i;
  generate for(i = 0; i < N; i = i + 4) begin
    RippleCarryAdder #(4) RCA(A[i+3:i],B[i+3:i],Sum[i+3:i],Carryin[(i/4)],CarryOut[(i/4)],overflow[i/4]);
  end
  for (i = 0; i < N ; i = i + 4 ) begin
    SkipLogic Skip(A[i+3:i],B[i+3:i],Carryin[(i/4)],CarryOut[(i/4)],Carryin[(i/4)+1]);
  end
  endgenerate
     
endmodule
