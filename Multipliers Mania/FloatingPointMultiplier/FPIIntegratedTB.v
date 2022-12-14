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
        .product(product), 
        .overflow(overflow), 
        .infinity(infinity),
        .NAN(NAN));

    initial begin
        $monitor(a, b, product, overflow, infinity, NAN);

        //initial values --> does nothing
        clk = 1; 
        a = {32{1'b0}}; b = {32{1'b0}}; 
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        #10
        // enable input registers to write a and b values
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

/*---------------------------------------------------------------------------------------------------------------------------------*/

        #10
        // enable input registers to write a and b values
        a = 32'b01000010001101001000000000000000; b = 32'b00111111100000000000000000000000; 
        writeEnableA = 1'b1; writeEnableB = 1'b1; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        #10
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product  
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b1; readEnableB = 1'b1; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        #10
        // enable output register to write multiplication output
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b1; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        #10
        //enable output register to read the product
        writeEnableA = 1'b0; writeEnableB = 1'b0; writeEnableOut = 1'b0; 
        readEnableA = 1'b0; readEnableB = 1'b0; readEnableOut = 1'b1; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

    end

    always #5 clk=~clk;
    
endmodule