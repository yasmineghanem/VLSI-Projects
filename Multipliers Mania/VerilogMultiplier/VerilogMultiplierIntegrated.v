`include "VerilogMultiplier.v"
`include "../Register.v"

module VerilogMultiplierIntegrated (clk, a, b, writeEnableA, writeEnableB, writeEnableOut, readEnableA, readEnableB, readEnableOut, resetA, resetB, resetOut, product, overflow, accessErrorA, accessErrorB, accessErrorOut);
    input clk;
    input writeEnableA, writeEnableB, writeEnableOut;
    input readEnableA, readEnableB, readEnableOut;
    input resetA, resetB, resetOut;
    input [31:0] a, b;
    output [31:0] product;
    output overflow;
    output accessErrorA, accessErrorB, accessErrorOut;


    wire [31:0] registerOutA, registerOutB;
    Register #(32) InputRegisterA(.clk(clk), .dataIn(a), .dataOut(registerOutA), .readEnable(readEnableA), .writeEnable(writeEnableA), .reset(resetA), .accessError(accessErrorA));
    Register #(32) InputRegisterB(.clk(clk), .dataIn(b), .dataOut(registerOutB), .readEnable(readEnableA), .writeEnable(writeEnableB), .reset(resetB), .accessError(accessErrorB));

    wire [31:0] registerInProduct;
    VerilogMultiplier VerilogMultiplierModule(.a(registerOutA), .b(registerOutB), .product(registerInProduct), .overflow(overflow));

    Register #(32) OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .readEnable(readEnableOut), .writeEnable(writeEnableOut), .reset(resetOut), .accessError(accessErrorOut));
endmodule