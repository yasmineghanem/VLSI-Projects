module MUX21(A, B, S, Out);

output Out;
input A, B, S;

assign Out =(S) ? B : A;
endmodule
