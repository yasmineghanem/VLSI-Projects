`include "../../Adders/PlusAdder.v"

module FLoatingPointMultiplier (a, b, product);
    //input and output ports
    input [31:0] a, b;
    output [31:0] product;

    //intermediate wires
    wire finalSign;
    wire [22:0] mantissaA, mantissaB;
    wire [7:0] expA, expB;
    wire earlyZero;

    wire [23:0] significandA; 
    wire [23:0] significandB;

    //Check for zero cases
    //if A is zero -> mantissa and exp are both zero
    assign earlyZero = 
    ((mantissaA == {23{1'b0}} && expA == {8{1'b0}}) || (mantissaB == {23{1'b0}} && expB == {8{1'b0}})) ? 
        1'b1 : 1'b0;

    assign finalSign = a[31] ^ b[31];
    assign mantissaA = a[22:0];
    assign mantissaB = b[22:0];
    assign expA = a[30:23];
    assign expB = b[30:23];

    //Concatenate 1 to MSB so the mantissas become 1.xxx
    assign significandA = {1'b1, mantissaA};
    assign significandB = {1'b1, mantissaB};

    wire [7:0] expSum;
    wire [47:0] significandProduct;

    //Adder wires
    wire cout, overflow;

    PlusAdder #(8) Adder(expA,expB,expSum,cout,overflow);

    wire [7:0] expBias;
    assign expBias = {cout,expSum} - 8'd127;

    // assign expSum = (expA + expB) - 8'b011111111; //subtract 127 (bias) from exp

    // multiply both significants the product is 48 bits
    assign significandProduct = significandA * significandB;
    wire [24:0] m3lsh, shiftedProduct;
    wire [22:0] normMantissa;
    wire normalize;

    assign m3lsh = significandProduct[47:23];
    assign normalize = significandProduct[47];

    assign shiftedProduct = m3lsh>>1;

    assign normMantissa =
        (normalize == 1'b1) ? shiftedProduct[22:0] : m3lsh[22:0];
    
    wire [7:0] normExp;
    assign normExp = (normalize == 1'b1) ? expBias+1 : expBias;

    assign product = {finalSign, normExp, normMantissa};
    
endmodule