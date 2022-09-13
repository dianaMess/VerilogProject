module pc(in, rst, clk, store, out); 
    input [31:0] in;
    input rst, clk, store;
    output reg [31:0] out;
    
    always @(posedge clk) begin
        if (rst)
            out <= 0;
        else if(store)
            out <= in; 
    end
endmodule
