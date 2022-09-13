module alu(srcA, srcB, op, aluZero, out);
    input [31:0] srcA, srcB;
    input [5:0] op;
    output reg aluZero;
    output reg [31:0] out;
    
    always @(*) begin
        case(op)
            6'b100_000: out <= srcA + srcB;
            6'b100_010: out <= srcA - srcB;
            6'b101_010: out <= srcA < srcB;
        endcase
        if (out == 0) 
            aluZero = 1;
        else
            aluZero = 0;
    end
endmodule
