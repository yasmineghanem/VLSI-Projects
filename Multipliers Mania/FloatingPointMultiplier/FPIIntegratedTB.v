`include "FPIntegrated.v"

module FPIntegratedTB ();
    reg clk;
    reg writeEnableA, writeEnableB, writeEnableOut;
    reg readEnableA, readEnableB, readEnableOut;
    reg resetA, resetB, resetOut;
    reg [31:0] a, b;
    wire [31:0] product;
    wire infinity;
    wire overflow, NAN;
    wire accessErrorA, accessErrorB, accessErrorOut;

    FPIntegrated FPIntegratedModule(
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
        .overflow(overflow), 
        .infinity(infinity),
        .NAN(NAN));

    initial begin
        //initial values --> does nothing
        clk = 1; 
        a = {32{1'b0}}; b = {32{1'b0}}; 
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        //Testcase(1): positive x positive: a = 85.125 b = 45.125        
        #10
        // enable input registers to write a and b values
        a = 32'b01000010101010100100000000000000; b = 32'b01000010001101001000000000000000;         
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
        if(product == 32'b01000101011100000001010001000000) begin
            $display("TESTCASE#1: SUCCESS");
        end 
        else begin
            $display("TESTCASE#1 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2): negative x negative: a = -5.5 b = -10.5       
        // enable input registers to write a and b values
        a = 32'b11000000101100000000000000000000; b = 32'b11000001001010000000000000000000;         
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
        if(product == 32'b01000010011001110000000000000000) begin
            $display("TESTCASE#2: SUCCESS");
        end 
        else begin
            $display("TESTCASE#2 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3): positive x negative a = 6.25 b = -3.4     
        // enable input registers to write a and b values
        a = 32'b01000000110010000000000000000000; b = 32'b11000000010110011001100110011010;         
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
        if(product == 32'b11000001101010100000000000000000) begin
            $display("TESTCASE#3: SUCCESS");
        end 
        else begin
            $display("TESTCASE#3 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4): negative x positive a = -5.5 b = 6.25   
        // enable input registers to write a and b values
        a = 32'b11000000101100000000000000000000; b = 32'b01000000110010000000000000000000;         
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
        if(product == 32'b11000010000010011000000000000000) begin
            $display("TESTCASE#4: SUCCESS");
        end 
        else begin
            $display("TESTCASE#4 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5): multiplication by 0   
        // enable input registers to write a and b values
        a = 32'b01000010101010100100000000000000; b = {32{1'b0}};         
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
        if(product == {32{1'b0}}) begin
            $display("TESTCASE#5: SUCCESS");
        end 
        else begin
            $display("TESTCASE#5 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6): multiplication by 1  
        // enable input registers to write a and b values
        a = 32'b01000010001101001000000000000000; b = 32'b00111111100000000000000000000000;         
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
        if(product == a) begin
            $display("TESTCASE#6: SUCCESS");
        end 
        else begin
            $display("TESTCASE#6 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(7): additional testcase: float x int a = 6.5 b = 3
        // enable input registers to write a and b values
        a = 32'b01000000110100000000000000000000; b = 32'b01000000010000000000000000000000;         
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
        if(product == 32'b01000001100111000000000000000000) begin
            $display("TESTCASE#7: SUCCESS");
        end 
        else begin
            $display("TESTCASE#7 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8): additional testcase: int x int a = 1 b = -1
        // enable input registers to write a and b values
        a = 32'b00111111100000000000000000000000; b = 32'b10111111100000000000000000000000;         
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
        if(product == b) begin
            $display("TESTCASE#8: SUCCESS");
        end 
        else begin
            $display("TESTCASE#8 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
    end

    always #5 clk=~clk;
    
endmodule