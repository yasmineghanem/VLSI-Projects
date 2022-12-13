module Register #(parameter N = 32) (clk, dataIn, dataOut, readEnable, writeEnable);
    input clk;
    input readEnable, writeEnable;
    input [N-1:0] dataIn;
    output [N-1:0] dataOut;

    reg [N-1:0] register;

    always @(posedge clk or posedge reset) begin
        if(reset){
            dataOut = 0;
        } else{
            if(writeEnable){
                register = dataIn;
            }
        }
    end

    always @(negedge clk) begin
        if(readEnable) begin
            dataOut = register;
        end
        
    end
endmodule