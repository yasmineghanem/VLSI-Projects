`include "../../Adders/PlusAdder.v"

module FLoatingPointMultiplier (a, b, product, infinity, NAN, overflow);
    //input and output ports
    input [31:0] a, b;
    output [31:0] product;
    output infinity, NAN, overflow;

    //intermediate wires
    wire finalSign;
    wire [22:0] mantissaA, mantissaB;
    wire [7:0] expA, expB;
    wire zero;

    wire [23:0] significandA; 
    wire [23:0] significandB;

    //Check for zero case
    //if A is zero -> mantissa and exp are both zero
    assign zero = 
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
    wire cout;

    //Add exponents 
    PlusAdder #(8) Adder(expA,expB,expSum,cout,overflow);

    //sbutract bias from added exponents
    wire [7:0] expBias;
    assign expBias = {cout,expSum} - 8'd127;

    // multiply both significands the product is 48 bits
    //round number take 23 MSBs
    assign significandProduct = significandA * significandB;
    wire [24:0] shiftedProduct;
    wire [22:0] normMantissa;
    wire normalize;

    assign normalize = significandProduct[47];

    assign shiftedProduct = significandProduct[47:23]>>1;

    assign normMantissa =
        (normalize == 1'b1) ? shiftedProduct[22:0] : significandProduct[45:23];
    
    wire [7:0] normExp;
    assign normExp = (normalize == 1'b1) ? expBias+1 : expBias;

    //check for infinty case 
    assign infinity =
        ((normExp == {8{1'b1}}) && (normMantissa == {23{1'b0}})) ? 1'b1 : 1'b0;

    //check for NAN case 
    assign NAN =
        ((normExp == {8{1'b1}}) && (normMantissa != {23{1'b0}})) ? 1'b1 : 1'b0;
    

    assign product = (zero == 1'b1) ? {32{1'b0}} : {finalSign, normExp, normMantissa};
    
endmodule