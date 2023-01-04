`include "BoothAlgorithm.v"

module BoothAlgorithmMultiplierTB();
    parameter N = 32;
    reg [N-1:0] X,Y;
    wire [2*N-1:0] Product;
    
    BoothAlgorithmMultiplier #(N) BoothAlgorithmMultiplier(X,Y,Product);
        initial begin
            $monitor(X,Y,Product);

            //Testcase(1): positive x positive
            X = 32'b00001100101000000001110110000111; //211819911
            Y = 32'b00000000000000000011000000111001; //12345
            //2614916801295
            #1000
            if(Product != 64'd2614916801295) 
            begin
                $display("TESTCASE#1 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#1: SUCCESS");
            end 

            
            #1000
            //Testcase(2): negative x negative
            X = 32'b11111111111111111111011111000001; //-2111
            Y = 32'b11111111111101111001001011010111; //-552233
            //1165763863
            #1000
            if(Product != 64'd1165763863) 
            begin
                $display("TESTCASE#2 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#2: SUCCESS");
            end 

            #1000
            //Testcase(3): positive x negative
            X = 32'b00000000000000000000000111110110; //502
            Y = 32'b11111111111111111111111111111100; //-4
            //-2008
            #1000
            if(Product != -64'd2008) 
            begin
                $display("TESTCASE#3 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#3: SUCCESS");
            end 

            #100
            //Testcase(4): negative x positive
            X = 32'b11111111111111111111011111000001; //-2111
            Y = 32'b00000000000000000000000001111101; //125
            //-263875
            #100
            if(Product != -64'd263875) 
            begin
                $display("TESTCASE#4 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#4: SUCCESS");
            end 

            #100
            //Testcase(5): multiplication by 0
            X = 32'b01101100101000000010110110000111; //1822436743
            Y = 32'b00000000000000000000000000000000; //0
            //0
            #100
            if(Product != 64'd0) 
            begin
                $display("TESTCASE#5 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#5: SUCCESS");
            end 

            #100
            //Testcase(6): multiplication by 1
            X = 32'b00000111010110111100110100010101; //123456789
            Y = 32'b00000000000000000000000000000001; //1
            //123456789
            #100
            if(Product != 64'd123456789) 
            begin
                $display("TESTCASE#6 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#6: SUCCESS");
            end 

           #100
            //Testcase(7): additional testcase: 0x0
            X = 32'b00000000000000000000000000000000; //0
            Y = 32'b00000000000000000000000000000000; //0
            //0
            #100
            if(Product != 64'd0) 
            begin
                $display("TESTCASE#7 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#7: SUCCESS");
            end 

            #100
            //Testcase(8): additional testcase: 
            X = 32'b01111111111111111111111111111111; //2147483647
            Y = 32'b10000000000000000000000000000000; //-2147483648
            //4611686016279904256
            #100
            if(Product != -64'd4611686016279904256) 
            begin
                $display("TESTCASE#8 FAILED with inputs X=%d and Y=%d and output Product=%d", X, Y, Product);
            end else begin
                $display("TESTCASE#8: SUCCESS");
            end 

        end
    
endmodule