`include "VerilogMultiplierIntegrated.v"

module VerilogMultiplierIntegratedTB ();
    parameter N = 32;
    reg clk;
    reg writeEnableA, writeEnableB, writeEnableOut;
    reg readEnableA, readEnableB, readEnableOut;
    reg resetA, resetB, resetOut;
    reg [N-1:0] a, b;
    wire [2*N-1:0] product;
    wire overflow;
    wire accessErrorA, accessErrorB, accessErrorOut;

    VerilogMultiplierIntegrated #(N) VerilogMultiplierIntegratedModule(
        .clk(clk), 
        .a(a), 
        .b(b), 
        .writeEnableA(writeEnableA), 
        .writeEnableB(writeEnableB), 
        .writeEnableOut(writeEnableOut), 
        .readEnableA(readEnableA), 
        .readEnableB(readEnableB), 
        .readEnableOut(readEnableOut), 
        .resetA(resetA), 
        .resetB(resetB), 
        .resetOut(resetOut),
        .accessErrorA(accessErrorA), 
        .accessErrorB(accessErrorB), 
        .accessErrorOut(accessErrorOut),
        .product(product), 
        .overflow(overflow));

    initial begin
        //initial values --> does nothing
        clk = 1; 
        a = {32{1'b0}}; b = {32{1'b0}}; 
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        //Testcase(1): positive x positive: a = 211819911 b = 12345       
        #10
        // enable input registers to write a and b values
        a = 32'b00001100101000000001110110000111; b = 32'b00000000000000000011000000111001;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#1: SUCCESS");
        end 
        else begin
            $display("TESTCASE#1 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2): negative x negative: a = -2111 b = -552233       
        // enable input registers to write a and b values
        a = 32'b11111111111111111111011111000001; b = 32'b11111111111101111001001011010111;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#2: SUCCESS");
        end 
        else begin
            $display("TESTCASE#2 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3): positive x negative a = 502 b = -4     
        // enable input registers to write a and b values
        a = 32'b00000000000000000000000111110110; b = 32'b11111111111111111111111111111100;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#3: SUCCESS");
        end 
        else begin
            $display("TESTCASE#3 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4): negative x positive a = -2111 b = 125   
        // enable input registers to write a and b values
        a = 32'b11111111111111111111011111000001; b = 32'b00000000000000000000000001111101;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#4: SUCCESS");
        end 
        else begin
            $display("TESTCASE#4 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5): multiplication by 0   
        // enable input registers to write a and b values
        a = 32'b01101100101000000010110110000111; b = {32{1'b0}};         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#5: SUCCESS");
        end 
        else begin
            $display("TESTCASE#5 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6): multiplication by 1  
        // enable input registers to write a and b values
        a = 32'b00000111010110111100110100010101; b = 32'b00000000000000000000000000000001;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#6: SUCCESS");
        end 
        else begin
            $display("TESTCASE#6 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(7): additional testcase: 0 x 0
        // enable input registers to write a and b values
        a = {32{1'b0}}; b = {32{1'b0}};         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#7: SUCCESS");
        end 
        else begin
            $display("TESTCASE#7 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8): additional testcase: int x int a = 32 b = 23
        // enable input registers to write a and b values
        a = 32'b00000000000000000000000000100000; b = 32'b00000000000000000000000000010111;         
        writeEnableA = 1'b1; writeEnableB = 1'b1;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        writeEnableA = 1'b0; writeEnableB = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1;

        #10
        // enable output register to write multiplication output
        writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0;

        #10
        //enable output register to read the product
        writeEnableOut = 1'b0; 
        readEnableOut = 1'b1; 

        //check results
        #10
        if(product == (a*b)) begin
            $display("TESTCASE#8: SUCCESS");
        end 
        else begin
            $display("TESTCASE#8 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
    end

    always #5 clk=~clk;
    
endmodule