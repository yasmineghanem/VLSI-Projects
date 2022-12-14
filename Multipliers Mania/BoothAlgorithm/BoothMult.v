module BoothMult #(parameter N = 32) (Multiplicand,Multiplier,Product);
input signed [N-1:0] Multiplicand,Multiplier; //33 bits, [31:0] 32 for number and [32] 1 bit for sign
output reg signed [2*N-1:0] Product; //65 bits, [63:0] 64 for number and [64] 1 bit for sign

reg [N-1:0] Q;
reg [N-1:0] A = 0;
wire Q1;
assign Q1 = Q[0];
reg Q0 = 0;
reg [N-1:0] temp;

integer i;

always @ (Multiplicand,Multiplier)
begin
    Q = Multiplier;
    for(i = N-1 ; i < 1 ; i = i-1)
    begin
        case ({Q1,Q0}) 
            2'b01: A = A + Multiplicand;
            2'b10: A = A - Multiplicand;
            default: begin end
        endcase
	temp = {A,Q,Q0};
        temp = temp >> 1;
        temp[N-1]=temp[N-2];
	{A,Q,Q0} = temp;
    end
    Product = {A,Q};
end


endmodule