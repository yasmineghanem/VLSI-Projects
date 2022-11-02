`include "RippleCarryAdder.v"
`include "PlusAdder.v"
`include "CarryLookAheadAdder.v"
`include "CarrySaveAdder.v"
`include "CarrySelectAdder.v"
`include "CarrySkipAdder.v"

module Testbench ();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg RippleCarryCin, CarrySelectCin;

    wire signed [N-1:0] RippleCarrySum, PlusSum, CarryLookAheadSum, CarrySaveSum, CarrySelectSum, CarrySkipSum;
    wire RippleCarryCout, PlusCout, CarryLookAheadCout, CarrySaveCout, CarrySelectCout, CarrySkipCout;
    wire RippleCarryOverflow, PlusOverflow, CarryLookAheadOverflow, CarrySaveOverflow, CarrySelectOverflow, CarrySkipOverflow;

    PlusAdder #(N) PA(A,B,PlusSum,PlusCout,PlusOverflow);
    RippleCarryAdder #(N) RCA(A,B,RippleCarrySum,RippleCarryCin,RippleCarryCout,RippleCarryOverflow);
    CarryLookAheadAdder #(N) CLA(A,B,CarryLookAheadSum,CarryLookAheadCout,CarryLookAheadOverflow);
    CarrySaveAdder #(N) CSaveA(A,B,CarrySaveSum,CarrySaveCout,CarrySaveOverflow);
    CarrySelectAdder #(N) CSelectA(A,B,CarrySelectSum,CarrySelectCin,CarrySelectCout,CarrySelectOverflow);
    CarrySkipAdder #(N) CSkipA(A,B,CarrySkipSum,CarrySkipCout,CarrySkipOverflow);

    initial begin
        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30; RippleCarryCin = 0; CarrySelectCin = 0;
        if(PlusSum == 50) begin
            $display("TESTCASE1: SUCCESS");
        end

        //TESTCASE2 --> Negative + Negative
        //TESTCASE3 --> Positive + Negative
        //TESTCASE4 --> Positive Overflow
        //TESTCASE5 --> Negative Overflow
        //TESTCASE6 --> Random Case 1
        //TESTCASE7 --> Random Case 2
        //TESTCASE8 --> Random Case 3        
    end
    
endmodule

