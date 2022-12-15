`include "BAMIntegrated.v"

module BMAIntegratedTB ();
    reg clk;
    reg writeEnableA, writeEnableB, writeEnableOut;
    reg readEnableA, readEnableB, readEnableOut;
    reg resetA, resetB, resetOut;
    reg [31:0] A, B;
    wire [63:0] product;
    wire accessErrorA, accessErrorB, accessErrorOut;

    BAMIntegrated BAMIntegratedModule(
        .clk(clk), 
        .Multiplicand(A), 
        .Multiplier(B), 
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
        .Product(product)
        );

    initial begin
        //initial values --> does nothing
        clk = 1; 
        A = {32{1'b0}}; B = {32{1'b0}}; 
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        //Testcase(1): positive x positive:       
        #10
        // enable input registers to write A & B values
        A = 32'b00001100101000000001110110000111; B = 32'b00000000000000000011000000111001;         
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
        if(product == 64'd2614916801295) begin
            $display("TESTCASE#1: SUCCESS");
        end 
        else begin
            $display("TESTCASE#1 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2): negative x negative: a = -5.5 b = -10.5       
        // enable input registers to write A & B values
        A = 32'b11111111111111111111011111000001; B = 32'b11111111111101111001001011010111;         
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
        if(product == 64'd1165763863) begin
            $display("TESTCASE#2: SUCCESS");
        end 
        else begin
            $display("TESTCASE#2 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3): positive x negative a = 6.25 b = -3.4     
        // enable input registers to write A & B values
        A = 32'b00000000000000000000000111110110; B = 32'b11111111111111111111111111111100;         
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
        if(product == -64'd2008) begin
            $display("TESTCASE#3: SUCCESS");
        end 
        else begin
            $display("TESTCASE#3 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4): negative x positive a = -5.5 b = 6.25   
        // enable input registers to write A & B values
        A = 32'b11111111111111111111011111000001; B = 32'b00000000000000000000000001111101;         
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
        if(product == -64'd263875) begin
            $display("TESTCASE#4: SUCCESS");
        end 
        else begin
            $display("TESTCASE#4 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5): multiplication by 0   
        // enable input registers to write A & B values
        A = 32'b01101100101000000010110110000111; B = {32{1'b0}};         
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
            $display("TESTCASE#5 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6): multiplication by 1  
        // enable input registers to write A & B values
        A = 32'b00000111010110111100110100010101; B = 32'b00000000000000000000000000000001;         
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
        if(product == 64'd123456789) begin
            $display("TESTCASE#6: SUCCESS");
        end 
        else begin
            $display("TESTCASE#6 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(7): additional testcase: float x int a = 6.5 b = 3
        // enable input registers to write A & B values
        A = 32'b00000000000000000000000000000000; B = 32'b00000000000000000000000000000000;         
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
        if(product == 64'd0) begin
            $display("TESTCASE#7: SUCCESS");
        end 
        else begin
            $display("TESTCASE#7 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8): additional testcase: int x int a = 1 b = -1
        // enable input registers to write A & B values
        A = 32'b01111111111111111111111111111111; B = 32'b10000000000000000000000000000000;         
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
        if(product == -64'd4611686016279904256) begin
            $display("TESTCASE#8: SUCCESS");
        end 
        else begin
            $display("TESTCASE#8 failed with input a=%d and b=%d and output product=%d " ,A,B,product );
        end
    end

    always #5 clk=~clk;
    
endmodule