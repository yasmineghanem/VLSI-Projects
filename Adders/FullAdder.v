// Half adder implementation
module HalfAdder(A,B,Sum,Cout);
    input A,B;
    output Sum, Cout;

    assign Sum = A ^ B;
    assign Cout = A & B;
endmodule

module FullAdder (A,B,Cin,Sum,Cout);
    input A,B,Cin;
    output Sum,Cout;
    
    assign Sum = A ^ B ^ Cin; 
    assign Cout = ((A ^ B) & Cin) | (A & B); 
endmodule
