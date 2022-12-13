module FLoatingPointMultiplierTB();
    reg [31:0] a,b;
    wire [31:0] product;
    wire infinity, NAN, overflow;

    FLoatingPointMultiplier FPMultiplierModule(.a(a),.b(b),.product(product),.infinity(infinity),.NAN(NAN),.overflow(overflow));

        initial begin

            $monitor(a,b,product,overflow);

                    //Initial values
            a={32{1'b0}}; b={32{1'b0}};
            #100

            //Testcase(1): positive x positive
            a = 32'b01000010101010100100000000000000; //85.125
            b = 32'b01000010001101001000000000000000; //45.125
            #20
            if(product == 32'b01000101011100000001010001000000) begin
                $display("TESTCASE#1: SUCCESS");
            end 
            else begin
                $display("TESTCASE#1 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
            end

            #100
            //Testcase(2): negative x negative
            a = 32'b11000000101100000000000000000000; //-5.5
            b = 32'b11000001001010000000000000000000; //-10.5
            #20
            if(product == 32'b01000010011001110000000000000000) begin
                $display("TESTCASE#2: SUCCESS");
            end else begin
                $display("TESTCASE#2 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

            #100
            //Testcase(3): positive x negative
            a = 32'b01000000110010000000000000000000; //6.25
            b = 32'b11000000010110011001100110011010; //-3.4
            #20             
            if(product == 32'b11000001101010100000000000000000) begin
                $display("TESTCASE#3: SUCCESS");
            end else begin
                $display("TESTCASE#3 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

            #100
            //Testcase(4): negative x positive
            a = 32'b11000000101100000000000000000000; //-5.5
            b = 32'b01000000110010000000000000000000; //6.25
            #20
            if(product == 32'b11000010000010011000000000000000) begin
                $display("TESTCASE#4: SUCCESS");
            end else begin
                $display("TESTCASE#4 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

            #100
            //Testcase(5): multiplication by 0
            a = 32'b01000010101010100100000000000000; //85.125
            b = {32{1'b0}}; //0
            #20
            if(product == {32{1'b0}}) begin
                $display("TESTCASE#5: SUCCESS");
            end else begin
                $display("TESTCASE#5 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

            #100
            //Testcase(6): multiplication by 1
            a = 32'b01000010001101001000000000000000; //45.125
            b = 32'b00111111100000000000000000000000; //1
            #20
            if(product == 32'b01000010001101001000000000000000) begin
                $display("TESTCASE#6: SUCCESS");
            end else begin
                $display("TESTCASE#6 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

           #100
            //Testcase(7): additional testcase: float x int
            a = 32'b01000000110100000000000000000000; //6.5
            b = 32'b01000000010000000000000000000000; //3
            #20
            if(product == 32'b01000001100111000000000000000000) begin
                $display("TESTCASE#7: SUCCESS");
            end else begin
                $display("TESTCASE#7 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end

            #100
            //Testcase(8): additional testcase: 
            a = 32'b00111111100000000000000000000000; //1
            b = 32'b10111111100000000000000000000000; //-1
            #20
            if(product == 32'b10111111100000000000000000000000) begin
                $display("TESTCASE#8: SUCCESS");
            end else begin
                $display("TESTCASE#8 failed with input a=%b and a=%b and output product=%b and overflow status =%b", a, b, product, overflow);
            end
        end
    
endmodule