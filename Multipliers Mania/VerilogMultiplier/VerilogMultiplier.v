module VerilogMultiplier (a, b, product);
    input signed [31:0] a, b;
    output signed [63:0] product;
      
    assign product = a * b;
endmodule