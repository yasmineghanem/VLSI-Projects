`include "VerilogMultiplierIntegrated.v"

module VerilogMultiplierIntegratedTB ();
    parameter N = 32;
    reg clk;
    reg writeEnableA, writeEnableB, writeEnableOut;
    reg readEnableA, readEnableB, readEnableOut;
    reg resetA, resetB, resetOut;
    reg [N-1:0] a, b;
    wire [2*N-1:0] product;
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
        .product(product));

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
        a = 32'd5; //5
        b = 32'd6; //6      
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
        
        if(product != (32'd30)) 
        begin
            $display("TESTCASE#1 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end 
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2): negative x negative: a = -2111 b = -552233       
        // enable input registers to write a and b values
        a = -32'd4; //-4
        b = -32'd7; //-7        
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
        
        if(product != (32'd28)) 
        begin
            $display("TESTCASE#2 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end 
        readEnableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3): positive x negative a = 10 b = -4     
        // enable input registers to write a and b values
        a = 32'd10; //10
        b = -32'd4; //-4     
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
        
        if(product != (-32'd40)) begin
            $display("TESTCASE#3 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end 
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4): negative x positive a = -2111 b = 125   
        // enable input registers to write a and b values
        a = -32'd50; //-50
        b = 32'd5; //5      
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
        
        if(product != (-32'd250)) begin
            $display("TESTCASE#4 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end 
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5): multiplication by 0   
        // enable input registers to write a and b values
        a = 32'd1234; //1822436743
        b = {32{1'b0}}; //0        
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
        
        if(product != ({32{1'b0}})) begin
            $display("TESTCASE#5 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end 
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6): multiplication by 1  
        // enable input registers to write a and b values
        a = 32'd99; //123456789
        b = 32'd1; //1     
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
        
        if(product != (32'd99)) begin
            $display("TESTCASE#6 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#6: SUCCESS");
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

        // check results
        if(product != ({32{1'b0}})) begin
            $display("TESTCASE#7 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end 
        readEnableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8): additional testcase: int x int a = 32 b = 23
        // enable input registers to write a and b values
        a = 32'd32; b = 32'd23;         
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
        
        if(product != (32'd736)) begin
            $display("TESTCASE#8 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end 
    end

    always #5 clk=~clk;
    
endmodule