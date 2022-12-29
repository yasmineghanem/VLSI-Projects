module Register #(parameter N = 32) (clk, dataIn, dataOut, readEnable, writeEnable, reset, accessError);
    input clk;
    input readEnable, writeEnable, reset;
    input [N-1:0] dataIn;
    output accessError;
    output reg [N-1:0] dataOut;

    // trying to read and write at the same time
    assign accessError = (readEnable == 1'b1 && writeEnable == 1'b1) ? 1'b1 : 1'b0;

    reg [N-1:0] register;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            dataOut = {32{1'b0}};
        end else begin
            if(writeEnable) begin
                register = dataIn;
            end else if(readEnable) begin
                dataOut = register;
            end
        end
    end

endmodule