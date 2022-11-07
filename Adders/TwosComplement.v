`include "MUXs.v"
`include "FullAdder.v"

module TwosComplement #(parameter N = 24) (A,Out);
	input [N-1:0] A;
    output [N-1:0] Out;

    wire [N-1:0] MuxWire;
    genvar i;
    generate
    for(i = 0; i < N; i = i + 1) begin
        MUX21 MUX(1'b1, 1'b0, A[i], MuxWire[i]);
    end
    endgenerate

    wire [N-1:0] BorrowWire;
    HalfAdder HA(MuxWire[0],1'b1,Out[0],BorrowWire[0]);

	generate
	for(i = 1; i < N; i = i + 1) begin
		FullAdder FA(MuxWire[i],1'b0,BorrowWire[i-1],Out[i],BorrowWire[i]);
	end
	endgenerate
	
endmodule