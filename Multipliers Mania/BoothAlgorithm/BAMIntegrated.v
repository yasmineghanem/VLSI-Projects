`include "BoothAlgorithm.v"
`include "../Register.v"

module BAMIntegrated (clk, Multiplicand, Multiplier, writeEnableA, writeEnableB, writeEnableOut, readEnableA, readEnableB, readEnableOut, resetA, resetB, resetOut, Product, accessErrorA, accessErrorB, accessErrorOut);
    input clk;
    input writeEnableA, writeEnableB, writeEnableOut;
    input readEnableA, readEnableB, readEnableOut;
    input resetA, resetB, resetOut;

    input [31:0] Multiplicand, Multiplier;
    output [63:0] Product;
    output accessErrorA, accessErrorB, accessErrorOut;


    wire [31:0] registerOutA, registerOutB;
    Register #(32) InputRegisterA(.clk(clk), .dataIn(Multiplicand), .dataOut(registerOutA), .readEnable(readEnableA), .writeEnable(writeEnableA), .reset(resetA), .accessError(accessErrorA));
    Register #(32) InputRegisterB(.clk(clk), .dataIn(Multiplier), .dataOut(registerOutB), .readEnable(readEnableB), .writeEnable(writeEnableB), .reset(resetB), .accessError(accessErrorB));

    wire [63:0] registerInProduct;
    BoothAlgorithmMultiplier BAMMultiplier(.Multiplicand(registerOutA), .Multiplier(registerOutB), .Product(registerInProduct));

    Register #(64) OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(Product), .readEnable(readEnableOut), .writeEnable(writeEnableOut), .reset(resetOut), .accessError(accessErrorOut));
endmodule