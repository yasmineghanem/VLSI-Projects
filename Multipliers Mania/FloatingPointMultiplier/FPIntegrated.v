`include "FloatingPointMultiplier.v"
`include "../Register.v"

module FPIntegrated (clk, a, b, writeEnableA, writeEnableB, writeEnableOut, readEnableA, readEnableB, readEnableOut, resetA, resetB, resetOut, product, overflow, infinity, NAN);
    input clk;
    input writeEnableA, writeEnableB, writeEnableOut;
    input readEnableA, readEnableB, readEnableOut;
    input resetA, resetB, resetOut;
    input [31:0] a, b;
    output [31:0] product;
    output infinity;
    output overflow, NAN;
    
    wire [31:0] registerOutA, registerOutB;
    Register #(32) InputRegisterA(.clk(clk), .dataIn(a), .dataOut(registerOutA), .readEnable(readEnableA), .writeEnable(writeEnableA), .reset(resetA));
    Register #(32) InputRegisterB(.clk(clk), .dataIn(b), .dataOut(registerOutB), .readEnable(readEnableA), .writeEnable(writeEnableB), .reset(resetB));

    wire [31:0] registerInProduct;
    FLoatingPointMultiplier FPMultiplier(.a(registerOutA), .b(registerOutB), .product(registerInProduct), .overflow(overflow), .infinity(infinity), .NAN(NAN));

    Register #(32) OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .readEnable(readEnableOut), .writeEnable(writeEnableOut), .reset(resetOut));
endmodule