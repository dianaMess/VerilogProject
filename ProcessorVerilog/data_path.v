module data_path
(
    input clk,
    input rst,
    input [5:0] op,
    input [1:0] d1,
    input d2,
    input d3,
    input d4,
    input regWr, 
    input regMem,
    input we,
    output aluZero,
    output [31:0] imData
);
    reg [31:0] pc_new;
    wire [31:0] alu, od, pc;
    reg [4:0] a3;
    wire [31:0] rd1, rd2;
    reg [31:0] wd3;
    reg [31:0] srcB;
    wire [31:0] instr;

    pc _pc(
        .in(pc_new),
        .rst(rst), 
        .clk(clk), 
        .store(we), 
        .out(pc));

    instr _instr(
        .addr(pc), 
        .com(instr));

    registers _registers(
        .clk(clk),
        .rst(rst), 
        .a1(instr[25:21]),
        .a2(instr[20:16]),
        .a3(a3),
        .rd1(rd1),
        .rd2(rd2),
        .wd3(wd3),
        .we3(regWr)
    );

    alu _alu(
        .srcA(rd1),
        .srcB(srcB), 
        .op(op), 
        .aluZero(aluZero),
        .out(alu));

    dmem _dmem(
        .addr(alu), 
        .id(rd2), 
        .w(regMem),
        .clk(clk), 
        .od(od));

    always @* begin
        if (d1 == 2'b01) 
            pc_new <= pc + 1 + instr[15:0];
        else if (d1 == 2'b11)
            pc_new <= instr[25:0];
        else if (d1 == 2'b00)
            pc_new <= pc + 1;
    end
    
    always @* begin
        if (d2)
            a3 <= instr[20:16];
        else if(!d2)
            a3 <= instr[15:11];
    end
    
    always @* begin
        if (d3)
            srcB <= rd2;
        else if(!d3)
            srcB <= instr[15:0];
    end
    
    always @* begin
        if (d4)
            wd3 <= od;
        else if(!d4)
            wd3 <= alu;
    end    
    assign imData = instr; 
endmodule



