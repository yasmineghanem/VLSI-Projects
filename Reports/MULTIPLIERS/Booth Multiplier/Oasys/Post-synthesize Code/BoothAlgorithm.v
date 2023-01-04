module BoothAlgorithmMultiplier #(parameter N = 32) (Multiplicand, Multiplier, Product);
    input signed [N-1:0] Multiplicand, Multiplier;
    output signed [2*N-1:0] Product;

    reg signed [2*N-1:0] Product;
    reg [1:0] booth;
    integer i;
    reg Q0;

    always @ (Multiplicand, Multiplier)
    begin
        Product = 0;
        Q0 = 0;
        if(Multiplier == 0 || Multiplicand == 0)
        begin
        Product = 0;
        end else begin
        for (i = 0; i < N; i = i + 1)
        begin
            //booth = Q1 Q0
            booth = {Multiplicand[i], Q0};
            //If booth = 10 then A = A - M where Product MSB 32 bits = A
            //If booth = 01 then A = A + M where Product MSB 32 bits = A
            case (booth)
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
        end
	    //Corner Case for multiplier
        //If the multiplier equals MAX negative number then we need to get the complement
        if (Multiplier == 32'b10000000000000000000000000000000)
            begin
                Product = - Product;
            end
    end
endmodule