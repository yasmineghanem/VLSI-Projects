`include "BoothAlgorithm.v"
`include "Register.v"

module BAMIntegrated (clk, Multiplicand, Multiplier,  enableA, enableB, enableOut, resetA, resetB, resetOut, Product);
    input clk;
    input enableA, enableB, enableOut;
    input resetA, resetB, resetOut;

    input [31:0] Multiplicand, Multiplier;
    output [63:0] Product;

    wire [31:0] registerOutA, registerOutB;
    InputRegister InputRegisterA(.clk(clk), .dataIn(Multiplicand), .dataOut(registerOutA), .enable(enableA), .reset(resetA));
    InputRegister InputRegisterB(.clk(clk), .dataIn(Multiplier), .dataOut(registerOutB), .enable(enableB), .reset(resetB));

    wire [63:0] registerInProduct;
    BoothAlgorithmMultiplier BAMMultiplier(.Multiplicand(registerOutA), .Multiplier(registerOutB), .Product(registerInProduct));

    OutputRegister  OutputRegister(.clk(clk), .dataIn(registerInProduct), .dataOut(Product), .enable(enableA), .reset(resetOut));
endmodule