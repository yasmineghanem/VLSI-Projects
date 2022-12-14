module BoothMult #(parameter N = 32) (Multiplicand,Multiplier,Product);
input signed [N-1:0] Multiplicand,Multiplier; //33 bits, [31:0] 32 for number and [32] 1 bit for sign
output reg signed [2*N-1:0] Product; //65 bits, [63:0] 64 for number and [64] 1 bit for sign

reg [N-1:0] A ;
reg Q0 = 0;
reg [1:0] temp;

integer i;

always @ (Multiplicand,Multiplier)
begin
    Product = 0;
    Q0 = 0;
    A = 0;
    for(i = 0 ; i < N ; i = i+1)
    begin
        temp = {Multiplicand[i], Q0};
        case (temp) 
            2'b01: Product [2*N-1 : N] = Product [2*N-1 : N] + Multiplier;
            2'b10: Product [2*N-1 : N] = Product [2*N-1 : N] - Multiplier;
            default: begin end
        endcase
        Product = Product >> 1;
        Product[2*N-1] = Product[2*N-2];
        //Updating Q0
        Q0 = Multiplicand[i];
    end
end

endmodule