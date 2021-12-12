module test_2();
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
      $dumpfile("dump2.vcd");
      $dumpvars(0, test_2);
      #115
      $finish;
   end
   initial begin
      #2
      rst = 1;
      #2
      rst = 0;
      on = 2'b10;
      start = 1'b0;
      #2
      on = 2'b10;
      start = 1'b1;
      #8
      x = 8'b1001_0110;
      start = 1'b0;
      #2
      on = 2'b11;
      #10
      on = 2'b00;
      #4
      on = 2'b01;
      start = 1'b1;
      #26
      on = 2'b00;
      #4
      on = 2'b01;
      start = 1'b0;
      #6
      start = 1'b1;
      #26
      on = 2'b11;
      x = 8'b0001_1010;
      #10
      on = 2'b00; 
   end
   initial clk = 0;
   always #1 clk = !clk;
endmodule
