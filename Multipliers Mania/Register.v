module Register #(parameter N = 32) (clk, dataIn, dataOut, readEnable, writeEnable, reset);
    input clk;
    input readEnable, writeEnable, reset;
    input [N-1:0] dataIn;
    output reg [N-1:0] dataOut;

    reg [N-1:0] register;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            dataOut = 0;
        end else begin
            if(writeEnable) begin
                register = dataIn;
            end else if(readEnable) begin
                dataOut = register;
            end
        end
    end

endmodule