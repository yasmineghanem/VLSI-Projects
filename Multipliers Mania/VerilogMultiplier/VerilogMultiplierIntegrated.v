`include "VerilogMultiplier.v"
`include "../Register.v"

module VerilogMultiplierIntegrated (clk, a, b, enableA, enableB, enableOut, resetA, resetB, resetOut, product);
    input clk;
    input enableA, enableB, enableOut;
    input resetA, resetB, resetOut;
    input signed [31:0] a, b;

    output signed [63:0] product;

    wire [31:0] registerOutA, registerOutB;
    InputRegister  InputRegisterModuleA(.clk(clk), .dataIn(a), .dataOut(registerOutA), .enable(enableA), .reset(resetA));
    InputRegister  InputRegisterModuleB(.clk(clk), .dataIn(b), .dataOut(registerOutB), .enable(enableB), .reset(resetB));

    wire [63:0] registerInProduct;
    VerilogMultiplier VerilogMultiplierModule(.a(registerOutA), .b(registerOutB), .product(registerInProduct));

    OutputRegister OutputRegisterModule(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .enable(enableOut), .reset(resetOut));
endmodule