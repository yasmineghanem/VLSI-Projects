module FLoatingPointMultiplierTB();
    reg [31:0] b,a;
    wire [31:0] product;

    FLoatingPointMultiplier FPMultiplierModule(a,b,product);
        initial begin

            //Testcase(1): positive x positive
            a = 32'b01000010101010100100000000000000; //85.125
            b = 32'b01000010001101001000000000000000; //45.125

            #100
            //Testcase(2): negative x negative
            a = 32'b11000000101100000000000000000000; //-5.5
            b = 32'b11000001001010000000000000000000; //-10.5

            #100
            //Testcase(3): positive x negative
            a = 32'b01000000110010000000000000000000; //6.25
            b = 32'b11000000010110011001100110011010; //-3.4

            #100
            //Testcase(4): negative x positive
            a = 32'b11000000101100000000000000000000; //-5.5
            b = 32'b01000000110010000000000000000000; //6.25

            #100
            //Testcase(5): multiplication by 0
            a = 32'b01000010101010100100000000000000; //85.125
            b = {32{1'b0}}; //0

            #100
            //Testcase(6): multiplication by 1
            a = 32'b01000010001101001000000000000000; //45.125
            b = 32'b00111111100000000000000000000000; //1

           #100
            //Testcase(7): additional testcase: float x int
            a = 32'b01000000110100000000000000000000; //6.5
            b = 32'b01000000010000000000000000000000; //3

            #100
            //Testcase(8): additional testcase: 
            a = 32'b01000010101010100100000000000000; //85.125
            b = 32'b01000010001101001000000000000000; //45.125
        end
    
endmodule