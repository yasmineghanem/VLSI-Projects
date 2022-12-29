module VerilogMultiplier #(parameter N = 32) (a, b, product);
    input signed [N-1:0] a,b;
    output signed [(2*N)-1:0] product;
      
    assign product = a * b;
endmodule