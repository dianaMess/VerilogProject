module main(clk, rst);
    input clk, rst;      // reset
    wire [31:0] instr;
    wire we;
    wire d2, d3, d4;
    wire [1:0] d1;
    wire [5:0] op;
    wire regWr, regMem, aluZero;


    control_path _control_path(
    .clk(clk),
    .rst(rst),
    .imData(instr),
    .aluZero(aluZero),
    .we(we),
    .regWr(regWr),
    .regMem(regMem),
    .op(op),
    .d1(d1), .d2(d2),
    .d3(d3),
    .d4(d4)
    );

    data_path _data_path(
    .clk(clk),
    .rst(rst),
    .op(op),
    .d1(d1),
    .d2(d2), 
    .d3(d3), 
    .d4(d4),
    .regWr(regWr), 
    .regMem(regMem),
    .we(we),
    .aluZero(aluZero),
    .imData(instr)
   );

endmodule
