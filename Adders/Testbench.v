`include "RippleCarryAdder.v"
`include "CarryLookAheadAdder.v"
`include "CarrySaveAdder.v"
`include "CarrySelectAdder.v"
`include "CarrySkipAdder.v"
`include "PlusAdder.v"
`include "CarryIncrementAdder.v"
`include "CarryBypassAdder.v"

module PlusAdderTestbench();
    parameter N = 32;
    reg signed [N-1:0] A,B;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    PlusAdder #(N) PA(.A(A),.B(B),.Sum(Sum),.Cout(Cout),.Overflow(Overflow));

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
        
    end
    
endmodule

module RippleCarryAdderTestbench();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg Cin;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    RippleCarryAdder #(N) RCA(A,B,Sum,Cin,Cout,Overflow);

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0; Cin=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
    end
endmodule

module CarryLookAheadAdderTestbench();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarryLookAheadAdder #(N) CLA(A,B,Sum,Cout,Overflow);

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
    end
    
endmodule

module CarrySelectAdderTestbench();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg Cin;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarrySelectAdder #(N) CSelectA(A,B,Sum,Cin,Cout,Overflow);

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0; Cin=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
    end
        
endmodule

module CarrySkipAdderTestbench();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg Cin;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarrySkipAdder #(N) CSkipA(A,B,Sum,Cout,Overflow);

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0; Cin=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
    end
        
endmodule

module CarrySaveAdderTestbench();

    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg Cin;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarrySaveAdder #(N) CSaveA(A,B,Sum,Cout,Overflow);

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0; Cin=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
    end
        
endmodule

module CarryBypassAdderTestbench();
    
    parameter N = 32;
    reg signed [N-1:0] A,B;
    reg Cin;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarryBypassAdder #(N) PA(.A(A),.B(B),.Sum(Sum),.Cin(Cin),.Cout(Cout),.Overflow(Overflow));

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0; Cin=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
        
    end
    
endmodule

module CarryBypassAdderTestbench();
    
    parameter N = 32;
    reg signed [N-1:0] A,B;
    wire signed [N-1:0] Sum;
    wire Cout;
    wire Overflow;

    CarryBypassAdder #(N) PA(.A(A),.B(B),.Sum(Sum),.Cout(Cout),.Overflow(Overflow));

    initial begin
        $monitor(A,B,Sum,Overflow);
        
        //Initial values
        A=0; B=0;
        #100

        //TESTCASE1 --> Positive + Positive
        A = 32'd20; B = 32'd30;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#1 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        #100

        //TESTCASE2 --> Negative + Negative
        A = -32'd100; B = -32'd423;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#2 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end
        #100

        //TESTCASE3 --> Positive + Negative
        A = 32'd40; B = -32'd50;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#3 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end
        #100

        //TESTCASE4 --> Positive Overflow
        A = 32'd2147483640; B = 32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#4 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end
        #100

        //TESTCASE5 --> Negative Overflow
        A = -32'd2147483640; B = -32'd10;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#5 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end
        #100

        //TESTCASE6 --> Random Case 1
        A = -32'd40; B = 32'd40; 
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#6 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end
        #100
        
        //TESTCASE7 --> Random Case 2
        A = 32'd422; B = -32'd200;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#7 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end
        #100

        //TESTCASE8 --> Random Case 3 
        A = 32'd0; B = 32'd1456;
        #20
        if(Overflow == 1 || Sum != (A+B)) begin
            $display("TESTCASE#8 failed with input A=%d and B=%d and output Sum=%d and overflow status Overflow=%d", A, B, Sum, Overflow);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end
        
    end
endmodule

