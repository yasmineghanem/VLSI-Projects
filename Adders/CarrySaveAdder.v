`include "FullAdder.v"

module CarrySaveAdder #(parameter N=32) (A,B,Sum,Cin,Cout,Overflow);
   input signed [N-1:0] A,B;
   wire [N-1:0] CarryIn,Carry_1;
   input Cin;
   output signed[N-1:0] Sum;
   output Cout, Overflow;
             
   wire [N:0] Sum_1,Carry_2;

   assign CarryIn[0] = Cin; 
   assign CarryIn[N-1:1] = 0;

   assign Carry_2[0] = 1'b0;
   assign Sum_1[N] = 1'b0;
   assign Sum[0] = Sum_1[0];
   assign Cout = Carry_2[N];
   assign Overflow = (A[N-1] == B[N-1] && (Sum[N-1] != A[N-1]))? 1 : 0;
   
   // Create the First level Adders (A,B,Cin,Sum,Cout);
   genvar i;
   generate
     for (i=0; i<N; i=i+1) 
       begin
          FullAdder F1(A[i], B[i], CarryIn[i],Sum_1[i],Carry_1[i]);
       end
   endgenerate
// Create the Second level Adders (A,B,Cin,Sum,Cout);
   genvar j;
   generate
      for (j=0; j<N; j=j+1) 
       begin
          FullAdder F2(Sum_1[j+1], Carry_1[j],Carry_2[j],Sum[j+1],Carry_2[j+1]);
       end
   endgenerate

endmodule

