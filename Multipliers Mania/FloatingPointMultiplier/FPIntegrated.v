`include "FloatingPointMultiplier.v"
`include "../Register.v"

module FPIntegrated (clk, a, b, enableA, enableB, enableOut, resetA, resetB, resetOut, product, overflow, infinity, NAN);
    input clk;
    input enableA, enableB, enableOut;
    input resetA, resetB, resetOut;
    input [31:0] a, b;
    output [31:0] product;
    output infinity;
    output overflow, NAN;

    wire [31:0] registerOutA, registerOutB;
    InputRegister  InputRegisterA(.clk(clk), .dataIn(a), .dataOut(registerOutA), .enableA(enableA), , .reset(resetA));
    InputRegister InputRegisterB(.clk(clk), .dataIn(b), .dataOut(registerOutB), enableB(enableB), .reset(resetB));

    wire [31:0] registerInProduct;
    FLoatingPointMultiplier FPMultiplier(.a(registerOutA), .b(registerOutB), .product(registerInProduct), .overflow(overflow), .infinity(infinity), .NAN(NAN));

    OutputRegister  OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .enableOut(enableOut), .reset(resetOut));
endmodule