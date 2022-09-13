module dmem(addr, id, w, clk, od);
    input [31:0] addr, id;
    input clk, w;
    output [31:0] od;
    
    reg [31:0] mem [31:0];
    
    initial mem[0] = 32'd1;
    initial mem[2] = 32'd10;
    
    assign od = mem[addr];
    
    always @(posedge clk) begin
        if (w)
            mem[addr] = id;
    end
    
endmodule
