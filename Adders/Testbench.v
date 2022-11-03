`include "RippleCarryAdder.v"
`include "CarryLookAheadAdder.v"
`include "CarrySaveAdder.v"
`include "CarrySelectAdder.v"
`include "CarrySkipAdder.v"
`include "PlusAdder.v"

module Testbench ();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg RippleCarryCin, CarrySelectCin, CarrySaveCin;

    wire signed [N-1:0] RippleCarrySum, PlusSum, CarryLookAheadSum, CarrySaveSum, CarrySelectSum, CarrySkipSum;
    wire RippleCarryCout, PlusCout, CarryLookAheadCout, CarrySaveCout, CarrySelectCout, CarrySkipCout;
    wire RippleCarryOverflow, PlusOverflow, CarryLookAheadOverflow, CarrySaveOverflow, CarrySelectOverflow, CarrySkipOverflow;

    PlusAdder #(N) PA(A,B,PlusSum,PlusCout,PlusOverflow);
    RippleCarryAdder #(N) RCA(A,B,RippleCarrySum,RippleCarryCin,RippleCarryCout,RippleCarryOverflow);
    CarryLookAheadAdder #(N) CLA(A,B,CarryLookAheadSum,CarryLookAheadCout,CarryLookAheadOverflow);
    CarrySaveAdder #(N) CSaveA(A,B,CarrySaveSum,CarrySaveCin,CarrySaveCout,CarrySaveOverflow);
    CarrySelectAdder #(N) CSelectA(A,B,CarrySelectSum,CarrySelectCin,CarrySelectCout,CarrySelectOverflow);
    CarrySkipAdder #(N) CSkipA(A,B,CarrySkipSum,CarrySkipCout,CarrySkipOverflow);

    initial begin
        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30; RippleCarryCin = 0; CarrySelectCin = 0; CarrySaveCin = 0;
        if(PlusSum == 32'd50) begin
            $display("TESTCASE1: SUCCESS");
        end
        #100
        #100
        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423; RippleCarryCin = 0; CarrySelectCin = 0; CarrySaveCin = 0;
        if(PlusSum == -32'd523) begin
            $display("TESTCASE2: SUCCESS");
        end
        #100
        #100
        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50; RippleCarryCin = 0; CarrySelectCin = 0; CarrySaveCin = 0;
        if(PlusSum == -32'd10) begin
            $display("TESTCASE3: SUCCESS");
        end
        #100
        #100
        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10; RippleCarryCin = 0; CarrySelectCin = 0; CarrySaveCin = 0;
        if(CarrySkipOverflow == 32'd1) begin
            $display("TESTCASE4: SUCCESS");
        end
        #100
        #100
        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10; RippleCarryCin = 0; CarrySelectCin = 0; CarrySaveCin = 0;
        if(CarrySkipOverflow == 32'd1) begin
            $display("TESTCASE5: SUCCESS");
        end
        //TESTCASE6 --> Random Case 1
        //TESTCASE7 --> Random Case 2
        //TESTCASE8 --> Random Case 3        
    end
    
endmodule

