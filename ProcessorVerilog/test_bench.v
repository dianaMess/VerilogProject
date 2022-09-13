module test_bench();
    reg clk, rst;
    main _main(.clk(clk), .rst(rst));
    initial clk = 0;
    
    always #1 clk = !clk;
    
    initial begin
        rst = 1;
        #2
        rst = 0;
    
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, test_bench);
        #90
        $finish;
    end
    
endmodule
