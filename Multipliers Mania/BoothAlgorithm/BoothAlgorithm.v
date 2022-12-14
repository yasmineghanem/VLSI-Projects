module BoothAlgorithmMultiplier #(parameter N = 32) (Multiplicand, Multiplier, Product);
    input signed [N-1:0] Multiplicand, Multiplier;
    output signed [2*N-1:0] Product;
    reg signed [2*N-1:0] Product;
    reg [1:0] temp;
    integer i;
    reg Q0;

    always @ (Multiplicand, Multiplier)
    begin
        Product = 0;
        Q0 = 0;
        for (i = 0; i < N; i = i + 1)
        begin
            //temp = Q1 Q0
            temp = {Multiplicand[i], Q0};
            //If temp = 10 then A = A - M where Product MSB 32 bits = A
            //If temp = 01 then A = A + M where Product MSB 32 bits = A
            case (temp)
                2'b10 : Product [2*N-1 : N] = Product [2*N-1 : N] - Multiplier;
                2'b01 : Product [2*N-1 : N] = Product [2*N-1 : N] + Multiplier;
            default : begin end
            endcase
            //Shift arithmetic right (Keeping sign bit)
            Product = Product >> 1;
            Product[2*N-1] = Product[2*N-2];
            //Updating Q0
            Q0 = Multiplicand[i];
        end
            //If the multiplier equals negative number then get the complement
            if (Multiplier == 32'b10000000000000000000000000000000)
                begin
                    Product = - Product;
                end
    end
endmodule