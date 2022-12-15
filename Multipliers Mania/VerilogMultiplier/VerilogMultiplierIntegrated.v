`include "VerilogMultiplier.v"
`include "../Register.v"

module VerilogMultiplierIntegrated #(parameter N = 32) (clk, a, b, writeEnableA, writeEnableB, writeEnableOut, readEnableA, readEnableB, readEnableOut, resetA, resetB, resetOut, product, overflow, accessErrorA, accessErrorB, accessErrorOut);
    input clk;
    input writeEnableA, writeEnableB, writeEnableOut;
    input readEnableA, readEnableB, readEnableOut;
    input resetA, resetB, resetOut;
    input [N-1:0] a, b;
    output [2*N-1:0] product;
    output overflow;
    output accessErrorA, accessErrorB, accessErrorOut;


    wire [N-1:0] registerOutA, registerOutB;
    Register #(N) InputRegisterA(.clk(clk), .dataIn(a), .dataOut(registerOutA), .readEnable(readEnableA), .writeEnable(writeEnableA), .reset(resetA), .accessError(accessErrorA));
    Register #(N) InputRegisterB(.clk(clk), .dataIn(b), .dataOut(registerOutB), .readEnable(readEnableA), .writeEnable(writeEnableB), .reset(resetB), .accessError(accessErrorB));

    wire [2*N-1:0] registerInProduct;
    VerilogMultiplier VerilogMultiplierModule(.a(registerOutA), .b(registerOutB), .product(registerInProduct), .overflow(overflow));

    Register #(2*N) OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .readEnable(readEnableOut), .writeEnable(writeEnableOut), .reset(resetOut), .accessError(accessErrorOut));
endmodule