`include "VerilogMultiplier.v"

module VerilogMultiplierTB();
    parameter N = 32;
    reg [N-1:0] a, b;
    wire [2*N-1:0] product;
    
    VerilogMultiplier #(N) VerilogMultiplierModule(.a(a), .b(b), .product(product));
        initial begin

            //Testcase(1): positive x positive
            a = 32'd5; //5
            b = 32'd6; //6
            //30
            
            if(product != (32'd30)) 
            begin
                $display("TESTCASE#1 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#1: SUCCESS");
            end 

            
            #100
            //Testcase(2): negative a negative
            a = -32'd4; //-4
            b = -32'd7; //-7
            //28
            
            if(product != (32'd28)) 
            begin
                $display("TESTCASE#2 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#2: SUCCESS");
            end 

            #100
            //Testcase(3): positive a negative
            a = 32'd10; //10
            b = -32'd4; //-4
            //-40
            
            if(product != (-32'd40)) 
            begin
                $display("TESTCASE#3 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#3: SUCCESS");
            end 

            #100
            //Testcase(4): negative a positive
            a = -32'd50; //-50
            b = 32'd5; //5
            //-250
            
            if(product != (-32'd250)) 
            begin
                $display("TESTCASE#4 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#4: SUCCESS");
            end 

            #100
            //Testcase(5): multiplication by 0
            a = 32'd1234; //1822436743
            b = {32{1'b0}}; //0
            //0
            
            if(product != ({32{1'b0}})) 
            begin
                $display("TESTCASE#5 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#5: SUCCESS");
            end 

            #100
            //Testcase(6): multiplication by 1
            a = 32'd99; //99
            b = 32'd1; //1
            //99
            
            if(product != (32'd99)) 
            begin
                $display("TESTCASE#6 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#6: SUCCESS");
            end 

           #100
            //Testcase(7): additional testcase: 0x0
            a = {32{1'b0}}; //0
            b = {32{1'b0}}; //0
            //0
            
            if(product != ({32{1'b0}})) 
            begin
                $display("TESTCASE#7 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#7: SUCCESS");
            end 

            #100
            //Testcase(8): additional testcase: 
            a = 32'd32; //32
            b = 32'd23; //23
            //736         

            if(product != (32'd736)) 
            begin
                $display("TESTCASE#8 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
            end else begin
                $display("TESTCASE#8: SUCCESS");
            end 

        end
    
endmodule