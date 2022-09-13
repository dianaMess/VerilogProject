module control_path
(
    input clk,
    input rst,
    input [31:0] imData,
    input aluZero,
    output reg we,
    output reg regWr,
    output reg regMem,
    output reg [5:0] op,
    output reg [1:0] d1,
    output reg d2, 
    output reg d3,
    output reg d4
);

    always @ (*) begin
        case(imData[31:26])
            6'b000_000: begin
                d1 = 2'b00;
                d2 = 1'b0;
                d3 = 1'b1;
                d4 = 1'b0;
                we = 1;
                regWr = 1;
                regMem = 0;
                op = imData[5:0];
           end
            6'b001_000: begin
                d1 = 2'b00;
                d2 = 1'b1;
                d3 = 1'b0;
                d4 = 1'b0;
                we = 1;
                regWr = 1;
                regMem = 0;
                op = 6'b100_000;
            end
            6'b000_100: begin
                d1 = aluZero ? 2'b01 : 2'b00;
                d2 = 1'bx;
                d3 = 1'b1;
                d4 = 1'bx;
                we = 1;
                regWr = 0;
                regMem = 0;
                op = 6'b100_010;
            end
            6'b100_011: begin
                d1 = 2'b00;
                d2 = 1'b1;
                d3 = 1'b0;
                d4 = 1'b1;
                we = 1;
                regWr = 1;
                regMem = 0;
                op = 6'b100_000;
            end
            6'b101_011: begin
                d1 = 2'b00;
                d2 = 1'bx;
                d3 = 1'b0;
                d4 = 1'bx;
                we = 1;
                regWr = 0;
                regMem = 1;
                op = 6'b100_000; 
            end
            6'b000_010: begin
                d1 = 2'b11;
                d2 = 1'bx;
                d3 = 1'bx;
                d4 = 1'bx;
                we = 1;
                regWr = 0;
                regMem = 0;
                op = 6'bxxx_xxx; 
            end
            default: we = 0;
        endcase
    end
endmodule

