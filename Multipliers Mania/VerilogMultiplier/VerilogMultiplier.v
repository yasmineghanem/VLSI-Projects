module VerilogMultiplier #(parameter N = 32) (a, b, product, overflow);
    input [N-1:0] a,b;
    output [(2*N)-1:0] product;
    output overflow;

      
    assign product = a * b;
    assign overflow = (a != {32{1'b0}} && (product/a) != b) ? 1'b1 : 1'b0;

endmodule