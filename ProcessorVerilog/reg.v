module registers
(
    input clk,
    input rst,
    input  [4:0] a1,
    input  [4:0] a2,
    input  [4:0] a3,
    input  [31:0] wd3,
    input  we3,
    output [31:0] rd1,
    output [31:0] rd2
 );
    reg [31:0] rf [31:0];
    integer i;

    assign rd1 = rf[a1];
    assign rd2 = rf[a2];

    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                rf[i] = 0;
            end
        end
        if(we3) 
            rf[a3] <= wd3;
    end
endmodule
