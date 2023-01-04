`include "FPIntegrated.v"

module GenericFloatingTB ();
    reg clk;
    reg enableA, enableB, enableOut;
    reg resetA, resetB, resetOut;
    reg [31:0] a, b;
    wire [31:0] product;
    wire infinity;
    wire overflow, NAN;

    FPIntegrated FPIntegratedModule(
        .clk(clk), 
        .a(a), 
        .b(b), 
        .enableA(enableB), 
        .enableB(enableB), 
        .enableOut(enableOut), 
        .resetA(resetA), 
        .resetB(resetB), 
        .resetOut(resetOut),
        .product(product), 
        .overflow(overflow), 
        .infinity(infinity),
        .NAN(NAN));

    initial begin
        //initial values --> does nothing
        clk = 1; 
        a = {32{1'b0}}; b = {32{1'b0}}; 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        //Testcase(1):         
        #20
        // enable input registers to write a and b values
        a = 32'h49072340; b = 32'h44520000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b01000101011100000001010001000000) begin
            $display("TESTCASE#1: SUCCESS");
        end 
        else begin
            $display("TESTCASE#1 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2):     
        // enable input registers to write a and b values
        a = 32'b11000000101100000000000000000000; b = 32'b11000001001010000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b01000010011001110000000000000000) begin
            $display("TESTCASE#2: SUCCESS");
        end 
        else begin
            $display("TESTCASE#2 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3): 
        // enable input registers to write a and b values
        a = 32'b01000000110010000000000000000000; b = 32'b11000000010110011001100110011010;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b11000001101010100000000000000000) begin
            $display("TESTCASE#3: SUCCESS");
        end 
        else begin
            $display("TESTCASE#3 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4):
        // enable input registers to write a and b values
        a = 32'b11000000101100000000000000000000; b = 32'b01000000110010000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b11000010000010011000000000000000) begin
            $display("TESTCASE#4: SUCCESS");
        end 
        else begin
            $display("TESTCASE#4 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5):
        // enable input registers to write a and b values
        a = 32'b01000010101010100100000000000000; b = {32{1'b0}};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == {32{1'b0}}) begin
            $display("TESTCASE#5: SUCCESS");
        end 
        else begin
            $display("TESTCASE#5 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6):
        // enable input registers to write a and b values
        a = 32'b01000010001101001000000000000000; b = 32'b00111111100000000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == a) begin
            $display("TESTCASE#6: SUCCESS");
        end 
        else begin
            $display("TESTCASE#6 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(7): 
        // enable input registers to write a and b values
        a = 32'b01000000110100000000000000000000; b = 32'b01000000010000000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b01000001100111000000000000000000) begin
            $display("TESTCASE#7: SUCCESS");
        end 
        else begin
            $display("TESTCASE#7 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8): 
        // enable input registers to write a and b values
        a = 32'b00111111100000000000000000000000; b = 32'b10111111100000000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == b) begin
            $display("TESTCASE#8: SUCCESS");
        end 
        else begin
            $display("TESTCASE#8 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end
        
        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(9): 
        // enable input registers to write a and b values
        a = 32'b01000000110100000000000000000000; b = 32'b01000000010000000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b01000001100111000000000000000000) begin
            $display("TESTCASE#9: SUCCESS");
        end 
        else begin
            $display("TESTCASE#9 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(10):
        // enable input registers to write a and b values
        a = 32'b01000000110100000000000000000000; b = 32'b01000000010000000000000000000000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'b01000001100111000000000000000000) begin
            $display("TESTCASE#10: SUCCESS");
        end 
        else begin
            $display("TESTCASE#10 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(11):
        // enable input registers to write a and b values
        a = 32'h0; b = 32'h4EA0C8E4;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'h0) begin
            $display("TESTCASE#11: SUCCESS");
        end 
        else begin
            $display("TESTCASE#11 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(12):
        // enable input registers to write a and b values
        a = 32'hCE8EF06B; b = 32'h0;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'h0) begin
            $display("TESTCASE#12: SUCCESS");
        end 
        else begin
            $display("TESTCASE#12 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(13): 
        // enable input registers to write a and b values
        a = 32'h3FFFFFF0; b = 32'h41A00000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(overflow == 1'b1) begin
            $display("TESTCASE#13: SUCCESS");
        end 
        else begin
            $display("TESTCASE#13 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(14): 
        // enable input registers to write a and b values
        a = 32'hBFFFFFFF; b = 32'h41A00000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(overflow == 1'b1) begin
            $display("TESTCASE#14: SUCCESS");
        end 
        else begin
            $display("TESTCASE#14 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(15): 
        // enable input registers to write a and b values
        a = 32'h35D00998; b = 32'h800000;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product == 32'h) begin
            $display("TESTCASE#15: SUCCESS");
        end 
        else begin
            $display("TESTCASE#15 failed with input a=%b and a=%b and output product=%b and overflow status =%b",a, b, product, overflow);
        end

        #10
        enableOut = 1'b0;
    end

    always #5 clk=~clk;
    
endmodule