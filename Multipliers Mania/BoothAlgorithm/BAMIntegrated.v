`include "BoothAlgorithmM.v"
`include "../Register.v"

module BAMIntegrated (clk, a, b, writeEnableA, writeEnableB, writeEnableOut, readEnableA, readEnableB, readEnableOut, resetA, resetB, resetOut, product, accessErrorA, accessErrorB, accessErrorOut);
    input clk;
    input writeEnableA, writeEnableB, writeEnableOut;
    input readEnableA, readEnableB, readEnableOut;
    input resetA, resetB, resetOut;

    input [31:0] Multiplicand, Multiplier;
    output [31:0] Product;
    output accessErrorA, accessErrorB, accessErrorOut;


    wire [31:0] registerOutA, registerOutB;
    Register #(32) InputRegisterA(.clk(clk), .dataIn(Multiplicand), .dataOut(registerOutA), .readEnable(readEnableA), .writeEnable(writeEnableA), .reset(resetA), .accessError(accessErrorA));
    Register #(32) InputRegisterB(.clk(clk), .dataIn(Multiplier), .dataOut(registerOutB), .readEnable(readEnableB), .writeEnable(writeEnableB), .reset(resetB), .accessError(accessErrorB));

    wire [31:0] registerInProduct;
    BoothAlgorithmMultiplier BAMMultiplier(.Multiplicand(registerOutA), .Multiplier(registerOutB), .Product(registerInProduct));

    Register #(32) OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(product), .readEnable(readEnableOut), .writeEnable(writeEnableOut), .reset(resetOut), .accessError(accessErrorOut));
endmodule