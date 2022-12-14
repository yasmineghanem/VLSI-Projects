`include "VerilogMultiplier.v"

module VerilogMultiplierTB();
    parameter N = 32;
    reg [N-1:0] a, b;
    wire [2*N-1:0] product;
    wire overflow;
    
    VerilogMultiplier #(N) VerilogMultiplierModule(.a(a),.b(b),.product(product), .overflow(overflow));
        initial begin

            //Testcase(1): positive a positive
            a = 32'b00001100101000000001110110000111; //211819911
            b = 32'b00000000000000000011000000111001; //12345
            //2614916801295
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#1 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#1: SUCCESS");
            end 

            
            #100
            //Testcase(2): negative a negative
            a = 32'b11111111111111111111011111000001; //-2111
            b = 32'b11111111111101111001001011010111; //-552233
            //1165763863
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#2 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#2: SUCCESS");
            end 

            #100
            //Testcase(3): positive a negative
            a = 32'b00000000000000000000000111110110; //502
            b = 32'b11111111111111111111111111111100; //-4
            //-2008
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#3 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#3: SUCCESS");
            end 

            #100
            //Testcase(4): negative a positive
            a = 32'b11111111111111111111011111000001; //-2111
            b = 32'b00000000000000000000000001111101; //125
            //-263875
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#4 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#4: SUCCESS");
            end 

            #100
            //Testcase(5): multiplication by 0
            a = 32'b01101100101000000010110110000111; //1822436743
            b = 32'b00000000000000000000000000000000; //0
            //0
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#5 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#5: SUCCESS");
            end 

            #100
            //Testcase(6): multiplication by 1
            a = 32'b00000111010110111100110100010101; //123456789
            b = 32'b00000000000000000000000000000001; //1
            //123456789
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#6 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#6: SUCCESS");
            end 

           #100
            //Testcase(7): additional testcase: 0x0
            a = 32'b00000000000000000000000000000000; //0
            b = 32'b00000000000000000000000000000000; //0
            //0
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#7 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#7: SUCCESS");
            end 

            #100
            //Testcase(8): additional testcase: 
            a = 32'b00000000000000000000000000100000; //32
            b = 32'b00000000000000000000000000010111; //23
            //736
            #20
            if(product != (a*b)) 
            begin
                $display("TESTCASE#8 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#8: SUCCESS");
            end 

        end
    
endmodule