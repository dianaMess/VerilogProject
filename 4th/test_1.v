module test_1();
   reg [7:0] x;
   reg [1:0] on;
   reg start;
   reg clk, rst;
   wire [7:0] y;
   wire [2:0] s;
   wire b, active;
   wire [1:0] regime;
   main _main(.x(x), .y(y), .s(s), .b(b), .on(on), .start(start), .regime(regime), .active(active), .clk(clk), .rst(rst));
   initial begin
      $dumpfile("dump1.vcd");
      $dumpvars(0, test_1);
      #70
      $finish;
   end
   initial begin
      #2
      rst = 1;
      #2
      rst = 0;
      x = 8'b0000_0001;
      on = 2'b01;
      start = 1'b0;
      #2
      x = 8'b0000_0101;
      on = 2'b01;
      start = 1'b0;
      #2
      start = 1'b1;
      #26
      start = 1'b0;
      on = 2'b11;
      x = 8'b0000_1001;
      #8
      start = 1'b0;
      on = 2'b10;
      #2
      start = 1'b1;
      #18
      start = 1'b0;
   end
   initial clk = 0;
   always #1 clk = !clk;
endmodule
