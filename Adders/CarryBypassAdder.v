`include "FullAdder.v"

module mux_2x1(input a,
               input b,
               input sel,
               output out);

    assign out=(sel)?a:b;

endmodule

module CarryBypassAdder4bits(input [3:0]a,
                           input [3:0]b,
                           input cin,
                           output cout,
                           output [3:0]sum);

   
    wire [4:0]carrys;                      //  series of full adders carries

    assign carrys[0] = cin;
    assign cout = carrys[4];

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            Fulladder FA(
                .in1(a[i]),
                .in2(b[i]),
                .cin(carrys[i]),
                .cout(carrys[i+1]),
                .sum(sum[i])
            );
        end
    endgenerate
endmodule


module CarryBypassAdder #(parameter N = 32) (A,B,Sum,Cin,Cout,Overflow);
     
    input signed[31:0]A;
    input signed[31:0]B;
    input Cin;
    output Cout, Overflow;
    output signed [31:0]Sum; 
    
    // FA series
    wire [7:0]carrys_in;
    wire [7:0]carrys_out;

    assign carrys_in[0] = Cin;
    assign cout = carrys_out[7];
    assign Overflow = (A[31] == B[31] && (Sum[31] != A[31]))? 1 : 0;

    genvar k;
    generate
        for (k = 0; k< 8; k= k + 1) begin
            CarryBypassAdder4bits Cba(
                .a(A[k*4+3:k*4]),
                .b(B[k*4+3:k*4]),
                .cin(carrys_in[k]),
                .cout(carrys_out[k]),
                .sum(Sum[k*4+3:k*4])
            );
        end
    endgenerate
genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin
            mux_2x1 MUX(
                .a(carrys_in[i]),
                .b(carrys_out[i]),
                .sel(
                    (A[i*4]^B[i*4])&
                    (A[i*4+1]^B[i*4+1])&
                    (A[i*4+2]^B[i*4+2])&
                    (A[i*4+3]^B[i*4+3])
                    ),
                .out(carrys_in[i+1])
            );
        end
    endgenerate
endmodule