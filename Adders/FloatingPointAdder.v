`include "MUXs.v"
`include "Subtractor.v"
`include "Shifter.v"
`include "PlusAdder.v"
`include "Incrementer.v"
`include "TwosComplement.v"
`include "LeadingZeroCounter.v"

module FloatingPointAdder (A,B,Sum, Overflow);
    input [31:0] A,B;
    output [31:0] Sum;
    output Overflow;
    //ALGORITHM

    //1. Seperate numbers
    wire [22:0] MentissaA, MentissaB;
    wire [7:0] ExponentA, ExponentB;
    wire SignA, SignB;

    assign MentissaA = A[22:0];
    assign MentissaB = B[22:0];
    assign ExponentA = A[30:23];
    assign ExponentB = B[30:23] ;
    assign SignA = A[31];
    assign SignB = B[31]; 

    // Get higher exponent by subtracting them
    wire [7:0] ExponentDifference, TwosCompExpDiff ,ModExponentDifference;
    wire Borrow;
    Subtractor Sub(ExponentA,ExponentB,ExponentDifference,Borrow);

    //Get Modulus of exponent
    TwosComplement ExpTwosComp(ExponentDifference, TwosCompExpDiff);
    assign ModExponentDifference = (Borrow == 1'b1) ? TwosCompExpDiff : ExponentDifference;

    //Get the higher exponent 
    wire [7:0] HigherExponent;
    MUX8bits ExponentMux1(ExponentA,ExponentB,Borrow,HigherExponent);

    //Get the mantissa of the smaller exponent
    wire [23:0] MantissaToShift, UnShiftedMantissa;
    Mux24bits MantissaMux1(MentissaB,MentissaA,Borrow,MantissaToShift);
    Mux24bits MantissaMux2(MentissaA,MentissaB,Borrow,UnShiftedMantissa);

    //Handling the sign bit 
    wire SignSel, BothNeg;
    assign SignSel = (SignA == SignB) ? 0 : 1;
    assign BothNeg = (SignA == 1 && SignB == 1) ? 1 : 0;
    wire Sign1, Sign2;
    MUX21 SignMux1(SignB, SignA, Borrow, Sign1);
    MUX21 SignMux2(SignA, SignB, Borrow, Sign2);

    //Shift the mantissa by the amount of exponent difference
    wire [23:0] ShiftedMantissa;
    RightShifter RightShifter1(MantissaToShift,ModExponentDifference,ShiftedMantissa);

    //Calculate 2's complement for both mantissa's and choose using a mux and the sign as the selector
    wire [23:0] ShiftedMantissaComplement, UnShiftedMantissaComplement;
    TwosComplement #(24) ShiftedComplement(ShiftedMantissa, ShiftedMantissaComplement);
    TwosComplement #(24) NonShiftedComplement(UnShiftedMantissa,UnShiftedMantissaComplement);

    wire [23:0] ShiftedMantissaAddition, UnShiftedMantissaAddition;
    Mux24Bits MantissaMux3(ShiftedMantissa, ShiftedMantissaComplement , Sign1, ShiftedMantissaAddition);
    Mux24Bits MantissaMux4(UnShiftedMantissa, UnShiftedMantissaComplement , Sign2, UnShiftedMantissaAddition);

    //Perform addition on the shifted and non shifted mantissa
    wire [23:0] MantissaSum, MantissaSumComplement;
    wire Cout;
    PlusAdder #(24) PA(ShiftedMantissaAddition, UnShiftedMantissaAddition, MantissaSum, Cout, Overflow);

    //Get result's final sign
    wire FinalSign;
    assign FinalSign = ((SignA != SignB) && (ShiftedMantissa > UnShiftedMantissa)) ? Sign1 : Sign2;

    //Choose between sum and sum's complement based on result's final sig
    wire [23:0] FinalMantissaSum;
    TwosComplement #(24) SumComplement(MantissaSum, MantissaSumComplement);
    Mux24Bits MantissaMux5(MantissaSum, MantissaSumComplement, FinalSign, FinalMantissaSum);

    //Shift left and right
    wire [23:0] ShiftMantissaRight, ShiftMantissaLeft;
    wire [31:0] MantissaSumTemp;
    wire [4:0] ShiftAmountPlus8, ShiftAmount; //Number of leading zeros
    assign MantissaSumTemp[23:0] = FinalMantissaSum;
    assign MantissaSumTemp[31:24] = 8'b0;

    CountLeadingZeros CLZ(MantissaSumTemp, ShiftAmountPlus8);
    assign ShiftAmount = ShiftAmountPlus8 - 8;

    //If Cout is 1 then shift mantissa by Cout
    CoutShift ShiftCout(FinalMantissaSum, Cout, ShiftMantissaRight);
    LeftShifter ShiftLeft(FinalMantissaSum, ShiftAmount, ShiftMantissaLeft);

    wire [22:0] FinalMantissa;
    Mux24bits MantissaMux6(ShiftMantissaRight[22:0], ShiftMantissaLeft[22:0], SignSel,FinalMantissa);

    //Increments exponent if the carry from the additiion is 1
    wire [7:0] FinalExponentIncrement, FinalExponentDecrement, FinalExponent;
    Increment Inc(HigherExponent, Cout, FinalExponentIncrement);
    Decrement Dec(HigherExponent, ShiftAmount, FinalExponentDecrement);
    MUX8bits ExponentMux2(FinalExponentIncrement, FinalExponentDecrement, SignSel, FinalExponent);

    assign Sum[31] = FinalSign;
    assign Sum[30:23] = FinalExponent;
    assign Sum[22:0] = FinalMantissa;

endmodule
