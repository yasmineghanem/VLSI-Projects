module InputRegister (clk, enable, reset, dataIn, dataOut);
    input clk;
    input enable, reset;
    input [31:0] dataIn;
    output reg [31:0] dataOut;

    reg [31:0] register;

    always @(negedge clk) begin
        if(enable == 1'b1) begin
        dataOut = register;
        end
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            register = {32{1'b0}};
        end else begin
            if (enable == 1'b1) begin
                register = dataIn;
            end
        end
    end
endmodule

module OutputRegister (clk, enable, reset, dataIn, dataOut);
    input clk;
    input enable, reset;
    input [63:0] dataIn;
    output reg [63:0] dataOut;

    reg [63:0] register;

    always @(negedge clk) begin
        if(enable == 1'b1) begin
        dataOut = register;
        end
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            register = {64{1'b0}};
        end else begin
            if (enable == 1'b1) begin
                register = dataIn;
            end
        end
    end
endmodule