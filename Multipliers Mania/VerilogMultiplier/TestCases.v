`include "VerilogMultiplier.v"

module GenericVerilogTB ();
    reg clk;
    reg enableA, enableB, enableOut;
    reg resetA, resetB, resetOut;
    reg [31:0] a, b;
    wire [63:0] product;

    VerilogMultiplierIntegrated VerilogMultiplierIntegratedModule(
        .clk(clk), 
        .a(a), 
        .b(b), 
        .enableA(enableA), 
        .enableB(enableB), 
        .enableOut(enableOut), 
        .resetA(resetA), 
        .resetB(resetB), 
        .resetOut(resetOut),
        .product(product));

    initial begin
        //initial values --> does nothing
        clk = 1; 
        a = {32{1'b0}}; b = {32{1'b0}}; 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b0; 
        resetA = 1'b0; resetB = 1'b0; resetOut = 1'b0;

        //Testcase(1):  
        #20
        // enable input registers to write a and b values
        a = 32'h87234; //5
        b = 32'h348; //6      
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'h1BB6BAA0)) begin
            $display("TESTCASE#1 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#1: SUCCESS");
        end

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
   
        //Testcase(2): 
        // enable input registers to write a and b values
        a = 32'h50647236; //-4
        b = 32'h50612336; //-7        
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'h193DE4CED7437964)) 
        begin
            $display("TESTCASE#2 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#2: SUCCESS");
        end 

        #10
        enableOut = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(3):     
        // enable input registers to write a and b values
        a = 32'h87234; //10
        b = 32'hFFFFFEFD; //-4     
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'hFFFFFFFF_F7747564)) begin
            $display("TESTCASE#3 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#3: SUCCESS");
        end 
        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(4): 
        // enable input registers to write a and b values
        a = 32'h50647236; //-50
        b = 32'hB887CAAF; //5      
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'hE98E647F4142AEEA)) begin
            $display("TESTCASE#4 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#4: SUCCESS");
        end 
        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(5): 
        // enable input registers to write a and b values
        a = 32'hFFFFFEFD; //1234
        b = 32'h87234; //0        
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != ({64'hFFFFFFFFF7747564})) begin
            $display("TESTCASE#5 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#5: SUCCESS");
        end 
        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(6): 
        // enable input registers to write a and b values
        a = 32'hB887CAAF; //123456789
        b = 32'h50647236; //1     
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'hE98E647F4142AEEA)) begin
            $display("TESTCASE#6 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#6: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(7): 
        // enable input registers to write a and b values
        a = {32'hFFFFFEFD};
        b = {32'hFFFFFEFD};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != ({64'h10609})) begin
            $display("TESTCASE#7 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#7: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(8):
        // enable input registers to write a and b values
        a = 32'hB887CAAF; 
        b = 32'h887CAAF3;         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'h215D8B0A7A419A1D)) begin
            $display("TESTCASE#8 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#8: SUCCESS");
        end 
        
        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(9):
        // enable input registers to write a and b values
        a = {32'h1};
        b = {32'h50647236};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != (64'h50647236)) begin
            $display("TESTCASE#9 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#9: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(10: 
        // enable input registers to write a and b values
        a = {32'hB887CAAF};
        b = {32'h1};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != ({64'hFFFFFFFFB887CAAF})) begin
            $display("TESTCASE#10 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#10: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(11): 
        // enable input registers to write a and b values
        a = {32'h0};
        b = {32'h50647236};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != ({64'h0})) begin
            $display("TESTCASE#11 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#11: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
/*---------------------------------------------------------------------------------------------------------------------------------*/
        
        //Testcase(12): 
        // enable input registers to write a and b values
        a = {32'hB887CAAF};
        b = {32'h0};         
        enableA = 1'b1; enableB = 1'b1;

        #20
        // enable input registers to read a and b values -> the multiplier performs operation and outputs the product 
        enableA = 1'b0; enableB = 1'b0; enableOut = 1'b1; 

        //check results
        #30
        if(product != ({64'h0})) begin
            $display("TESTCASE#12 FAILED with inputs a=%d and b=%d and output product=%d", a, b, product);
        end else begin
            $display("TESTCASE#12: SUCCESS");
        end 

        #10
        enableOut  = 1'b0;
    end

    always #3 clk=~clk;
    
endmodule